Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD11FC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 21:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhLVViz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 16:38:55 -0500
Received: from siwi.pair.com ([209.68.5.199]:17886 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhLVViy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 16:38:54 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BF3823F48D5;
        Wed, 22 Dec 2021 16:38:53 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 823FD3F48FE;
        Wed, 22 Dec 2021 16:38:53 -0500 (EST)
Subject: Re: [PATCH 7/9] trace2: add stopwatch timers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <dd4f0576254defa3ab0e73a73c9c433f28fcca5b.1640012469.git.gitgitgadget@gmail.com>
 <211220.86h7b3usnn.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9856c7aa-fe07-6164-d101-6d7d25c1ebbb@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 16:38:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211220.86h7b3usnn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/21 11:42 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> [...]
>> +
>> +void trace2_timer_stop(enum trace2_timer_id tid)
>> +{
>> +	if (!trace2_enabled)
>> +		return;
>> +
>> +	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
>> +		BUG("invalid timer id: %d", tid);
> 
> nit / style: maybe assert() instead for cases where assert() produces
> better info than BUG(). I.e. it would quote the whole expression, and
> show you what condition it violated....

I'd rather leave it a BUG() so that we always get the
guard code.  assert() goes away in non-debug builds and
a little while later "tid" will be used as a subscript.

I'll add the function name to the BUG message to make
it a little clearer.


[...]
> 
> Perhaps more readable/easily understood as just a (untested):
> 
>      if (!t->interval_count || us_interval >= t->min_us)
> 	    t->min_us = us_interval;
>      if (!t->interval_count || us_interval >= t->max_us)
> 	    t->max_us = us_interval;
> 
> I.e. to avoid duplicating the identical assignment...
[...]

I'll look at something here to make this a little less
messy.  Probably add a MIN() and MAX() to the mixture.

> 
>> +	/*
>> +	 * Number of nested starts on the stack in this thread.  (We
>> +	 * ignore recursive starts and use this to track the recursive
>> +	 * calls.)
>> +	 */
>> +	unsigned int recursion_count;
> 
> Earlier we have various forms of:
> 
>      if (t->recursion_count > 1)
> 
> But since it's unsigned can we just make those a:
> 
>      if (t->recursion_count)
> 

The places that are > 0, yes.  But the > 1 instances
are different since we're counting how many calls are
on the stack and want to handle recursive calls differently
than the first.

