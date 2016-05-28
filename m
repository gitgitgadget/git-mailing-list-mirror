From: Adam Spiers <git@adamspiers.org>
Subject: Re: RFC: new git-splice subcommand for non-interactive branch
 splicing
Date: Sat, 28 May 2016 12:24:18 +0100
Message-ID: <20160528112417.GD11256@pacific.linksys.moosehall>
References: <20160527140811.GB11256@pacific.linksys.moosehall>
 <alpine.DEB.2.20.1605271701500.4449@virtualbox>
 <20160527163652.GC11256@pacific.linksys.moosehall>
 <alpine.DEB.2.20.1605280841000.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>,
	Jon Seymour <jon.seymour@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 28 13:24:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6cMM-0001gy-3G
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 13:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbcE1LY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 07:24:28 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46569 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcE1LY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 07:24:26 -0400
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E05DC2E0F3;
	Sat, 28 May 2016 12:24:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1605280841000.4449@virtualbox>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295810>

On Sat, May 28, 2016 at 09:06:59AM +0200, Johannes Schindelin wrote:
> Hi Adam,
> 
> please reply-to-all on this list.

Sorry, I forgot that was the policy here.  Every list and individual
has different preferences on whether to Cc: on list mail, so I find it
almost impossible to keep track of who prefers what :-/

> On Fri, 27 May 2016, Adam Spiers wrote:
> > My feeling is that rebase -i provides something tremendously
> > important, which the vast majority of users use on a regular basis,
> > but that git is currently missing a convenient way to
> > *non-interactively* perform the same magic which rebase -i
> > facilitates.
> 
> Would it not make sense to enhance `rebase -i`, then?

You mean enhance it to support non-interactive usage?  That wouldn't
make much sense to me, given that -i is short for --interactive.  Even
if we added a new non-interactive rebase mode which let you edit the
commits prior to rebasing them, I can't imagine how it would need to
be any different to how non-interactive rebase -i currently works,
i.e. setting GIT_SEQUENCE_EDITOR to a non-interactive command which
modifies the rebase todo file passed via $1.

Or maybe you are suggesting to enhance it to perform operations on the
rebase todo list, such as removing a commit from the todo list, or
moving a commit to a different position?  But that sounds like scope
creep to me; IMHO it would be cleaner for rebase -i to remain an
unopinionated platform for history editing, rather than to make
assumptions about common history editing workflows.  I think those
assumptions belong in higher-level porcelain tools.

Or if you have some other enhancement in mind, please share details!

> I, for one, plan to port my Git garden shears (at least partially) once I
> managed to get my rebase--helper work in. The shears script is kind of a
> "--preseve-merges done right":
> 
>     https://github.com/git-for-windows/build-extra/blob/master/shears.sh
> 
> It allows you to (re-)create a branch structure like this:
> 
>     bud
>     pick cafebabe XYZ
>     pick 01234567 Another patch
>     mark the-first-branch
> 
>     bud
>     pick 98765432 This patch was unrelated
>     mark the-second-branch
> 
>     bud
>     merge the-first-branch
>     merge the-second-branch
> 
> Of course, this is interactive.

Interesting approach; thanks for sharing.  At a first glance, this
does sound similar to what topgit and gitwork are trying to achieve.
I don't entirely understand it yet, however; it's hard to without
knowing more about the structure of Git for Windows' integration
branch and seeing a concrete example and/or comprehensive
documentation.  For example, it's not clear to me how
generate_script() works, or how it lets you modify just one of the
topic "sub-branches" and then automatically update all other
sub-branches which depend on it?

> But quite frankly, you want to be able to
> perform quite complicated stuff

Why do you say that?  Splice and transplant operations are
conceptually very straightforward, and not even particularly hard to
implement.  git-splice only took me a day or so, and I expect
git-transplant to be quicker.

The only complicated thing I want to implement is git-explode, but if
I have splice and transplant "primitives" available, then it should be
quite easy to implement git-explode as a series of splice/transplant
operations.

> and I think the command-line offers only an inadequate interface for
> this.

Please can you give an example where it would be inadequate?

