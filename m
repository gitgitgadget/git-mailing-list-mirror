From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.4.0 usability problem
Date: Tue, 20 Jun 2006 02:35:32 -0700
Message-ID: <7vr71kb257.fsf@assigned-by-dhcp.cox.net>
References: <449557B6.1080907@garzik.org>
	<7vbqsqdru0.fsf@assigned-by-dhcp.cox.net> <4495DB3B.10403@garzik.org>
	<7v4pyhdel5.fsf@assigned-by-dhcp.cox.net>
	<4497B39E.2050205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 11:35:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsce1-0005ED-6M
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 11:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWFTJfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 05:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWFTJfe
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 05:35:34 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5088 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965233AbWFTJfd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 05:35:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620093533.LESP6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 05:35:33 -0400
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <4497B39E.2050205@garzik.org> (Jeff Garzik's message of "Tue, 20
	Jun 2006 04:36:46 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22185>

Jeff Garzik <jeff@garzik.org> writes:

> Here's a real world example of the 1.4.0 change breaking a merge:
>
> ("netdev-2.6" == local clone of kernel.org/...jgarzik/netdev-2.6.git)
> [jgarzik@pretzel netdev-2.6]$ git branch
>   ALL
>   e100-sbit
> * master
>   upstream
>   upstream-linus
>
> [jgarzik@pretzel netdev-2.6]$ git pull /spare/repo/linux-2.6
> ...
> Updating from 427abfa28afedffadfca9dd8b067eb6d36bac53f to
> 25f42b6af09e34c3f92107b36b5aa6edc2fdba2f
> fatal: Untracked working tree file 'drivers/net/myri10ge/Makefile'
> would be overwritten by merge.
>
> EXPLANATION:
>
> * drivers/net/myri10ge/Makefile exists in latest Linus kernel tree,
> stored locally in /spare/repo/linux-2.6.
> * drivers/net/myri10ge/Makefile exists in netdev-2.6#upstream and
> netdev-2.6#upstream-linus branches.
> * drivers/net/myri10ge/Makefile does not exist in current branch,
> netdev-2.6#master.

Requesting one more bit of explanation.

When you did this pull, you were on your "master" branch.  Whose
HEAD does not have the myri10ge/Makefile in its tree.  And you
did not have that path in the index either (otherwise it would
not have said "untracked working tree file").  Did you have that
file in your working tree?  And if so how/why?

If you did something like this before ending up in your "master"
branch, I think you would have such a file:

	$ git branch ;# you were in upstream-linus branch
          ALL
          e100-sbit
          master
          upstream
        * upstream-linus
        $ git diff      ;# and were up-to-date -- no output nor
        $ git diff HEAD ;# local changes
        $ git checkout -f master ;# but you switched to master with -f

With "checkout -f", your local changes to files that appear in
the "master" branch will be overwritten, but the files that are
supposed to disappear because you are switching out of the
current branch (e.g. myri10ge/Makefile) are left behind.

It probably would make sense to change "checkout -f" so that it
removes such files from your working tree to support this
particular usage.  We kept saying "with -f local dirty state
will be gone", but "checkout -f" does not do as thorough job as
"reset --hard".  Changing "checkout -f next-branch" to do the
moral equivalent of "reset --hard HEAD && checkout next-branch"
would solve this problem, and I do not think changing it that
way would not have any negative impact.

I suspect this patch would do exactly that...

diff --git a/git-checkout.sh b/git-checkout.sh
index 564117f..193f6c5 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -137,7 +137,7 @@ # what we already had
 
 if [ "$force" ]
 then
-    git-read-tree --reset $new &&
+    git-read-tree --reset -u $new &&
 	git-checkout-index -q -f -u -a
 else
     git-update-index --refresh >/dev/null
