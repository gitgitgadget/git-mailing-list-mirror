Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6442047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbdHGRLC (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:11:02 -0400
Received: from 7.mo64.mail-out.ovh.net ([46.105.63.1]:57095 "EHLO
        7.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdHGRLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:11:01 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 1A0967142C;
        Mon,  7 Aug 2017 19:04:13 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 7 Aug
 2017 19:04:12 +0200
Subject: Re: [PATCH 1/4] imap-send: add wrapper to get server credentials if
 needed
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <9687e182-1e23-f84d-3fad-83fdf15dba4c@morey-chaisemartin.com>
 <CAN0heSoA_Xm+14V49hjJBMT7PS_ge0wyhmuvKiw-MHD99rApYQ@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Message-ID: <fdd74c52-7d9a-b12e-2e1f-524479201701@morey-chaisemartin.com>
Date:   Mon, 7 Aug 2017 19:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSoA_Xm+14V49hjJBMT7PS_ge0wyhmuvKiw-MHD99rApYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS2.indiv2.local (172.16.1.2) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 11352730239073249245
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedugdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 07/08/2017 à 18:30, Martin Ågren a écrit :
> On 7 August 2017 at 16:03, Nicolas Morey-Chaisemartin
> <nicolas@morey-chaisemartin.com> wrote:
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>  imap-send.c | 38 ++++++++++++++++++++++++--------------
>>  1 file changed, 24 insertions(+), 14 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index b2d0b849b..38b3c817e 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -926,6 +926,29 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
>>         return 0;
>>  }
>>
>> +static void server_fill_credential(struct imap_server_conf *srvc)
>> +{
>> +       struct credential cred = CREDENTIAL_INIT;
>> +
>> +       if (srvc->user && srvc->pass)
>> +               return;
>> +
>> +       cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
>> +       cred.host = xstrdup(srvc->host);
>> +
>> +       cred.username = xstrdup_or_null(srvc->user);
>> +       cred.password = xstrdup_or_null(srvc->pass);
>> +
>> +       credential_fill(&cred);
>> +
>> +       if (!srvc->user)
>> +               srvc->user = xstrdup(cred.username);
>> +       if (!srvc->pass)
>> +               srvc->pass = xstrdup(cred.password);
>> +
>> +       credential_clear(&cred);
>> +}
>> +
>>  static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
>>  {
>>         struct credential cred = CREDENTIAL_INIT;
>> @@ -1078,20 +1101,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
>>                 }
>>  #endif
>>                 imap_info("Logging in...\n");
>> -               if (!srvc->user || !srvc->pass) {
>> -                       cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
>> -                       cred.host = xstrdup(srvc->host);
>> -
>> -                       cred.username = xstrdup_or_null(srvc->user);
>> -                       cred.password = xstrdup_or_null(srvc->pass);
>> -
>> -                       credential_fill(&cred);
>> -
>> -                       if (!srvc->user)
>> -                               srvc->user = xstrdup(cred.username);
>> -                       if (!srvc->pass)
>> -                               srvc->pass = xstrdup(cred.password);
>> -               }
>> +               server_fill_credential(srvc);
>>
>>                 if (srvc->auth_method) {
>>                         struct imap_cmd_cb cb;
> "cred.username" is checked further down, but now it will always be NULL,
> no?

You're right I missed this.
Not sure if this is needed though.
From what I understand this means the username/password are store for the next access to credential. but in the current state, there is only one.
Maybe the credential_approved can be dropped ?

Nicolas
