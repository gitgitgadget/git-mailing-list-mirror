Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512DDC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 21:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4C61163
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 21:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhJMVLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 17:11:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:16665 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhJMVLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 17:11:14 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A90413F410A;
        Wed, 13 Oct 2021 17:09:07 -0400 (EDT)
Received: from msranlcmt20.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 72B4F3F4107;
        Wed, 13 Oct 2021 17:09:07 -0400 (EDT)
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
 <YVyPH59LpxFLHep0@nand.local> <20211010212626.GB571180@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <568aa754-4ff2-1841-afaf-519673e36bcc@jeffhostetler.com>
Date:   Wed, 13 Oct 2021 17:09:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211010212626.GB571180@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/10/21 5:26 PM, SZEDER Gábor wrote:
> On Tue, Oct 05, 2021 at 01:45:03PM -0400, Taylor Blau wrote:
>> On Mon, Oct 04, 2021 at 10:29:03PM +0000, Jeff Hostetler via GitGitGadget wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Teach test_perf_() to remove the temporary test_times.* files
>>
>> Small nit: s/test_times/test_time here and throughout.
>>
>>> at the end of each test.
>>>
>>> test_perf_() runs a particular GIT_PERF_REPEAT_COUNT times and creates
>>> ./test_times.[123...].  It then uses a perl script to find the minimum
>>> over "./test_times.*" (note the wildcard) and writes that time to
>>> "test-results/<testname>.<testnumber>.result".
>>>
>>> If the repeat count is changed during the pXXXX test script, stale
>>> test_times.* files (from previous steps) may be included in the min()
>>> computation.  For example:
>>>
>>> ...
>>> GIT_PERF_REPEAT_COUNT=3 \
>>> test_perf "status" "
>>> 	git status
>>> "
>>>
>>> GIT_PERF_REPEAT_COUNT=1 \
>>> test_perf "checkout other" "
>>> 	git checkout other
>>> "
>>> ...
>>>
>>> The time reported in the summary for "XXXX.2 checkout other" would
>>> be "min( checkout[1], status[2], status[3] )".
>>>
>>> We prevent that error by removing the test_times.* files at the end of
>>> each test.
>>
>> Well explained, and makes sense to me. I didn't know we set
>> GIT_PERF_REPEAT_COUNT inline with the performance tests themselves, but
>> grepping shows that we do it in the fsmonitor tests.
>>
>> Dropping any test_times files makes sense as the right thing to do. I
>> have no opinion on whether it should happen before running a perf test,
>> or after generating the results. So what you did here looks good to me.
> 
> I think it's better to remove those files before running the perf
> test, and leave them behind after the test finished.  This would give
> developers an opportunity to use the timing results for whatever other
> statistics they might be interested in.

I could see doing it before.  I'd like to leave it as is for now.
Let's fix the correctness now and we can fine tune it later (with
your suggestion below).

That makes me wonder if it would it be better to have the script
keep all of the test time values?  That is, create something like
test_time.$test_count.$test_seq.  Then you could look at all of
the timings over the whole test script, rather just of those of the
one where you stopped it.


> 
> And yes, I think it would be better if 'make test' left behind
> 't/test-results' with all the test trace output for later analysis as
> well.  E.g. grepping through the test logs can uncover bugs like this:
> 
>    https://public-inbox.org/git/20211010172809.1472914-1-szeder.dev@gmail.com/
> 
> and I've fixed several similar test bugs that I've found when looking
> through 'test-results/*.out'.  Alas, it's always a bit of a hassle to
> comment out 'make clean-except-prove-cache' in 't/Makefile'.
> 

Jeff
