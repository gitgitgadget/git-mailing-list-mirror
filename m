Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E81D1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbcFUQ0H (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:26:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:57970 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751811AbcFUQ0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:26:06 -0400
Received: (qmail 24950 invoked by uid 102); 21 Jun 2016 15:59:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 11:59:23 -0400
Received: (qmail 25897 invoked by uid 107); 21 Jun 2016 15:59:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 11:59:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 11:59:21 -0400
Date:	Tue, 21 Jun 2016 11:59:21 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes
 >= 8GB
Message-ID: <20160621155920.GA7549@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net>
 <57687413.3030609@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57687413.3030609@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 12:54:11AM +0200, René Scharfe wrote:

> > Unfortunately, it's quite an expensive test to run. For one
> > thing, unless your filesystem supports files with holes, it
> > takes 64GB of disk space (you might think piping straight to
> > `hash-object --stdin` would be better, but it's not; that
> > tries to buffer all 64GB in RAM!). Furthermore, hashing and
> > compressing the object takes several minutes of CPU time.
> > 
> > We could ship just the resulting compressed object data as a
> > loose object, but even that takes 64MB. So sadly, this code
> > path remains untested in the test suite.
> 
> If we could set the limit to a lower value than 8GB for testing then we
> could at least check if the extended header is written, e.g. if ustar_size()
> could be convinced to return 0 every time using a hidden command line
> parameter or an environment variable or something better.

Yes, we could do that, though I think it loses most of the value of the
test. We can check that if we hit an arbitrary value we generate the pax
header, but I think what we _really_ care about is: did we generate an
output that somebody else's tar implementation can handle.

And for the smaller-than-64GB case, GNU tar happily handles our existing
output (though I suspect other tars might fail at "only" 8GB).

> > +static inline unsigned long ustar_size(uintmax_t size)
> > +{
> > +	if (size < 077777777777UL)
> 
> Shouldn't that be less-or-equal?

Yeah, you're right (and for the one in the next patch, too).

> > +	if (ustar_size(size) != size)
> > +		strbuf_append_ext_header_uint(&ext_header, "size", size);
> 
> It needs "S_ISREG(mode) && " as well, no?  In practice it probably doesn't
> matter (until someone stores a 8GB long symlink target), but the size field
> should only be set for regular files.

Thanks for noticing that. I remembered wondering that when I was early
in debugging/diagnosing, but forgot to follow up on it. I agree it's
unlikely in practice, but we should have consistent checks (I think it
would actually make sense to move the ISREG check inside ustar_size, and
then we can apply it consistently here and when generating the header;
my goal with ustar_size() was to avoid having the same logic in multiple
places).

-Peff
