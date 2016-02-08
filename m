From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add
 -Wdeclaration-after-statement
Date: Mon, 8 Feb 2016 07:25:51 -0500
Message-ID: <20160208122551.GD24217@sigill.intra.peff.net>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 08 13:25:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSktC-0007Qq-Eg
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 13:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbcBHMZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 07:25:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:39153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751552AbcBHMZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 07:25:54 -0500
Received: (qmail 24832 invoked by uid 102); 8 Feb 2016 12:25:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 07:25:53 -0500
Received: (qmail 4526 invoked by uid 107); 8 Feb 2016 12:25:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 07:25:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 07:25:51 -0500
Content-Disposition: inline
In-Reply-To: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285761>

On Mon, Feb 08, 2016 at 09:59:18AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The global Travis-CI environment variable CFLAGS did not override the
> CFLAGS variable in the makefile. Pass CFLAGS as make variable to
> override it properly.

Makes sense.

> In addition to that, add '-Wdeclaration-after-statement' to make a
> Travis-CI build fail (because of '-Werror') if the code does not adhere
> to the Git coding style.

I think this is a good step, but is probably the tip of the iceberg. I
typically use:

  -Wall -Werror -Wdeclaration-after-statement
  -Wpointer-arith -Wstrict-prototypes -Wvla
  -Wold-style-declaration -Wold-style-definition

Junio does his integration testing with a similar set, which I think you
can find in one of the scripts in his "todo" branch.

> I made this patch because Peff pointed out to me that "git style doesn't
> allow declaration-after-statement" [1]. I wonder if it would make sense
> to add this check even in the makefile [2]?

I think we keep the default CFLAGS to a pretty tame set, so that we
build out of the box on a large number of compilers. I know I have run
into problems with -Wold-style-* on clang (though perhaps that is no
longer the case, as I haven't tried recently), let alone truly antique
compilers.

I have, however, wondered if it would make sense to codify this
knowledge in the Makefile with an optional knob. E.g., let DEVELOPER=1
roughly mean "you are a git dev, you have a reasonably modern compiler,
and want to be as careful as possible before sending your patches".

> I am no make expert, but I
> also wonder why we don't use the override directive [3] for the CFLAGS?
> AFAIK this would allow a make invocation like this:
> 
> make target CFLAGS+=-Wdeclaration-after-statement

I think it is rather the opposite. If we used:

  override CFLAGS+= ...

in the Makefile, then if a user did:

  make CFLAGS=...

we would add to their CFLAGS (whereas without the override, our
appending is ignored). Our Makefile solves that in a different way,
though. We pass $(ALL_CFLAGS) to the compiler, and that in turn is made
up of $(CFLAGS) and $(BASIC_CFLAGS). We assume the user tweaks the
former, and we set the latter based on Makefile knobs (e.g., NO_CURL,
etc).

-Peff
