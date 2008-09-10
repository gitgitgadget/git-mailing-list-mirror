From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 12:18:52 -0400
Message-ID: <20080910161852.GR21071@mit.edu>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 18:21:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdSQR-000090-QI
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 18:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYIJQTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbYIJQTH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 12:19:07 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37936 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752216AbYIJQTG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 12:19:06 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8AGIrqq029269;
	Wed, 10 Sep 2008 12:18:53 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8AGIqVD006082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Sep 2008 12:18:52 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KdSP6-0003hu-5G; Wed, 10 Sep 2008 12:18:52 -0400
Content-Disposition: inline
In-Reply-To: <20080910141630.GB7397@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95538>

On Wed, Sep 10, 2008 at 04:16:30PM +0200, Stephen R. van den Berg wrote:
> The renumbering is not a problem, renumbering is a rare operation since
> a project's history is supposed to be stable.  And even if renumbering
> is performed, it is a well understood operation of which the renumbering
> of the origin links imposes a negligible overhead on top of the existing
> renumbering overhead.

Well *you* were the one using this as an argument for using the origin
link.  But I'll note that in some workflows, rebasing happens all the
time when a patch is being developed and moved around.  Sometimes
patches are created in git, exported as a patch, and then it re-enters
git again later (which is another reason why using an external UUID or
bug tracking identifier is a good thing).

> >Addresses-Bug: Red_Hat/149480, Sourceforge_Feature/120167
> >or
> >Addresses-Bug: Debian/432865, Launchpad/203323, Sourceforge_Bug/1926023
> 
> >Once you have this information, it is not difficult to maintain a
> >berk_db database which maps a particular Bug identifier (i.e.,
> >Red_Hat/149480, or Debian/471977, or Launchpad/203323) to a series of
> >commits.
> 
> This is nice, I admit, but it has the following downsides:
> - It is nontrivial to automate this on execution of "git cherry-pick".

It's trivial if it's in the free-form text.  In fact, it happens
automatically.  If it's stored within the git commit object, then it
will be done in the C code (if you've updated to the latest git;
again, one of the advantages of doing it in free-form text).

> - In a distributed environment this requires a network-reachable bug
>   database.
> - A network-reachable bug database means that suddenly git needs network
>   access for e.g. cherry-pick, revert, gitk, log --graph, blame.
> - Network queries for commits containing references kind of kills
>   performance.

No, because you don't need to look up the bug identifier unless you
want to, you know, actually look at the bug.  Otherwise, we are just
using something like "debian/432865" as an identifier; you only need
to look them up if you want to look up the bug.  Any time you have a
collaborative development environment, you will need either a
centralized, network accessible bug tracking system, or use a
distributed bug tracking system.  Either way, though, if it's just
matter of seeing whether or not a bug fix such as debian/432865 is
fixed by some commit in some branch, using the bug identifier actually
makes this *easier*, not harder.

> - Some backports don't have entries in a bug database because they
>   weren't bugs to begin with, in which case it becomes impossible to add
>   an identifier to the commit message after the fact.

This is true.  The transition is a little easier if you are pointing
to a pre-existing commit, whereas if you need some kind of rendevous
identifer (whether it is a bug ID or some UUID).  On the other hand,
you've cherry-picked some bug fix using a git that didn't support the
origin link, you'd also be screwed, so 

> - It relies heavily on tools outside of git-core, which raises the
>   threshold for using it.

Well, it relies on changes to git --- just like the origin link
requires changes to git.  If the it is implemented using free-form
text, which is a great way to prototype it, you have the *option* of
implementing it via either git porcelain changes or outside tools like
emacs or vi macros (just as most of us who are kernel developers have
editor macros that insert Signed-off-by: into git commit messages, as
well as changes in git porcelain such that "git am -s" automatically
adds the Signed-off-by header).  But given the wildly successful use
of Signed-off-by in the kernel sources, this objection seems not very
credible, to say the least.

> The recommended practice here is quite simple:
> 
> - Origin links should only be created pointing to stable commits (i.e.
>   commits which you'd be willing to publish or already have published).
> 
> - This implies that pointing an origin link at a commit in a strain that
>   you still want to rebase is asking for trouble.  Doing this is akin to
>   doing a merge between two branches and then you start rebasing 4
>   commits *below* the mergepoint.  Don't do that.

Right.  And if we use a UUID to identify commits, then we don't have
to have these restrictions.

> - The only special case I'd allow is if you rebase a strain and the
>   origin link points from one of the commits in the strain to be rebased
>   back *into* the same strain being rebased (most likely a revert).
>   Rebase can be bothered to renumber the origin link in this case.

Nope, because you might have a branch to the original origin link, and
some body else may have already done a cherry-pick to the original
origin commit.  You've hand-waved around the problem by saying, "don't
do that", but it just points out how **fragile** the origin link
scheme really is.  It's just not robust.

In contrast, generating a UUID per commit is much more robust, since
you can now export it out of git in a patch, and then re-import it
later, and have the right thing happen.

> >(and I am not convinced that you do), the ***much*** better approach
> >is to use the same approach as the bug tracking identifier, and add a
> >level of indirection.  How would that work in practice?  Whenever you
> >create a new commit, create a UUID which is assigned to the patch.
> 
> This only works if you know at time of commit that you want to backport
> it at some later date.

I'm suggesting that all commits (once you upgrade to a version of git
that supports this --- and you've already handwaved away the question
on whether you can get all of developers for a project to upgrade to
the latest git, remember) would have a UUID generated.  That UUID
could be stored internal to git, or (perhaps as an initial prototyping
as a proof of concept, before we add something into the git commit
record **forever**) could be in the free-form text.

> >Yes, it means that you have to maintain a separate database so you can
> >easily find the list of commits that contain a particular UUID, but I
> >suspect you would need this in the case of the origin link concept
> >anyway, since sooner or later some of the more useful uses of said
> >link would require you to be able to find the commits which had origin
> >links to the original commit, which means you would need to create and
> >maintain this database anyway.
> 
> That isn't true.  Finding commits which have origin links to a certain
> commit is just as hard as finding all children of a certain commit.
> It's not exactly instant, but it is not a big problem, and depending on
> the amount of repositorytraversal you already are doing, it might even
> be a negligible amount of extra overhead.

My point is you'll need this separate database anyway, in order to
deal with the cases where you have two commits that point to the same
(non-existent) origin link, one in maint1, and one in maint2, and
given the commit in the maint1 branch, you want to see if there is
related comit in the maint2 branch you'll need this database anyway
(or you do a brute force search of the repository, which isn't too bad
for modest datbases).  It's identical in both cases --- but having a
UUID field in the commit is much *cleaner*, since it merely states
that these two commits introduce the same semantic change; it doesn't
imply some kind of parent/child relationship which an origin link
implies.

> The database needs to be available to anyone doing a clone of the
> repository, which implies that:
> - It needs to be network based.
> - It needs controlled write access (which is a mess).
> - It is slow during blame/gitk operations.
> - It is rather nontrivial to get things setup such that someone (after
>   cloning the repository) is able to run cherry-pick/gitk/blame/revert
>   and have those commands use the database transparently.

No it doesn't, since the database can be inferred from the objects in
the repository.  So you can generate it locally if you need it, merely
as an optimization.  The same is true for the origin link proposal, as
I've said.

    		    	    	     - Ted
