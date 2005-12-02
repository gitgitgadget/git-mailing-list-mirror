From: linux@horizon.com
Subject: Is reserving the branch name "bisect" a good thing?
Date: 2 Dec 2005 18:25:55 -0500
Message-ID: <20051202232555.13082.qmail@science.horizon.com>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Dec 03 00:26:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiKHw-0004pf-4C
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 00:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVLBXZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 18:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVLBXZ4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 18:25:56 -0500
Received: from science.horizon.com ([192.35.100.1]:26187 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751120AbVLBXZ4
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 18:25:56 -0500
Received: (qmail 13083 invoked by uid 1000); 2 Dec 2005 18:25:55 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13137>

Just wondering... most of the "magic" references are in $GIT_DIR
directly, and ALL_CAPS.  "git bisect start" begins with
"rm -f $GIT_DIR/refs/heads/bisect", which could catch someone
trying to implement a bisection algorithm in their own code.

Would it be better if "git bisect" followed that rule as well?
Otherwise, we really should document the reserved word.

Either that, or use refs/bisect/current and avoid the issue entirely.

Something like (untested):

diff --git a/git-bisect.sh b/git-bisect.sh
index 68838f3..19a8f36 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -50,7 +50,7 @@ bisect_start() {
 	head=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD) ||
 	die "Bad HEAD - I need a symbolic ref"
 	case "$head" in
-	refs/heads/bisect*)
+	BISECT*)
 		git checkout master || exit
 		;;
 	refs/heads/*)
@@ -63,7 +63,7 @@ bisect_start() {
 	#
 	# Get rid of any old bisect state
 	#
-	rm -f "$GIT_DIR/refs/heads/bisect"
+	rm -f "$GIT_DIR/BISECT"
 	rm -rf "$GIT_DIR/refs/bisect/"
 	mkdir "$GIT_DIR/refs/bisect"
 	{
@@ -146,10 +146,10 @@ bisect_next() {
 	fi
 	nr=$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAMES)" | wc -l) || exit
 	echo "Bisecting: $nr revisions left to test after this"
-	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
-	git checkout new-bisect || exit
-	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
-	GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD refs/heads/bisect
+	echo "$rev" > "$GIT_DIR/NEW-BISECT"
+	git checkout NEW-BISECT || exit
+	mv "$GIT_DIR/NEW-BISECT" "$GIT_DIR/BISECT" &&
+	GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD BISECT
 	git-show-branch "$rev"
 }
 
@@ -172,7 +172,7 @@ bisect_reset() {
 	esac
 	git checkout "$branch" &&
 	rm -fr "$GIT_DIR/refs/bisect"
-	rm -f "$GIT_DIR/refs/heads/bisect"
+	rm -f "$GIT_DIR/BISECT"
 	rm -f "$GIT_DIR/BISECT_LOG"
 }
 
