From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] fix http deadlock on giant ref negotiations
Date: Fri, 15 May 2015 04:38:43 -0400
Message-ID: <20150515083843.GA16910@peff.net>
References: <20150513210436.GA7407@gmail.com>
 <20150514004724.GA3059@peff.net>
 <20150515062901.GA30768@peff.net>
 <1431675680.14042.39.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri May 15 10:38:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtB8x-0005WZ-9Q
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 10:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934133AbbEOIiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 04:38:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:59100 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934105AbbEOIiq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 04:38:46 -0400
Received: (qmail 29520 invoked by uid 102); 15 May 2015 08:38:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 03:38:46 -0500
Received: (qmail 32645 invoked by uid 107); 15 May 2015 08:38:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 04:38:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 04:38:43 -0400
Content-Disposition: inline
In-Reply-To: <1431675680.14042.39.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269133>

On Fri, May 15, 2015 at 09:41:20AM +0200, Dennis Kaarsemaker wrote:

> > I have no clue how to write a test that would trigger this reliably
> > without requiring a gigantic test fixture. However, I did confirm that
> > it fixes the problem on the chromium case you provided (which otherwise
> > deadlocks reliably for me).
> 
> This looks similar to the failure I posted about alst year in
> http://thread.gmane.org/gmane.comp.version-control.git/258514
> 
> Though the issue is different, it has the same 'hanging git fetch'
> symptom due to the deadlock between upload-pack and http-backend.

Thanks, I think it is the same issue (in the end I was replicating not
with `--reference`, but just by doing a fetch from the other
repository). And our solutions are essentially the same. I do prefer
mine because:

  1. It keeps the buffering logic in http-backend; the half-duplex
     nature is an http detail.

  2. I think it's better to buffer the request rather than the response,
     for the reasons I stated in the commit message.

> The patch I sent back then is suboptimal, as it can cause larger packs
> than necessary (we still use it though, as the alternative is a
> non-working git), but it does include a test you may be able to use to
> verify your fix, if this is indeed the same issue.

I applied the test from your patch, but couldn't get it to fail even
with stock git.  The test above it shrunk a bit, but I was able to tweak
yours to generate tags from 2001..100000, which I thought would have
worked.  I suspect it's something silly like the size not being quite
big enough for the pipe buffer on my system, or something like that.
Though I couldn't get it to fail even with 200,000 tags, so perhaps it's
something else.

-Peff
