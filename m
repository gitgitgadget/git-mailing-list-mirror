From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] fix http deadlock on giant ref negotiations
Date: Fri, 15 May 2015 04:53:55 -0400
Message-ID: <20150515085355.GA18890@peff.net>
References: <20150513210436.GA7407@gmail.com>
 <20150514004724.GA3059@peff.net>
 <20150515062901.GA30768@peff.net>
 <1431675680.14042.39.camel@kaarsemaker.net>
 <20150515083843.GA16910@peff.net>
 <1431679490.14042.42.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri May 15 10:54:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtBNc-0004dv-EK
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 10:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934176AbbEOIyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 04:54:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:59110 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932092AbbEOIx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 04:53:58 -0400
Received: (qmail 30354 invoked by uid 102); 15 May 2015 08:53:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 03:53:58 -0500
Received: (qmail 32743 invoked by uid 107); 15 May 2015 08:53:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 04:53:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 04:53:55 -0400
Content-Disposition: inline
In-Reply-To: <1431679490.14042.42.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269135>

On Fri, May 15, 2015 at 10:44:50AM +0200, Dennis Kaarsemaker wrote:

> > I applied the test from your patch, but couldn't get it to fail even
> > with stock git.  The test above it shrunk a bit, but I was able to tweak
> > yours to generate tags from 2001..100000, which I thought would have
> > worked.  I suspect it's something silly like the size not being quite
> > big enough for the pipe buffer on my system, or something like that.
> > Though I couldn't get it to fail even with 200,000 tags, so perhaps it's
> > something else.
> 
> The shrinkage in the test above it will actually work around the issue,
> as there are now fewer already-fetched tags to negotiate. Either
> reverting that shrinkage or executing the new test twice should do the
> trick.

Ah, right, that makes sense. I was creating the right number of tags,
but not with half of them already in the repo when I did the critical
fetch. I got it to fail by adding and fetching another 48,000, and then
adding and fetching another 50,000 on top of that.

Interestingly, with my patch the _first_ fetch fails, that otherwise
succeeds with stock git. My patch sets a maximum size on the spool
buffer, and we exceed it. I guess 1MB isn't enough for pathological
cases. I'm hesitant to let it expand indefinitely for security reasons,
but we could probably bump it to 10MB or something.

I dunno. I'm not excited about introducing new size restrictions that
were not there before.

Maybe it's time to implement git-over-websockets. ;)

-Peff
