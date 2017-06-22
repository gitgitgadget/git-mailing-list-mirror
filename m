Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236BF20802
	for <e@80x24.org>; Thu, 22 Jun 2017 23:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbdFVXPJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 19:15:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:49610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752832AbdFVXPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 19:15:08 -0400
Received: (qmail 30897 invoked by uid 109); 22 Jun 2017 23:15:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 23:15:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7036 invoked by uid 111); 22 Jun 2017 23:15:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 19:15:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 19:15:06 -0400
Date:   Thu, 22 Jun 2017 19:15:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
Message-ID: <20170622231506.prfndno7cipp2d7f@sigill.intra.peff.net>
References: <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b0bc9dab-bd93-c321-9f2e-f1621f857708@web.de>
 <20170618114923.bffmbr5dqe4oivyw@sigill.intra.peff.net>
 <96c26ba2-8548-1693-e803-3a3434ae3a62@web.de>
 <20170618135623.3b27zhzdxur6gpg3@sigill.intra.peff.net>
 <87848e2d-9766-7dad-62cf-ded0c18f6dc3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87848e2d-9766-7dad-62cf-ded0c18f6dc3@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 08:19:40PM +0200, René Scharfe wrote:

> > I'd be OK with keeping it if we could reduce the number of magic
> > numbers. E.g,. rather than 32 elsewhere use:
> > 
> >    (sizeof(*loose_objects_subdir_bitmap) * CHAR_BIT)
> 
> We have a bitsizeof macro for that.
> 
> > and similarly rather than 8 here use
> > 
> >    256 / sizeof(*loose_objects_subdir_bitmap) / CHAR_BIT
> 
> If we're pretending not to know the number of bits in a byte then we
> need to round up, and we have DIV_ROUND_UP for that. :)

Thanks, I meant to mention the rounding thing but forgot. I didn't know
about either of those macros, though.

> There is another example of a bitmap in shallow_c (just search for
> "32").  It would benefit from the macros mentioned above.  That
> might make it easier to switch to the native word size (unsigned int)
> instead of using uint32_t everywhere.
> 
> But perhaps this one is actually a candidate for using EWAH, depending
> on the number of refs the code is supposed to handle.

I thought at first you meant real EWAH bitmaps. But those aren't random
access (so you have to read them into an uncompressed bitmap in memory,
which is why ewah/bitmap.c exists). But if you just mean reusing those
bitmaps, then yeah, possibly.

It looks like it's using a commit slab, though. If you know the number
of bits you need up front, then the commit slab can do it without any
waste. I didn't dig enough to see if that's what it's doing or not.

-Peff
