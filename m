From: Junio C Hamano <junkio@cox.net>
Subject: Re: Simple UI question...
Date: Sun, 07 Jan 2007 03:30:56 -0800
Message-ID: <7vodpb13bj.fsf@assigned-by-dhcp.cox.net>
References: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 12:31:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3WF5-0004ni-3U
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbXAGLa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbXAGLa7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:30:59 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:45792 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517AbXAGLa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:30:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107113057.IWRA29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jan 2007 06:30:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8BXC1W0071kojtg0000000; Sun, 07 Jan 2007 06:31:13 -0500
To: "Chris Lee" <clee@kde.org>
In-Reply-To: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
	(Chris Lee's message of "Sun, 7 Jan 2007 03:02:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36162>

"Chris Lee" <clee@kde.org> writes:

> Eric Anholt suggested 'git checkout -b temporary-branch-name
> $sha1sum'; davej suggested 'git-read-tree $sha1sum &&
> git-checkout-index -a -f' but for some reason, neither of these
> commands seems to do exactly as I expect.

These two do vastly different things (but the latter is flawed
and does _not_ do what it is trying to do).

 - If this checkout is just to look-see, and if you are on a
   branch that is precious to you (say, you intend to keep
   importing from svn or other repository onto that branch),
   then you should use a temporary branch.  Eric's suggestion is
   this approach -- but "git checkout -b $branch $start" is
   about CREATING a new branch, so once you used the temporary
   branch name, you cannot expect the same command line with
   only different starting point to work.  In other words, I
   suspect you saw "it doesn't work" because you did this:

	$ git checkout -b foo $commit1
	$ git checkout -b foo $commit2

   and got an error message from the second one.

 - If you do not mind trashing the current branch, then "git
   reset --hard" is what you want, and what you said was Dave's
   suggestion is an incorrectly spelled version of old timer's
   way to do what "git reset --hard" does by hand.

Assuming that you do not want to trash your branch (and you
usually don't), the correct sequence is first do:

	$ git checkout -b look-see

This creates a new branch "look-see" (the name does not matter
as long as you do not have such a branch) from whatever branch
you happen to be on and switch to it.  After this, you will be
on the new "look-see" branch.  At which commit this branch
starts does not matter.

Then, whichever commit you would want to check out and look at,
you would do:

	$ git reset --hard $commit
 
This "trashes" look-see branch by moving to that commit -- it
trashes in the sense that it makes the "look-see" branch forget
about all commits that comes after you resetted to, but you do
not care because this branch is temporary branch you created.
Once you are done looking at this commit, you can repeatedly say
"git reset --hard" to move around to look at different commits.

Once you are done, you do not need to be on (nor need) look-see
branch, so get rid of it.

	$ git checkout master
        $ git branch -D look-see

> ... (The problem I have seen is that, for some
> revisions, the only files I get in the working copy are the files that
> were changed in that commit; the rest of the files in the tree do not
> get checked out.)

This is because the low-level commands in the above example to
mimick "git reset --hard" does is flawed.

If you are curious,...

The way "git-reset --hard" does it (it is just a shell script) is:

	git-read-tree --reset -u $rev

but it does other things for safety.  Dave apparently learned
git long time before we only had plumbing (set of low-level
commands), so the suggestion did not use Porcelain (higher level
commands) "git-reset"; back then, the correct way to spell that
was:

	git-read-tree $rev &&
        git-checkout-index -f -q -u -a

but git-read-tree learned -u option and made the second command
in this sequence unnecessary.

In general, you should not have to use git-checkout-index nor
git-read-tree yourself if you are working with today's git.
