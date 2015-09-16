From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 16:35:30 -0400
Message-ID: <20150916203530.GD3915@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915153637.GO29753@sigill.intra.peff.net>
 <CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
 <20150916094814.GB13966@sigill.intra.peff.net>
 <xmqqh9muql2c.fsf@gitster.mtv.corp.google.com>
 <20150916185256.GA2654@sigill.intra.peff.net>
 <xmqq1tdyqj2l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kb=dR3omuf1ji8AK9Dh0VCW8pWJ-twWkXXHdDV96RA2QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:35:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJQd-0002Ix-8j
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbbIPUfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:35:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:60334 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752791AbbIPUfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:35:38 -0400
Received: (qmail 25071 invoked by uid 102); 16 Sep 2015 20:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 15:35:38 -0500
Received: (qmail 23097 invoked by uid 107); 16 Sep 2015 20:35:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:35:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 16:35:30 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kb=dR3omuf1ji8AK9Dh0VCW8pWJ-twWkXXHdDV96RA2QA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278064>

On Wed, Sep 16, 2015 at 12:19:10PM -0700, Stefan Beller wrote:

> > That will make future readers wonder "Is this a typo, and if it is,
> > which index is a mistake I can fix?" and may lead to an unnecessary
> > confusion.  I do not want to see a correctly written
> >
> >         xsnprintf(ownbuf[stage], sizeof(ownbuf[0]), "%o", ...);
> >
> > turned into
> >
> >         xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", ...);
> >
> > out of such a confusion.
> 
> So we could just not use the bracket notation, but the pointer then?
> 
>     xsnprintf(ownbuf[stage], sizeof(*ownbuf), "%o", ...);

IMHO that is even more confusing, as I expect sizeof(*ownbuf) to
generally be dereferencing a pointer to a struct, and we would be
writing to "ownbuf". There's not anything _wrong_ with what you've
written, it's just using a syntax that in my mind generally applies to a
different idiom, and I'd wonder if the writer got it wrong.

> IMHO that would reasonably well tell you that we just care about the
> size of one element there.
> 
> A funny thought:
> 
>      xsnprintf(ownbuf[stage], sizeof(ownbuf[-1]), "%o", ...);
> 
> should work as well as any reader would question the sanity
> of a negative index.

I'm not sure what the standard would have to say on that, as the
expression invokes undefined behavior (but of course we're not really
using the expression, only asking for the size). I tried to find any
mention of non-constant indices with sizeof() in the standard, but
couldn't.

I think at this point I'm inclined to switch it back to the original
sizeof(ownbuf[stage]), and we can deal with this if and when any
compiler actually complains.

-Peff
