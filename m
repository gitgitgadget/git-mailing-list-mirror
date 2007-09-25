From: Jeff King <peff@peff.net>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 16:17:17 -0400
Message-ID: <20070925201717.GB19549@segfault.peff.net>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se> <46F96493.8000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 22:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaGqd-0006bi-1O
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 22:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbXIYUR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbXIYUR2
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 16:17:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4020 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbXIYUR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 16:17:27 -0400
Received: (qmail 19874 invoked by uid 1000); 25 Sep 2007 20:17:17 -0000
Content-Disposition: inline
In-Reply-To: <46F96493.8000607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59170>

On Tue, Sep 25, 2007 at 02:42:11PM -0500, Russ Brown wrote:

> > This isn't necessary. Branches in git are very nearly zero-cost, so having
> > them in the same repo as the master branch won't hurt a bit. You can add
> > an update-hook on the mothership repo to restrict access to the master
> > branch if you like, but creating two separate repos will likely give
> > more headache than it's worth.
> > 
> 
> Ah, right. I'm just trying to remember why it was I came up with that
> idea in the first place, but I'm struggling a bit. :)

It's not entirely true that branches are zero-cost. They cost nothing to
make, but fetching a branch that has commits that you don't want is
going to cost something. And since git-clone doesn't have good support
for "fetch only this subset of the branches" you end up getting them
all.

That being said, you will be amazed how _little_ that cost is unless
one of the branches doesn't delta well (e.g., if one branch introduces 100M
of unrelated images, then getting that branch is going to cost). But
it's almost certainly worth seeing what your workload is like.

> Here's a question: is the creation and deletion of a branch also version
> controlled as it is in Subversion? In other words, if I create a branch,
> develop on it and delete it without merging it anywhere, will the
> revisions hang around and get pulled down by future people cloning the
> repository, or do they get thrown away?

Branch creation isn't version controlled, but your frame of reference is
obviously svn branches, not git branches. A git repo is just a
collection of refs, and each ref is a pointer to some commit (which
points to a tree and to further commits). Branches are just refs in a
given namespace (where the namespace refs/heads/ indicates "it's ok to
make further commits on top of these").

So if you create a branch in your private repo, it is a totally private
thing; the central repo has no notion of it. When you push that branch
to the central repo, you are creating a new ref at the central location
that points to some commits you made. People who clone it will clone
that ref and your commits. If you delete the branch locally, again it
has no effect on the master repo. If you delete the branch from the
central repo, then nobody will fetch those commits anymore (since
nothing will be pointing to them).

> I've seen the term 'topic-branch' used here quite a bit but it's
> unfamiliar to me. It is basically synonymous with what we call a
> 'project branch'? i.e. Management decide that feature X is required so
> we create a branch to develop it on which all developers on the project
> commit to.

Yes, that's exactly right. You have a "branch" for working on a "topic".

> Note that in step 4 above I mean the developer takes a local branch of
> the topic branch. For example, we start projectX/main, and create branch
> projectX on the shared repo. Developer 'jeff' works on the project and
> so creates local branch projectX/jeff and begins work. In step 5 they

You are actually talking about per-developer, per-topic branches. Which
is fine, too. It sounds like these projects are big (many participants
over an extended period), so you may want to do things hierarchically:

  1. project X starts, so you make a branch projectX and assign Bob to
     be the integrator (or if you prefer, nobody is the integrator).
  2. Jeff starts to work on project X, feature Y. He makes a branch
     projectX/featureY, based on projectX. He may publish this to the
     shared repo if he wants to communicate his progress.
  3. When featureY is "ready", he tells Bob to pull it into the main
     projectX branch (or if no integrator, he does it himself).

Any developer can see the progress of any "topic" by looking at its
branch. But only things which have advanced to the main "projectX"
branch are used as the basis for other topics. If you want, you can
replace featureY with "jeff" to indicate "this is the work Jeff is doing
on projectX", but then you will run into issues when Jeff is working on
two different topics of projectY.

> Having been using git-svn for a while I really like the clean history
> result that rebase gives, however my understanding was that you should
> never rebase any published branch as it could screw up clones of that
> branch. In fact, this is what has me the most confused: how to rebase a
> project branch that is on a shared repository against master when
> everyone will have it cloned? Or is this something that I clearly don't
> understand properly?

You generally don't want to rebase that branch. If there are other
branches based on some work, then it will become more difficult to merge
those branches into the rebased work. IOW, rebase works well only at the
"outermost" level of development. So if branch "featureY" is branched from
"projectX" which is branched from "main", then it is reasonable to
rebase featureY against projectX. But rebasing projectX against master
will make integrating "featureY" more difficult. So you should either:
  - just do regular merges of projectX into main (and hopefully, if
    projectX is an aggregate of features, it won't have _that_ many
    merges, so the history should still be quite readable)
  - wait until all such "featureY" branches are merged into projectX,
    announce a freeze of branching from projectX, and then rebase it
    forward.

-Peff
