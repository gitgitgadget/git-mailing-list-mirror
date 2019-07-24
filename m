Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3971F462
	for <e@80x24.org>; Wed, 24 Jul 2019 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbfGXVZL (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 17:25:11 -0400
Received: from mail-gateway-shared03.cyon.net ([194.126.200.53]:44156 "EHLO
        mail-gateway-shared03.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfGXVZL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jul 2019 17:25:11 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared03.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1hqOkz-0000Fm-DS
        for git@vger.kernel.org; Wed, 24 Jul 2019 23:25:08 +0200
Received: from [10.20.10.230] (port=65510 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <dev+git@drbeat.li>)
        id 1hqOky-0001ys-6u; Wed, 24 Jul 2019 23:25:04 +0200
Subject: Re: [PATCH] grep: print the pcre2_jit_on value
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20190722181923.21572-1-dev+git@drbeat.li>
 <nycvar.QRO.7.76.6.1907232118460.21907@tvgsbejvaqbjf.bet>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <c85bcde8-2bef-3345-ec43-9ab44e587e39@drbeat.li>
Date:   Wed, 24 Jul 2019 23:25:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907232118460.21907@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 23.07.19 21:19, Johannes Schindelin wrote:
> Hi Beat,
> 
> On Mon, 22 Jul 2019, Beat Bolli wrote:
> 
>> When pcre2_jit_on is neither 1 nor 0, the BUG() call printed the value
>> of pcre1_jit_on.
>>
>> Print the value of pcre2_jit_on instead.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>  grep.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/grep.c b/grep.c
>> index f7c3a5803e..cd952ef5d3 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -559,7 +559,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>>  		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
>>  	} else if (p->pcre2_jit_on != 0) {
>>  		BUG("The pcre2_jit_on variable should be 0 or 1, not %d",
>> -		    p->pcre1_jit_on);
>> +		    p->pcre2_jit_on);
> 
> Seems obviously good.
> 
> Maybe while you're in the vicinity, you can add that information to the
> `--debug` output?

Do you mean something like this?

diff --git a/grep.c b/grep.c
index cd952ef5d3..8a57ba998f 100644
--- a/grep.c
+++ b/grep.c
@@ -406,6 +406,8 @@ static void compile_pcre1_regexp(struct grep_pat *p,
const struct grep_opt *opt)

 #ifdef GIT_PCRE1_USE_JIT
        pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
+       if (opt->debug)
+               fprintf(stderr, "pcre1_jit_on=%d\n", p->pcre1_jit_on);
        if (p->pcre1_jit_on == 1) {
                p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
                if (!p->pcre1_jit_stack)
@@ -522,6 +524,8 @@ static void compile_pcre2_pattern(struct grep_pat
*p, const struct grep_opt *opt
        }

        pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
+       if (opt->debug)
+               fprintf(stderr, "pcre2_jit_on=%d\n", p->pcre2_jit_on);
        if (p->pcre2_jit_on == 1) {
                jitret = pcre2_jit_compile(p->pcre2_pattern,
PCRE2_JIT_COMPLETE);
                if (jitret)

If so, I'll wait a bit until it's clear whether Ævar's series [1] or my
patch is going to be applied.

If this is missing your intentions, I need more guidance ;-)

[1] https://public-inbox.org/git/20190724151415.3698-1-avarab@gmail.com/


> 
> Thanks,
> Dscho
> 
>>  	}
>>  }
>>

Cheers,
Beat
