Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C764BC63697
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 03:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D1C206FA
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 03:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgKXDAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:00:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:39710 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgKXDAn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 22:00:43 -0500
Received: (qmail 30947 invoked by uid 109); 24 Nov 2020 03:00:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 03:00:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10729 invoked by uid 111); 24 Nov 2020 03:00:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 22:00:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 22:00:42 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 07/23] ewah: make bitmap growth less aggressive
Message-ID: <X7x3WtCItVGhQ57O@coredump.intra.peff.net>
References: <cover.1605123652.git.me@ttaylorr.com>
 <c7db594fae4d0447a55a92e830475d9bc418ae7f.1605123652.git.me@ttaylorr.com>
 <xmqq7dqdqgji.fsf@gitster.c.googlers.com>
 <X7voLUlevHygqFg/@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7voLUlevHygqFg/@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 11:49:49AM -0500, Taylor Blau wrote:

> On Sun, Nov 22, 2020 at 12:32:01PM -0800, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > >  - a geometric increase in existing size; we'll switch to 3/2 instead of
> > >    2 here. That's less aggressive and may help avoid fragmenting memory
> > >    (N + 3N/2 > 9N/4, so old chunks can be reused as we scale up).
> >
> > I am sure this is something obvious to bitmap folks, but where does
> > 9N/4 come from (I get that the left-hand-side of the comparison is
> > the memory necessary to hold both the old and the new copy while
> > reallocating the words[] array)?
> 
> I thought that I was in the group of "bitmap folks", but since it's not
> obvious to me either, I guess I'll have to hand in my bitmap folks
> membership card ;).
> 
> Peff: where does 9N/4 come from?

it is not a bitmap thing at all. We are growing a buffer, so if we
continually multiply it by 3/2, then our sequence of sizes is:

  - before growth: N
  - after 1 growth: 3N/2
  - after 2 growths: 9N/4

Meaning we can fit the third chunk into the memory vacated by the second
two. Whereas with a factor of, say 2:

  - before growth: N
  - after 1 growth: 2N
  - after 2 growth: 4N

which does not fit, and fragments your memory.

There's a slight lie there, which is that you'll typically still hold
the growth G-1 while doing growth G (after all, that is where you will
copy the data from). But it still works out that you eventually get to
use old chunks. The breakeven point is actually the golden ratio, but a)
it's irrational and b) it probably makes sense to give some slop for
malloc chunk overhead. 1.6 would probably be fine, too, though. :)

> On a similar note: we could certainly
> use ALLOC_GROW here, too, but it would change the behavior slightly (by
> using alloc_nr()'s "add-16-first" behavior). Maybe we should be using
> it, but I'll defer to your judgement.

That would be OK, modulo the measurement question I asked in the other
(wrong) part of the thread.

-Peff
