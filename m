From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] checkout -d: explicitly detach HEAD even when switching to the tip of a branch
Date: Tue, 03 Apr 2007 17:11:44 -0700
Message-ID: <7vtzvxt2v3.fsf@assigned-by-dhcp.cox.net>
References: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net>
	<euk8ps$vu1$1@sea.gmane.org>
	<200703311455.l2VEtHO5021300@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 02:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYt6L-00038h-IL
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 02:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992505AbXDDALq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 20:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992500AbXDDALq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 20:11:46 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42055 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992505AbXDDALp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 20:11:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404001145.JFFF28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 20:11:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ioBk1W00F1kojtg0000000; Tue, 03 Apr 2007 20:11:45 -0400
In-Reply-To: <200703311455.l2VEtHO5021300@localhost.localdomain> (Xavier
	Maillard's message of "Sat, 31 Mar 2007 16:55:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43698>

Xavier Maillard <zedek@gnu.org> writes:

>    > You cannot currently checkout the tip of an existing branch
>    > without moving to the branch.
>    > 
>    > This allows you to detach your HEAD and place it at such a
>    > commit, with:
>    > 
>    >     $ git checkout -d master
>
>    What about
>
> 	 $ git checkout master^0
>
>    trick to force detaching?
>
> I love this idea.

Could anybody remind me why we have the "new != old" check here?

diff --git a/git-checkout.sh b/git-checkout.sh
index a7390e8..573a3c0 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -170,7 +170,7 @@ describe_detached_head () {
 	}
 }
 
-if test -z "$branch$newbranch" && test "$new" != "$old"
+if test -z "$branch$newbranch"
 then
 	detached="$new"
 	if test -n "$oldbranch" && test -z "$quiet"

I think I do not need an explicit -d option if we just remove
that second test.  It is coming from an ancient commit 91dcdfd3,
and I _think_ it was to prevent something like:

	git-checkout-script v2.6.12^0

from succeeding, while allowing

	git-checkout-script HEAD^0

to be a no-op (as it happens to be naming the same commit).

commit 91dcdfd3b5331d955cfb60edf8930f1b5c142905
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Mon Jul 11 20:44:20 2005 -0700

    Make "git checkout" create new branches on demand

diff --git a/git-checkout-script b/git-checkout-script
index 48e1da9..7e70338 100755
--- a/git-checkout-script
+++ b/git-checkout-script
@@ -5,10 +5,19 @@ old=$(git-rev-parse HEAD)
 ...
@@ -32,6 +41,16 @@ while [ "$#" != "0" ]; do
 done
 [ -z "$new" ] && new=$old
 
+#
+# If we don't have an old branch that we're switching to,
+# and we don't have a new branch name for the target we
+# are switching to, then we'd better just be checking out
+# what we already had
+#
+[ -z "$branch$newbranch" ] &&
+	[ "$new" != "$old" ] &&
+	die "git checkout: you need to specify a new branch name"
+
 if [ "$force" ]
 then
     git-read-tree --reset $new &&
@@ -47,6 +66,10 @@ fi
 ...
