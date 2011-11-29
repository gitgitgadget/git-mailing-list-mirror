From: Jeff King <peff@peff.net>
Subject: Re: git-bisect working only from toplevel dir
Date: Tue, 29 Nov 2011 07:06:12 -0500
Message-ID: <20111129120612.GA30456@sigill.intra.peff.net>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
 <20111123192329.GA21630@sigill.intra.peff.net>
 <7vzkfma7q9.fsf@alter.siamese.dyndns.org>
 <20111124070659.GC6291@m62s10.vlinux.de>
 <7vd3chage9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Baumann <waste.manager@gmx.de>,
	Adam Borowski <kilobyte@angband.pl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 13:06:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVMS5-000358-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 13:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab1K2MGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 07:06:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55624
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab1K2MGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 07:06:15 -0500
Received: (qmail 31028 invoked by uid 107); 29 Nov 2011 12:12:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 07:12:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 07:06:12 -0500
Content-Disposition: inline
In-Reply-To: <7vd3chage9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186054>

On Thu, Nov 24, 2011 at 03:50:22AM -0800, Junio C Hamano wrote:

> > On Wed, Nov 23, 2011 at 12:45:18PM -0800, Junio C Hamano wrote:
> > ...
> >> Also didn't we make bisect workable in a bare repository recently? So the
> >> start-up sequence has to be something more elaborate like...
> >> ...
> >> and then inside bisect_next() you would check if $prefix exists, and go
> >> there to run bisect--helper (or fail to go there and say "cannot test").
> >
> > But is the "cannot test" aka exit(127) the best we can do in this case?
> 
> Yeah, thinking about it a bit more, it may probably be better to make it a
> failure. The user explicitly asked "be in _this_ directory and run make;
> it should succeed for the bisection test to pass". If the bisection test
> criterion the user was interested in was a successful build of the whole
> project (not the subpart of the current directory), the user would have
> gone up to the top-level and "bisect run make" there.

There are more possibilities than that. For example, imagine a project
with two sibling directories, one a library and one a command that is
built on the library. The library has a bug that we want to bisect, but
the command is the only mechanism we have to test the bug. The command's
Makefile points to the library directory (e.g., using recursive
make[1]).  It would be natural for the user to do something like:

  cd cmd
  make && ./test-cmd
  : hmph, it's broken
  git bisect start
  git bisect bad
  : I think v1.1 was OK
  git checkout v1.1
  make && ./test-cmd
  : Yep, let's run.
  git bisect good
  git bisect run 'make && ./test-cmd'

If, somewhere in the middle, the current directory doesn't exist, then
our test harness does not exist. And we can't say good or bad, but only
"don't know".  Not knowing all of the details of what the user's command
does, that seems to me to be the only safe option.

The worst case is that the bisection takes longer to run and says "I
don't know where the bug is, but it's in this range", and the user has
to go back and run it again with a smarter test. But if we return "no,
the test failed" then we are likely going to just produce nonsensical
results, as our search is hitting on two different errors, and the "bug"
will appear to come and go.

It might be tempting to say that this case can't come up. After all, at
the branch tip the bug is there, and in v1.1 it isn't. What is the
chance that the test harness goes away in the middle? In a linear
history, not hight. But if you have history like this:


       D--*--*--*
      /          \
  *--*--A--B--C---*--E

where:

  - A introduces the "cmd" directory
  - B is v1.1 (known good)
  - C is the location of the actual bug
  - D is on a side branch, but does _not_ have "cmd"
  - E is our current tip (known bad)

then we will have to search down the side branch towards D to look for
the bug.

If this seems contrived, well, it is. In 99% of cases, the directory
_won't_ go away, and none of this will matter.  And of course you can
have this exact same problem even without the directory issue. If your
test command is "make && ./test-harness", and the side branch doesn't
have the harness, then it's going to erroneously report the presence of
the bug. But that's your fault for writing a crappy test command that
wasn't careful about verifying the pre-conditions.

So maybe it doesn't matter; there are a lot of ways to shoot yourself in
the foot with a bisection. I just think git should set a good example
and default to being conservative with its claims.

-Peff
