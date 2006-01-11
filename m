From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect is magical
Date: Tue, 10 Jan 2006 18:47:36 -0800
Message-ID: <7vhd8b1nw7.fsf@assigned-by-dhcp.cox.net>
References: <dpuoqf$3rp$1@sea.gmane.org>
	<Pine.LNX.4.64.0601091516460.5588@g5.osdl.org>
	<dq11c6$g15$1@sea.gmane.org>
	<Pine.LNX.4.64.0601101131540.4939@g5.osdl.org>
	<Pine.LNX.4.64.0601101143180.4939@g5.osdl.org>
	<dq168p$3kt$1@sea.gmane.org>
	<Pine.LNX.4.64.0601101308540.4939@g5.osdl.org>
	<dq1o88$1bm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 03:47:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwW1Y-0001gZ-0s
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 03:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWAKCrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 21:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWAKCrl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 21:47:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:736 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932699AbWAKCrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 21:47:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111024534.GNSQ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 21:45:34 -0500
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dq1o88$1bm$1@sea.gmane.org> (wa1ter@myrealbox.com's message of
	"Tue, 10 Jan 2006 17:50:00 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14475>

walt <wa1ter@myrealbox.com> writes:

> Linus Torvalds wrote:
> [...]
>> So when you say "git checkout origin", it actually _switches_ to the
>> origin branch (which is just my state) and checks that out.
>
> Please --> what am I switching *from* when I switch to 'origin'?

Short version: if you have only two branches "master" and
"origin", then obviously there is only one "the other one" ;-).

Longer version:

At the very beginning, you started your repository like this:

        $ git clone git://git.kernel.org/some/where mine
        $ cd mine

You can say:

	$ git branch

And you would see:

	$ git branch
        * master
          origin

So you have two branches, and you are on "master" right now.

Your working tree files are associated with one branch at any
moment, and "git branch" shows you which branch you are on.
That branch is "the current branch".  When you make your
commits, you will commit into that branch.  The commit-producing
commands include "git commit", "git am", "git pull", "git
merge", "git revert" and "git cherry-pick".  They all create a
new commit on your "current branch".  The difference among them
is where the commit you create takes the modifications from
(commit from the index file and the working tree, am from a
mailbox, pull and merge from a different branch, and revert and
cherry-pick from an existing commit).

You usually work in your "master" branch.  But you do not have
to.  Suppose you are working on maintaining some product, and
you have a couple of trivial bugfixes you can make and one
rather involved enhancement.  What you could do is to have more
than one branches, and use "master" for what are ready to be
consumed by other people, and another branch for your
developments.

Your repository at one point might look like this:

        $ git show-branch
        *  [master] trivial fix #2
         ! [devel] work in progress #3
        --
         + [devel] work in progress #3
         + [devel^] work in progress #2
         + [devel~2] work in progress #1
        +  [master] trivial fix #2
        +  [master^] trivial fix #1
        ++ [master~2] released frotz gadget

You are on the "master" branch, and committed two trivial fixes
on top of it since your last release.  But in the meantime you
found time to do independent enhancements, not yet finished but
slowly progressing.  You hope to be able to complete the
development and include that in the master branch eventually,
but not yet.

How you would end up to something like above would go like this:

 1. You have just released frotz gadget.  Your "master" branch
    is at that commit, and you do not have the "devel" branch
    yet.

 2. You are inspired by somebody to enhance frotz in a novel
    way.  You start hacking and accumulate some changes in the
    working tree files, but now you realize it will be a bigger
    task than you initially thought.  In the meantime, you got a
    couple of bug reports and you think you know how to fix them
    trivially.  But unfortunately, your working tree files are
    currently in a great mess.  Then:

        $ git checkout -b devel

    This creates a new branch ("devel") based on the current
    branch head (remember, you were on "master" branch), and
    switches to that new branch.  It is a short-hand for the two
    command sequence:

	$ git branch devel
        $ git checkout devel

    This takes your working tree changes with you, so at this
    point if you do "git diff", you will see your changes.  You
    commit this mess (do not worry about "presentable history"
    yet; you will be cleaning up the mess later anyway before
    you merge).

	$ git add new-files-you-created
	$ git commit -a -m 'work in progress #1'

 3. Now you can switch mood and can work on the trivial fixes.
    Go back to the "master" branch:

	$ git checkout master

    you'll notice that all the mess you made while working on
    devel has been cleaned up --- WIP edits are gone, and if you
    made new files for "devel" they are gone too.  You start
    from the state immediately after release, and work on fixes,
    and commit:

	$ edit for trivial fix number 1
	$ git commit -a -m 'trivial fix #1'
	$ edit for trivial fix number 2
	$ git commit -a -m 'trivial fix #2'

 4. Now fixes are out of your way, you can go back to work on
    the enhancements.  The same thing as step 3.

	$ git checkout devel
	$ edit / test / commit

Eventually what you do in your devel branch comes to maturity
and ready for public consumption.  How would you make sure when?
For that, you would create a throw-away test branch and try
things out:

	$ git branch -f test master
        $ git checkout test
        $ git merge 'development trial' test devel

This would create something like this:

        $ git show-branch
        !   [master] trivial fix #2
         !  [devel] work in progress #3
          * [test] development trial
        ---
	  + [test] development trial
         ++ [devel] work in progress #3
         ++ [devel^] work in progress #2
         ++ [devel~2] work in progress #1
        + + [master] trivial fix #2
        + + [master^] trivial fix #1
        +++ [master~2] released frotz gadget

You merged "devel" and "master" in "test" branch, so that you
can test your development along with the other fixes you had in
the "master" branch since your "devel" branch forked.  Try
things out and if you find the result satisfactory, then you
know what you have in "devel" is good for public consumption.

There are three ways to bring the "devel" into "master" at this
moment.  It depends on how much you care about clean history.

 A) just merge.

	$ git checkout master
        $ git pull . devel

    This is the simplest, but you would see all the real history
    in "devel" branch, things like "work in progress #n" commit
    log messages.

 B) refactor and linearize.

	$ git format-patch -k -m -o ./+redo master..devel

    This leaves a patchfile per commit in devel branch in +redo/
    directory.  You can edit the commit log message and patch
    just as if you are preparing them for e-mail submission to
    another project maintainer.  Once you are done editing:

	$ git checkout master
        $ git am -k -3 ./+redo/0*.txt

    to apply them on top of the master branch.

 C) linearize without refactoring.

	$ git checkout devel
        $ git rebase master
        $ git checkout master
        $ git pull . devel

    This "rebases" the development branch (the first two steps),
    and then pulls the result into the "master" branch (the
    rest).  It should give you the same result as approach B) if
    you do not edit your +redo/ files at all.

Once you are done, you can clean up by

	$ git branch -D test devel
