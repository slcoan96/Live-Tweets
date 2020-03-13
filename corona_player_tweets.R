corona_tweets = cleaner %>%
  mutate(screen_name = tolower(screen_name)) %>%
  left_join(handles_dat %>% mutate(TWITTER = tolower(TWITTER)),by=c("screen_name" = "TWITTER")) %>%
  select(X.3,screen_name,created_at,text,is_quote,is_retweet,favorite_count,retweet_count,status_url,followers_count) %>%
  filter(followers_count > 1000)

View(corona_tweets %>%
       filter(created_at >= '2020-03-11') %>%
       filter(is_retweet == FALSE & is_quote == FALSE) %>%
       mutate(About_Virus = ifelse(grepl('corona|virus|covid|safe|clean|pray|global|employee|salary|paid|pay|health|strong|precaution|hope|home|quarantine|2020|hands|movie|spread|shock|crazy|wild|wow|care|test|rudy|gobert|donovan|mitchell|infect',text,ignore.case = T) == TRUE,'Probably','Unsure')) %>%
       rename(Name = X.3) %>%
       arrange(About_Virus)
)

IG = read.csv('C:/Users/scoan/Desktop/2020-03-13-10-42-08-EDT-Historical-Report-NBA-Players-2019-2020-2020-03-11--2020-03-14.csv',stringsAsFactors = FALSE)

write.csv(IG %>%
       mutate(About_Virus = ifelse(grepl('corona|virus|covid|safe|clean|pray|global|employee|salary|paid|pay|health|strong|precaution|hope|home|quarantine|2020|hands|movie|spread|shock|crazy|wild|wow|care|test|rudy|gobert|donovan|mitchell|infect|outbreak',Description,ignore.case = T) == TRUE,'Probably','Unsure')) %>%
       select(ï..Account,User.Name,Created,Likes,Comments,Link,Description,About_Virus) %>%
       arrange(About_Virus),
       'players_IG_virus.csv'
)

colnames(IG)[1]



s