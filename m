Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6B91F858
	for <e@80x24.org>; Fri, 29 Jul 2016 05:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbcG2Fpl (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 01:45:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:50840 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750752AbcG2Fpk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 01:45:40 -0400
Received: (qmail 31887 invoked by uid 102); 29 Jul 2016 05:45:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 01:45:41 -0400
Received: (qmail 31767 invoked by uid 107); 29 Jul 2016 05:46:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 01:46:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 01:45:37 -0400
Date:	Fri, 29 Jul 2016 01:45:37 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] pack-objects: use mru list when iterating over
 packs
Message-ID: <20160729054536.GA27343@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
 <20160729041524.GG22408@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729041524.GG22408@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 12:15:24AM -0400, Jeff King wrote:

> Note that this reordering does have a potential impact on
> the final pack, as we store only a single "found" pack for
> each object, even if it is present in multiple packs. In
> principle, any copy is acceptable, as they all refer to the
> same content. But in practice, they may differ in whether
> they are stored as deltas, against which base, etc. This may
> have an impact on delta reuse, and even the delta search
> (since we skip pairs that were already in the same pack).
> 
> It's not clear whether this change of order would hurt or
> even help average cases, though. The most likely reason to
> have duplicate objects is from the completion of thin packs
> (e.g., you have some objects, then receive several pushes;
> the packs you receive may be thin on the wire, with deltas
> that refer to bases outside the pack, but we complete them
> with duplicate base objects when indexing them).
> 
> In such a case the current code would always find the thin
> duplicates (because we currently walk the packs in reverse
> chronological order). With this patch, it's possible that
> some of them would be found in older packs instead. But
> again, it's unclear whether that is a net win or loss in
> practice.

Hmm, so the efficacy of packing aside, this does definitely have a
negative effect.

I happened to have a repository sitting around that has 15 million
objects and 3600 packs (don't ask), so this seemed like a good test.

With this patch series, it took 11 minutes to do the counting, delta
compression, and write phases. Without it, after 11 minutes git had not
even gotten 10% of the way through counting. So that's good news.

The not-so-good news is that during the write phase, it hit the
"recursive delta detected" warning in write_one(), many times.

I think what is happening is that in the original code, we cannot ever
see a delta cycle, because the pack ordering is fixed. So if `A` is a
delta of `B`, then we know that they must both exist in the same pack
(since we do not do cross-pack deltas on disk). And because we look at
the packs in the same order for each object, we know that if we are
going to find `A`, we must either find `B` in the same pack (or a prior
one if there is another duplicate). But if we do so, then we cannot
also find `B` as a delta of `A` in that pack (because we know that packs
do not have delta cycles themselves) or an earlier pack (because if so,
we would have found `A` in that pack, too).

But because this series switches the order of pack-lookup between
objects, it is possible for us to find a `B` which is a delta against
`A` in one pack, and then another copy of `A` which is a delta against
another copy of `B` from another pack. We add both of the deltas to our
packing list, but at write time when we try to write out all of the
bases for `A`, we realize that whoops, we are recursing infinitely.

As it turns out, Git actually handles this pretty well! Upon noticing
the recursion, it breaks the delta chain and writes out one of the
objects as a full base. This is due to Junio's f63c79d (pack-object:
tolerate broken packs that have duplicated objects, 2011-11-16), though
I think we later decided that duplicated objects were simply insane.

So one option is to simply silence the warning, because the resulting
pack is perfectly fine. But we do notice this during the write phase,
after the delta search is done. So it's possible that the resulting pack
is not as small as it could be (i.e., we break the chain with a base
object, but it's possible if we looked that we could have broken the
chain by making a delta against an existing base object). So I wonder if
it's possible to detect this case earlier, during the "can we reuse this
delta" bits of check_object().

Suggestions welcome. I haven't really dug past what I've written here,
and it's way too late here to go any further tonight.

-Peff
