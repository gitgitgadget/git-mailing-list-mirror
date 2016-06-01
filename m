From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 12:07:36 -0400
Message-ID: <20160601160735.GB9219@sigill.intra.peff.net>
References: <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
 <20160601034413.GC5411@sigill.intra.peff.net>
 <20160601053325.GA20797@sigill.intra.peff.net>
 <20160601054048.GB20797@sigill.intra.peff.net>
 <xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com>
 <20160601070425.GA13648@sigill.intra.peff.net>
 <xmqqfusx0wyj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:08:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88gT-0005DL-NQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbcFAQHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:07:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:47260 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752689AbcFAQHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:07:44 -0400
Received: (qmail 15998 invoked by uid 102); 1 Jun 2016 16:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 12:07:38 -0400
Received: (qmail 1930 invoked by uid 107); 1 Jun 2016 16:07:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 12:07:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 12:07:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfusx0wyj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296095>

On Wed, Jun 01, 2016 at 08:07:16AM -0700, Junio C Hamano wrote:

> > Here's the patch I wrote up earlier (but was too timid to send out after
> > my barrage of emails :) ).
> 
> Looks very sensible.  I'll drop all these "Attempt to test with
> ksh93 found these breakages" patches and queue this one.

Curious based on our previous discussion, I applied your patches and did
a "make SHELL_PATH=/bin/ksh93 test". There were only a handful of
failures remaining. Some were definitely the "../.git" thing (which
Andreas earlier reported as fixed, though the fix still has not made it
into the version in Debian), but some were just puzzling. I shrugged and
gave up.

> > We sometimes get around this by using env, like:
> >
> >   test_must_fail env FOO=BAR some-program
> >
> > But that only works because test_must_fail's arguments are
> > themselves a command which can be run. You can't run:
> 
> We can do "test_must_fail test_commit ...", but "test_must_fail env
> FOO=BAR test_commit ..." would not work, right?
> 
> If so s/because/when/, perhaps?

Right. What I was trying to say is that it works in this case because
test_must_fail further executes its arguments, which gives us an
opportunity to put the "env" on the right-hand side of the function
call. I'm not sure s/because/when/ makes that any better, though.

Maybe:

    We sometimes get around this by using env, like:

      test_must_fail env FOO=BAR some-program

    But that works for test_must_fail because it further runs its
    arguments via the shell, so we can stick the "env" on the right-hand
    side of the function. It would not work to do:

      env FOO=BAR test_must_fail some-program

    because env does not know about our shell functions...

is more clear?

-Peff
