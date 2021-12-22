Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA1C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 21:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhLVV5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 16:57:34 -0500
Received: from siwi.pair.com ([209.68.5.199]:19095 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234030AbhLVV5e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 16:57:34 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 78E6D3F4163;
        Wed, 22 Dec 2021 16:57:33 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 360173F4148;
        Wed, 22 Dec 2021 16:57:33 -0500 (EST)
Subject: Re: [PATCH 7/9] trace2: add stopwatch timers
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <dd4f0576254defa3ab0e73a73c9c433f28fcca5b.1640012469.git.gitgitgadget@gmail.com>
 <5f9c6997-abae-c2c7-0121-eb2d360108b8@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9316427d-56a1-50bc-c88e-fda043b88415@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 16:57:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5f9c6997-abae-c2c7-0121-eb2d360108b8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/21/21 9:45 AM, Derrick Stolee wrote:
> On 12/20/2021 10:01 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Add a stopwatch timer mechanism to Git.
[...]
> 
>> +# Exercise the stopwatch timer "test" in a loop and confirm that it was
>> +# we have as many start/stop intervals as expected.  We cannot really test
>> +# the (elapsed, min, max) timer values, so we assume they are good.
> 
> We can't check their values, but we could check that their labels are
> emitted.

good point.  i'll add that to the patterns in the grep.


> 
[...]
>> +	grep "\"event\":\"timer\".*\"thread\":\"${thread}\".*\"name\":\"${name}\".*\"count\":${count}" $file
> 
> Adding more detail to this pattern.
> 
> This helper could probably benefit from constructing the regex across
> multiple string concatenations, so we can see the different pieces.
> Something like
> 
> 	pattern="\"event\":\"timer\""
> 	pattern="$pattern.*\"thread\":\"${thread}\""
> 	pattern="$pattern.*\"name\":\"${name}\""
> 	pattern="$pattern.*\"count\":\"${count}\""
> 	pattern="$pattern.*\"t_total\":"
> 	pattern="$pattern.*\"t_min\":"
> 	pattern="$pattern.*\"t_max\":"
> 
> 	grep "$pattern" $file
> 

yeah, that helps a lot.  thanks.


[...]
>> +/*
>> + * Define the set of stopwatch timers.
>> + *
>> + * We can add more at any time, but they must be defined at compile
>> + * time (to avoid the need to dynamically allocate and synchronize
>> + * them between different threads).
>> + *
>> + * These must start at 0 and be contiguous (because we use them
>> + * elsewhere as array indexes).
> 
> I was worried at first about using an array here, but this is essentially
> one chunk of global memory per process that will not be very large, even

s/process/thread/

> if we add a lot of timer IDs here. If we use this API enough that that
> memory is a problem, then we can refactor the memory to be a hashmap that
> only populates entries for IDs that are used by the process.

we're only talking about 48 bytes per timer being added to the thread
context.  and it is allocated, not stack based, so i'm not worried
about it.

and besides, we get constant time lookups when starting/stopping
a timer.  And when we get ready to sum across the thread pool, we
can do it efficiently.

> 
>> + * Any values added to this enum must also be added to the timer definitions
>> + * array.  See `trace2/tr2_tmr.c:tr2tmr_def_block[]`.
>> + */
>> +enum trace2_timer_id {
>> +	/*
>> +	 * Define two timers for testing.  See `t/helper/test-trace2.c`.
>> +	 * These can be used for ad hoc testing, but should not be used
>> +	 * for permanent analysis code.
>> +	 */
>> +	TRACE2_TIMER_ID_TEST1 = 0, /* emits summary event only */
>> +	TRACE2_TIMER_ID_TEST2,     /* emits summary and thread events */
>> +
>> +
>> +	/* Add additional timer definitions before here. */
>> +	TRACE2_NUMBER_OF_TIMERS
>> +};
> 
> ....
> 
>> +static struct tr2tmr_def tr2tmr_def_block[TRACE2_NUMBER_OF_TIMERS] = {
>> +	[TRACE2_TIMER_ID_TEST1] = { "test", "test1", 0 },
>> +	[TRACE2_TIMER_ID_TEST2] = { "test", "test2", 1 },
>> +};
> 
> Although this will always be populated, so maybe my thoughts about how
> to reduce memory load in the hypothetical future are worthless.

yeah, i think this model works well for us.  and it is lock free.

> 
>> +void tr2tmr_start(enum trace2_timer_id tid)
>> +{
>> +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
>> +	struct tr2tmr_timer *t = &ctx->timers.timer[tid];
>> +
>> +	t->recursion_count++;
>> +	if (t->recursion_count > 1)
>> +		return; /* ignore recursive starts */
>> +
>> +	t->start_us = getnanotime() / 1000;
> 
> Using nanotime gives us the best precision available, and dividing
> by 1000 will lose some precision. This is likely why we saw some
> 0.000000 values for t_min in some of your experiments. That should
> be rare for real uses of this API (such as wrapping lstat() calls).
> 
> But why do we divide by 1000 here at all? 2^63 nanoseconds is
> still 292 years, so we don't risk overflow. You specify uint64_t
> so this isn't different on 32-bit machines.

When I did the original Trace2 parts, I made absolute and relative
elapsed times be in microseconds.  With the overhead of logging
and etc, the lower bits weren't really useful.  And then I converted
those to "%9.6f" in the trace logs, so that we always have "seconds"
in the traces.

I just copied that model when I did timers.  But I could see keeping
nanoseconds around for these timers (since they don't log on every
start/stop, like regions do).

<grin> While drafting this reply I've been fixing up the code in
parallel.  I converted timers to report integer ns values rather
than floats.  And in every line of trace output the total/min/max
timer values all end in 000 -- because (at least on MacOS) getnanotime()
calls gettimeofday() and computes (tv.tv_sec * 1000000000 + tv.tv_usec).
</grin>

So maybe I did the original "%9.6" for other reasons....
I'll try it on another OS later and see if it is useful.


Thanks,
Jeff


