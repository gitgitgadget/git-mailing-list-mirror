From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] report where the new HEAD is upon detaching HEAD
Date: Fri, 23 Mar 2007 02:37:19 -0700
Message-ID: <7vejngqp0w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 10:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUgDJ-0005iE-1e
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbXCWJhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934275AbXCWJhV
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:37:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43844 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422749AbXCWJhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 05:37:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323093718.JNMM321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Mar 2007 05:37:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id e9dK1W0051kojtg0000000; Fri, 23 Mar 2007 05:37:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42918>

After "git reset" moves the HEAD around, it reports which commit
you are on, which gives the user a warm fuzzy feeling of
assurance.  Give the same assurance from git-checkout when
moving the detached HEAD around.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-checkout.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 3c9b1bb..a7390e8 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -163,6 +163,13 @@ cd_to_toplevel
 detached=
 detach_warn=
 
+describe_detached_head () {
+	test -n "$quiet" || {
+		printf >&2 "$1 "
+		GIT_PAGER= git log >&2 -1 --pretty=oneline --abbrev-commit "$2"
+	}
+}
+
 if test -z "$branch$newbranch" && test "$new" != "$old"
 then
 	detached="$new"
@@ -173,9 +180,9 @@ If you want to create a new branch from this
 (now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>"
 	fi
-elif test -z "$oldbranch" && test -z "$quiet"
+elif test -z "$oldbranch"
 then
-	echo >&2 "Previous HEAD position was $old"
+	describe_detached_head 'Previous HEAD position was' "$old"
 fi
 
 if [ "X$old" = X ]
@@ -275,6 +282,7 @@ if [ "$?" -eq 0 ]; then
 		then
 			echo >&2 "$detach_warn"
 		fi
+		describe_detached_head 'HEAD is now at' HEAD
 	fi
 	rm -f "$GIT_DIR/MERGE_HEAD"
 else
