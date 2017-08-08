Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568A91F991
	for <e@80x24.org>; Tue,  8 Aug 2017 10:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdHHKeH (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 06:34:07 -0400
Received: from 4.mo176.mail-out.ovh.net ([46.105.39.204]:44666 "EHLO
        4.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdHHKeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 06:34:06 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id B097F69C86;
        Tue,  8 Aug 2017 12:34:03 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 8 Aug
 2017 12:34:03 +0200
Subject: Re: [PATCHv2 3/4] imap_send: setup_curl: retreive credentials if not
 set in config file
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <3637fd31-3120-eca0-b7ee-8e6e324b6b58@morey-chaisemartin.com>
 <43798048-d896-f93b-951a-53ca9cce6bbc@morey-chaisemartin.com>
 <CAN0heSoqtp=48t5vK7QjsPY1jZz0jPL2arryP0BZTPouXiUOCw@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Message-ID: <daa7f7b7-c36d-2ffe-842c-f61ec3250556@morey-chaisemartin.com>
Date:   Tue, 8 Aug 2017 12:34:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSoqtp=48t5vK7QjsPY1jZz0jPL2arryP0BZTPouXiUOCw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX1.indiv2.local (172.16.2.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 10636094946139236317
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkeefgdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 08/08/2017 à 12:09, Martin Ågren a écrit :
> On 8 August 2017 at 09:48, Nicolas Morey-Chaisemartin
> <nicolas@morey-chaisemartin.com> wrote:
>> Up to this point, the curl mode only supported getting the username
>> and password from the gitconfig file while the legacy mode could also
>> fetch them using the credential API.
>>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>  imap-send.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 448a4a0b3..5e80edaff 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -1398,7 +1398,7 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
>>  }
>>
>>  #ifdef USE_CURL_FOR_IMAP_SEND
>> -static CURL *setup_curl(struct imap_server_conf *srvc)
>> +static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
> Hmm, yeah, that really did pollute the interface. :)
>
>>  {
>>         CURL *curl;
>>         struct strbuf path = STRBUF_INIT;
>> @@ -1411,6 +1411,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>>         if (!curl)
>>                 die("curl_easy_init failed");
>>
>> +       server_fill_credential(&server, cred);
>>         curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
>>         curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
>>
>> @@ -1460,8 +1461,9 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>>         struct buffer msgbuf = { STRBUF_INIT, 0 };
>>         CURL *curl;
>>         CURLcode res = CURLE_OK;
>> +       struct credential cred = CREDENTIAL_INIT;
>>
>> -       curl = setup_curl(server);
>> +       curl = setup_curl(server, &cred);
>>         curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
>>
>>         fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
>> @@ -1496,6 +1498,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>>         curl_easy_cleanup(curl);
>>         curl_global_cleanup();
>>
>> +       if (res == CURLE_OK && cred.username)
>> +               credential_approve(&cred);
> Maybe a similar call to credential_reject(&cred) here? I guess all we'll
> know is that some sort of error happened, possibly credentials-related,
> possibly not. Just a thought.

Checking the doc, there is actually a CURLE_LOGIN_DENIED return code which means authentication failed.
I'll fix this in v3

Nicolas
