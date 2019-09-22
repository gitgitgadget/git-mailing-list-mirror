Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2091F464
	for <e@80x24.org>; Sun, 22 Sep 2019 21:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392343AbfIVVBa (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 17:01:30 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:42608 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391959AbfIVVBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 17:01:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46c0HW1DzMz5tl9;
        Sun, 22 Sep 2019 23:01:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7457D4AAB;
        Sun, 22 Sep 2019 23:01:26 +0200 (CEST)
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <20190922180143.25026-1-szeder.dev@gmail.com>
 <5692e751-ae5b-e1c8-e5f7-79f0b43e20c0@gmail.com>
 <20190922195312.GC10866@szeder.dev>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8e7617ef-85d0-df3f-4418-5a2502b8e726@kdbg.org>
Date:   Sun, 22 Sep 2019 23:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922195312.GC10866@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.09.19 um 21:53 schrieb SZEDER Gábor:
> On Sun, Sep 22, 2019 at 07:57:36PM +0100, Phillip Wood wrote:
>> On 22/09/2019 19:01, SZEDER Gábor wrote:
>>> +/*
>>> + * One day.  See the 'name a rev close to epoch' test in t6120 when
>>> + * changing this value
>>> + */
>>> +#define CUTOFF_DATE_SLOP 86400
>>>  typedef struct rev_name {
>>>  	const char *tip_name;
>>> @@ -481,8 +485,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>>>  		add_object_array(object, *argv, &revs);
>>>  	}
>>> -	if (cutoff)
>>> -		cutoff = cutoff - CUTOFF_DATE_SLOP;
>>> +	if (cutoff) {
>>> +		/* check for undeflow */
>>> +		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
>>
>> Nice catch but wouldn't this be clearer as
>>   if (cutoff > CUTOFF_DATE_SLOP) ?
> 
> It would only be clearer now, with an unsigned 'timestamp_t'.  I
> tried to future-proof for a signed 'timestamp_t' and a cutoff date
> before the UNIX epoch.

Huh? For signed cutoff and positive CUTOFF_DATE_SLOP,
cutoff - CUTOFF_DATE_SLOP < cutoff is ALWAYS true. Signed interger
underflow is undefined behavior and signed integer arithmetic does not
wrap around!

IOW, the new condition makes only sense today, because cutoff is an
unsigned type, but breaks down should we switch to a signed type.

You need this on top:

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a4d8d312ab..2d83c2b172 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -487,10 +487,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	if (cutoff) {
 		/* check for undeflow */
-		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
+		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
 			cutoff = cutoff - CUTOFF_DATE_SLOP;
 		else
-			cutoff = 0;
+			cutoff = TIME_MIN;
 	}
 	for_each_ref(name_ref, &data);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index c68c61d07c..1bdc21a069 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -344,6 +344,7 @@ typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
 #define TIME_MAX UINTMAX_MAX
+#define TIME_MIN 0
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
