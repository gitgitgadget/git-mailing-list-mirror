From: Junio C Hamano <junkio@cox.net>
Subject: Re: Is reserving the branch name "bisect" a good thing?
Date: Sat, 03 Dec 2005 11:15:07 -0800
Message-ID: <7vbqzyxa9w.fsf@assigned-by-dhcp.cox.net>
References: <20051202232555.13082.qmail@science.horizon.com>
	<20051203134136.31524.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:16:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eicqn-00041H-1f
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVLCTPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVLCTPK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:15:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:50680 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751114AbVLCTPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 14:15:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203191420.QMNN20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 14:14:20 -0500
To: linux@horizon.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13160>

linux@horizon.com writes:

> Without changing this policy in git-checkout, or replicating most
> of git-checkout's code in git-bisect, I can't get away from using
> a head name in refs/heads/.  :-(

I tend to think the above "restriction" a conscious design decision.

> Actually, this leads to a question... suppose I want to manually
> check out some old revision (like "v.2.6.12") for some reason
> (performance testing, say).  How do I do that?
> Do I have to create a branch just to do that?

Absolutely, and that is deliberately so.  You do not want to:

	git checkout v2.6.12
        work work work
        git commit

and move tag v2.6.12 to something that is not v2.6.12.  As you
outlined, that "not moving the tag" check can be done in git
commit and have the user do:

	git checkout v2.6.12
        work work work
        git commit ;# fails
	git checkout -b oops-i-needed-a-branch-after-all
	git commit

but that feels ugly and wrong.

Branches are cheap (just a single file which is a pointer), so
if you prefer neatness:

	git checkout -b test-build v2.6.12
        work work work
        git checkout master ;# when you are done
        git branch -d test-build

Or if you are lazy like me, just keep a single throwaway branch
around, and whenever you feel like:

	git branch -f ta v2.6.12
        git checkout ta
        work work work
        git checkout master ;# when you are done

To test and possibly further develop the git-daemon update topic
branch, which is two revs before the tip of proposed updates
branch:

	git branch -f daemon-updates pu~2
        git checkout daemon-updates
        make
	work work work, find problems and do enhancements
        git commit

then you can say "Hey, Junio I found problem in your daemon
updates topic branch, and if you want my fixes you can pull from
my daemon-updates branch".

> It might be nicer to allow such a checkout and do the checking in
> git-commit, telling you to "git-checkout -b <new_branch>" before
> you check in your edits.

That may be, but it is too confusing.  Everybody needs to be
aware HEAD can point at random place, not necessarily on some
branch.  You happen to have noticed git-commit wants HEAD to be
pointing at a branch and no other random place, but are you
absolutely sure no other tools care?  I don't.

> +# Not generally needed, but provide a cleanup function
> +bisect_stop() {

Why isn't this part of bisect reset?
