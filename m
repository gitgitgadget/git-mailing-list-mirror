From: Jeff King <peff@peff.net>
Subject: Re: Timezone with DATE_STRFTIME
Date: Mon, 8 Feb 2016 10:44:15 -0500
Message-ID: <20160208154414.GA19978@sigill.intra.peff.net>
References: <20160208143317.GN29880@serenity.lan>
 <20160208152858.GA17226@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 08 16:44:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSnzE-0007ZQ-TR
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 16:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbcBHPoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 10:44:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:39272 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753155AbcBHPoR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 10:44:17 -0500
Received: (qmail 2413 invoked by uid 102); 8 Feb 2016 15:44:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 10:44:17 -0500
Received: (qmail 6201 invoked by uid 107); 8 Feb 2016 15:44:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 10:44:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 10:44:15 -0500
Content-Disposition: inline
In-Reply-To: <20160208152858.GA17226@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285778>

On Mon, Feb 08, 2016 at 10:28:58AM -0500, Jeff King wrote:

> So I think the fix is probably just that we need to feed the zone
> information to strftime via the "struct tm".

Ugh, I forgot how horrible the strftime interface is.

There is no zone information in "struct tm". It gets pulled from the
magic global variable "timezone", and you're supposed to use "tzset" to
set it up. We don't. POSIX says:

  Local timezone information is used as though strftime() called
  tzset().

but on my system that does not seem to be the case. At any rate, our
options are:

  1. Trying to munge a global variable with the timezone information we
     have just for the duration of our strftime call.

or

  2. Admit that strftime's "%z" is crap, and tell people not to use it.

I think I am leaning towards the latter, though unfortunately I don't
think there is a way to find out the author's timezone via
--date=format, then. Perhaps it should default to "--date=format-local:".

-Peff
