Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9452018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427307AbcHEVOj (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:14:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:55613 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946137AbcHEVOi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:14:38 -0400
Received: (qmail 11808 invoked by uid 102); 5 Aug 2016 21:14:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 17:14:38 -0400
Received: (qmail 30733 invoked by uid 107); 5 Aug 2016 21:15:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 17:15:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 17:14:35 -0400
Date:	Fri, 5 Aug 2016 17:14:35 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff Hostetler <git@jeffhostetler.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 5/8] status: print per-file porcelain v2 status data
Message-ID: <20160805211434.54mtaw2cty4gaxsr@sigill.intra.peff.net>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-6-git-send-email-git@jeffhostetler.com>
 <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
 <CAPc5daUr7OgFeefbwWLWFt3KW_9X-ijRmHa2oj0--zY4fqt82A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daUr7OgFeefbwWLWFt3KW_9X-ijRmHa2oj0--zY4fqt82A@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 05, 2016 at 02:09:48PM -0700, Junio C Hamano wrote:

> On Fri, Aug 5, 2016 at 2:02 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Aug 02, 2016 at 10:12:14AM -0400, Jeff Hostetler wrote:
> >> +     switch (d->stagemask) {
> >> +     case 1: key = "DD"; break; /* both deleted */
> >> + ...
> >> +     case 7: key = "UU"; break; /* both modified */
> >> +     }
> >> [...]
> >> +     fprintf(s->fp, "%c %s %s %06o %06o %06o %06o %s %s %s %s%c",
> >> +                     unmerged_prefix, key, submodule_token,
> >
> > Coverity complains that "key" can be uninitialized here. I think it's
> > wrong, and just doesn't know that d->stagemask is constrained to 1-7.
> >
> > But perhaps it is worth adding a:
> >
> >   default:
> >         die("BUG: unhandled unmerged status %x", d->stagemask);
> >
> > to the end of the switch. That would shut up Coverity, and give us a
> > better indication if our constraint is violated.
> 
> This is pure curiosity but I wonder if Coverity shuts up if we
> instead switched on (d->stagemask & 07). Your "default: BUG"
> suggestion is what we should use as a real fix, of course.

I suspect yes. It's pretty clever about analyzing the flow and placing
constraints on values (though in this case "& 07" includes "0", which is
not handled in the switch).

Unfortunately it is hard for me to test a one-off, as running it locally
is a complete pain. Stefan set it up long ago to pull "pu" and email out
the results from their central servers, so I just scan those emails for
things that look like real issues.

-Peff
