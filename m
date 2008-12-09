From: Jeff King <peff@peff.net>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 9 Dec 2008 05:57:03 -0500
Message-ID: <20081209105703.GA21536@coredump.intra.peff.net>
References: <1228815240.18611.48.camel@starfruit.local> <20081209191704.6117@nanako3.lavabit.com> <1228819087.18611.73.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA0IU-0006MC-6a
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYLIK5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYLIK5H
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:57:07 -0500
Received: from peff.net ([208.65.91.99]:2848 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbYLIK5G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:57:06 -0500
Received: (qmail 2069 invoked by uid 111); 9 Dec 2008 10:57:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Dec 2008 05:57:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2008 05:57:03 -0500
Content-Disposition: inline
In-Reply-To: <1228819087.18611.73.camel@starfruit.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102626>

On Tue, Dec 09, 2008 at 02:38:07AM -0800, R. Tyler Ballance wrote:

> At this point, QA is involved and what can happen is that QA realizes
> that this code is *not* stable and *never* should have been brought into
> the stable branch.
> 
> Now we have two options "block" the stable branch until LazyDeveloper
> makes the appropriate changes to stabilize the branch again *OR* back
> out LazyDeveloper's changes (A, B, C, D) and beat them up in the
> alleyway :)

It sounds like the problem is that LazyDeveloper has the authority to
push to the stable branch that everyone else pulls from, but can't be
trusted with that authority (because he is pushing bad work).

Maybe you would do better to invert your workflow:

  1. LazyDeveloper does some work on the 'foo' branch locally. Either
     his work repo is accessible to everyone, or he pushes it to a
     personal public repo (or a personal namespace within a shared
     repo).

  2. LazyDeveloper tells QA "check out foo, which should be ready for
     integration."

  3. QA pulls LazyDeveloper's foo. If it is OK, they merge and push to
     the official "stable" branch. If it isn't, they reject and
     LazyDeveloper fixes and goes back to step 2. LazyDeveloper is free
     to reset, rewind, or rebase as appropriate, since nobody but QA has
     ever even looked at this branch (and once they reached the "reject"
     conclusion, they don't care anymore).

So everyone builds off of the official "stable" branch, which by
definition is stuff that has passed through QA.

> Given the nature of our work, we have a stable branch per-team, and one
> funneling stable branch for the entire company (master), that branch
> being used to push the live web site with. 

And you could of course have per-team QA if you wanted to organize it
that way.

> The second option is why I want to force --no-ff on *all* pulls if
> possible. With --no-ff we can simply `git revert -sn <hash> -m 1 && git
> commit -a` in order to back out A, B, C, D. With a true fast-forward,
> we've had to use git-rev-list(1) trickery and some bash scriptery to
> properly revert a series of commits from a given time frame from a given
> developer.

There isn't good support for multiple reverts, but you can do the moral
equivalent with a big patch (note that revert can actually be more
clever about resolving the three way merge, but if you are close to the
tip, you shouldn't find any conflicts):

  git diff HEAD last-good-commit | git apply

If they are the tip commits, then you can always just make a new commit
with the pre-breakage state. This is sort of a mix of "git reset" and
"git revert" in that it throws away changes, but not history.

I don't think there is good porcelain support for this, but you can do:

  GIT_INDEX_FILE=index.tmp; export GIT_INDEX_FILE
  git read-tree last-good-commit
  git commit -m 'revert crappy commits'

-Peff
