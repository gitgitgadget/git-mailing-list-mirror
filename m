From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] Fix interactive rebase on dropped commits.
Date: Wed, 1 Oct 2008 01:11:07 -0500
Organization: Exigence
Message-ID: <20081001011107.0971ce32.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: ae@op5.se, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 01 08:12:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkuwi-0002ZF-Ay
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 08:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbYJAGLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 02:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYJAGLM
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 02:11:12 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:46901 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbYJAGLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 02:11:11 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id ED38D5B38BD;
	Wed,  1 Oct 2008 02:11:10 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 6D1141F1A28;
	Wed,  1 Oct 2008 02:11:10 -0400 (EDT)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97205>

Interactive rebase got its rev-list of commits to keep by --left-right and
--cherry-pick. Adding --cherry-pick would throw out commits that were just
duplicating changes already in the rebase target.

Which is desirable, except the dropped commit has forgotten about when it came
to rewriting the parents of its descendents, so the descendents would get
cherry-picked as-in and essentially make the rebase a no-op.

This change adds a $DOTEST/dropped directory to remember dropped commits and
rewrite its children's parents as the children's (possibly rewritten)
grandparents.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh                  |   52 ++++++++++++---
 t/t3409-rebase-interactive-cherry-picked.sh |   94 +++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 10 deletions(-)
 create mode 100644 t/t3409-rebase-interactive-cherry-picked.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 929d681..2d62590 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -37,6 +37,7 @@ DONE="$DOTEST"/done
 MSG="$DOTEST"/message
 SQUASH_MSG="$DOTEST"/message-squash
 REWRITTEN="$DOTEST"/rewritten
+DROPPED="$DOTEST"/dropped
 PRESERVE_MERGES=
 STRATEGY=
 ONTO=
@@ -146,15 +147,7 @@ pick_one () {
 
 pick_one_preserving_merges () {
 	fast_forward=t
-	case "$1" in
-	-n)
-		fast_forward=f
-		sha1=$2
-		;;
-	*)
-		sha1=$1
-		;;
-	esac
+	case "$1" in -n) fast_forward=f sha1=$2 ;; *) sha1=$1 ;; esac
 	sha1=$(git rev-parse $sha1)
 
 	if test -f "$DOTEST"/current-commit
@@ -183,7 +176,28 @@ pick_one_preserving_merges () {
 				;;
 			esac
 		else
-			new_parents="$new_parents $p"
+			if test -f "$DROPPED"/$p
+			then
+				fast_forward=f
+				cat "$DROPPED"/$p | while read grandparent
+				do
+					if test -f "$REWRITTEN"/$grandparent
+					then
+						new_p=$(cat "$REWRITTEN"/$grandparent)
+					else
+						new_p=$grandparent
+					fi
+					case "$new_parents" in
+					*$new_p*)
+						;; # do nothing; that parent is already there
+					*)
+						new_parents="$new_parents $new_p"
+						;;
+					esac
+				done
+			else
+				new_parents="$new_parents $p"
+			fi
 		fi
 	done
 	case $fast_forward in
@@ -574,6 +588,24 @@ do
 #
 EOF
 
+		# Watch for commits that been dropped by --cherry-pick
+		if test t = "$PRESERVE_MERGES"
+		then
+			mkdir "$DROPPED"
+			# drop the --cherry-pick parameter this time
+			git rev-list $MERGES_OPTION --abbrev-commit \
+				--abbrev=7 $UPSTREAM...$HEAD --left-right | \
+				sed -n "s/^>//p" | while read rev
+			do
+				grep --quiet "$rev" "$TODO"
+				if [ $? -ne 0 ]
+				then
+					full=$(git rev-parse $rev)
+					git rev-list --parents -1 $rev | cut -d' ' -f2- | sed 's/ /\n/g' > "$DROPPED"/$full
+				fi
+			done
+		fi
+
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
diff --git a/t/t3409-rebase-interactive-cherry-picked.sh b/t/t3409-rebase-interactive-cherry-picked.sh
new file mode 100644
index 0000000..3d20180
--- /dev/null
+++ b/t/t3409-rebase-interactive-cherry-picked.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='rebase interactive does not rebase'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "setup" >a &&
+	git add a &&
+	git commit -m "setup" &&
+	git clone ./. server &&
+	rm -fr server/.git/hooks &&
+	git remote add origin ./server &&
+	git config --add branch.master.remote origin &&
+	git config --add branch.master.merge refs/heads/master &&
+	git fetch &&
+
+	git checkout -b stable master &&
+	echo "setup.stable" >a &&
+	git commit -a -m "stable" &&
+	git push origin stable
+'
+#
+# A --C------            <-- origin/stable
+#  \  |      \
+#   B -- D -- E -- F     <-- origin/topic2
+#    \|             \
+#     g -- h ------- i   <-- topic2
+#
+# Trying to push F..i
+#
+# merge-base(F, h) has two options: B and C
+#
+test_expect_success 'merging in stable with tricky double baserev does not fool the script' '
+	# B: start our topic2 branch, and share it
+	git checkout -b topic2 origin/stable &&
+	git config --add branch.topic2.merge refs/heads/topic2 &&
+	echo "commit B" >a.topic2 &&
+	git add a.topic2 &&
+	git commit -m "commit B created topic2" &&
+	git push origin topic2 &&
+
+	# C: now, separately, move ahead stable, and share it
+	git checkout stable
+	echo "commit C" >a &&
+	git commit -a -m "commit C moved stable" &&
+	git push origin stable &&
+
+	# D: have another client commit (in this case, it is the server, but close enough) moves topic2
+	cd server &&
+	git checkout topic2 &&
+	echo "commit D continuing topic2" >a.client2 &&
+	git add a.client2 &&
+	git commit -m "commit D by client2" &&
+
+	# E: the same other client merges the moved stable
+	git merge stable &&
+
+	# F: the same other client moves topic2 again
+	echo "commit F" >a.client2 &&
+	git commit -a -m "commit F by client2" &&
+	F_hash=$(git rev-parse HEAD) &&
+	cd .. &&
+
+	# g: now locally merge in the moved stable (even though our topic2 is out of date)
+	git checkout topic2 &&
+	git merge stable &&
+	g_hash=$(git rev-parse HEAD) &&
+
+	# h: advance local topic2
+	echo "commit H" >a.topic2 &&
+	git commit -a -m "commit H continues local fork" &&
+	h_hash=$(git rev-parse HEAD) &&
+
+	# i: make a new merge commit
+	git pull --no-rebase &&
+	i_hash=$(git rev-parse HEAD) &&
+
+	# Watch merge rejected as something that should get rebased
+	# ! git push origin topic2
+	test "$i_hash $h_hash $F_hash" = "$(git rev-list --parents --no-walk HEAD)"
+
+	# Now fix it the merge by rebasing it
+	git reset --hard ORIG_HEAD &&
+	GIT_EDITOR=: git rebase -i -p origin/topic2 &&
+	h2_hash=$(git rev-parse HEAD) &&
+
+	# Previously $F_hash was dropped and it was the same $h_hash $g_hash
+	test "$h2_hash $F_hash" = "$(git rev-list --parents --no-walk HEAD)"
+'
+
+test_done
+
+
-- 
1.6.0.2
