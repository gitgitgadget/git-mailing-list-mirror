From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-merge: make it usable as the first class UI again.
Date: Fri, 26 Jan 2007 01:28:22 -0800
Message-ID: <7v4pqe16ix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 10:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANNj-0008Vo-8a
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965605AbXAZJ2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965608AbXAZJ2Y
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:28:24 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35655 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965605AbXAZJ2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:28:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126092822.SKDR3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 04:28:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FlTR1W0081kojtg0000000; Fri, 26 Jan 2007 04:27:25 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37822>

reflog wants to have a short-and-sweet single line message, but
its set_reflog_action was slurping the whole command line arguments.
When given a multi-line commit message from the command line, reflog
code refused to update the ref with the resulting commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * When pull threw huge merge message, it has already set the
   reflog action on its own so this breakage was hidden.  Also
   because most of the time people did not specify -m message
   (or use the old-style <msg> HEAD <others>) from the command
   line, nobody seems to have noticed this.

 git-merge.sh |    2 +-
 git-pull.sh  |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 7b59026..91909b7 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -7,7 +7,7 @@ USAGE='[-n] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commi
 
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
-set_reflog_action "merge $*"
+set_reflog_action merge
 require_work_tree
 cd_to_toplevel
 
diff --git a/git-pull.sh b/git-pull.sh
index a3665d7..fc76aea 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -51,6 +51,33 @@ do
 	shift
 done
 
+if test "X$1" = X.
+then
+	# We are merging from this repository.  We can avoid fetch
+	# and go right into merge if the user isn't doing something
+	# odd like asking us to also update tracking branches in
+	# this repository as part of the pull.  Yeah, they probably
+	# shouldn't do that - but we allowed it in the past...
+	#
+	direct_merge=1
+	for remote
+	do
+		case "$remote" in
+		*:*) direct_merge=0; break;;
+		esac
+	done
+	if test $direct_merge = 1
+	then
+		shift
+		exec git-merge \
+			$no_summary $no_commit $squash $strategy_args \
+			"$@"
+	else
+		echo >&2 "Clever... Updating tracking branch while pulling from yourself."
+		echo >&2
+	fi
+fi
+
 orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 git-fetch --update-head-ok "$@" || exit 1
 
-- 
1.5.0.rc2.g8a816
