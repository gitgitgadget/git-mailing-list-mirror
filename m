From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add commit --interactive
Date: Thu, 01 Mar 2007 22:06:34 -0800
Message-ID: <7v649ki3h1.fsf@assigned-by-dhcp.cox.net>
References: <es6bgl$t3f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 07:06:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN0ud-0002A3-7C
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 07:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422938AbXCBGGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 01:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422940AbXCBGGg
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 01:06:36 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43494 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422938AbXCBGGf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 01:06:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302060634.MOKG2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 01:06:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vi6a1W0071kojtg0000000; Fri, 02 Mar 2007 01:06:35 -0500
In-Reply-To: <es6bgl$t3f$1@sea.gmane.org> (Paolo Bonzini's message of "Thu, 01
	Mar 2007 11:56:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41160>

I am guilty of introducing "add --interactive" and am somewhat
regretting it.

Why?

Because it encourages a wrong workflow, but the word "wrong"
needs to be clarified.

The workflow assumed by "add --interactive" (hence by its
wrapper, "commit --interactive") goes like this:

 1. You have some large task.  You start hacking and keep hacking
    and hacking.

 2. Your working tree might still be a messy state, but there are
    some good bits in the mess that are worth committing on their
    own, excluding the other changes in the working tree.  This
    could happen for a number of reasons:

    - You might be actually done with the change and your working
      tree is perfect, but the change since the HEAD commit is
      too big to be a single logical change.  You want to split
      the changes into smaller steps.

    - You might be still in the middle of what you initially
      wanted to achieve, but at the same time you found
      something worth changing, which is independently useful
      regardless of what you are doing.  It may be a typo.  It
      may be a bug that might or might not affect what you are
      doing.  But as long as you found it and fixed it, you
      would want to make a separate commit.

 3. So you would fire up "add --interactive", and isolate the
    "good bits" by updating the index selectively to prepare for
    commit.  You would run "diff --cached" to review the change
    you are going to commit makes sense, and then finally make a
    commit.

I am not saying the first two steps are wrong.  Everybody does
that all the time.

What's wrong is the approach "add --interactive" takes in the
last step.  The isolation of "good bits" happens in the index,
not in the working tree --- which is largely because git is
designed to commit the state recorded in the index --- but that
encourages the user to commit something that has never been in
the working tree, so by definition what is committed in step 3
never could have been even tested.  And that is what I feel is
very wrong.  People in the past claimed that they later would go
back to each individual commit and test them, but that is simply
hard to believe, because it is tedious in practice.

We should be able to do better than that.  Instead of the step 3
in the above, we could have a way to quickly stash the working
tree state, reset the working tree to that of the last commit
(or whatever commit we want to build a new commit on top of),
and selectively apply parts of the the changes we stashed to the
working tree.  Then we can test the state in the working tree,
and run "commit -a" as usual.  What's still left in the stashed
state can incrementally be trickled in to make further commits.

Probably the operation would go like this.  I'll describe them
in terms of lower level operations, and leave the scripting to
others.

* Stashing the current state

        git commit -a -m 'stashed'
	git tag -f stash
        git reset --hard HEAD^

  After this point, "diff stash^ stash" is the changes yet
  to be applied.

* Switch to the commit you want to apply part of what was
  stashed to.  This part is optional if you are only building on
  top of the current HEAD, but if you have a small but urgent
  bugfix you might want to switch to another branch (say,
  'maint').  There is no magic command needed -- just run

	git checkout maint

  as usual, for example.

* Trickle some of the stashed changes in, perhaps interactively:

	git pick stash

  would probably give an interactive UI similar to "add -i" to
  let you pick and choose from "git show stash" (either per-hunk
  or per-path), but unlike "add -i", which applies the chosen
  change only to the index, it applies the change to the working
  tree and to the index.  As the last step of its operation,
  "git pick" would save the resulting index state as a tree:

	git tag -f pre-fixup `git-write-tree`

* Review and test the change in the working tree.  This does not
  need any special command.  You may also make fix-up in the
  working tree as usual.  Then you would make a commit, perhaps
  using the usual "git commit".

* Then this is the tricky and interesting part.  We need to
  subtract the change we already used to advance HEAD from
  "stashed changes".  I do not think we currently have a single
  command to do this step, but it would probably go like this.

  1. First, we build a tree that is stash^ plus the changes
     we committed right now.

	git read-tree -m -u stash^
	git merge-recursive HEAD^ -- stash^ HEAD
	NEW_TREE=`git write-tree`
        NEW_BASE=`echo stash | git commit-tree $NEW_TREE`

     This would make our working tree and the index match the
     state you would have had, had you started from the original
     state and made only the changes you have committed just
     now.  Note that the resulting tree contains the manual
     fix-ups you made since pre-fixup.

  2. The tree state you would eventually want to have used to be
     in stash but that lacks the manual fix-up you made, which
     is the difference between pre-fixup and HEAD.  So let's
     update the final state with this difference:

	git read-tree -m -u stash
        git merge-recursive pre-fixup -- stash HEAD
	NEW_TREE=`git write-tree`

  3. The strategy is to keep stash pointed at a commit that has
     the tree state of what you eventually would want to have
     (which is now in $NEW_TREE), and represent the changes yet
     to be applied as "diff stash^ stash".  So let's update the
     stash tag:

	NEW_STASH=`echo stash | git commit-tree $NEW_TREE -p $NEW_BASE`
	git tag -f stash $NEW_STASH

* You just finished one step, and still have remainder that can
  be seen from "git show stash".  Go back to "Switch to the
  commit" step (or "Trickle some of the stashed changes" step)
  above and repeat.  The output from "git show stash" will keep
  shrinking, and when it becomes empty you are done.
