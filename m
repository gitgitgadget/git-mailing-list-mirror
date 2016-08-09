Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD871F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbcHIRpc (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:45:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:52137 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752234AbcHIRpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:45:31 -0400
Received: (qmail 15825 invoked by uid 109); 9 Aug 2016 17:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 17:45:31 +0000
Received: (qmail 22671 invoked by uid 111); 9 Aug 2016 17:45:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 13:45:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 13:45:29 -0400
Date:	Tue, 9 Aug 2016 13:45:29 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/7] pack-objects: use mru list when iterating over
 packs
Message-ID: <20160809174528.2ydgkhd7ayclat3t@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
 <20160729041524.GG22408@sigill.intra.peff.net>
 <20160729054536.GA27343@sigill.intra.peff.net>
 <xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
 <20160808145042.uwrk2m6jq3m4li37@sigill.intra.peff.net>
 <xmqq8tw7gr82.fsf@gitster.mtv.corp.google.com>
 <20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net>
 <xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
 <20160809140411.7745apztp36nwshx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160809140411.7745apztp36nwshx@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 10:04:11AM -0400, Jeff King wrote:

> Here's the code to do the cycle-breaking.
> [...]
> It seems to perform well, and it does break the cycles (the later check
> during the write does not kick in, and we get no warnings). I didn't dig
> into the fates of specific objects, but any cycles should be added to
> the delta-compression phase.

Curious about that last part, I did the repack both with and without
this patch. We should be able to see the difference in the progress
meter from the "Compressing" phase. And indeed, it goes from 3030778
objects to 3031056, an increase of 278 objects. Which just so happens to
be exactly the number of "warning: recursive delta detected" lines that
are printed without the patch.

Not surprising, but a nice confirmation that everything is working as
expected.  But while looking at this, I managed to unravel what's been
going on this whole time.

I ran the repack again with stock git (no MRU patch), and the number of
objects in the delta phase jumped to 3087880, around 56,000 more than
with the MRU patch. So that's probably where the magic "3%" is coming
from.  By looking at the smaller packs first, we are more likely to find
copies of objects which _aren't_ deltas, and then consider them for
delta compression. And that compression tends to find a better match
than reusing what was in the big pack, and we end up with a slightly
smaller output pack.

So why are the deltas we find so much better than what is in the big
pack?

There's something rather subtle going on, and it has to do with the fact
that the existing pack was _not_ made by a stock version of git.

I may have mentioned before that I have some patches which restrict the
delta selection process. The goal is that if you have several "islands"
of refs (in my case, refs corresponding to particular forks of a
repository), it's desirable that you don't make a delta against a base
that is not reachable from all of the same islands. Otherwise, when
somebody fetches or clones the fork, you have to throw away the delta
and find one from scratch. If this happens a lot, it gets expensive.
Unsurprisingly, the packfiles produced with the island-restrictions
turned on are slightly worse than normal packfiles (because we reject
some delta possibilities that might be better).

When I did my testing, I did not enable the delta islands, because I
didn't want them to influence the results. But of course their effect
could still be seen in the deltas in the existing packfile, because it
came off our production servers (because I wanted a real-world test
case). So any pack ordering which ends up reusing _fewer_ of those
deltas is going to be a net win in size, because it's going to find new
deltas without being hampered by the island restrictions. And that's
exactly what happened in my tests; the stock pack ordering finds more
objects in the newer packs, has fewer deltas to reuse, and is able to
find better unrestricted deltas.

Unfortunately I don't have a real-world test case that's been packed up
until now with stock git. So the next-best thing I can do is re-run my
tests with the island restrictions turned on, so that newly-found deltas
do not have an unfair advantage. And here are the sizes for each case
after doing so:

  7848512375 before.git/objects/pack/pack-2f5878f6569cd6682e7084318de311ed26d19af5.pack
  7851778788 mru.git/objects/pack/pack-7694766c660eaa0e27e4e51a77bd5c457c3d2f1d.pack
  7851165480 cycle-break.git/objects/pack/pack-cfaceb3423993c72e4ac588c30c94da2d087145a.pack

The MRU case _is_ slightly bigger, but only by 0.04%. And then adding
the cycle-breaking on top of that reclaims a little bit of space,
because rather than throwing out those 287 deltas at the write phase,
it's able to add those objects back to the delta search and find new
deltas for them.

So there. Mystery solved, and I feel confident in saying that the MRU
patches _don't_ represent a real regression in pack size. We do need to
deal with the cycles, of course, but it's less an issue of size and more
one of correctness (well, the pack is correct either way, but still, it
seems more correct to realize during the correct phase that we cannot
reuse those deltas).

I also suspect that one of the tricks I tried, simply reversing the pack
order (so the big pack is at the front, but the order is stable) would
work very well for this case. But as I mentioned before, I prefer the
MRU strategy because it's less susceptible to pathological cases.

-Peff
