From: Junio C Hamano <junkio@cox.net>
Subject: Re: new file leaked onto release branch
Date: Sat, 17 Dec 2005 23:08:40 -0800
Message-ID: <7vhd96ubk7.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056B83F2@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0512141150210.3292@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 08:09:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ensez-0008Gc-FP
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 08:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbVLRHIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 02:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbVLRHIm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 02:08:42 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55434 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932681AbVLRHIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2005 02:08:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051218070657.PALL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Dec 2005 02:06:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512141150210.3292@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 14 Dec 2005 12:10:47 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13790>

Linus Torvalds <torvalds@osdl.org> writes:

> git-merge does:
>
> 	common=$(git-merge-base --all $head "$@")
>
> and then it _should_ have triggered this case:
>
> 	case "$#,$common,$no_commit" in
> 	..
> 	1,"$1",*)
> 		# If head can reach all the merge then we are up to date.
> 		# but first the most common case of merging one remote
> 		echo "Already up-to-date."
> 		dropsave
> 		exit 0
> 		;;
> 	..
>
> and thus never have created any merge messages.
>...
> Hmm. It really looks like it should have been impossible to generate that 
> commit with current git, which is why I'm still a bit suspicious. 

Two good news (one puzzle fully explained, one bug fixed) and
one not so good news (one puzzle still remains).

First good news.  I solved this puzzle.  This has been fixed as
a part of a seemingly independent fix:

    commit 9954f5b876abb6118f9bdf1d113239d86acca7bd
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Tue Dec 13 17:01:23 2005 -0800

        [PATCH] allow merging any committish

        Although "git-merge" is advertised as the end-user level command
        (instead of being a "git-pull" backend), it was not prepared to
        take tag objects that point at commits and barfed when fed one.
        Sanitize the input while we validate them, for which we already
        have a loop.

        Signed-off-by: Junio C Hamano <junkio@cox.net>

There was a bug in git-merge which used the user input without
converting them to object names.  When the part you quoted above
was executed, $1..${$#} were remote ref parameters from the
command line, so in the case of Len's commit, which did:

      git merge "Auto-update from upstream" release linus

"$1" at that point was string "linus", not the object name
returned from "git-rev-parse --verify linus".  The case pattern
match did not match because $common was object name and $1 was
not.  This was fixed by the above commit; the user supplied refs
are already converted into object names at that point with the
current code.

I have never seen this problem myself because git-pull feeds
object names after converting refnames to git-merge, but people
who used the git-merge command themselves could have been
affected by the bug.

So I think I am done with the "this is "already-up-to-date"; why
does that commit exists in the first place?" commit we have
discussed in this thread.

Second good news.  I have been working on a theory on the "where
did this file come from?" problem.  I found a real bug that can
cause a bad mismerge that can introduce completely unrelated
changes to the tree, but after digging a bit deeper, I do not
think it matches Len's problematic commit.  It still is a bug.

If you run the sequence attached at the end in an empty
repository, you will have a repository suitable for this
demonstration.  After the script runs, the commit structure
would look like this:

! [heads/7589] add xyzzy
 * [master] Merge 7589 branch
  ! [nitfol] add nitfol
---
+   [8eec60c] add xyzzy			<tag 7589>
 +  [db5bc99] edit frotz
  + [758916c] add nitfol
+++ [70c4319] initial

There are three branches: master, nitfol, and "7589".
They all start from the initial commit which has one file
"frotz" and each branch adds one commit.  Also the tip of 7589
branch is tagged as "7589".  Now, we will run this:

	$ git merge "Merge 7589 branch" HEAD 7589

With this setup, the current tip of the "master" branch
mismerges and adds "nitfol" file which did not exist in either
branch heads (and it is not fixed with the 9954f5 commit above).

A change I introduced mid November causes get_sha1_basic() to
misinterpret "7589" to be neither the tag 7589 nor branch 7589
tip, but by mistake it does not outright fail, but returns the
758916c commit!  This merge ends up pulling nitfol branch head
into master branch, not 7589 branch as the user intended.  The
resulting merge commit has db5bc99 and 758916c as its parents.

The "revert misguided disambiguation" patch I posted earlier
fixes this problem.  I'll push it out tonight.

This theory however does not seem to match what really happened.
Len did mention that he has "5165" branch (there is a commit
marked "Pull 5165 into release branch" near a problematic
merge), but he did not say he also has a 5165 tag; the bug does
not trigger if you do not have the tag of the same name.  Also
if this theory holds true, the problematic commit should have a
commit whose object name begins with 5165 as the second parent
but that is not the case.  And the problem happened with a
commit that is not a merge between release/test and topic
branch anyway; it is with an "Auto-update from upstream" commit.

So I am still puzzled by the "where did this file come from"
problem.  The most plausible explanation was the driver error
mentioned already in the thread: "update-index --add" in the
middle of merge with manual committing.

----------------------------------------------------------------
#!/bin/sh

GIT_AUTHOR_DATE='1995-01-29T15:00:00 -0800'
GIT_AUTHOR_EMAIL='author@example.com'
GIT_AUTHOR_NAME='A U Thor'
GIT_COMMITTER_DATE='1995-01-29T15:00:00 -0800'
GIT_COMMITTER_EMAIL='committer@example.com'
GIT_COMMITTER_NAME='C O Mmitter'

export GIT_AUTHOR_DATE
export GIT_AUTHOR_EMAIL
export GIT_AUTHOR_NAME
export GIT_COMMITTER_DATE
export GIT_COMMITTER_EMAIL
export GIT_COMMITTER_NAME

git init-db

echo frotz >frotz
git add frotz
git commit -m 'initial'

git checkout -b nitfol
echo nitfol >nitfol
git add nitfol
git commit -m 'add nitfol'

git checkout -b 7589 master
echo xyzzy >xyzzy
git add xyzzy
git commit -m 'add xyzzy'
git tag 7589

git checkout master
echo FROTZ >frotz
git update-index frotz
git commit -m 'edit frotz'