> > I suspect the most popular use-case in the short term would be the
> > infamous "oops, I only just noticed that I put that commit on the
> > wrong branch, and now there's already a whole bunch of other commits
> > on top of it".
> 
> I have two workflows for that. The simpler one:
> 
>     git checkout other-branch
>     git commit
>     git checkout @{-1}
>
> after those calls.
> 
> The more complicated one comes in handy when a complete rebuild takes a
> long time, and branch switching would trigger a rebuild:
> 
>     # Here, I stash what I *want* on the other branch
>     git stash -p
>     git worktree add throwaway other-branch
>     cd throwaway
>     git stash apply
>     git commit

Neither of these workflows work with the scenario I described.  In my
scenario, the commit is already buried beneath other commits.

> I did use the approach you proposed a couple of times: just commit in the
> middle, and sort things out later. The problem: I frequently forgot, and
> if I did not, reordering the commits resulted in stupid and avoidable
> merge conflicts.

I think you are misunderstanding me - I am not proposing this
workflow; in fact that would be stupid because it's already in common
usage.  But I'm not even advocating it.  I'm saying:

  - I do it regularly by accident (since when I am in the hacking
    zone, I am usually focused on the code, not on branch maintenance).

  - When I eventually realise I've done it, I need to go back afterwards
    and clean up the mess by decomposing the linear series of commits
    into separate topic branches.

  - No really good higher-level topic branch maintenance tools exist yet.

  - This is a common problem which many git users suffer from, based
    on a) my experience collaborating with others, b) personal
    feedback I've received on this topic, and c) googling for things
    like "git move commit to another branch".

  - There needs to be an easier way to clean up the mess, which minimises
    the pain resulting from merge conflicts.

> > > > In the longer term however, I'd like to write two more subcommands:
> > > > 
> > > >   - git-transplant(1) which wraps around git-splice(1) and enables
> > > >     easy non-interactive transplanting of a range of commits from
> > > >     one branch to another.  This should be pretty straightforward
> > > >     to implement.
> > > 
> > > This is just cherry-pick with a range...
> > 
> > No it's not:
> > 
> >   - git-transplant would be able to splice commits from one branch
> >     *into* (i.e. inside, *not* onto) another branch.
> 
> Okay, but in case of merge conflicts, you still have to switch to the
> other branch, right?

Nope, if there are conflicts, you would either do

    git transplant --abort

leaving you where you started, or fix the conflicts and then do

    git transplant --continue

leaving you on the original branch, but with the transplanted commits
no longer in that branch and instead in the target branch.

> >   - git-transplant would also take care of removing the commits from
> >     the source branch, but not before they were safely inside the
> >     destination branch.
> 
> That assumes a workflow where you develop on one big messy branch and
> later sort it out into the appropriate, separate branches, right? I admit
> that I used to do that, too, but ever since worktrees arrived, I do not do
> that anymore: it resulted in too much clean-up work. Better to put the
> commits into the correct branch right away. Of course, that is just *my*
> preference.

It's *my* preference too, as I already stated above.  That does not
change the fact that even with the best intentions to avoid this
workflow, it will still happen, *especially* when there are still no
good higher-level tools which help avoid it.  BTW gitwork is the
closest I've seen to a tool which correctly addresses this:

    https://jonseymour.s3.amazonaws.com/git-work.html#_discussion

but AFAIK it hasn't been updated in 3 years.  Maybe Jon (cc'd) can
comment on whether that means it already worked perfectly 3 years ago ;-)

> >   - git-transplant would orchestrate the whole workflow with a single
> >     command, complete with --abort and --continue.
> 
> cherry-pick also sports --abort and --continue.

If you look at my implementation of git-splice you'll see that it uses
cherry-pick --abort and --continue.  So thanks but I'm already fully
aware of that :-)  However that misses the point.

Transplant needs to be a composite of multiple operations (splice into
the target branch followed by splice to remove from the source
branch).  Therefore given that either of these splice operations can
fail due to conflicts, the overall transplant needs to be orchestrated
as a single workflow which supports --abort and --continue.  For
example, if the second splice fails with conflicts, the user needs to
be able _with_a_single_command_ to roll back to the state before the
transplant started.  That means aborting the second splice, and
reverting the first.

If rollback is not as easy as a single command, the UX will create
fear of failure, which will discourage users from using the tool.

