Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA24A20989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbcJJUFA (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:05:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:55299 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbcJJUFA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:05:00 -0400
Received: (qmail 13531 invoked by uid 109); 10 Oct 2016 20:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 20:04:59 +0000
Received: (qmail 1413 invoked by uid 111); 10 Oct 2016 20:05:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 16:05:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 16:04:57 -0400
Date:   Mon, 10 Oct 2016 16:04:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Tom Hale <tom@hale.ee>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: respect color settings for %C placeholders
Message-ID: <20161010200457.6dzcrkhoi5id3z4x@sigill.intra.peff.net>
References: <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
 <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
 <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net>
 <42b3be14-fadb-4801-f377-59fb42b7ccdf@web.de>
 <20161010174257.b4uxplavefjyr6rl@sigill.intra.peff.net>
 <19e59db7-f3dd-35ec-8cf1-b070b1c05abe@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19e59db7-f3dd-35ec-8cf1-b070b1c05abe@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 09:59:17PM +0200, René Scharfe wrote:

> > > Shouldn't we have an "else" here?
> > 
> > I'm not sure what you mean; can you write it out?
> 
> > -		if (skip_prefix(begin, "auto,", &begin)) {
> > +
> > +		if (!skip_prefix(begin, "always,", &begin)) {
> >  			if (!want_color(c->pretty_ctx->color))
> >  				return end - placeholder + 1;
> >  		}
> 
> 		else {	/* here */
> 
> > +		/* this is a historical noop */
> > +		skip_prefix(begin, "auto,", &begin);
> 
> 		}
> 
> Otherwise "always,auto," would be allowed and mean the same as "always,",
> which just seems wrong.  Not a biggie.

I don't think that will parse "%C(auto,foo)", as we hit the
!skip_prefix() of the conditional, and do not look for "auto," at all.

I think you'd have to move the check for "auto," inside the if block.

I'm leaning towards just writing it out the long way, though, as I did
in my reply to Junio.

> > > Perhaps it's a funtion like add_color(sb, ctx, color) or similar would be
> > > nice?
> > 
> > I actually wrote it that way first (I called it "maybe_add_color()"),
> > but it felt a little funny to have a separate function that people might
> > be tempted to reuse (the right solution is generally to check
> > want_color() early as above, but we can't do that here because we have
> > to find the end of each placeholder).
> 
> OK.  A variable then?  Lazy pseudo-code:
> 
> 	if (RED)
> 		color = red;
> 	else if (GREEN)
> 		...
> 
> 	if (want_color())
> 		strbuf_addstr(sb, color);

Yeah, that is a bit more clear (the final conditional just needs to
check that we actually found a color).

-Peff
