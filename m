From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Wed, 18 May 2016 13:49:19 -0400
Message-ID: <20160518174919.GA5796@sigill.intra.peff.net>
References: <87vb2d37ea.fsf@web.de>
 <8760ucoaus.fsf@web.de>
 <20160518004008.GA20007@sigill.intra.peff.net>
 <20160518005824.GA7120@sigill.intra.peff.net>
 <xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Heerdegen <michael_heerdegen@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 19:49:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b35b5-00061F-JQ
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 19:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbcERRtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 13:49:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:41354 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752772AbcERRtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 13:49:22 -0400
Received: (qmail 15196 invoked by uid 102); 18 May 2016 17:49:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 13:49:22 -0400
Received: (qmail 24734 invoked by uid 107); 18 May 2016 17:49:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 13:49:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 13:49:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294982>

On Wed, May 18, 2016 at 09:21:34AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I tried a few obvious things, but couldn't make anything work. Setting
> > "timezone" manually seems to do nothing. It's supposed to be set by
> > putting the right thing in $TZ and then calling tzset(). So I tried
> > munging $TZ to something like "+0200". It did have _some_ effect, but I
> 
> Wouldn't that be more like "UTC+0200"?

Maybe. I tried several different things, and couldn't make it work
sensibly with any of them. My test case is basically:

  git log --format="%ad%n%at" --date=format:'%H:%M %z (%Z)%n%s'

Which should give three lines: the human-readable time and date,
strftime's epoch time, and git's epoch time. And the following
conditions should be met:

  1. The human-readable time is in the author's timezone (or the user's
     if you use format-local).

  2. The zone offset and name in the first line matches the time we
     show.

  3. The epoch times for the latter lines should match.

We currently get (1) right (which is good, because it is IMHO the most
important). I haven't been able to get (2) to change at all, no matter
what I do. And (3) is the subject of debate here; I suspect I could make
it work at the cost of breaking (1) by giving a "struct tm" that is in
UTC.

> In any case, I do not think anybody wants to do tzset() on each and
> every commit while running "git log".  Can we declare "format:<strftime>"
> will always use the local timezone, or something?

I think that is basically the case already. It is in the author's
timezone or in the viewing user's timezone (as reported by localtime()),
and everything seems to work except the %z zone information and the %s
format.

For a raw "%s" date-format, my suggestion is: don't. It is redundant
with --date=raw.

I'd love to make %z work, but I have no idea how.

So I guess we could list those in BUGS in one of the manpages.

-Peff
