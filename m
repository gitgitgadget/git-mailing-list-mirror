From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Tue, 17 May 2016 20:40:08 -0400
Message-ID: <20160518004008.GA20007@sigill.intra.peff.net>
References: <87vb2d37ea.fsf@web.de>
 <8760ucoaus.fsf@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Heerdegen <michael_heerdegen@web.de>
X-From: git-owner@vger.kernel.org Wed May 18 02:40:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2pXF-0006Wm-Fj
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 02:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbcERAkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 20:40:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:41046 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751410AbcERAkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 20:40:11 -0400
Received: (qmail 23821 invoked by uid 102); 18 May 2016 00:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 20:40:10 -0400
Received: (qmail 19210 invoked by uid 107); 18 May 2016 00:40:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 20:40:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2016 20:40:08 -0400
Content-Disposition: inline
In-Reply-To: <8760ucoaus.fsf@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294925>

On Tue, May 17, 2016 at 07:25:31PM +0200, Michael Heerdegen wrote:

> Michael Heerdegen <michael_heerdegen@web.de> writes:
> 
> > the command
> >
> >    git log --pretty=format:%ad --date=format:%s
> >
> > displays wrong unixtime values; apparently how much the printed value
> > differs from the expected value depends on the system's time zone and
> > whether daylight savings time is enabled or not.
> 
> Two more comments:
> 
>   - --date=raw seems to work correctly (though the doc tells it would
>     also use "%s").

I think the doc is misleading there. None of the date formats except the
recently added "--date=format" use strftime at all.

The problem is almost certainly some mismatch between git's idea of the
timezone and what we are feeding to strftime. I'm not sure if it will be
solvable, though. strftime() takes a "struct tm", which has no timezone
field. We feed it a "struct tm" either in the author's timezone or in
the user's timezone (if "format-local" was used). We could feed it in
UTC, but I'm not sure that solves the problem, and it probably makes new
ones.

In your examples, you showed that setting $TZ changes the epoch time
strftime gives us. Which probably means that it is guessing the fed
"struct tm" is in the local timezone, which would still be wrong.

And even if that did work, feeding it UTC means that all of the other
non-%s values would be in UTC, not in the author's or user's timezone.

So we need some way to tell strftime "...and by the way, this is the
timezone for the value we are currently feeding you." There isn't a slot
in "struct tm" for that, but I think maybe you can hack around it by
setting the global "timezone" variable (and then restoring it
afterwards).

>   - When specifying versions like @{N hours}, the result seems to differ
>     (by one hour?) from what I expect, too.

This is probably a totally separate issue, as it would not be using
strftime (or IIRC, any of the standard time functions at all). Do you
have a detailed example that shows the problem?

-Peff
