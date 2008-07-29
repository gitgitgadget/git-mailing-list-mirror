From: Jeff King <peff@peff.net>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Tue, 29 Jul 2008 01:02:18 -0400
Message-ID: <20080729050218.GD26997@sigill.intra.peff.net>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer> <20080728192651.GA26677@sigill.intra.peff.net> <7vsktto78y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhMn-0000Y2-IJ
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbYG2FCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYG2FCV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:02:21 -0400
Received: from peff.net ([208.65.91.99]:2770 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbYG2FCU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:02:20 -0400
Received: (qmail 5789 invoked by uid 111); 29 Jul 2008 05:02:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Jul 2008 01:02:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 01:02:18 -0400
Content-Disposition: inline
In-Reply-To: <7vsktto78y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90565>

On Mon, Jul 28, 2008 at 05:37:33PM -0700, Junio C Hamano wrote:

> I sense a slightly broken workflow here, whether the "-s theirs" strategy
> is used or the merge is done in the other direction using "-s ours"
> strategy.
> 
> Remember, when you create a merge commit between one history and another,
> you are making this statement:
> 
>     I have looked at the tree state and the development history behind
>     both of these commits, and came up with this tree, which I believe
>     suits the purpose of _my_ history better than either of them.

Right, that is precisely what I wanted to say. These are the histories
of the devel and stable branches, and now they both are the contents of
stable. In this case, "I have looked at all of the commits in stable
that were _not_ in devel, and confirmed that they have moral equivalents
in devel".

> That is why, after making such a merge with "git merge other", you won't
> see any output from "git log ..other", which asks "what do I have yet to
> merge?"  Everything that was included in other is now in your history and
> there is nothing you have to worry about having left out anymore.

Right, that is just what I wanted.

> So if you suspect that the sutuation "in case those fixes needed to be
> looked at later" ever arises, such a merge should *not* be recorded as a
> proper merge on the 'stable' branch, because at that point when you are
> doing that "-s theirs" merge (and this applies equally to the case where
> you make "-s ours" merge as well), you actually have not looked at "those
> fixes" closely enough to make the above statement with confidence.

No, I had looked at them with confidence. I just didn't want history
thrown away for two reasons:

  - historical interest; some of the commits had counterparts in devel
    that were done differently (because the two branches had diverged),
    but it might later be interesting to see how and why the stable
    changes were done (e.g., if a similar situation arose)

  - this project did not rebase, favoring the simplicity of "git pull"
    over clean history.

Bear in mind that this project was not very big. I think devel had ~20
commits, and stable had about ~5. So it was easy to get such confidence.

> Even though having said all of the above, I would actually prefer such a
> "pull all of the devel down to stable" be done with this workflow instead:
> 
>  (1) go to 'devel';
>  (2) merge all of 'stable';
>  (3) look at the result and prove it is perfect;
>  (4) go to 'stable';
>  (5) merge 'devel'.
> 
> The last step would be a fast-forward, and you do not need "-s theirs"
> anywhere in this procedure.  Step (2) can be helped with "-s ours" (which
> have the same issue I discussed above), but the result is checked before
> it hits the 'stable' (presumably more precious branch), which is
> conceptually a big difference.  This is where the existing asymmetry
> between theirs and ours comes from.

Of course you can do this (and that is, in fact, exactly what I did).
But there is no point discussing "what hits stable" since neither branch
is precious. All of this is happening in a private repo that nobody is
looking at. So it really is a case of thinking about it as "devel
subsumes stable, and then stable becomes devel" versus "stable is
discarded in favor of master".

I think both are equally valid ways of looking at what is happening. The
only differences will be:

  - the commit message will be reversed ("Merge X into Y"). And this
    really comes down to "how would I want to see this presented in 3
    months when I look at it?".  And either is valid, depending on how you
    think of the problem (but I think in both cases, you owe it to
    future readers to write a bit of text saying _why_ such a strategy
    was OK to use).

  - the parents will be swapped. Using "-s theirs" should let you ask
    "what changes did I make on my stable branch" using
    "--first-parent". I don't know how useful that is, as I don't
    actively work on that project anymore.

-Peff
