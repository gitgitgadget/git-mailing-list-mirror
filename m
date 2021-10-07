Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF86C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99BA61260
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbhJGRvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:51:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:42101 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243073AbhJGRvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 13:51:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AA20A3F404F;
        Thu,  7 Oct 2021 13:49:16 -0400 (EDT)
Received: from WIN10-A.eucom.mil (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6FF5A3F4047;
        Thu,  7 Oct 2021 13:49:16 -0400 (EDT)
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
 <YVyPH59LpxFLHep0@nand.local> <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3f03ed89-d3db-32ba-3c1f-b8fac7cfb097@jeffhostetler.com>
Date:   Thu, 7 Oct 2021 13:49:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/6/21 3:24 PM, Jeff King wrote:
> On Tue, Oct 05, 2021 at 01:45:03PM -0400, Taylor Blau wrote:
> 
>>> GIT_PERF_REPEAT_COUNT=3 \
>>> test_perf "status" "
>>> 	git status
>>> "
>>>
>>> GIT_PERF_REPEAT_COUNT=1 \
>>> test_perf "checkout other" "
>>> 	git checkout other
>>> "
>> [...]
>>
>> Well explained, and makes sense to me. I didn't know we set
>> GIT_PERF_REPEAT_COUNT inline with the performance tests themselves, but
>> grepping shows that we do it in the fsmonitor tests.
> 
> Neither did I. IMHO that is a hack that we would do better to avoid, as
> the point of it is to let the user drive the decision of time versus
> quality of results. So the first example above is spending extra time
> that the user may have asked us not to, and the second is getting less
> significant results by not repeating the trial.
> 
> Presumably the issue in the second one is that the test modifies state.
> The "right" solution there is to give test_perf() a way to set up the
> state between trials (you can do it in the test_perf block, but you'd
> want to avoid letting the setup step affect the timing).
> 
> I'd also note that
> 
>    GIT_PERF_REPEAT_COUNT=1 \
>    test_perf ...
> 
> in the commit message is a bad pattern. On some shells, the one-shot
> variable before a function will persist after the function returns (so
> it would accidentally tweak the count for later tests, too).
> 
> All that said, I do think cleaning up the test_time files after each
> test_perf is a good precuation, even if I don't think it's a good idea
> in general to flip the REPEAT_COUNT variable in the middle of a test.
> 
> -Peff
> 

Yeah, I don't think I want to keep switching the value of _REPEAT_COUNT
in the body of the test.  (It did feel a little "against the spirit" of
the framework.)  I'm in the process of redoing the test to not need
that.



There's a problem with the perf test assumptions here and I'm curious
if there's a better way to use the perf-lib that I'm not thinking of.

When working with big repos (in this case 100K files), the actual
checkout takes 33 seconds, but the repetitions are fast -- since they
just print a warning and stop.  In the 1M file case that number is ~7
minutes for the first instance.)  With the code in min_time.perl
silently taking the min() of the runs, it looks like the checkout was
really fast when it wasn't.  That fact gets hidden in the summary report
printed at the end.

$ time ~/work/core/git checkout p0006-ballast
Updating files: 100% (100000/100000), done.
Switched to branch 'p0006-ballast'

real	0m33.510s
user	0m2.757s
sys	0m15.565s

$ time ~/work/core/git checkout p0006-ballast
Already on 'p0006-ballast'

real	0m0.745s
user	0m0.214s
sys	0m4.705s

$ time ~/work/core/git checkout p0006-ballast
Already on 'p0006-ballast'

real	0m0.738s
user	0m0.134s
sys	0m6.850s


I could use test_expect_success() for anything that does want
to change state, and then save test_perf() for status calls
and other read-only tests, but I think we lose some opportunities
here.

I'm open to suggestions here.

Thanks,
Jeff

