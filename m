From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [WIP PATCH 0/3] implement merge strategy for submodule
	links
Date: Mon, 14 Jun 2010 19:02:23 +0200
Message-ID: <20100614170222.GB1389@book.hvoigt.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006121212.50545.johan@herland.net> <20100612120620.GA13910@book.hvoigt.net> <201006131959.43356.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 14 19:02:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOD3O-0004Ht-MK
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 19:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab0FNRCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 13:02:25 -0400
Received: from darksea.de ([83.133.111.250]:32817 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755089Ab0FNRCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 13:02:24 -0400
Received: (qmail 20407 invoked from network); 14 Jun 2010 19:02:22 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Jun 2010 19:02:22 +0200
Content-Disposition: inline
In-Reply-To: <201006131959.43356.johan@herland.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149128>

Hi,

On Sun, Jun 13, 2010 at 07:59:43PM +0200, Johan Herland wrote:
> On Saturday 12 June 2010, Heiko Voigt wrote:
> > On Sat, Jun 12, 2010 at 12:12:50PM +0200, Johan Herland wrote:
> > > E.g. say we have the following commit history in the submodule:
> > >   A---B---C---D  <-- master
> > > 
> > > Now, say that your merge conflict comes from one branch updating the
> > > submodule from B to C, while the other branch reverts the submodule
> > > from B to A. In your proposed scheme, Git would auto-resolve the
> > > conflict to D.
> > 
> > You are right. I did forget to mention this in my topic letter: Both
> > changes need to point forward. This exact case is also tested in the
> > testcases and results in a merge conflict which needs to be resolved by
> > hand.
> 
> Still doesn't solve one of the cases I gave in the last email: Say one 
> branch updates the submodule from A to B, and the other updates from A to C. 
> Your proposal resolves the merge by fast-forwarding to D, which seems 
> irresponsible, since we have no concept of how well D is tested. Maybe it 
> introduces another showstopper bug, and that is why neither branch has 
> upgraded to it yet?
> 
> A better solution would be, to put it generally: Given a submodule being 
> part of a superproject conflict, if one of the candidate submodule SHA1s is 
> is a descendant of _all_ the other submodule SHA1 candidates, then choose 
> that SHA1 as the proposed resolution (but please leave the index entry 
> "unmerged", so that the resolution must be confirmed by the user).

Is there currently any logic to support a "suggested" merge resolution
in git.git? I am not that familiar with code base yet and I do not think
that I have seen something like that. Is it done somewhere already?

> This removes all the "stable" branch magic from your patch. All you need to 
> look at are the candidate SHA1s and their relationship in the commit graph. 
> No refs involved.
> 
> In the A->B vs. A->C case above, we would see that C is a descendant of B, 
> and we would therefore choose C as a suggested conflict resolution, which 
> IMHO is a much better choice than D.
> 
> I still don't want to add a lot of auto-resolving cleverness to Git, as it 
> inevitably _will_ choose incorrectly sometimes, and in those situations it 
> will be much more confusing than if it didn't choose at all.

I see your point. But nevertheless there is a specific workflow I target
to support which is not supported by your approach:

Lets assume Alice creates a feature branch feature_a for her development
and needs to modify the submodule and creates a branch there as well. At
the same time Bob develops feature_b and also needs changes in the
submodule and so he creates a feature branch there as well.

Assume we now have the following history in the submodule:

  B---C---D         [feature_a]
 /         \
A---E---F---G---K   [master]
     \         /
      H---I---J     [feature_b]

Now during the development of her branch Alice would link D in the
superproject as it is the tip of her branch. Bob would do the same and
link to J as his tip. Now Alice sends out her branch to the reviewers
and after everybody is happy with it the maintainer merges her branch
first. The superproject links to D. Now Bob does the same and the
maintainer wants to merge his branch and gets a merge conflict because D
and J do not have a parent/children relationship.

I think this is a fairly natural pattern which evolves from the use of
feature branches in git. So I would like to make git behave naturally
for this workflow and automatically merge.

Now your point is that master could be wrong and you are right, but
normal merges can go wrong in a similar way. Just imagine this:

Alice adds a parameter to the static function somefunc() and changes all
callsites of it in her branch. Independently Bob writes new code in
his branch that uses somefunc() with the old signature. When both
branches are merged git has no chance of doing it right and the code
will not compile. So even normal merging is always a little heuristic.
Question is: How well does the heuristic perform in practise.

> > Thats why I only want to search through stable branches further down. I
> > mean stable in the git sense that they never get rewound and of course
> > should contain the most stable part of development. To ease the
> > configuration we would default to master which we could assume as
> > stable. But if we want to be on the safe side we could also say that
> > automatic submodule merging only works when the user has configured some
> > stable branches.
> 
> Ok, so you can configure exactly which branch(es) you consider stable. I'd 
> still much rather prefer the approach I outlined above, which does away with 
> all the "stable" branch magic, and only considers the commit ancestry 
> directly.

Ok what do you think about combining both approaches: If no stable
branches are configured we default to your strategy and if the user
wants some magic (I mean isn't that what git is all about: magic)
configuring stable branches will enable git to resolve conflicts like
the ones I described above.

My feeling is that in practise automatic merging into stable branches
will work well and the cases of failure will be neglectable to not
happening at all. So my approach would be to go ahead, implement the
strategy and let people play around with it so we can collect some real
life data whether it is helping or making matters worse.

cheers Heiko
