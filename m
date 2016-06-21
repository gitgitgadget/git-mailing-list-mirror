Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AF51FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbcFUQJd (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:09:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:57942 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752074AbcFUQJd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:09:33 -0400
Received: (qmail 25119 invoked by uid 102); 21 Jun 2016 16:02:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 12:02:51 -0400
Received: (qmail 25938 invoked by uid 107); 21 Jun 2016 16:03:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 12:03:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 12:02:49 -0400
Date:	Tue, 21 Jun 2016 12:02:49 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes
 >= 8GB
Message-ID: <20160621160249.GA9645@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net>
 <57687413.3030609@web.de>
 <20160621155920.GA7549@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160621155920.GA7549@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 11:59:20AM -0400, Jeff King wrote:

> > > +	if (ustar_size(size) != size)
> > > +		strbuf_append_ext_header_uint(&ext_header, "size", size);
> > 
> > It needs "S_ISREG(mode) && " as well, no?  In practice it probably doesn't
> > matter (until someone stores a 8GB long symlink target), but the size field
> > should only be set for regular files.
> 
> Thanks for noticing that. I remembered wondering that when I was early
> in debugging/diagnosing, but forgot to follow up on it. I agree it's
> unlikely in practice, but we should have consistent checks (I think it
> would actually make sense to move the ISREG check inside ustar_size, and
> then we can apply it consistently here and when generating the header;
> my goal with ustar_size() was to avoid having the same logic in multiple
> places).

Actually, scratch that. It makes things awkward because it would be hard
to tell when ustar_size() returned zero because it's a file with a big
size, and thus needs a pax header, versus that it was not a file, and
therefore must _not_ have a pax header.

-Peff
