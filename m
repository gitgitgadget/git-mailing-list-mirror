From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 23:02:00 -0700
Message-ID: <7vejmg9a1z.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>
	<200704181426.29969.andyparkins@gmail.com>
	<462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org>
	<4626C4B9.1040707@midwinter.com>
	<7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 08:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HePit-0006BX-17
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 08:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030853AbXDSGCD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 02:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030856AbXDSGCD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 02:02:03 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60345 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030853AbXDSGCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 02:02:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419060200.VHLU1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Apr 2007 02:02:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ou201W00R1kojtg0000000; Thu, 19 Apr 2007 02:02:00 -0400
In-Reply-To: <7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Apr 2007 19:11:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44986>

Junio C Hamano <junkio@cox.net> writes:

> Steven Grimm <koreth@midwinter.com> writes:
>
>> And in particular -- this being the original topic of the thread --
>> when an svn user sees me doing that, they do not immediately think of
>> the fact that merging between immutable revisions may have some
>> benefits. They see me typing four commands (commit, fetch, rebase,
>> reset) to do the same thing they can do in one command with svn, and
>> conclude that git is harder to use.
>
> No arguments there.  While I know I will never use such a
> workflow myself, I think it makes sense to _allow_ local
> changes to be merged to the new revision if the user chooses to
> use such a workflow.

Actually, there is one thing that makes this much easier to do
in SVN.  It is its centralized nature.

If you have this sequence:

	(1) update and sync with the repository
        (2) you work alone, without committing
        (3) while you do (2), other people make commits
        (4) you update from the repository

Because of its central nature, the commits made in (3) are
always proper descendant of the commit you are basing your work
on in (2).  So at point (4), the resolution you would need to
perform is this "merge".

          (2).............M?
         /               . 
	1-----3a-3b-3c-3d

    Notational convention: Solid lines and unparenthesized
    letters are actual commits and ancestry in these pictures.
    Letters in parentheses and dotted lines are locally modified
    states and derivations of these states from commits.

But because there is no "commit" that records the work you did
in (2) alone, you can afford to 3-way merge whatever conflict
you get at M and you do not even record M as a merge.  The
result simply becomes a proper descendant of 3, which is still
uncommitted local change.

                          (2')
                         .
	1-----3a-3b-3c-3d


The patch series I "vaguely recalled" in my previous message
handled this special case where the branch being merged
(i.e. 3d) was a fast-forward of the current commit (i.e. 1).

However, in git, you do not necessarily work that way.  As you
admitted, the ability to commit locally is what's different.


          2a---2b..(2c)...M?
         /               .
	1-----3a-3b-3c-3d

If (4) happened after you've accmulated local commits 2a, and
2b, and you have local changes (your state 2c is different from
your tip, 2b, but is uncommitted, and kept in the working tree
alone), you usually do not want to resolve the mess to make a
commit M, pretend M is a proper descendant of 3d, depending on
the final structure you are trying to achieve (the mess may come
from interactions between 3's and 2a or 2b, or interactions
between 3's and 2c).

There are three possible commit ancestry structures you would
want to eventually reach, and three distinct sets of steps to
reach those structures.

 1. Perfect what you were in the middle of, and then perform a
    merge.  IOW, you don't have to update from remote when you
    are not ready.

          2a---2b---2c----M
         /               / 
	1-----3a-3b-3c-3d

 2. Merge what has already been committed, excluding your
    unproven WIP that is in the working tree, and roll forward
    your local changes on top of it.

          2a---2b---------M..(2c')
         /               / 
	1-----3a-3b-3c-3d

 3. Always serialize by rebasing.  The structure you would want
    to end up with is like this:

                         2a'-2b'.(2c')
                        /
	1-----3a-3b-3c-3d

Among these three workflows, what is most natural in git is the
first one.  The tool natively supports it well.

For the second workflow, you would:

    2-a. first make a tentative commit 2c

	$ git commit

                 --2c
                /
          2a---2b
         /
	1-----3a-3b-3c-3d

    2-b. merge what was ready on your end and the other side:

	$ git checkout HEAD^ && git merge origin

                 --2c
                /
          2a---2b---------M
         /               / 
	1-----3a-3b-3c-3d

    2-c. roll forward the local change you have in 2c:

	$ git rebase --onto HEAD master
        $ git reset HEAD^

          2a---2b---------M...(2c')
         /               / 
	1-----3a-3b-3c-3d


This probably is the next best organization.  But you have to
realize that this requires you to resolve potential conflict
when creating M and then another conflict when rolling forward
your local changes.

    We probably could help automating this, but your "git pull"
    session transcript need to look like this:

	$ git pull origin
        First stashing away of your local changes...
	Resolving conflicts between 2b and 3d.
	Conflicted merge.  Please resolve and commit.
	$ edit ; test
        $ git commit ;# to record M
	Committed the merge result.
        You have stashed local changes further to roll forward.
        $ git unstash local-changes
        Resolving conflicts between M and 2c.
	Local changes conflicted during roll-forward.
        Leaving resulting mess in the working tree for you to sort out.
	$ 


To end up with the third graph, you would:

    3-a. first make a tentative commit 2c

	$ git commit

                 --2c
                /
          2a---2b
         /
	1-----3a-3b-3c-3d

    3-b. rebase

	$ git rebase origin

                          2a'--2b'--2c
                         /
	1-----3a-3b-3c-3d

    3-c. reset

	$ git reset HEAD^

                          2a'--2b'..(2c')
                         /
	1-----3a-3b-3c-3d


and I think that is what you have been doing.  Both the final
structure and the workflow are least "git-like" among these
three.

    If you want to automate this, you can use this four-liner
    shell script:

	#!/bin/sh
        git commit || exit
	git fetch origin || exit
        git rebase origin || exit
	git reset HEAD^

    Store this in $HOME/bin/git-sgpull, if you may, and you can
    even say "git sgpull" to invoke it.

    When 'rebase' does not get conflict, which is the bast case
    you are primarily complaining about, having to type three
    commands, this will run to the end with this single command
    and you will feel happier.

    When 'rebase' gets conflict, however, you would need to
    resolve and have it keep going, but that is something you
    cannot avoid.  You would need to remember that the final
    "reset HEAD^" needs to be issued from your shell, but that
    should be obvious.
