Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1822098B
	for <e@80x24.org>; Sun, 16 Oct 2016 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757455AbcJPTqL (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 15:46:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:58091 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755684AbcJPTqK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 15:46:10 -0400
Received: (qmail 28378 invoked by uid 109); 16 Oct 2016 19:46:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Oct 2016 19:46:10 +0000
Received: (qmail 23573 invoked by uid 111); 16 Oct 2016 19:46:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Oct 2016 15:46:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2016 15:46:08 -0400
Date:   Sun, 16 Oct 2016 15:46:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] avoid pointer arithmetic involving NULL in FLEX_ALLOC_MEM
Message-ID: <20161016194607.a6mhmdida57rhe23@sigill.intra.peff.net>
References: <ccb15072-d949-fc84-ee45-45ba013f53c4@web.de>
 <20161015171325.k2jggjezfmhk3tz7@sigill.intra.peff.net>
 <c99474f2-dac3-e42a-5e4a-02464cac3982@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c99474f2-dac3-e42a-5e4a-02464cac3982@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 16, 2016 at 12:06:02PM +0200, René Scharfe wrote:

> > Yeah, this NULL computation is pretty nasty. I recall trying to get rid
> > of it, but I think it is impossible to do so portably while still using
> > the generic xalloc_flex() helper.
> 
> The only way I see is to pass the type to the macro explicitly (because
> typeof is an extention), and that would make call sites ugly.

Yep, exactly. I really wish we could use typeof(); there are a couple
things that could be made less error-prone and ugly. But it's not even a
matter of C99; it's a GNU-ism, so I don't think we are even close to
having support for it everywhere.

> > This looks correct. I wondered at first why you bothered with
> > flex_array_len, but it is to avoid evaluating the "len" parameter
> > multiple times.
> 
> Right; we could drop that feature of the original macros and require
> users to pass length expressions that don't have side effects -- all of
> them already do that anyway.  But let's keep it in this round; it just
> costs one extra line.

Oh, I think it's worth keeping forever, if only because it makes the
macro interface have one fewer gotcha. Spending a line of code on that
is OK with me.

> > Now that xalloc_flex() has only this one caller remaining, perhaps it
> > should just be inlined here, too, for simplicity.
> 
> -- >8 --
> Subject: [PATCH 2/1] inline xalloc_flex() into FLEXPTR_ALLOC_MEM
> 
> Allocate and copy directly in FLEXPTR_ALLOC_MEM and remove the now
> unused helper function xalloc_flex().  The resulting code is shorter
> and the offset arithmetic is a bit simpler.

Looks good. Thanks for following up.

-Peff
