From: linux@horizon.com
Subject: Re: Is reserving the branch name "bisect" a good thing?
Date: 3 Dec 2005 08:41:36 -0500
Message-ID: <20051203134136.31524.qmail@science.horizon.com>
References: <20051202232555.13082.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Dec 03 14:43:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiXeR-0003XK-Mr
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 14:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVLCNlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 08:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVLCNlo
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 08:41:44 -0500
Received: from science.horizon.com ([192.35.100.1]:6696 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750893AbVLCNln
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 08:41:43 -0500
Received: (qmail 31525 invoked by uid 1000); 3 Dec 2005 08:41:36 -0500
To: junkio@twinsun.com
In-Reply-To: <20051202232555.13082.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13155>

>> Would it be better if "git bisect" followed that rule as well?
>> Otherwise, we really should document the reserved word.

> I wonder if you broke "git bisect visualize" with that patch.

I don't know, but I sure broke git-bisect.

The problem is that git-checkout won't switch branches if the
ref given is not in $GIT_DIR/refs/heads.  (Try to include a "heads/"
prefix on a non-selected existing branch to see.)

Without changing this policy in git-checkout, or replicating most
of git-checkout's code in git-bisect, I can't get away from using
a head name in refs/heads/.  :-(

Stepping back, the problem is that
- git has a policy against allowing checkins against a ref not in refs/heads/
- git-commit doesn't have a concept of an unwriteable HEAD, so
- git-checkout refuses to set HEAD to an unwriteable ref (not in refs/heads/)
But "git bisect" wants exactly this sort of historical snapshot.

Actually, this leads to a question... suppose I want to manually
check out some old revision (like "v.2.6.12") for some reason
(performance testing, say).  How do I do that?
Do I have to create a branch just to do that?

It might be nicer to allow such a checkout and do the checking in
git-commit, telling you to "git-checkout -b <new_branch>" before
you check in your edits.


In git-bisect, I finally managed to do a bit of a hack, but it's
a bit annoying for doing the above from the command line.
(Error handling could also probably use improvement.)

See the "@@ -146,10 +160,12 @@ bisect_next() {" chunk, third
from the end, for the meat.


diff --git a/git-bisect.sh b/git-bisect.sh
index 68838f3..c8b9d7b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 . git-sh-setup
 
+# Put arguments in single quotes to they can be re-interpreted by the shell.
+# (To put a single quote in a single-quoted string, you need to write
+# 'wasn'\''t' = 'wasn' + \' + 't'.)
 sq() {
 	perl -e '
 		for (@ARGV) {
@@ -42,6 +45,18 @@ bisect_autostart() {
 	}
 }
 
+# Not generally needed, but provide a cleanup function
+bisect_stop() {
+	case "$(cat "$GIT_DIR/HEAD")" in
+	refs/bisect/*)
+		echo "Resetting HEAD to master"
+		git checkout master || exit
+		;;
+	esac
+	rm -rf "$GIT_DIR/refs/bisect/"
+	rm -f "$GIT_DIR/BISECT_LOG" "$GIT_DIR/BISECT_NAMES"
+}
+
 bisect_start() {
 	#
 	# Verify HEAD. If we were bisecting before this, reset to the
@@ -50,7 +65,7 @@ bisect_start() {
 	head=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD) ||
 	die "Bad HEAD - I need a symbolic ref"
 	case "$head" in
-	refs/heads/bisect*)
+	refs/bisect/*)
 		git checkout master || exit
 		;;
 	refs/heads/*)
@@ -63,7 +78,6 @@ bisect_start() {
 	#
 	# Get rid of any old bisect state
 	#
-	rm -f "$GIT_DIR/refs/heads/bisect"
 	rm -rf "$GIT_DIR/refs/bisect/"
 	mkdir "$GIT_DIR/refs/bisect"
 	{
@@ -146,10 +160,12 @@ bisect_next() {
 	fi
 	nr=$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAMES)" | wc -l) || exit
 	echo "Bisecting: $nr revisions left to test after this"
-	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
-	git checkout new-bisect || exit
-	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
-	GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD refs/heads/bisect
+	next="$(TMPDIR="$GIT_DIR/refs/heads" tempfile -p bisect)"
+	echo "$rev" > "$next"
+	# checkout refuses to deal with a head name not in refs/heads...
+	git checkout $(basename "$next")
+	mv "$next" "$GIT_DIR/refs/bisect/current" &&
+	GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD refs/bisect/current
 	git-show-branch "$rev"
 }
 
@@ -172,7 +188,6 @@ bisect_reset() {
 	esac
 	git checkout "$branch" &&
 	rm -fr "$GIT_DIR/refs/bisect"
-	rm -f "$GIT_DIR/refs/heads/bisect"
 	rm -f "$GIT_DIR/BISECT_LOG"
 }
 
@@ -217,6 +232,8 @@ case "$#" in
     case "$cmd" in
     start)
         bisect_start "$@" ;;
+    stop)
+        bisect_stop "$@" ;;
     bad)
         bisect_bad "$@" ;;
     good)
