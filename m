Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A9F203C5
	for <e@80x24.org>; Thu, 21 Jul 2016 21:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbcGUVDJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 17:03:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:48281 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753954AbcGUVDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 17:03:08 -0400
Received: (qmail 28027 invoked by uid 102); 21 Jul 2016 21:03:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Jul 2016 17:03:00 -0400
Received: (qmail 335 invoked by uid 107); 21 Jul 2016 21:03:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Jul 2016 17:03:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jul 2016 17:02:54 -0400
Date:	Thu, 21 Jul 2016 17:02:54 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strbuf_addbuf() for appending a strbuf to another
Message-ID: <20160721210253.GA4604@sigill.intra.peff.net>
References: <578E732D.2090803@web.de>
 <20160720132025.GD17469@sigill.intra.peff.net>
 <5790FC74.6000602@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5790FC74.6000602@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 21, 2016 at 06:46:44PM +0200, René Scharfe wrote:

> >> -	strbuf_add(out, untracked->ident.buf, untracked->ident.len);
> >> +	strbuf_addbuf(out, &untracked->ident);
> > 
> > This is actually slightly _less_ efficient, because we already are using
> > the precomputed len, and the new code will call an extra strbuf_grow()
> > to cover the case where the two arguments are the same.  See 81d2cae
> > (strbuf_addbuf(): allow passing the same buf to dst and src,
> > 2010-01-12).
> 
> Ah, I wasn't aware of that.  Calling strbuf_grow() twice shouldn't be
> thaaat bad.  However, I wonder where we duplicate strbufs, or why we
> would ever want to do so.  Anyway, here's a patch for that:

I don't think we do. Going back to the original discussion:

  http://thread.gmane.org/gmane.comp.version-control.git/136141/focus=136774

it was mostly just "hey, this would fail really confusingly if we ever
did, so let's make it safe".

The second strbuf_grow() is by definition a noop (which is why 81d2cae
works at all), but we do pay the size-computation cost.

> -- >8 --
> Subject: strbuf: avoid calling strbuf_grow() twice in strbuf_addbuf()
> 
> Implement strbuf_addbuf() as a normal function in order to avoid calling
> strbuf_grow() twice, with the second callinside strbud_add() being a
> no-op.  This is slightly faster and also reduces the text size a bit.

Seems reasonable.  IMHO the main advantage is that one does not have to
reason about the double strbuf_grow() (i.e., that the strbuf_add() is
safe because we know its grow is a noop).

-Peff
