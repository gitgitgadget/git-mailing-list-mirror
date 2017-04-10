Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5172E20960
	for <e@80x24.org>; Mon, 10 Apr 2017 20:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdDJUzq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 16:55:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:59430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbdDJUzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 16:55:45 -0400
Received: (qmail 24903 invoked by uid 109); 10 Apr 2017 20:55:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 20:55:43 +0000
Received: (qmail 28588 invoked by uid 111); 10 Apr 2017 20:56:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 16:56:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 16:55:40 -0400
Date:   Mon, 10 Apr 2017 16:55:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] unpack-trees: avoid duplicate ODB lookups during
 checkout
Message-ID: <20170410205540.wvlb7ch7bodiytmh@sigill.intra.peff.net>
References: <20170407155306.42375-1-git@jeffhostetler.com>
 <20170407155306.42375-2-git@jeffhostetler.com>
 <23662d7b-84a9-4b71-1aa5-5d3d111f5c3d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23662d7b-84a9-4b71-1aa5-5d3d111f5c3d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 04:06:41PM +0200, René Scharfe wrote:

> > +		} else if (i > 1 && are_same_oid(&names[i], &names[i-2])) {
> > +			/* implicitly borrow buf[i-2] inside tree_desc[i] */
> > +			memcpy(&t[i], &t[i-2], sizeof(struct tree_desc));
> 
> Similar case.
> 
> > +			buf[i] = NULL;
> 
> What makes the previous two entries special, or differently put: Why not
> just check *all* previous entries?  MAX_UNPACK_TREES is 8; the number of
> comparisons would just about double in the worst case and stay the same for
> three trees or less.  The order of four trees or more wouldn't matter
> anymore.

If I understand correctly, we've got N (up to 8) trees, and we want to
find sets of duplicates. Adjacency doesn't matter. Aren't our options
basically:

  - look through all previous entries naively, O(N^2)

  - sort the list, O(N log N); but we need the original order, so we'd
    have to unsort at the end, too

  - use a hash table, O(N) but with O(N) extra storage

I know N=8 isn't very big algorithmically speaking, but it would feel
ugly to introduce something quadratic. Especially the limit of 8 seems
rather arbitrary. In normal cases we see at most a 3-way merge. Beyond
that we're in octopus territory, and 8 is way too low there (I think the
octopus strategy just unpacks one at a time and barfs if there are any
conflicts).

I assume the rationale behind "check the last 2" is just "this
optimization will kick in reliably for all sane cases", weird octopus
unpack-trees be damned (though reading ca885a4fe, it sounds like 4-trees
can actually happen, but I'm not clear on how).

-Peff
