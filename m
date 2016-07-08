Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F432070D
	for <e@80x24.org>; Fri,  8 Jul 2016 21:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172AbcGHVvS (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 17:51:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:42151 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751658AbcGHVvR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 17:51:17 -0400
Received: (qmail 5124 invoked by uid 102); 8 Jul 2016 21:51:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 17:51:18 -0400
Received: (qmail 15918 invoked by uid 107); 8 Jul 2016 21:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 17:51:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 17:51:14 -0400
Date:	Fri, 8 Jul 2016 17:51:14 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: ignore return value of write_file()
Message-ID: <20160708215114.GC9820@sigill.intra.peff.net>
References: <577EB546.1090007@web.de>
 <alpine.DEB.2.20.1607080830430.6426@virtualbox>
 <577FF48C.4030008@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <577FF48C.4030008@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 08:44:28PM +0200, René Scharfe wrote:

> > The question is whether it makes sense for write_file() to die(). It is a
> > library function and not every caller can be happy with that function to
> > exit the program when some file could not be written, without a chance to
> > tell the user what to do about the situation.
> > 
> > If write_file() was defined in builtin/am.c, as a static function, I would
> > grudgingly acquiesce, but it is not.
> > 
> > IMO it would be better to fix write_file() to *not* die() but return
> > error() instead.
> 
> there is write_file_gently() for that purpose, but it's used only by a
> single caller that exits on failure after all, and in fact Peff's series
> drops it.

Yeah, I always feel funny going in the opposite direction of
libification, as in this case. But having looked at the set of current
and potential-to-convert callers, I couldn't find a single one which
would want the gentle behavior. Any site which doesn't die also wanted
something else more complex (e.g., different open options).

So I think rather than loading down write_file() with options that will
make the simple callers harder to read, we are better off to keep its
implementation simple, and let people call its building blocks easily.

And I think we already have that; in my final version it really is just
xopen/write_in_full/close. So the non-simple sites can still make use of
those components.

-Peff
