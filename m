Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049611F461
	for <e@80x24.org>; Thu, 27 Jun 2019 21:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfF0VKC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 17:10:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:53064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726426AbfF0VKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 17:10:02 -0400
Received: (qmail 10845 invoked by uid 109); 27 Jun 2019 21:10:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jun 2019 21:10:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11472 invoked by uid 111); 27 Jun 2019 21:10:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Jun 2019 17:10:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jun 2019 17:10:00 -0400
Date:   Thu, 27 Jun 2019 17:10:00 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: fprintf_ln() is slow
Message-ID: <20190627210959.GA20250@sigill.intra.peff.net>
References: <20190627052515.GA21207@sigill.intra.peff.net>
 <20190627055739.GA9322@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906271358260.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906271358260.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 02:00:54PM +0200, Johannes Schindelin wrote:

> > I can get similar speedups by formatting into a buffer:
> [..]
> > But we shouldn't have to resort to that.
> 
> Why not?

My thinking was that it was introducing an extra copy of the data. But
on further reflection, it probably doesn't, at least for the case of an
unbuffered stream (we might want to predicate it on "fp == stderr",
though).

> It would make for a perfectly fine excuse to finally get work going in
> direction of a initially heap-backed strbuf. Which we have wanted for ages
> now.

I assume you initially stack-backed strbuf?

Perhaps. I'm not sure that it's better for the fallback when we need
more than the stack buffer to be allocating more memory as opposed to
just calling fprintf() and sending it out in multiple writes.

> > We can use setvbuf() to toggle buffering back and forth, but I'm not
> > sure if there's a way to query the current buffering scheme for a stdio
> > stream.
> 
> It also is not very safe, especially when we want to have this work in a
> multi-threaded fashion.

I considered that, too, but I think it is safe. stdio has its own
locking, so every individual call is atomic. The potentially problematic
case would be where we switch back from line buffering to no-buffering,
and somebody else has written some content into our stack-based buffer
(that is about to go out of scope!). But I'd assume that as part of the
switch to no-buffering that any stdio implementation would flush out the
buffer that it's detaching from (while under lock). Nothing else makes
sense.

That said...

> I'd be much more comfortable with rendering the string into a buffer and
> then sending that buffer wholesale to stderr.

It's sufficiently complex that I think I prefer to just use our own
buffer, too.

It also makes it more likely for the newline and the message to end up
in an atomic write(), so if multiple threads _are_ writing to stderr
they'd be more likely to stay together.

It does sound like people in the other part of the thread are OK with
just getting rid of the "_ln" functions altogether.

-Peff
