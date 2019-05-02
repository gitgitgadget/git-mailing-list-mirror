Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BAF61F453
	for <e@80x24.org>; Thu,  2 May 2019 21:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEBVpM (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 17:45:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:47406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726030AbfEBVpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 17:45:11 -0400
Received: (qmail 22309 invoked by uid 109); 2 May 2019 21:45:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 May 2019 21:45:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5791 invoked by uid 111); 2 May 2019 21:45:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 May 2019 17:45:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 May 2019 17:45:09 -0400
Date:   Thu, 2 May 2019 17:45:09 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/partial-clone-connectivity-check (was: What's cooking in
 git.git (Apr 2019, #05; Thu, 25))
Message-ID: <20190502214509.GA19188@sigill.intra.peff.net>
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
 <20190425221657.GV60888@google.com>
 <20190502025206.GA25395@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190502025206.GA25395@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 10:52:06PM -0400, Jeff King wrote:

> > > * js/partial-clone-connectivity-check (2019-04-21) 1 commit
> > >   (merged to 'next' on 2019-04-25 at ebd8b4bffd)
> > >  + clone: do faster object check for partial clones
> > > 
> > >  During an initial "git clone --depth=..." partial clone, it is
> > >  pointless to spend cycles for a large portion of the connectivity
> > >  check that enumerates and skips promisor objects (which by
> > >  definition is all objects fetched from the other side).  This has
> > >  been optimized out.
> > > 
> > >  Will merge to 'master'.
> > 
> > Peff asked for a perf test for this [1], but I haven't had time to write one
> > yet. I can do that in a separate patch if you still want to merge this
> > as-is.
> 
> I won't die without one, but it would be nice. It may also be that an
> existing perf test, but I don't think we cover partial clones in t/perf
> at all. Might be worth just a straight-up "git clone --filter=blob:none"
> test.

Here's what I came up with. Note that there's a bug in 'master' right
now which causes perf to produce nonsense results. It's due to my
0baf78e7bc (perf-lib.sh: rely on test-lib.sh for --tee handling,
2019-03-15). I'll fix that separately (the timing below is done with
that commit reverted).

-- >8 --
Subject: [PATCH] t/perf: add perf script for partial clones

We don't cover the partial clone feature at all in t/perf. Let's at
least run a few basic tests so that we'll notice any regressions.

We'll do a no-blob clone, and split it into two parts: the actual object
transfer, and the subsequent checkout (which will of course require
another transfer to get the blobs). That will help us more clearly
assess the performance of each.

There are obviously a lot more possibilities besides just a no-blob
partial clone, but this should serve as a canary that alerts us to any
generic slow-downs (and we can add more tests later for cases that
aren't exercised here).

There are a few non-ideal things here that make this not an entirely
accurate test, but are probably OK for our purposes:

  1. We have to do some extra prep/cleanup work inside the timing tests,
     since they impact the on-disk state and the perf harness may run
     each one multiple times.

     In practice this is probably OK, since these bits should be much
     less expensive than the operations we are measuring.

  2. The clone time is likely to be dominated by the server's object
     enumeration. In the real world, a repo large enough to drive people
     to partial clones is likely to have reachability bitmaps enabled.

     And in the opposite direction, our object transfer is happening at
     the speed of a local pipe, whereas in the real world it would
     bottle-neck on the network.

     So any percentage speedups should be taken with a grain of salt.
     But hopefully any regressions will produce enough of an effect to
     be noticeable.

This script also demonstrates the recent improvement from dfa33a298d
(clone: do faster object check for partial clones, 2019-04-19):

  Test                          dfa33a298d^         dfa33a298d
  -------------------------------------------------------------------------
  5600.2: clone without blobs   18.41(22.72+1.09)   6.83(11.65+0.50) -62.9%
  5600.3: checkout of result    1.82(3.24+0.26)     1.84(3.24+0.26) +1.1%

Signed-off-by: Jeff King <peff@peff.net>
---
The speedup from dfa33a298d was larger than I expected. Doing a full
`rev-list --objects --all` on a non-partial clone is only 3-4s. So how
did we manage to save 11s by removing it? The answer is that the
is_promisor check is super expensive: we have to walk all of those trees
in the partial pack to find which blobs are mentioned, only to then walk
them all again for the actual traversal and say "yep, this is in our
promisor list". Yikes.

Your patch makes all of that go away, but I do think there's room for us
to be more clever here (but that leads us back down the rabbit hole you
explored earlier, so I think it makes sense to take your patch now and
deal with other optimizations separately).

 t/perf/p5600-partial-clone.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 t/perf/p5600-partial-clone.sh

diff --git a/t/perf/p5600-partial-clone.sh b/t/perf/p5600-partial-clone.sh
new file mode 100755
index 0000000000..3e04bd2ae1
--- /dev/null
+++ b/t/perf/p5600-partial-clone.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='performance of partial clones'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'enable server-side config' '
+	git config uploadpack.allowFilter true &&
+	git config uploadpack.allowAnySHA1InWant true
+'
+
+test_perf 'clone without blobs' '
+	rm -rf bare.git &&
+	git clone --no-local --bare --filter=blob:none . bare.git
+'
+
+test_perf 'checkout of result' '
+	rm -rf worktree &&
+	mkdir -p worktree/.git &&
+	tar -C bare.git -cf - . | tar -C worktree/.git -xf - &&
+	git -C worktree config core.bare false &&
+	git -C worktree checkout -f
+'
+
+test_done
-- 
2.21.0.1314.g224b191707

