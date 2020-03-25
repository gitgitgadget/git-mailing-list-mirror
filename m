Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0625BC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BE120774
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgCYFak (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:30:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:50272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725781AbgCYFak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:30:40 -0400
Received: (qmail 22917 invoked by uid 109); 25 Mar 2020 05:30:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 25 Mar 2020 05:30:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32300 invoked by uid 111); 25 Mar 2020 05:40:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Mar 2020 01:40:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Mar 2020 01:30:39 -0400
From:   Jeff King <peff@peff.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        oystwa@gmail.com, entwicklung@pengutronix.de
Subject: Re: bug in git-log with funny merges
Message-ID: <20200325053039.GA651138@coredump.intra.peff.net>
References: <20200324172949.yx7kketvkkl5lyvt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324172949.yx7kketvkkl5lyvt@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 06:29:49PM +0100, Uwe Kleine-König wrote:

> So v5.4.27 is an ancestor of HEAD:
> 
> 	$ git merge-base --is-ancestor v5.4.27 @ && echo yes
> 	yes
> 
> But!:
> 
> 	$ git rev-list --count HEAD..v5.4.27
> 	3868

Yeah, this seems impossible. If v5.4.27 is an ancestor of HEAD, then
that rev-list result must be 0 commits. I'd trust merge-base over
rev-list's limiting, as the latter can be confused by clock skew.

And indeed, doing:

  $ git log --graph --format='%h %cd' HEAD

does point to some weirdness:

  [...]
  * | | d1437a91a10e Tue Mar 24 17:53:00 2020 +0100
  * | | 803aad81ca69 Mon Feb 3 21:24:56 2020 +0100
  * | | 8a4579487b00 Thu Jan 30 11:58:13 2020 +0100
  * | | 25a9309d7ded Thu Jan 30 11:54:28 2020 +0100
  * | | e8f40385c55d Thu Jan 30 14:15:47 2020 +0100
  * | | b95a62694eae Wed Sep 30 11:19:29 2015 +0200
  * | | f5af38a6b7a1 Thu Sep 19 17:59:29 2019 +0200
  * | | 14075cd0ce1b Tue Nov 17 21:20:00 2015 +0100
  * | | 338647d2ab5c Wed Jul 13 10:41:40 2016 +0200
  * | | b31f3c6fbc18 Mon Sep 23 15:59:16 2019 +0200
  * | | 585e0cc08069 Sat Mar 21 08:12:00 2020 +0100

The commit dates are very out-of-order: we go back to January (and even
to 2015!) for commits that are built on top of ones from last Saturday.
So while looking for a common ancestor with v5.4.27 (which is from only
a few days ago), I think we'd stop walking if we're left only with
UNINTERESTING commits (which these are, being ancestors of HEAD) that
seem to be from long before the last interesting one.

There's a slop-counter which is supposed to skip over up to 5
out-of-order commits, but that's clearly not enough here. Curiously,
bumping it to 100k commits isn't enough for this case! I had to bump it
to a million (effectively disabling the optimization entirely):

diff --git a/revision.c b/revision.c
index 8136929e23..cf585f375e 100644
--- a/revision.c
+++ b/revision.c
@@ -1085,7 +1085,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 }
 
 /* How many extra uninteresting commits we want to see.. */
-#define SLOP 5
+#define SLOP 1000000
 
 static int still_interesting(struct commit_list *src, timestamp_t date, int slop,
 			     struct commit **interesting_cache)

I guess this depth might have to do with some weird topology between
linux-stable and linux.git (or maybe just something with your merge, I
didn't look too closely).

But my takeaways are:

One, whatever is generating this history is wrong. Author dates can be
out of order (and it is perfectly reasonable to do so to represent
cherry-picked or rebased commits). But commit dates should generally be
monotonically increasing. If you're applying old patches, etc, you
should be using the old date for the author timestamp, but the current
time for the committer timestamp.

And two, the clock skew issue is known in Git, and is an accepted
tradeoff for performance. E.g., "rev-list --count HEAD..v5.4.27" goes
from 43ms to 7200ms when I bump the SLOP value.

But the good news is that there's work towards correcting this. Instead
of using commit timestamps as a proxy for graph generation numbers, the
new commit-graph feature actually generates real generation numbers. So:

  $ git commit-graph write --reachable
  $ git rev-list --topo-order --count HEAD..v5.4.27
  0

which is the correct answer (and the rev-list runs even faster than the
SLOP version). The slightly bad news is that I needed --topo-order to
get that result. We're not yet using the generation numbers everywhere;
the issue is that they can actually be slower than commit timestamps
(timestamps, when they're accurate, have more resolution than generation
numbers, so they let us order the breadth-first search better). There
are plans to have the graph code use a "combined" number that stores
both a generation (for accuracy) and a timestamp (for resolution).

-Peff
