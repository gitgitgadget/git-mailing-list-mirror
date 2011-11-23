From: Jeff King <peff@peff.net>
Subject: Re: git-bisect working only from toplevel dir
Date: Wed, 23 Nov 2011 16:36:05 -0500
Message-ID: <20111123213605.GA21835@sigill.intra.peff.net>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
 <20111123192329.GA21630@sigill.intra.peff.net>
 <20111123202643.GB6291@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Borowski <kilobyte@angband.pl>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 23 22:36:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTKUI-0002Vb-6z
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 22:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab1KWVgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 16:36:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49442
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab1KWVgH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 16:36:07 -0500
Received: (qmail 6659 invoked by uid 107); 23 Nov 2011 21:36:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Nov 2011 16:36:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Nov 2011 16:36:05 -0500
Content-Disposition: inline
In-Reply-To: <20111123202643.GB6291@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185878>

On Wed, Nov 23, 2011 at 09:26:43PM +0100, Peter Baumann wrote:

> > If we cd_to_toplevel, we can remember the prefix that we started from
> > and cd to it before running the user's command, but there is no
> > guarantee that it actually exists. Maybe that commit should be
> > considered indeterminate then?
> > 
> 
> Why not simply fail the run with exit(-1)? If the directory doesn't exist
> in an older commit (which I think is not that common) git bisect should
> simply stop and let the user proceed.

The point of "git bisect run" is to run unattended until we reach an
answer. I don't think most people would be happy with it not running to
come to _some_ answer (e.g., imagine checking the results of an
overnight "bisect run" in the morning only to find that it stopped 20
minutes in).

That's why I think just marking the commit as indeterminate would be
better; it jumps over parts of history that omit the directory, and will
generally still come to a good conclusion. If it's possible to get an
answer, that is. It might say "we can't come up with an answer because
all of these commits are not testable". But that tells you something,
too: your bisection test is not a good one.

> And yes, I find the current behaviour to forbid running git bisect from
> a subdirectory slighly annoying and I'm glad somebody took a stab at it.

Agreed. I often bisect by hand with two terminals, doing something like:

  [terminal 1]
  git bisect start ...
  make

  [terminal 2]
  cd t
  ./t1234-whatever -v

  [terminal 1]
  git bisect good|bad
  make

  [terminal 2]
  ./t1234-whatever

And then want to type "git bisect good|bad" into terminal 2. Which
doesn't work, of course (yes, in this simple case I could automate the
running of the test script from terminal 1; but often times it is
simpler to just eyeball the output during the bisection).

-Peff
