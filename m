From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] new tutorial
Date: Sun, 15 Jan 2006 15:26:53 -0800
Message-ID: <7v64olysw2.fsf@assigned-by-dhcp.cox.net>
References: <20060111230451.GH8618@fieldses.org>
	<7vek3epbs9.fsf@assigned-by-dhcp.cox.net>
	<20060112005531.GB14599@fieldses.org>
	<7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net>
	<20060113030837.GD27214@fieldses.org>
	<7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net>
	<20060113151005.GA29804@fieldses.org>
	<7v4q477vqj.fsf@assigned-by-dhcp.cox.net>
	<20060113200152.GI4369@fieldses.org>
	<20060115185458.GA3985@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 00:27:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyHH2-0007jT-RB
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 00:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWAOX06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 18:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWAOX06
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 18:26:58 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16571 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750982AbWAOX05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 18:26:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115232551.VBUI20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 18:25:51 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14715>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> OK, now to partially contradict this,...
>...
> I think it makes sense for the main tutorial to address those beginnning
> users, so with this patch I'm proposing that we move
> Documentation/tutorial.txt to Documentation/core-tutorial.txt and
> replace it by a new tutorial.

Well done, and I think this new organization would serve people better.

> ** Documentation/tutorial.txt **
>...
> Finally,
> 
> ------------------------------------------------
> $ git commit -a
> ------------------------------------------------
> 
> will prompt you for a commit message, then record the current state of all the
> files to the repository.

We may want to mention that the canonical commit log message
format is a single line "summary phrase", an empty line, and the
body of the message.  The core does not enforce it, but it is a
good practice to get into because that is more compatible with
the e-mail workflow.  The first line becomes subject and the rest
the message body, and we do not want the first line of an
multi-line sentence to be on the subject line, with the message
body starting in the middle of that sentence.

> This actually pulls from the branch in Bob's repository named "master".  Alice
> could specify a different branch to pull from in a third argument to pull.
> 
>...

A bit narrower fill-column settings, please.

> She can do this by creating a temporary branch just for the purpose of
> studying Bob's changes:
> 
> -------------------------------------
> $ git branch bob-incoming
> $ git checkout bob-incoming
> $ git pull /home/bob/myrepo
> $ git-whatchanged -p
> --------------------------------------

Easier would be:

        $ git fetch /home/bob/myrepo master:refs/heads/bob-incoming
        $ git whatchanged -p HEAD..bob-incoming

You do not have to switch out of your "master" branch only to
fetch into a different branch.  And it is usually a good
discipline not to commit yourself into a branch you use to keep
track of foreign branch.  Which means you do not do the fixup in
bob-incoming branch, but either in your master or another
branch:

	$ git checkout -b bob-fixup bob-incoming
        $ edit
        $ git commit -a -m 'Fixup frotz and filfre'

Then you can:

	$ git checkout master
	$ git pull . bob-fixup

> Fixing Mistakes
>...
> -------------------------------------
> $ git reset --mixed HEAD^
> -------------------------------------

I have a mixed feeling on this one.  I tend to recommend --soft
instead --mixed to people, but both have their pros and cons:

 * "reset --mixed HEAD^" reads the HEAD^ tree into the index, so
   "git diff" shows your changes.  However, it *forgets* all the
   "git add" you did [*1*].

 * "reset --soft HEAD^" does not touch the index, so "git diff"
   would show the same thing as what you would have seen before
   your reset, which means nothing after a commit you regret
   about.  You need to say "git diff --cached".  But it does not
   forget about "git add".

> $ git-cat-file commit 67ad31933f09677d0fed6ac62287f07441b215c6
> tree 4662df01e0e9cfd9b7fab83d7a5234ee651d8804
> parent 9e9b26751a5ca7a257b3e1cfb319fe3e4efc663c
> author J. Bruce Fields <bfields@puzzle.fieldses.org> 1137281075 -0500
> committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1137281075 -0500
> 
> minor copyediting of recent additions to git-commit and git-reset ...

If this is intended to be a beginner documentation, I'd prefer
if it did not talk about cat-file, nor how commit objects are
internally represented.

> Note that by default git pull does not fetch new tags; use
> 
> -------------------------------------
> $ git-fetch --tags
> -------------------------------------
> 
> to get all of the tags from a repository.

These days by default "git fetch" (and "git pull") fetches the
tags that refer to the commits you fetch as part of regular
updates, so this part is mostly redundant.  It still is useful
to slurp tags that do not belong to the commit chain you are
following.

> You can revisit the old state of a tree, and make further modifications
> if you wish, using git branch:
> 
> -------------------------------------
> $ git branch stable-release 67ad31933f09677d
> -------------------------------------

Empirically the first 7 hexdigits are enough (even 5 for small
projects such as git itself).  In fact, in the linux-2.6
repository itself, it appears 5 hexdigits are enough to identify
all 171902 objects (not just commits) uniquely currently, but of
course that would not hold true forever.  16 is way overkill and
an eyesore.


BTW, I do not see the CC'ed copy on list archives and am
wondering why even though I see CC: header in the copy I
received...

BTW^2, it might be interesting to do

	$ git format-patch -C origin..master

the next time around.


[Footnote]

*1* If we taught the index file how to record "intent to add"
(or, "keep an eye on this path for me"), we could fix the
implementation of reset --mixed to take advantage of it.
