From: Jeff King <peff@peff.net>
Subject: Re: Timezone with DATE_STRFTIME
Date: Mon, 8 Feb 2016 10:28:58 -0500
Message-ID: <20160208152858.GA17226@sigill.intra.peff.net>
References: <20160208143317.GN29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 08 16:29:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSnkR-0005aG-3L
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 16:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbcBHP3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 10:29:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:39250 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753833AbcBHP3B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 10:29:01 -0500
Received: (qmail 1752 invoked by uid 102); 8 Feb 2016 15:29:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 10:29:00 -0500
Received: (qmail 5939 invoked by uid 107); 8 Feb 2016 15:29:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 10:29:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 10:28:58 -0500
Content-Disposition: inline
In-Reply-To: <20160208143317.GN29880@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285774>

On Mon, Feb 08, 2016 at 02:33:17PM +0000, John Keeping wrote:

> I have just noticed that with DATE_STRFTIME, the timezone in the output
> is likely to be incorrect.
> 
> For all other time formats, we print the string ourselves and use the
> correct timezone from the input, but with DATE_STRFTIME strftime(3) will
> always use the system timezone.

You mean here that the "%z" formatting will not be correct, right?
AFAICT the time shown is generally correct for the original of the
author, and we simply need to communicate the zone to strftime.

Taking the current tip of master, for instance, I get:

  $ for i in \
      default \
      local \
      "format:%H:%M %z" \
      "format-local:%H:%M %z"; do
            git log -1 --format=%ad --date="$i" ff4ea6004
    done
  Fri Feb 5 15:24:02 2016 -0800
  Fri Feb 5 18:24:02 2016
  15:24 +0000
  18:24 +0000

You can see that my system is in -0500, three hours ahead of the author.
And as expected, strftime shows the time in the original author's
timezone. The %z information is totally bogus, but I don't think it has
anything to do with the system time. It is simply that we don't provide
it (...but having just looked at _your_ local timezone from your email,
I can guess how you got confused :) ).

So I think the fix is probably just that we need to feed the zone
information to strftime via the "struct tm".

-Peff
