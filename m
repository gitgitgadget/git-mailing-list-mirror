From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Tue, 7 Apr 2015 15:04:14 -0400
Message-ID: <20150407190413.GB2553@peff.net>
References: <20150405010611.GA15901@peff.net>
 <20150405011110.GC30127@peff.net>
 <20150405045614.GA12053@peff.net>
 <87zj6kjbgu.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Tue Apr 07 21:04:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfYnR-0001Wu-No
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 21:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbbDGTES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 15:04:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:43491 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750883AbbDGTER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 15:04:17 -0400
Received: (qmail 15269 invoked by uid 102); 7 Apr 2015 19:04:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Apr 2015 14:04:17 -0500
Received: (qmail 22782 invoked by uid 107); 7 Apr 2015 19:04:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Apr 2015 15:04:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2015 15:04:14 -0400
Content-Disposition: inline
In-Reply-To: <87zj6kjbgu.fsf@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266932>

On Tue, Apr 07, 2015 at 03:48:33PM +0200, Rasmus Villemoes wrote:

> >   3. Find some alternative that is more robust than fgets, and faster
> >      than getc. I don't think there is anything in stdio, but I am not
> >      above dropping in a faster non-portable call if it is available,
> >      and then falling back to the current code otherwise.
> 
> getdelim is in POSIX 2008
> (http://pubs.opengroup.org/stage7tc1/functions/getdelim.html), so should
> be available on any half-{d,r}ecent platform. It obviously has the
> advantage of having access to the internal stdio buffer, and by
> definition handles embedded NULs. No idea if using such modern
> interfaces in git is ok, though.

Thanks, that's perfect. I knew about getline(), but not getdelim(), and
I had thought getline() unconditionally malloc'd. But it doesn't; it
behaves exactly as we are already doing here. :-/

> Implementation-wise, I think strbuf_getwholeline could be implemented
> mostly as a simple wrapper for getdelim. If I'm reading the current code
> and the posix spec for getdelim correctly, something like this should do
> it (though obviously not meant to be included as-is):

I think it's close to what we want. strbuf_grow calls xrealloc, which
will call try_to_free_routine() and possibly die() for us. So we would
probably want to check errno on failure and respond similarly if we get
ENOMEM.

Your patch performs even faster than my fgets version (about 8%).

I wonder if it is even worth doing the getc_unlocked dance at all. It
would potentially speed up the fallback code, but my hope that would be
that most systems would simply use the getdelim() version.

-Peff
