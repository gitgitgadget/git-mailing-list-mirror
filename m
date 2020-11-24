Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD74C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DAD20720
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgKXCvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:51:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:39700 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbgKXCvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 21:51:42 -0500
Received: (qmail 30906 invoked by uid 109); 24 Nov 2020 02:51:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 02:51:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10692 invoked by uid 111); 24 Nov 2020 02:51:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 21:51:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 21:51:41 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 01/23] ewah/ewah_bitmap.c: grow buffer past 1
Message-ID: <X7x1PciN+bVDkJhr@coredump.intra.peff.net>
References: <cover.1605123652.git.me@ttaylorr.com>
 <36deaad366d66d10b96755dd6969bfe51123a2d4.1605123652.git.me@ttaylorr.com>
 <xmqqblfpqj4e.fsf@gitster.c.googlers.com>
 <X7vhrCbeFzxaEVvv@nand.local>
 <X7x0du3qoC4vuGtS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7x0du3qoC4vuGtS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 09:48:22PM -0500, Jeff King wrote:

> > I think that we probably could just use ALLOC_GROW() as you suggest.
> > Funny enough, reading through GitHub's chat logs, apparently this is
> > something that Peff and I talked about. So, 16 probably came from
> > alloc_nr(), but we probably stopped short of realizing that we could
> > just use ALLOC_GROW as-is.
> 
> That would probably be OK. It's a bit more aggressive, which could
> matter if you have a large number of very small bitmaps. My original
> goal of the "grow less aggressively" patch was to keep memory usage
> down, knowing that I was going to be holding a lot of bitmaps in memory
> at once. But even with micro-optimizations like this, it turned out to
> be far too big in practice (and hence Stolee's work on top to reduce the
> total number we hold at once).

Oh, sorry, I was mixing this patch up with patches 6 and 7, which touch
buffer_grow().  This is a totally separate spot, and this is a pure
bug-fix.

I think the main reason we didn't use ALLOC_GROW() here in the beginning
is that the ewah code was originally designed to be a separate library
(a port of the java ewah library), and didn't depend on Git code.

These days we pull in xmalloc, etc, so we should be fine to use
ALLOC_GROW().

Likewise...

> I think the real test would be measuring the peak heap of the series as
> you posted it in v2, and this version replacing this patch (and the
> "grow less aggressively" one) with ALLOC_GROW(). On something big, like
> repacking all of the torvalds/linux or git/git fork networks.
> 
> If there's no appreciable difference, then definitely I think it's worth
> the simplicity of reusing ALLOC_GROW().

All of this is nonsense (though it does apply to the question of using
ALLOC_GROW() in bitmap_grow(), via patch 7).

We have many fewer ewah bitmaps in memory at one time, so I don't think
it's worth micro-managing a few extra bytes of growth. Using
ALLOC_GROW() for this case would be fine.

-Peff
