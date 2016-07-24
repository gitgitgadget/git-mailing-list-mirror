Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F97203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 15:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcGXPa6 (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 11:30:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:48360 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752172AbcGXPan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 11:30:43 -0400
Received: (qmail 5503 invoked by uid 102); 24 Jul 2016 15:30:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jul 2016 11:30:42 -0400
Received: (qmail 19294 invoked by uid 107); 24 Jul 2016 15:31:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jul 2016 11:31:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jul 2016 11:30:36 -0400
Date:	Sun, 24 Jul 2016 11:30:36 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] format-patch: escape "From " lines recognized by
 mailsplit
Message-ID: <20160724153035.GA32304@sigill.intra.peff.net>
References: <20160722224739.GA22961@whir>
 <alpine.DEB.2.20.1607231056150.14111@virtualbox>
 <20160724031409.GA32480@starla>
 <20160724031543.GC32480@starla>
 <alpine.DEB.2.20.1607240926500.14111@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607240926500.14111@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 24, 2016 at 09:37:57AM +0200, Johannes Schindelin wrote:

> On Sun, 24 Jul 2016, Eric Wong wrote:
> 
> > @@ -1745,9 +1746,18 @@ void pp_remainder(struct pretty_print_context *pp,
> >  			strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
> >  					     line, linelen);
> >  		else {
> > -			if (pp->fmt == CMIT_FMT_MBOXRD &&
> > -					is_mboxrd_from(line, linelen))
> > -				strbuf_addch(sb, '>');
> > +			switch (pp->fmt) {
> > +			case CMIT_FMT_EMAIL:
> > +				if (is_from_line(line, linelen))
> > +					strbuf_addch(sb, '>');
> > +				break;
> > +			case CMIT_FMT_MBOXRD:
> > +				if (is_mboxrd_from(line, linelen))
> > +					strbuf_addch(sb, '>');
> > +				break;
> > +			default:
> > +				break;
> > +			}
> 
> Sorry to be nitpicking once again; I think this would be conciser (and
> easier to read at least for me) as:
> 
> -			if (pp->fmt == CMIT_FMT_MBOXRD &&
> -					is_mboxrd_from(line, linelen))
> +			if ((pp->fmt == CMIT_FMT_MBOXRD &&
> +			     is_mboxrd_from(line, linelen)) ||
> +			    (pp->fmt == CMIT_FMT_EMAIL &&
> +			     is_from_line(line, linelen)))
>  				strbuf_addch(sb, '>');

Since we are nitpicking, I think:

  static int needs_from_quoting(enum cmit_fmt fmt,
                                const char *line, size_t len)
  {
	if (fmt == CMIT_FMT_MBOXRD && is_mboxrd_from(line, linelen))
		return 1;
	if (fmt == CMIT_FMT_EMAIL && is_from_line(line, linelen))
		return 1;
	return 0;
  }

  ...
  if (needs_from_quoting(pp->fmt, line, linelen))
	strbuf_addch(sb, '>');

is even nicer. There are lots of alternatives to write the helper
function, and I do not care much which one is chosen. But splitting it
out into a concise "do we need to do this?" query function makes the
flow in pp_remainder much easier to follow.

-Peff
