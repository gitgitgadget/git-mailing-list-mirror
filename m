From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Portability: returning void
Date: Wed, 30 Mar 2011 00:13:39 -0400
Message-ID: <20110330041339.GA26281@sigill.intra.peff.net>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie>
 <20110330033017.GA18157@sigill.intra.peff.net>
 <20110330035733.GA2793@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 06:13:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4mn7-0001Ph-RF
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 06:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784Ab1C3ENm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 00:13:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53059
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab1C3ENl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 00:13:41 -0400
Received: (qmail 5725 invoked by uid 107); 30 Mar 2011 04:14:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 00:14:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 00:13:39 -0400
Content-Disposition: inline
In-Reply-To: <20110330035733.GA2793@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170353>

On Tue, Mar 29, 2011 at 10:57:33PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > While we're at it, let's make the "kill" process a little
> > more robust. Specifically:
> >
> >   1. Wrap the "kill" in a test_when_finished, since we want
> >      to clean up the process whether the test succeeds or not.
> >
> >   2. The "kill" is part of our && chain for test success. It
> >      probably won't fail, but it can if the process has
> >      expired before we manage to kill it. So let's mark it
> >      as OK to fail.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Actually, my (2) above is unlikely to trigger, since the test would have
> > to hang for 100 seconds first, which probably means it is failing
> > anyway. But I did run across it when I screwed up my fix.
> 
> That is actually how the tests distinguish between success and
> failure.  Any idea about a better way?

Ah. I was trying not to look too hard at how the tests actually work, so
I completely missed that. Yes, if the "kill" is part of the actual test,
then it should stay in the test. We can also put in a test_when_finished
to kill it should the test fail to make it that far. If the cleanup one
does an extra kill, it shouldn't be a big deal.

> I was in the process of writing a commit message for the same "exec"
> trick, but I'm glad you got to it first. ;-)

I don't know why I didn't think of it sooner. :)

> > Also, is it just me, or does it seem weird that test_when_finished
> > blocks failing can produce test failure? I would think you would be able
> > to put any old cleanup crap into them and not care whether it worked or
> > not.
> 
> I'm generally happy that it catches mistakes in cleanup code, but I
> could easily be convinced to change it anyway.

I don't think it's a big deal. It just surprised me.

> Maybe it would be good to factor out a helper to make future
> improvements a little easier, like so:
> 
> -- 8< --
> Subject: t0081: introduce helper to fill a pipe in the background
> 
> The fill_input function generates a fifo and runs a command to write
> to it and wait a while.  The intended use is to test programs that
> need to be able to cope with input of limited length without relying
> on EOF or SIGPIPE to detect its end.

Yeah, that looks much nicer. Do you want to just re-roll that on top of
what's in 'master', with the "exec" magic and the defensive
test_when_finished in it (or as a separate patch on top if you want to
split the refactor and fix)? Feel free to borrow from my commit message.

-Peff
