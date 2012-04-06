From: Jeff King <peff@peff.net>
Subject: Re: Interleaved remote branch update problems
Date: Fri, 6 Apr 2012 02:09:47 -0400
Message-ID: <20120406060947.GB25301@sigill.intra.peff.net>
References: <201204051549.14397.mfick@codeaurora.org>
 <20120406003710.GC14224@sigill.intra.peff.net>
 <9a97881f-a49e-47b2-9c14-b067bc7a525c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 08:09:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG2Mw-0001jb-9C
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 08:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab2DFGJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 02:09:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49676
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab2DFGJw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 02:09:52 -0400
Received: (qmail 32068 invoked by uid 107); 6 Apr 2012 06:09:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 02:09:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 02:09:47 -0400
Content-Disposition: inline
In-Reply-To: <9a97881f-a49e-47b2-9c14-b067bc7a525c@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194848>

On Thu, Apr 05, 2012 at 11:32:40PM -0600, Martin Fick wrote:

> >Yes, that's expected. --force means "it's OK to push something that
> > will rewind history", not "it's OK to clobber somebody else who is
> > pushing at the same time".
> 
> But why is it ok to clobber somebody else right after they pushed,
> this seems like splitting hairs?  Why force me to wait to clobber?

Because it gives you a chance to take it back. You have told git "it is
OK to move from A to B, even if that is a rewind". You did not tell it
"it is OK to move C to B". Imagine your workflow is:

  1. Try to push B, and see that the remote is at A; your push is
     rejected.

  2. Examine "git log --graph A...B" and see that yes, your B is an
     amendment over A, and so it is OK to push. Or maybe you just happen
     to know what B and A are, because you just pushed a broken A and
     are amending it, in which case you can skip the log. But the point
     is that the user makes a decision about the case.

  3. Do "git push -f" to approve writing B over A.

If somebody else has built C on top of A, and pushed it during (3), then
you don't necessarily want to clobber it; you should repeat your
analysis from (2) and make a new decision.

The astute reader will notice that somebody might have pushed C between
steps (1) and (3), and therefore the second "push -f" may overwrite
their C, even though that was not what was intended by the user. The git
protocol already says "I am expecting to move ref R from A to B". The
problem is that the interface is mis-designed for this workflow. The
first push should note "A" somewhere on disk, and the second "git push
-f" should really be "git push --retry-with-force", and check to make
sure that our starting point really is "A".

I suspect nobody has complained so far because it is a race condition
that just doesn't come up unless you have an extremely busy repository
with lots of force pushes.

> And what about the fast forward case?  If client A is pushing change a
> and then client B starts pushing b which depends on a, why shouldn't B
> succeed as long as A succeeds first, even without the force flag?  But
> it does not work this way even with the force flag.

Right. Because the force flag is about history rewinds, not about
clobbering simultaneous pushes.

Don't get me wrong; I can see the use for an option to clobber a
simultaneous push in some workflows. I just think that there is value in
distinguishing it from what "force" does now.

> I think this use case distinction is irrelevant to users on a shared
> server unless you could somehow tell git to "only clobber the branch
> if it currently points to shax".  Which is sort of what git is
> pretending to do, but it isn't really since the user isn't specifying
> shax, it is determined when the push starts and is inherently subject
> to a race.  It's not like the user can safely determine what the
> remote branch points to before they update it to see if it is ok to
> clobber it.

Right. And I think that is a bug (or an interface misdesign), albeit one
that doesn't come up much. But I'd rather not make it worse by losing
what safety we have.

-Peff
