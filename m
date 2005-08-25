From: Junio C Hamano <junkio@cox.net>
Subject: Re: cache status after git pull
Date: Thu, 25 Aug 2005 13:26:07 -0700
Message-ID: <7v4q9dvk4g.fsf@assigned-by-dhcp.cox.net>
References: <200508251608.j7PG8XGq016882@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 22:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8OIe-0001z4-Bt
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 22:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVHYU0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 16:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVHYU0J
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 16:26:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38092 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932550AbVHYU0I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 16:26:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050825202608.SZBT3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 Aug 2005 16:26:08 -0400
To: tony.luck@intel.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7760>

tony.luck@intel.com writes:

> Aha ... is this the problem that caught me out last week (when
> I ended up with 10 extra files attached to one of my commits)?

Plausible.

> 1) Updated my "linus" branch:
>
>   $ git checkout linus && git pull linus

I would assume that just after "git checkout linus" before "git
pull linus", running "git diff -r linus" would have said
nothing.

The second command, "git pull linus", would internally run "git
fetch linus".  It depends on how your shorthand "linus" is
defined, but if it is set to update (either overwrite or
fast-forward) the "linus" branch head, then your HEAD pointer
would be updated without updating the index and working tree.
This is bad because now you are telling git that your working
tree is based on updated "linus" branch head, and what you
_could_ commit on top of it is the same thing as what old
"linus" branch head commit used to have.  That's why "git
status" output shows the minefield.

If I keep copies of foreign brahches in $GIT_DIR/refs/heads/
somewhere, I never checkout those branches in my working tree.
I always stay in my branches to do my work.  I may "diff"
against them to see where I am.  Of course I would "resolve"
with them when I feel I am ready.

So, assumes that "linus" short-hand is set up to update
$GIT_DIR/refs/heads/linus with the foreign branch head, the
above example would have been:

    $ git checkout master && git pull linus
    : examine diffs and be convinced what Linus does is always right.

If my "master" branch is not ready to merge from Linus but I
want to get a feel of what is coming, I would instead do:

    : while staying on my master branch
    $ git fetch linus
    $ gitk linus master ;# or git show-branch linus master

and later when my branch is ready, I would merge it into my
master:

    : still staying on my master branch
    $ git pull . linus

If you did the pull into your master but it turns out that the
merge result is too messy, you could always reset (back to the
first example):

    $ git checkout master && git pull linus
    : if merge failed...
    $ git reset --hard master

    $ git checkout master && git pull linus
    : merge succeeds, but I realize that my tree was not quite
    : ready to merge from linus -- going back to pre-merge state
    $ git reset --hard master^1


The rules for updating $GIT_DIR/refs/ when fetch happens have
been extended and clarified in 0.99.5 quite a bit.

To set up "linus" short-hand to be updated with "master" branch
head from Linus, you would do one of the following:

  * Using old style shorthand

    $ echo >$GIT_DIR/branches/linus \
    http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
    $ git fetch linus

  * Using new style shorthand

    $ cat >$GIT_DIR/remotes/linus \
    URL: http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
    Pull: master:linus
    $ git fetch linus

  * From the command line, having either branches/linus or
    remotes/linus from the above two examples:

    $ git fetch linus master:linus

To set up "linus" short-hand _not_ to update any local branch
head (i.e. you only use "pull" to update your local branch,
which can be named "linus" branch), you would do one of the
following:

  * Using old style shorthand

    There is no way to do this using old style shorthand without
    an explicit command line <refspec>.  See the "From the
    command line" example below how to do this.

  * Using new style shorthand

    $ cat >$GIT_DIR/remotes/linus \
    URL: http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
    Pull: master:
    $ git fetch linus

  * From the command line, having either branches/linus or
    remotes/linus from the above two examples:

    $ git fetch linus master:
