From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [TopGit PATCH] tg-create.sh: Introduce --add option to add a
 dependency.
Date: Fri, 15 Aug 2008 10:25:50 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808150913180.9955@harper.uchicago.edu>
References: <1218637514.7561.30.camel@heerbeest> 
 <Pine.GSO.4.62.0808131100280.1278@harper.uchicago.edu> <1218787834.7585.13.camel@heerbeest>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Jan Holesovsky <kendy@suse.cz>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Aug 15 17:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU1Ct-0003gF-E6
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 17:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbYHOPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756074AbYHOPZ4
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 11:25:56 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:57616 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022AbYHOPZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 11:25:55 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7FFPsdI023925;
	Fri, 15 Aug 2008 10:25:54 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7FFPo2N012610;
	Fri, 15 Aug 2008 10:25:50 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <1218787834.7585.13.camel@heerbeest>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92486>

Hi,

I think my last message missed your real point.  Let P be the old topic
branch tip, B the old base, P' the new tip, and B' the new base.  There
are four questions to answer:

1) How should the tree of B' be determined?
2) What should the parents of B' be?
3) How should the tree of P' be determined from P, B, and B'?
4) What should the parents of P' be?

I gave my answers to 2, 3, and 4, but I think the problem you ran into
is already there in question 1.  It comes from the basic model of how
TopGit works, not some design decision you made, I think.  Suppose I

	Make a topic branch t/foo depending on master.
	Change the dependency of t/foo to the older version maint.
	Make a new topic branch t/bar depending on t/foo and master.

Because in TopGit we do not ever rewrite history on the t/foo branch,
master is a parent of t/foo even after the dependencies change.  So
merging t/foo and master gives just t/foo, and the base for the new
topic branch does not incorporate the changes from maint to master at
all.

But note that this has nothing to do with how the second step takes
place - the problem occurs as long as we are not throwing away history
and we are using merges to calculate the topic branch bases.

We would really like in the third step to calculate a three-way merge of
t/foo with master, with maint as merge base.  The merge-recursive magic
(making use of the history between maint and t/foo) is just a recipe for
trouble here, and we know better than the automatically chosen merge
base (master).

So:

	foo_deps=$(git show t/foo:.topdeps)
	merge_bases=$(git merge-base --all master $foo_deps)
	git merge-resolve $merge_bases -- master t/foo

should give the right effect in this case (even if t/foo has multiple
dependencies).  This example fails to take into account the case where
master and t/foo are completely independent, but that is easily fixed.
But if t/foo depends on other topic branches in turn, it is not so easy
to fix - I am not sure what to do then.  I am tempted to suggest some
insanity like making the dependency graph into history with grafts...

So all this trouble is there when we try to come up with the topic base
for a new topic, as long as it is possible /in some way/ to weaken
dependencies.

Ok, onto your questions about 2, 3, and 4:

> > 	$ git checkout -b P' P
> > 	$ git rebase --onto B' B
> 
> .. is using rebase a robust solution?  We should provide a way to
> recover after user intervention here?

It is the temporary P' branch that is being rebased, so we can recover
by checking out P and throwing away the P' branch.  I suggested rebase
because there is UI for skipping a change, etc. but the more I think
about it, the more I think it would make sense to just

	...
	$ git checkout -b P' B'
	$ {
	>	echo Subject: temporary commit &&
	>	echo --- &&
	>	git diff -M B P
	> } | git am -3
	...

or, if we make B a parent of B',

	$ git checkout P
	$ git merge B'

which might be preferrable.

> > 	$ git checkout P
> > 	$ git merge --no-ff --no-commit B'   (*)
> 
> Do you remember in what area the problem is here, that would make it a 
> lot easier for me to look.

I tried this out, and it seems here I was worrying needlessly.  I was
probably thinking of the following, which might or might not be
intentional:

	$ mkdir newrepo && cd newrepo
	$ git init
	$ git remote add upstream ../oldrepo
	$ git fetch upstream
	$ git merge --no-ff --no-commit upstream/master

We asked for no commit, but because we are on a branch yet to be born,
the merge makes a commit anyway.

> > 	$ git read-tree -u P'
> 
> Ouch, I'm feeling so git-unitiated here; what is read-tree doing 
> differently from merge?  Isn't here a -m missing?

Why?  We want to just blindly take the tree from P' and using it.  The
point is to make setting the contents of the new branch tip and its
parentage separate decisions.

> > The main problem I see with this story is that if B' is just B with some
> > new changes added this is overly complicated.
> 
> Yes, that's my main gripe.  One of the use cases I'm looking at is
> our ooo-build master branch; which includes ~300 topic branches.
> 
> Removing or [re-]adding one dependency using this rebase-by-merging 
> approch would take ~7 minutes on my machine.

Can you be more precise here?  What user action causes topgit to do
so much work (adding one dependency to what topic)?  What other
approach avoids all this work?
 
> I'm now also looking at a .topundeps file, to support
> the re-adding of a depenency using the cherry-pick approach...

Does it address the situation I mention at the top of this file?

Thanks for clarifying, and sorry I missed your point before.  I'll take
a look at your patch now.

Regards,
Jonathan
