From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] http-backend: spool ref negotiation requests to
 buffer
Date: Fri, 15 May 2015 15:16:46 -0400
Message-ID: <20150515191646.GA29934@peff.net>
References: <20150515062901.GA30768@peff.net>
 <20150515063339.GB30890@peff.net>
 <xmqqegmhhf9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 21:16:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtL6L-0007Tp-VX
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 21:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934241AbbEOTQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 15:16:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:59396 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754661AbbEOTQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 15:16:49 -0400
Received: (qmail 30860 invoked by uid 102); 15 May 2015 19:16:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 14:16:48 -0500
Received: (qmail 5265 invoked by uid 107); 15 May 2015 19:16:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 15:16:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 15:16:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegmhhf9p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269174>

On Fri, May 15, 2015 at 11:22:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The solution is fairly straight-forward: we read the request
> > body into an in-memory buffer in http-backend, freeing up
> > Apache, and then feed the data ourselves to upload-pack. But
> > there are a few important things to note:
> >
> >   1. We limit in-memory buffer to no larger than 1 megabyte
> >      to prevent an obvious denial-of-service attack. This
> >      is a new hard limit on requests, but it's likely that
> >      requests of this size didn't work before at all (i.e.,
> >      they would have run into the pipe buffer thing and
> >      deadlocked).

So this 1MB limit is clearly a problem, and the reasoning above is not
right. The case we are helping is when a large amount of input creates a
large amount of output. But we're _hurting_ the case where there's just
a large amount of input (as shown by the Dennis's test case).

What do we want to do about that? We can switch to streaming after
hitting our limit (so opening the opportunity for deadlock again in some
cases, but making sure we do no harm to cases that currently work). Or
we can just bump the input size and say "you'd be crazy to send more
than 10MB" (or 50, or whatever). We could make a configuration knob,
too, I guess.

> One unrelated thing I noticed was that three codepaths independently
> have close(0) in run_service() now, and made me follow the two
> helper functions to see they both do the close at the end.  It might
> have made the flow easier to follow if run_service() were
> 
>     ...
>     close(1);
>     if (gzip)
>     	inflate();
>     else if (buffer)
>         copy();
>     close(0);
>     ...
> 
> But that is minor.

I don't see the close(0) in the other (buffered) code paths. We close
the _output_ to the child, but of course we have to do that to tell it
we're done sending (I actually forgot it in an earlier version of
copy_request(), and things hang :) ).

I don't think there's any need to close(0) in the buffered cases. We
read until EOF in the copy() case. For gzip, we read until the end of
the gzipped data. I guess it would be better to close if we're not
expecting more input, as otherwise Apache might block trying to write to
us if the client sends bogus input (i.e., a zlib stream with more cruft
at the end).

> Also, is it worth allocating small and then growing up to the maximum?
> I think this only relays one request at a time anyway, and I suspect
> that a single 1MB allocation at the first call kept getting reused
> may be sufficient (and much simpler).

My initial attempt did exactly that, but I had a much smaller buffer. I
started to get worried around 1MB. If we bump it to 10MB (or make it
configurable), I get more so. I dunno. It is not _that_ much memory, but
it is per-request we are serving, so it might add up on a busy server.
OTOH, pack-objects thinks nothing of allocating 800MB just for the
book-keeping to serve a clone of torvalds/linux.

-Peff
