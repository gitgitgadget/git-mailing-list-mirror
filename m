From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/14] log: refactor add_header to drop some magic numbers
Date: Fri, 1 Jan 2016 03:46:21 -0500
Message-ID: <20160101084621.GA22563@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
 <20151229072048.GB8842@sigill.intra.peff.net>
 <CAPig+cRgK5Ey8WNDLLOnAhR+xh6NEHk-hGhGccj4SkZO-RV_-Q@mail.gmail.com>
 <20160101084206.GB20715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 09:46:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEvLw-0007lH-7t
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 09:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbcAAIqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 03:46:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:47623 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751253AbcAAIqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 03:46:24 -0500
Received: (qmail 13639 invoked by uid 102); 1 Jan 2016 08:46:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jan 2016 03:46:24 -0500
Received: (qmail 14842 invoked by uid 107); 1 Jan 2016 08:46:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jan 2016 03:46:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jan 2016 03:46:21 -0500
Content-Disposition: inline
In-Reply-To: <20160101084206.GB20715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283249>

On Fri, Jan 01, 2016 at 03:42:06AM -0500, Jeff King wrote:

> On Thu, Dec 31, 2015 at 01:21:42AM -0500, Eric Sunshine wrote:
> 
> > > -       item->string[len] = '\0';
> > > +       len = strlen(item->string);
> > > +       while (len && item->string[len - 1] == '\n')
> > > +               item->string[--len] = '\0';
> > 
> > Not a strong objection, but this implementation may make the reader
> > wonder why NUL needs to be assigned to all "stripped" characters. I'd
> > have expected to see:
> > 
> >     len = strlen(item->string);
> >     while (len && item->string[len - 1] == '\n')
> >         len--;
> >     item->string[len] = '\0';
> > 
> > which indicates clearly that this is a simple truncation rather than
> > some odd NUL-fill operation, and is slightly more easy to reason about
> > since it doesn't involve a pre-decrement as an array subscript.
> 
> Hmm. I consider the "write NULs backward" strategy to be pretty
> idiomatic (you can find several similar ones grepping for `\[--` in the
> git codebase). But that may just be me (I didn't look, but it's possible
> I wrote the other ones, too :) ).
> 
> I don't have a strong preference, though. What you've written is quite
> readable.

Actually, looking at the diff, the original already has your final line
(it _has_ to do the search and NUL-write separately because it does the
former before allocating the copy). So between the two options, yours
makes the diff more obvious, too, which is a good thing. I'll take your
suggestion.

-Peff
