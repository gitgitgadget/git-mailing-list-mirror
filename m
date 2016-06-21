Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2201FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 21:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbcFUVDN (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 17:03:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:58148 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751516AbcFUVDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 17:03:11 -0400
Received: (qmail 6109 invoked by uid 102); 21 Jun 2016 21:02:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 17:02:36 -0400
Received: (qmail 28733 invoked by uid 107); 21 Jun 2016 21:02:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 17:02:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 17:02:34 -0400
Date:	Tue, 21 Jun 2016 17:02:34 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes
 >= 8GB
Message-ID: <20160621210234.GB4747@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net>
 <57687413.3030609@web.de>
 <20160621155920.GA7549@sigill.intra.peff.net>
 <5769A6CC.9030001@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5769A6CC.9030001@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 10:42:52PM +0200, René Scharfe wrote:

> >> If we could set the limit to a lower value than 8GB for testing then we
> >> could at least check if the extended header is written, e.g. if ustar_size()
> >> could be convinced to return 0 every time using a hidden command line
> >> parameter or an environment variable or something better.
> > 
> > Yes, we could do that, though I think it loses most of the value of the
> > test. We can check that if we hit an arbitrary value we generate the pax
> > header, but I think what we _really_ care about is: did we generate an
> > output that somebody else's tar implementation can handle.
> 
> I agree with the last point, but don't see how that diminishes the
> value of such a test.  If we provide file sizes only through extended
> headers (the normal header field being set to 0) and we can extract
> files with correct sizes then tar must have interpreted those header
> as intended, right?

The diminished value is:

  1. This is a situation that doesn't actually happen in real life.

  2. Now we're carrying extra code inside git only for the sake of
     testing (which can have its own bugs, etc).

Still, it may be better than nothing.

> -- >8 --
> Subject: archive-tar: test creation of pax extended size headers
> 
> ---
> The value 120 is magic; we need it to pass the tests.  That's
> because prepare_header() is used for building extended header
> records as well and we don't create extended headers for extended
> headers (not sure if that would work anyway), so they simply
> vanish when they're over the limit as their size field is set to
> zero.

Right, so this is sort of what I meant in (2). Now we have a
tar.ustarsizemax setting shipped in git that is totally broken if you
set it to "1".

I can live with it as a tradeoff, but it is definitely a negative IMHO.

-Peff
