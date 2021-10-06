Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D1FC433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD74611C3
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbhJFT0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:26:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:34392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhJFT0A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 15:26:00 -0400
Received: (qmail 26810 invoked by uid 109); 6 Oct 2021 19:24:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Oct 2021 19:24:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 353 invoked by uid 111); 6 Oct 2021 19:24:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 15:24:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 15:24:07 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
Message-ID: <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
 <YVyPH59LpxFLHep0@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVyPH59LpxFLHep0@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 01:45:03PM -0400, Taylor Blau wrote:

> > GIT_PERF_REPEAT_COUNT=3 \
> > test_perf "status" "
> > 	git status
> > "
> >
> > GIT_PERF_REPEAT_COUNT=1 \
> > test_perf "checkout other" "
> > 	git checkout other
> > "
> [...]
> 
> Well explained, and makes sense to me. I didn't know we set
> GIT_PERF_REPEAT_COUNT inline with the performance tests themselves, but
> grepping shows that we do it in the fsmonitor tests.

Neither did I. IMHO that is a hack that we would do better to avoid, as
the point of it is to let the user drive the decision of time versus
quality of results. So the first example above is spending extra time
that the user may have asked us not to, and the second is getting less
significant results by not repeating the trial.

Presumably the issue in the second one is that the test modifies state.
The "right" solution there is to give test_perf() a way to set up the
state between trials (you can do it in the test_perf block, but you'd
want to avoid letting the setup step affect the timing).

I'd also note that

  GIT_PERF_REPEAT_COUNT=1 \
  test_perf ...

in the commit message is a bad pattern. On some shells, the one-shot
variable before a function will persist after the function returns (so
it would accidentally tweak the count for later tests, too).

All that said, I do think cleaning up the test_time files after each
test_perf is a good precuation, even if I don't think it's a good idea
in general to flip the REPEAT_COUNT variable in the middle of a test.

-Peff
