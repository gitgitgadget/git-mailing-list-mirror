Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875DF1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 19:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHKWYm (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 18:24:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:51276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727485AbeHKWYm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 18:24:42 -0400
Received: (qmail 1592 invoked by uid 109); 11 Aug 2018 17:02:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 17:02:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28621 invoked by uid 111); 11 Aug 2018 17:02:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 13:02:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 13:02:48 -0400
Date:   Sat, 11 Aug 2018 13:02:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
Message-ID: <20180811170248.GC27393@sigill.intra.peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 05:47:56PM +0200, René Scharfe wrote:

> Object IDs to skip are stored in a shared static oid_array.  Lookups do
> a binary search on the sorted array.  The code checks if the object IDs
> are already in the correct order while loading and skips sorting in that
> case.
> 
> Simplify the code by using an oidset instead.  Memory usage is a bit
> higher, but lookups are done in constant time and there is no need to
> worry about any sort order.
> 
> Embed the oidset into struct fsck_options to make its ownership clear
> (no hidden sharing) and avoid unnecessary pointer indirection.

I actually had a case[1] yesterday where it seems like oidset is a fair
bit slower than oid_array for a large set.

But:

  - loading the skiplist into memory has pretty lousy performance
    anyway. If we really care about performance of large lists, we
    should define a sorted on-disk format that can be mmap'd and
    searched directly.  Or if people are willing to tolerate false
    positives, even a bloom filter.

    I've never really used a big skiplist myself, so I haven't done any
    work towards those things.

  - we could probably improve the speed of oidset. Two things I notice
    about its implementation:

      - it has to malloc for each entry, which I suspect is the main
	bottleneck. We could probably pool-allocate blocks, and when
	entries get removed just leave the allocations in place until we
	clear(). Most callers tend to build up a set and then query it a
	lot, or possibly remove items from the set until it's empty. But
	my guess is that few or none want a long-lived set that they add
	and remove from randomly.

      - insertion lets you do check-and-insert as a single operation
	(something I failed to notice in [1]). But it's not implemented
	as efficiently as it could be, since the "contains" and "put"
	operations do separate lookups. This doesn't matter for a set
	that's queried a lot more, but for something like de-duping
	(like I was doing in [1]) most operations are check-and-insert.

Most of that is just food for thought, but it possibly argues that we
should not care about performance characteristics for swapping out
oid_array and oidset here (i.e., that your patch is fine, and the
simplicity benefit is the most important thing).

[1] https://public-inbox.org/git/20180810232457.GG19875@sigill.intra.peff.net/
    but note that it's buried pretty deep.

> ---
>  fsck.c | 23 ++---------------------
>  fsck.h |  8 +++++---
>  2 files changed, 7 insertions(+), 24 deletions(-)

Again, I didn't see anything wrong with the patch itself.

-Peff
