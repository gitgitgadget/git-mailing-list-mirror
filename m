Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FC41FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 21:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbcFXVJK (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 17:09:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:60096 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751109AbcFXVJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 17:09:09 -0400
Received: (qmail 4366 invoked by uid 102); 24 Jun 2016 21:09:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 17:09:08 -0400
Received: (qmail 23106 invoked by uid 107); 24 Jun 2016 21:09:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 17:09:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 17:09:06 -0400
Date:	Fri, 24 Jun 2016 17:09:06 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
Message-ID: <20160624210906.GD6282@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232041.GA3668@sigill.intra.peff.net>
 <xmqq1t3mh0vg.fsf@gitster.mtv.corp.google.com>
 <20160624190744.GA32118@sigill.intra.peff.net>
 <CAPig+cRD43DnaiZrT4ODnT7Nm5J8q=MhtSeyK3ZNjwaTW8mdbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRD43DnaiZrT4ODnT7Nm5J8q=MhtSeyK3ZNjwaTW8mdbg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 04:58:58PM -0400, Eric Sunshine wrote:

> On Fri, Jun 24, 2016 at 3:07 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, Jun 24, 2016 at 11:56:19AM -0700, Junio C Hamano wrote:
> >> Jeff King <peff@peff.net> writes:
> >> > +tar_info () {
> >> > +   "$TAR" tvf "$1" | awk '{print $3 " " $4}' | cut -d- -f1
> >> > +}
> >
> >> Seeing an awk piped into cut always makes me want to suggest a
> >> single sed/awk/perl invocation.
> >
> > I want the auto-splitting of awk, but then to auto-split the result
> > using a different delimiter. Is there a not-painful way to do that in
> > awk?
> 
> The awk split() function is POSIX and accepts an optional separator argument.

Thanks. I'm not that familiar with awk functions, simply because I came
of age after perl existed, and using perl tends to be more portable and
powerful (if you can assume it's available). But this is simple enough
that it should be OK.

Replacing it with:

        "$TAR" tvf "$1" |
        awk '{
                split($4, date, "-")
                print $3 " " date[1]
        }'

seems to work.

-Peff
