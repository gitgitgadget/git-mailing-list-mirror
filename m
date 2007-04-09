From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Move check_base() shell function to git-sh-setup
Date: Sun, 08 Apr 2007 23:13:33 -0700
Message-ID: <7v3b3a5b3m.fsf@assigned-by-dhcp.cox.net>
References: <7vwt0uypz7.fsf@assigned-by-dhcp.cox.net>
	<7vhcrvti9i.fsf@assigned-by-dhcp.cox.net>
	<7vps6e5b93.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 08:14:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Han8q-0000Yn-93
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 08:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbXDIGOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 02:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbXDIGOM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 02:14:12 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51546 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbXDIGOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 02:14:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409061333.VSAL1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 02:13:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kuDZ1W0041kojtg0000000; Mon, 09 Apr 2007 02:13:33 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44042>

The scripts that attempt to make a commit on top of the current
HEAD need to use the same logic in check_base() to make sure the
current index is based on the HEAD commit we are going to build
on top of.  Move this function from git-commit to git-sh-setup,
so that it is available to everybody else.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-commit.sh   |   16 ----------------
 git-sh-setup.sh |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 42f1c93..6b4c784 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -25,22 +25,6 @@ refuse_partial () {
 	exit 1
 }
 
-check_base () {
-	quiet="$1"
-	if HEAD=`git rev-parse --verify HEAD 2>/dev/null` &&
-	   BASE=`git update-index --get-base` &&
-	   test -n "$BASE" &&
-	   test "$BASE" != "$HEAD"
-	then
-		test -z "$quiet" || exit 1
-		ours=`git show -s --pretty=oneline --abbrev-commit $BASE`
-		theirs=`git show -s --pretty=oneline --abbrev-commit $HEAD`
-		echo >&2 "* The index is based on '$ours', however, the HEAD"
-		echo >&2 "  points at different commit '$theirs'"
-		exit 1
-	fi
-}
-
 THIS_INDEX="$GIT_DIR/index"
 NEXT_INDEX="$GIT_DIR/next-index$$"
 rm -f "$NEXT_INDEX"
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index f24c7f2..0797acd 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -28,6 +28,22 @@ set_reflog_action() {
 	fi
 }
 
+check_base () {
+	quiet="$1"
+	if HEAD=`git rev-parse --verify HEAD 2>/dev/null` &&
+	   BASE=`git update-index --get-base` &&
+	   test -n "$BASE" &&
+	   test "$BASE" != "$HEAD"
+	then
+		test -z "$quiet" || exit 1
+		ours=`git show -s --pretty=oneline --abbrev-commit $BASE`
+		theirs=`git show -s --pretty=oneline --abbrev-commit $HEAD`
+		echo >&2 "* The index is based on '$ours', however, the HEAD"
+		echo >&2 "  points at different commit '$theirs'"
+		exit 1
+	fi
+}
+
 is_bare_repository () {
 	git-config --bool --get core.bare ||
 	case "$GIT_DIR" in
-- 
1.5.1.730.g0d43be
