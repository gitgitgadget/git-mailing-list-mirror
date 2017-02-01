Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8391FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 11:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdBALsD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 06:48:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:47754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbdBALsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 06:48:02 -0500
Received: (qmail 17381 invoked by uid 109); 1 Feb 2017 11:47:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 11:47:56 +0000
Received: (qmail 10117 invoked by uid 111); 1 Feb 2017 11:47:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 06:47:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2017 12:47:51 +0100
Date:   Wed, 1 Feb 2017 12:47:51 +0100
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
Message-ID: <20170201114750.r5xdy6emdczmnh4j@sigill.intra.peff.net>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
 <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
 <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
 <20170130222157.GC35626@google.com>
 <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
 <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702011225250.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1702011225250.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2017 at 12:28:13PM +0100, Johannes Schindelin wrote:

> > One funny thing is that your macro takes address-of itself, behind the
> > scenes. I wonder if it would be more natural for it to take
> > pointers-to-objects, making it look more like a real function (i.e.,
> > SWAP(&a, &b) instead of SWAP(a, b)". And then these funny corner cases
> > become quite obvious in the caller, because the caller is the one who
> > has to type "&".
> 
> But forcing SWAP(&a, &b) would make it even more cumbersome to use, and it
> would also make it harder to optimize, say, by using registers instead of
> addressable memory (think swapping two 32-bit integers: there is *no* need
> to write them into memory just to swap them).

I don't find the register thing compelling at all. I'd expect modern
compilers to optimize *(&a) into just "a" and keep using a register. I'm
sure there are compilers that don't, but I'm also not sure how much we
_care_. If your compiler doesn't do basic micro-optimizations, then you
live with it or get a better compiler.

I'm much more interested in what's readable and maintainable, versus
trying to micro-optimize something that hasn't even been shown to be
measurably interesting.

That said...

> And I think I should repeat my point that this discussion veers towards
> making simple swaps *more* complicated, rather than less complicated. Bad
> direction.

I'm not altogether convinced that SWAP() is an improvement in
readability. I really like that it's shorter than the code it replaces,
but there is a danger with introducing opaque constructs. It's one more
thing for somebody familiar with C but new to the project to learn or
get wrong.

IMHO the main maintenance gain from René's patch is that you don't have
to specify the type, which means you can never have a memory-overflow
bug due to incorrect types. If we lose that, then I don't see all that
much value in the whole thing.

-Peff
