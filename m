Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB1C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891CA610CC
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhJHC5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 22:57:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:35522 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhJHC5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 22:57:14 -0400
Received: (qmail 31591 invoked by uid 109); 8 Oct 2021 02:55:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 02:55:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29980 invoked by uid 111); 8 Oct 2021 02:55:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Oct 2021 22:55:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Oct 2021 22:55:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
Message-ID: <YV+zFqi4VmBVJYex@coredump.intra.peff.net>
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
 <YVyPH59LpxFLHep0@nand.local>
 <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
 <3f03ed89-d3db-32ba-3c1f-b8fac7cfb097@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f03ed89-d3db-32ba-3c1f-b8fac7cfb097@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 01:49:15PM -0400, Jeff Hostetler wrote:

> Yeah, I don't think I want to keep switching the value of _REPEAT_COUNT
> in the body of the test.  (It did feel a little "against the spirit" of
> the framework.)  I'm in the process of redoing the test to not need
> that.

Sounds good to me. :)

> There's a problem with the perf test assumptions here and I'm curious
> if there's a better way to use the perf-lib that I'm not thinking of.
> 
> When working with big repos (in this case 100K files), the actual
> checkout takes 33 seconds, but the repetitions are fast -- since they
> just print a warning and stop.  In the 1M file case that number is ~7
> minutes for the first instance.)  With the code in min_time.perl
> silently taking the min() of the runs, it looks like the checkout was
> really fast when it wasn't.  That fact gets hidden in the summary report
> printed at the end.

Right. So your option now is basically something like:

  test_perf 'checkout' '
	git reset --hard the_original_state &&
	git checkout
  '

I.e., reset the state _and_ perform the operation you want to time,
within a single test_perf(). (Here it's a literal "git reset", but
obviously it could be anything to adjust the state back to the
baseline). But that reset operation will get lumped into your timing.
That might not matter if it's comparatively cheap, but it might throw
off all your results.

What I'd propose instead is that we ought to have:

  test_perf 'checkout'
            --prepare '
	        git reset --hard the_original_state
	    ' '
	        git checkout
	    '

Having two multi-line snippets is a bit ugly (check out that awful
middle line), but I think this could be added without breaking existing
tests (they just wouldn't have a --prepare option).

If that syntax is too horrendous, we could have:

  # this saves the snippet in a variable internally, and runs
  # it before each trial of the next test_perf(), after which
  # it is discarded
  test_perf_prepare '
          git reset --hard the_original_state
  '

  test_perf 'checkout' '
          git checkout
  '

I think that would be pretty easy to implement, and would solve the most
common form of this problem. And there's plenty of prior art; just about
every decent benchmarking system has a "do this before each trial"
mechanism. Our t/perf suite (as you probably noticed) is rather more
ad-hoc and less mature.

There are cases it doesn't help, though. For instance, in one of the
scripts we measure the time to run "git repack -adb" to generate
bitmaps. But the first run has to do more work, because we can reuse
results for subsequent ones! It would help to "rm -f
objects/pack/*.bitmap", but even that's not entirely fair, as it will be
repacking from a single pack, versus whatever state we started with.

And there I think the whole "take the best run" strategy is hampering
us. These inaccuracies in our timings go unseen, because we don't do any
statistical analysis of the results. Whereas a tool like hyperfine (for
example) will run trials until the mean stabilizes, and then let you
know when there were trials outside of a standard deviation.

I know we're hesitant to introduce dependencies, but I do wonder if we
could have much higher quality perf results if we accepted a dependency
on a tool like that. I'd never want that for the regular test suite, but
I'd my feelings for the perf suite are much looser. I suspect not many
people run it at all, and its main utility is showing off improvements
and looking for broad regressions. It's possible somebody would want to
track down a performance change on a specific obscure platform, but in
general I'd suspect they'd be much better off timing things manually in
such a case.

So there. That was probably more than you wanted to hear, and further
than you want to go right now. In the near-term for the tests you're
interested in, something like the "prepare" feature I outlined above
would probably not be too hard to add, and would address your immediate
problem.

-Peff
