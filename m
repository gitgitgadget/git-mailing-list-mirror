Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F311F4DD
	for <e@80x24.org>; Thu, 24 Aug 2017 06:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbdHXGIh (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 02:08:37 -0400
Received: from 5.mo176.mail-out.ovh.net ([46.105.43.127]:44911 "EHLO
        5.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdHXGIg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 02:08:36 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 09D067F437;
        Thu, 24 Aug 2017 08:08:32 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Aug 2017 08:08:32 +0200
Subject: Re: [PATCH v3 2/4] imap-send: add wrapper to get server credentials
 if needed
To:     Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <peff@peff.net>
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
 <9df045f4-71bd-92a1-20bb-4931e25b22c3@morey-chaisemartin.com>
 <xmqqtw0yxcsk.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <d1c39912-a847-1831-60ae-18b15359092f@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 08:08:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqtw0yxcsk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS1.indiv2.local (172.16.1.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 7881580823206356983
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtdefgdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 23/08/2017 à 22:13, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:
>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>  imap-send.c | 34 ++++++++++++++++++++--------------
>>  1 file changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 09f29ea95..448a4a0b3 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -926,6 +926,25 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
>>  	return 0;
>>  }
>>  
>> +static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
>> +{
>> +	if (srvc->user && srvc->pass)
>> +		return;
>> +
>> +	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
>> +	cred->host = xstrdup(srvc->host);
>> +
>> +	cred->username = xstrdup_or_null(srvc->user);
>> +	cred->password = xstrdup_or_null(srvc->pass);
>> +
>> +	credential_fill(cred);
>> +
>> +	if (!srvc->user)
>> +		srvc->user = xstrdup(cred->username);
>> +	if (!srvc->pass)
>> +		srvc->pass = xstrdup(cred->password);
>> +}
>> +
> This looks straight-forward code movement.  The only thing that
> makes me wonder is if this is "server".  The existing naming of the
> variables screams at me that this is not "server" but is "service".

I read srvc as server conf not service.
But I can change the name if you prefer

Nicolas

