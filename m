Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D6C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB1E64DF5
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232863AbhA2XBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:01:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:41038 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhA2XBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:01:12 -0500
Received: (qmail 4525 invoked by uid 109); 29 Jan 2021 23:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 23:00:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10555 invoked by uid 111); 29 Jan 2021 23:00:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 18:00:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 18:00:30 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBSTjkuW8Mib4o5A@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
 <xmqq35yjtrip.fsf@gitster.c.googlers.com>
 <YBSPlO/ki5vRNX0T@coredump.intra.peff.net>
 <YBSSBviXOL8rM3Ao@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YBSSBviXOL8rM3Ao@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 05:53:58PM -0500, Taylor Blau wrote:

> > I'm still thinking aloud here, and not really sure which is a better
> > path. I do feel like the failure modes for the second one are less
> > risky.
> 
> The more I think about it, the more I feel that the second option is the
> right approach. It seems like if you were naïvely implementing this from
> scratch, that you'd pick the second one (i.e., have pack-objects
> understand a new input mode, and then make a pack based on that).
> 
> I am leery that we'd be able to get the first option "right" without
> attaching some sort of marker to each pack, especially given how
> difficult I think that this is to reason about precisely. I suppose you
> could have a .closed file corresponding to each pack, or alternatively a
> $objdir/pack/pack-geometry file which specifies the same thing, but both
> of these feel overly restrictive.

Yeah, I think my gut feeling matches yours.

> Besides having to special case the loose objects, is there any downside
> to doing the simpler thing here?

The other downside I can think of is that you can't just run "git repack
--geometric" every time, and eventually get a good result (or one that
asymptotically approaches good ;) ). I.e., you now have two types of
repacks: quick and dirty rollups, and "real" ones that do reachability.
So you need some heuristics about how often you do one versus the other.

I'm definitely OK with that outcome. And I think we could even bake
those heuristics into a script or mode of repack (e.g., maybe "gc
--auto" would trigger a bigger repack every N times or something). But
that's what I came up with by brainstorming. :)

-Peff
