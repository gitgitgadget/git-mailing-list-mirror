Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC10FC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 19:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55292100A
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 19:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgHaTXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:23:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:45684 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHaTXE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 15:23:04 -0400
Received: (qmail 21397 invoked by uid 109); 31 Aug 2020 19:23:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 31 Aug 2020 19:23:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19854 invoked by uid 111); 31 Aug 2020 19:23:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Aug 2020 15:23:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Aug 2020 15:23:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ori@eigenstate.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
Message-ID: <20200831192302.GA2819760@coredump.intra.peff.net>
References: <A1CA9D499EDDACBA275BA61E114645F0@eigenstate.org>
 <59efeeab-49de-17e7-8b1c-355d6ef31b5d@web.de>
 <xmqqwo1gglf5.fsf@gitster.c.googlers.com>
 <20200831092946.GA2812764@coredump.intra.peff.net>
 <xmqqk0xehj38.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0xehj38.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 31, 2020 at 09:32:27AM -0700, Junio C Hamano wrote:

> > A related point is that delta chains might be composed of both types. If
> > we don't differentiate between the two types, then the limit is clearly
> > total chain length. If we do, then is the limit the total number of
> > ref-deltas found in the current lookup, or is it the number of
> > consecutive ref-deltas? I guess it would have to be the former if our
> > goal is to catch cycles (since a cycle could include an ofs-delta, as
> > long as a ref-delta is the part that forms the loop).
> 
> Ah, OK, you've thought about it already.
> 
> I wonder we can just count both and limit the chain length to the
> total number of objects in the pack we are currently looking at? 

That's an interesting suggestion. Within a single pack, it does prevent
cycles, and it does so without needing a separate knob, which is nice.

As you note, it only works as long as packs aren't thin. That shouldn't
matter for the current scheme (where all on-disk packs are
self-contained with respect to deltas), but I do wonder if we'll
eventually want to support on-disk thin packs (coupled with a
multi-pack-index, that eliminates most of the reason that one needs
repack existing objects; it's probably a necessary step in scaling to
repos with hundreds of millions of objects). We could still auto-bound
it with the total number of packed objects in the repository, though.

> It
> guarantees to catch any cycle as long as pack is not thin, but is
> that too lenient and likely to bust the stack while counting?  On
> the other side of the coin, we saw 10000 as a hard-coded limit in
> the patch, but do we know 10000 is low enough that most boxes have
> no trouble recursing that deep?

I don't think we have to worry about stack size. We already ran into
stack-busting problems with non-broken cases. ;) That led to 790d96c023
(sha1_file: remove recursion in packed_object_info, 2013-03-25) using
its own stack.

I do wonder about CPU, though. We might have tens of millions of objects
in a single pack file. How long does it take to convince ourselves we're
cycling (even if the cycle itself might only involve a handful of
objects)? I'm not sure we care too much about this being a fast
operation (after all, the point is that it should never happen and we're
just trying not to spin forever). But if it takes 60 minutes to detect
the cycle, from a user's perspective that might not be any different
than an infinite loop.

-Peff