> > > >   - git-explode(1) which wraps around git-transplant(1) and
> > > >     git-deps(1), and automatically breaks a linear sequence of commits
> > > >     into multiple smaller sequences, forming a commit graph where
> > > >     ancestry mirrors commit dependency, as mentioned above.  I expect
> > > >     this to be more difficult, and would probably write it in Python.
> > > 
> > > You mean something like Darcs on top of Git. Essentially, you want to end
> > > up with an octopus merge of branches whose commits would conflict if
> > > exchanged.
> > 
> > Something like that, yes, but it's not as simple as a single octopus
> > merge.  It would support arbitrarily deep DAGs of topic branches.
> 
> Yes, of course. Because
> 
> A - B - C - D
> 
> might need to resolve into
> 
> A - M1 - C - M3
>   X        /
> B - M2 - D

Why are both M1 and M2 needed here?  Can't D be a child of M1?

    A---M1---C---M3
       /  \     /
    B-'    `-D-'

> > > I implemented the logic for this in a shell script somewhere, so it is not
> > > *all* that hard (Python not required). But I ended up never quite using it
> > > because it turns out that in practice, the commit "dependency" (as defined
> > > by the commit diffs) does not really reflect the true dependency.
> > >
> > > For example,
> > 
> > [snipped examples]
> > 
> > Sure - I already covered this concern in footnote [0] of my previous
> > mail; maybe you missed that?
> 
> I think it deserves more prominent a place than a footnote.

I originally had it inline ;-/ but then moved it to a footnote since
it was somewhat orthogonal to the main subject (git-splice) and I
thought it was at risk of diluting focus.  Sorry if that was the
wrong decision.

> > > So I think that this is a nice exercise, but in practice it will
> > > require a human to determine which commits really depend on each
> > > other.
> > 
> > Of course - this is exactly why I wrote "or at least
> > semi-automatically" in the first mail of this thread.  But even though
> > git-deps / git-explode can never automatically handle *all*
> > dependencies, they can handle enough dependencies to be significantly
> > useful.  I have concrete real-world experience of that.
> 
> I'd love to see those examples where it worked, because it sure did not
> work for me (I wasted two weeks to implement that script that I never used
> successfully).

Yeah - I was hoping to make another YouTube video demonstrating one of
them, but I've gone over my time budget simply by implementing
git-splice (and unit tests) and then discussing it here :-/

> > I have made a large bunch of small commits to a single text file
> > (design document).  Some are possibly contentious; some aren't.
> 
> Ah. Well, as I said, I changed my workflow to use multiple worktrees with
> multiple branches. The contentious changes would go into at least one
> branch, more likely multiple. The uncontentious changes would go into
> another.

Exactly, that's the ideal situation we're aiming for.  The question is
how to get there.  Doing this branch maintenance manually is currently
too inconvenient for most users.  My belief is that building primitive
operations such as splice and transplant will encourage the
development of higher-level tools which can further automate the
maintenance tasks.

> And most likely at least some of those branches would cause merge
> conflicts.

Small nitpick: technically, branches can't cause merge conflicts; only
operations such as cherry-pick / merge / rebase can cause them.

> However, they would do so only once, not multiple times during
> the cleaning-up phase.

Sorry, I'm not sure I understand this, because I'm not sure exactly
which operations you are referring to.

> I did actually track the time at some stage to determine what is faster.
> Sorting things into multiple branches won hands down (in my hands). And
> no: I did not believe it would.

It can certainly win, yes, and as I already said, this is my favoured
approach too, when I remember to do it.  But the win gets less likely
for each dependency which exists between branches, in the absence of
good branch management tools.

> > So I need to split them out into a series of smaller independent patch
> > series which I can submit to gerrit for review, thereby making life
> > easier for the reviewers and minimizing any bottlenecks where reviews
> > for one change are blocked because another change hasn't been reviewed
> > yet.  And in this case, because the changes are all applying to a single
> > file containing only natural language, git-deps correctly determines
> > *all* dependencies, not just textual ones.
> 
> I do not buy that. When you introduce a section way down in the document
> for which you have to introduce a new definition in one of the first
> sections, logically those two changes belong to the same topic branch. Yet
> git-deps would have no chance to determine that.

Sure, but none of the 24 commits I am referring to do that - a fact of
which I was entirely aware when I performed the analysis with
git-deps.  Sorry for omitting this from the above "because ..." clause.

But I would like to reiterate: just because it is known not to work in
all situations, it does *not* mean it can't be of use in any
situation.  Again, don't let the perfect become the enemy of the good.

Cheers,
Adam
