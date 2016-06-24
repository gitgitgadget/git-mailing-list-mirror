Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B773F2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbcFXTQv (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:16:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:59906 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbcFXTQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:16:51 -0400
Received: (qmail 30132 invoked by uid 102); 24 Jun 2016 19:16:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:16:50 -0400
Received: (qmail 21813 invoked by uid 107); 24 Jun 2016 19:17:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:17:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 15:16:48 -0400
Date:	Fri, 24 Jun 2016 15:16:48 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 3/4] archive-tar: write extended headers for
 far-future mtime
Message-ID: <20160624191648.GC32118@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232112.GC3668@sigill.intra.peff.net>
 <xmqqshw2flt8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshw2flt8.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 12:06:59PM -0700, Junio C Hamano wrote:

> > +	if (args->time > 077777777777UL) {
> > +		strbuf_append_ext_header_uint(&ext_header, "mtime",
> > +					      args->time);
> > +		args->time = 077777777777UL;
> > +	}
> > +
> > +	if (!ext_header.len)
> > +		return 0;
> 
> Another symbolic constant to explain this, e.g. TAR_TIME_LIMIT, may
> want to exist.

This one at least appears twice. I think one of the reasons I am
slightly resistant to a symbolic constant is that it tempts people to
think that it's OK to change it. It's not. These values are mandated by
POSIX, and must match the size of the ustar header field.

So the least-repetitive thing would be to define it as:

  (1UL << (1 + (3 * (sizeof(ustar_header.mtime) - 1)))) - 1

That's pretty horrible to read, but if wrapped in a symbolic constant,
at least people would think twice before touching it. ;)

-Peff
