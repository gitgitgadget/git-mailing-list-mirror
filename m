From: Adam Spiers <git@adamspiers.org>
Subject: Re: RFC: new git-splice subcommand for non-interactive branch
 splicing
Date: Fri, 27 May 2016 17:36:52 +0100
Message-ID: <20160527163652.GC11256@pacific.linksys.moosehall>
References: <20160527140811.GB11256@pacific.linksys.moosehall>
 <alpine.DEB.2.20.1605271701500.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 18:37:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Kkx-0002nm-Q6
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 18:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbcE0Qg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 12:36:58 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45056 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869AbcE0Qg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 12:36:57 -0400
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E49D22E0E6
	for <git@vger.kernel.org>; Fri, 27 May 2016 17:36:52 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1605271701500.4449@virtualbox>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295767>

Hi Johannes,

Thanks for the quick reply!  Responses inline below:

On Fri, May 27, 2016 at 05:27:14PM +0200, Johannes Schindelin wrote:
> On Fri, 27 May 2016, Adam Spiers wrote:
> 
> > Description
> > -----------
> > 
> > git-splice(1) non-interactively splices the current branch by removing
> > a range of commits from within it and/or cherry-picking a range of
> > commits into it.  It's essentially just a glorified wrapper around
> > cherry-pick and rebase -i.
> 
> It sounds as if you could accomplish the same with
> 
>       git checkout -b former-commits <split>
>       git checkout -b latter-commits <base>
>       git cherry-pick <split>..HEAD@{2}

Not really - that is missing several features which git-splice
provides, e.g.

  - The ability to remove a non-consecutive list of commits
    from the branch.

  - The ability to insert commits at the same time as removing
    (granted, that's just in extra cherry-pick your method, but again
    that's another thing to orchestrate).

  - The ability to specify commits to remove / insert using
    arguments understood by git-rev-list.

  - The patch-id magic which is built into git-rebase.  This
    would kick in if any of the commits to insert are already
    in <split>..HEAD@{2} (using your reference terminology).

  - A single command to orchestrate the whole workflow, including
    cleanup, and --abort and --continue when manual conflict
    resolution is required.  This modularity should help a lot when
    building further tools which wrap around it in order to perform
    more complex tasks.

This last point is perhaps the most important.  Of course it's
possible to do this manually already.  But the whole point of
git-splice is to automate it in a convenient and reliable manner.

> > Next steps, and the future
> > --------------------------
> > 
> > Obviously, I'd welcome thoughts on whether it would make sense to
> > include this in the git distribution.
> 
> Far be I from discouraging you to work on these scripts, but I think that
> a really good place for such subcommands is a separate repository, as you
> have it already. There are already some rarely used subcommands in
> libexec/git-core/ cluttering up the space and I would be reluctant to add
> even more subcommands to the default Git installation delivered to every
> user.

Sure, I appreciate the difficulty in deciding where to draw the line.
My feeling is that rebase -i provides something tremendously
important, which the vast majority of users use on a regular basis,
but that git is currently missing a convenient way to
*non-interactively* perform the same magic which rebase -i
facilitates.  And removing / reordering commits is surely one of the
most common use cases of rebase -i, so I think a lot of people could
benefit from some porcelain to automate that and allow building
higher-level tools on top of it.

I suspect the most popular use-case in the short term would be the
infamous "oops, I only just noticed that I put that commit on the
wrong branch, and now there's already a whole bunch of other commits
on top of it".  I would expect that reducing this solution to a single
git-transplant(1) command would be pretty attractive for a lot of
people.  And of course GUIs / IDEs could incorporate it into their
more beautiful front-ends.  However, if it's not in git core, that's
unlikely to happen.

> You can *always* just extend the PATH so that git-splice can be found;
> Then `git splice ...` will do exactly what you want. That is e.g. how
> git-flow works.

Sure, I've been using that trick since at least 2009 ;-) [0]

> (Of course I hope that you will maintain your scripts
> much, much better than git-flow, i.e. not abandon all users).

I hope so too ;-)

> > In the longer term however, I'd like to write two more subcommands:
> > 
> >   - git-transplant(1) which wraps around git-splice(1) and enables
> >     easy non-interactive transplanting of a range of commits from
> >     one branch to another.  This should be pretty straightforward
> >     to implement.
> 
> This is just cherry-pick with a range...

No it's not:

  - git-transplant would be able to splice commits from one branch
    *into* (i.e. inside, *not* onto) another branch.

  - git-transplant would also take care of removing the commits from
    the source branch, but not before they were safely inside the
    destination branch.

  - git-transplant would orchestrate the whole workflow with a single
    command, complete with --abort and --continue.

> >   - git-explode(1) which wraps around git-transplant(1) and
> >     git-deps(1), and automatically breaks a linear sequence of commits
> >     into multiple smaller sequences, forming a commit graph where
> >     ancestry mirrors commit dependency, as mentioned above.  I expect
> >     this to be more difficult, and would probably write it in Python.
> 
> You mean something like Darcs on top of Git. Essentially, you want to end
> up with an octopus merge of branches whose commits would conflict if
> exchanged.

Something like that, yes, but it's not as simple as a single octopus
merge.  It would support arbitrarily deep DAGs of topic branches.

> I implemented the logic for this in a shell script somewhere, so it is not
> *all* that hard (Python not required). But I ended up never quite using it
> because it turns out that in practice, the commit "dependency" (as defined
> by the commit diffs) does not really reflect the true dependency.
>
> For example,

[snipped examples]

Sure - I already covered this concern in footnote [0] of my previous
mail; maybe you missed that?  As I said there, in my experience, I
have found it very useful to be able to automatically detect textual
dependencies via git-deps, even though they do not represent the
entire set of dependencies.  I've even recorded a YouTube screencast
demonstrating one such use case[1].  So please don't let the question
for perfection become the enemy of the good ;-)

> So I think that this is a nice exercise, but in practice it will require a
> human to determine which commits really depend on each other.

Of course - this is exactly why I wrote "or at least
semi-automatically" in the first mail of this thread.  But even though
git-deps / git-explode can never automatically handle *all*
dependencies, they can handle enough dependencies to be significantly
useful.  I have concrete real-world experience of that.  In fact there
is one scenario I am working on right now which is current proof of
this (no coincidence, since that's what motivated me to take this next
step on this journey and write git-splice):

I have made a large bunch of small commits to a single text file
(design document).  Some are possibly contentious; some aren't.  So I
need to split them out into a series of smaller independent patch
series which I can submit to gerrit for review, thereby making life
easier for the reviewers and minimizing any bottlenecks where reviews
for one change are blocked because another change hasn't been reviewed
yet.  And in this case, because the changes are all applying to a
single file containing only natural language, git-deps correctly
determines *all* dependencies, not just textual ones.

> You would render me *really* impressed if you could come up with an
> automated way to determine logical dependencies between patches.

Hey, I would *really* impress myself if I could do that, too; after
all, that would be a pretty sophisticated form of artificial
intelligence :-)

Thanks again for the feedback!

Adam


[0] https://github.com/aspiers/git-config/commit/287685408326

    BTW there are currently 36 git-* scripts in that repo; you may or
    may not find it interesting to browse through them.

[1] https://github.com/aspiers/git-deps#use-case-1-porting-between-branches

    In this case, git-deps can serve as an early warning system to
    flag when a backporting task's cost:reward ratio would be too
    high to justify starting work on it.
