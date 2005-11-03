From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Now What?
Date: Thu, 03 Nov 2005 12:51:10 -0600
Message-ID: <1131043869.10979.17.camel@cashmere.sps.mot.com>
References: <20051103014307.GA1988@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 19:54:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXkCV-0000ts-E2
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 19:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVKCSvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 13:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVKCSvP
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 13:51:15 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:52894 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030434AbVKCSvM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 13:51:12 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id jA3J0XN9026775
	for <git@vger.kernel.org>; Thu, 3 Nov 2005 12:00:33 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jA3IvAWD024133
	for <git@vger.kernel.org>; Thu, 3 Nov 2005 12:57:11 -0600 (CST)
To: Git List <git@vger.kernel.org>
In-Reply-To: <20051103014307.GA1988@pe.Belkin>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11083>

On Wed, 2005-11-02 at 19:43, Chris Shoemaker wrote:

> In general, for each common operation, it'd be nice to explain how to
> "undo". 

So, I've take a stab at the "Reverse a Commit" process.
I _think_ this just about covers all the usual cases
and encompasses much of the lore already sent to the list.

I've punted (so far) on the details of the case where
you want to reverse a buried or copied commit.  I've
read the howto/revert-branch-rebase.txt from Junio,
but I'm not satisfied with it.  While his write up
there is very expository and comprehensive, I think it
is overkill for a "simple recipe paragraph".  Also,
I was annoyed that "git revert -n commit-name" created
conflicts and the reversal and merges didn't happen
for me cleanly even though they did for Junio.  I suck.
So either I don't get it, or it isn't working quite
right these days.  Not sure.  Advice sought.

Here's the gunk I have so far.  Does this need to be
simplified?  Style OK?  Send us more of same!  God help
us all, more ASCII art!?

You know,
jdl





Reversing Commits
-----------------
While a goal of a revision control system is to record
changes and log them via commits, it is sometimes necessary
to reverse a bogus or unwanted commit.

Making a commit in git is a reversible operation.  In order
to realize the reversal, either the index needs to be
reverted to its prior state, or the contents of the files
needs to be reverted and the index updated appropriately.


Here is a rough flow chart to help you.  Discussion of
the individual cases, along with example commands, follows.


+----------------------+
| Oops!  I didn't mean |
| to make that commit! |
+----------------------+
            |
            |
            |
            V
            ^
          /   \
        / Does  \
      /  anyone   \       "Live with it"
     < else have a > -----------------+
      \  copy of  /  Yes              |
        \ commit/                     |
          \ ? /                       |
            V                         |
            | No                      |
            |                         |
            |                         |
            V                         |
            ^                         |
          /   \                       |
        /  Is   \                     V
      /  commit   \  No            +--------------------+
     <  at top of  > ------------> | Generate and apply |
      \    HEAD   /     Ponder     | a reverse patch or |
        \   ?   /    Using StGit   | use git-revert     |
          \   /                    +--------------------+
            V
            | Yes
            |
            |
            V
            ^
          /   \
        /  Are  \
      /   there   \  No            +------------------------+
     <  local dir  > ------------> | # Blow it all away     | 
      \    mods   /                | git reset --hard HEAD^ | 
        \   ?   /                  +------------------------+
          \   /                                |
            V                                  |
                                               |
            | Yes                              |
            |                                  |
            |                                  |
            V                                  |
+----------------------------+                 V
| # I want to recommit it    |     +----------------------+
| git reset --soft HEAD^     |     | # Maybe cleanup some |  
|                            | --> | git prune            |
| # edit/fixup files by hand |     +----------------------+
| # maybe git-add new files  |
|                            |
| git commit -a -c ORIG_HEAD |
+----------------------------+

First, answer this question:  Is it possible that someone
else has a copy of this repository with the faulty commit?
If so, or if the bogus commit is not the most recent commit
on the head, it is very likely the correct course of action
is to simply make a new commit that reverses the prior, bogus
commit.

If there is no other copy of the repository with the bad
commit, then fairly simple steps can be taken to reverse
or remove the bogus commit, but it depends on the state
of your working directory and your intent.


Reverse a buried or copied commit
---------------------------------

FIXME: While the "git diff | apply" works cleanly,
       the "git revert" didn't.  Ponder.

    Use git show-branch to determine the patch name you
    would like to revert.

        # "c" is some commit name, c^ its parent
	% git diff c c^ | git apply
	% git commit -m "Reverting commit...."

    Versus:

	% git revert -n c


[FIXME: Reference howto/revert-branch-rebase.txt]

If you find yourself doing this sort of apply-then-revert
operation frequently, you might want to consider the
StGit tool [FIXME: Reference StGit].



I didn't mean to do that commit! (And I want to blow it away!)
-------------------------------------------------------------
If no other repository or copy of the bogus commit exists,
you can easily remove the immediately prior commit on a
head by simply reverting the index to its prior state.

First, make sure that your working tree matches the
latest commit you are about to undo:

	# Should be no diffs here
	% git diff HEAD

	# Should be the bogus commit, forward:
	% git diff HEAD^

	# Should be the bogus commit, reverse:
	% git diff HEAD HEAD^

If that all looks fine, revert the index:

	# Revert the index to its prior (pre-commit) state
	% git reset --hard HEAD^

Be sure you have no other modified files in your working
directory as they will be overwritten by this command.
Entirely new files that are not mentioned in the index will
be left untouched. However, files that are tracked in the
index will be reverted to their HEAD^ state.



I didn't mean to do that commit! (And I want to recommit it.)
-------------------------------------------------------------

After making a commit and finding a mistake either in the
checked-in files or commit log message), you can fix it up
by doing this:

	# Revert the index to its prior (pre-commit) state
	% git reset --soft HEAD^

	# Fix the checked-in files using your favorite editor
	# Maybe do git-add file(s) that was forgotten, etc.

        % git commit -a -c ORIG_HEAD

The --soft reset leaves the working tree files intact
and just rewinds the .git/HEAD to whatever commit you specify.
Here, the immediately prior index state, HEAD^.  As a side
effect it stores the original .git/HEAD in .git/ORIG_HEAD.

The -a flag to git-commit asks for all paths in the index
to be updated.  The lowercase -c flag to git-commit requests
an opportunity to re-edit the prior commit log message.


Cleaning Up After A Reverted Commit
-----------------------------------
If you have reverted a commit using either "git reset --hard"
or "git reset --soft", you will very likely have created
at least one dangling commit and possibly some dangling blobs
as well.  If you are certain you no longer need these objects,
you can check for fuzz and prune them:

	# Fuzz check
	% git fsck-objects

	# Maybe inspect the danglers using git-cat-file

	# Remove the danglers, they aren't needed
	$ git prune
