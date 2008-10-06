From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v3] rebase--interactive: fix parent rewriting for dropped
 commits
Date: Sun, 5 Oct 2008 23:26:52 -0500
Organization: Exigence
Message-ID: <20081005232652.ab151c3e.stephen@exigencecorp.com>
References: <20081001011107.0971ce32.stephen@exigencecorp.com>
	<20081003133246.bae6b657.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: ae@op5.se, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 06:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmhhW-0004kP-Tc
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 06:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbYJFE0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 00:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYJFE0z
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 00:26:55 -0400
Received: from smtp122.sat.emailsrvr.com ([66.216.121.122]:50312 "EHLO
	smtp122.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbYJFE0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 00:26:54 -0400
Received: from relay2.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay2.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 1E7C027CD2F;
	Mon,  6 Oct 2008 00:26:54 -0400 (EDT)
Received: by relay2.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 940B627CD0B;
	Mon,  6 Oct 2008 00:26:53 -0400 (EDT)
In-Reply-To: <20081003133246.bae6b657.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97559>

`rebase -i -p` got its rev-list of commits to keep by --left-right and
--cherry-pick. Adding --cherry-pick would drop commits that duplicated changes
already in the rebase target.

The dropped commits were then forgotten about when it came to rewriting the
parents of their descendents, so the descendents would get cherry-picked with
their old, unwritten parents and essentially make the rebase a no-op.

This commit adds a $DOTEST/dropped directory to remember dropped commits and
rewrite their children's parent as the dropped commit's possibly-rewritten
first-parent.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---

These two lines changed from the v2 patch:

    pend=" $(cat "$DROPPED"/$p)$pend"

It now puts $p at the start of $pend instead of the end. I have no tests
that assert this behavior (vs. the old of putting it at the end), but it
seems rational to put the dropped-replacement parent first so that the
current commit's parents come out in the same order (otherwise a commit
with parents "p1 p2dropped p3" would end up "p1 p3 p2firstparent").

Also, this line changed:

    new_parents="$new_parents $p"

Previously it said "$new_parents $new_p" which was a copy/paste bug--$new_p
was from up in the code a bit and here we just want to use $p.

I also cleaned up the commit message.

 git-rebase--interactive.sh                |   37 +++++++-
 t/t3410-rebase-preserve-dropped-merges.sh |  140 +++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 t/t3410-rebase-preserve-dropped-merges.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index edb6ec6..4d53347 100755
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
@@ -169,8 +170,12 @@ pick_one_preserving_merges () {
 
 	# rewrite parents; if none were rewritten, we can fast-forward.
 	new_parents=
-	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
+	pend=" $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)"
+	while [ "$pend" != "" ]
 	do
+		p=$(expr "$pend" : ' \([^ ]*\)')
+		pend="${pend# $p}"
+
 		if test -f "$REWRITTEN"/$p
 		then
 			new_p=$(cat "$REWRITTEN"/$p)
@@ -183,7 +188,13 @@ pick_one_preserving_merges () {
 				;;
 			esac
 		else
-			new_parents="$new_parents $p"
+			if test -f "$DROPPED"/$p
+			then
+				fast_forward=f
+				pend=" $(cat "$DROPPED"/$p)$pend"
+			else
+				new_parents="$new_parents $p"
+			fi
 		fi
 	done
 	case $fast_forward in
@@ -582,6 +593,28 @@ first and then run 'git rebase --continue' again."
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
+					# Use -f2 because if rev-list is telling this commit is not
+					# worthwhile, we don't want to track its multiple heads,
+					# just the history of its first-parent for others that will
+					# be rebasing on top of us
+					full=$(git rev-parse $rev)
+					git rev-list --parents -1 $rev | cut -d' ' -f2 > "$DROPPED"/$full
+				fi
+			done
+		fi
+
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
diff --git a/t/t3410-rebase-preserve-dropped-merges.sh b/t/t3410-rebase-preserve-dropped-merges.sh
new file mode 100644
index 0000000..7c8862b
--- /dev/null
+++ b/t/t3410-rebase-preserve-dropped-merges.sh
@@ -0,0 +1,140 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Stephen Haberman
+#
+
+test_description='git rebase preserve merges
+
+This test runs git rebase with preserve merges and ensures commits
+dropped by the --cherry-pick flag have their childrens parents
+rewritten.
+'
+. ./test-lib.sh
+
+# set up two branches like this:
+#
+# A - B - C - D - E
+#   \
+#     F - G - H
+#       \
+#         I
+#
+# where B, D and G touch the same file.
+
+test_expect_success 'setup' '
+	: > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m A &&
+	git tag A &&
+	echo 1 > file1 &&
+	test_tick &&
+	git commit -m B file1 &&
+	: > file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m C &&
+	echo 2 > file1 &&
+	test_tick &&
+	git commit -m D file1 &&
+	: > file3 &&
+	git add file3 &&
+	test_tick &&
+	git commit -m E &&
+	git tag E &&
+	git checkout -b branch1 A &&
+	: > file4 &&
+	git add file4 &&
+	test_tick &&
+	git commit -m F &&
+	git tag F &&
+	echo 3 > file1 &&
+	test_tick &&
+	git commit -m G file1 &&
+	git tag G &&
+	: > file5 &&
+	git add file5 &&
+	test_tick &&
+	git commit -m H &&
+	git tag H &&
+	git checkout -b branch2 F &&
+	: > file6 &&
+	git add file6 &&
+	test_tick &&
+	git commit -m I &&
+	git tag I
+'
+
+# A - B - C - D - E
+#   \             \ \
+#     F - G - H -- L \        -->   L
+#       \            |               \
+#         I -- G2 -- J -- K           I -- K
+# G2 = same changes as G
+test_expect_success 'skip same-resolution merges with -p' '
+	git checkout branch1 &&
+	! git merge E &&
+	echo 23 > file1 &&
+	git add file1 &&
+	git commit -m L &&
+	git checkout branch2 &&
+	echo 3 > file1 &&
+	git commit -a -m G2 &&
+	! git merge E &&
+	echo 23 > file1 &&
+	git add file1 &&
+	git commit -m J &&
+	echo file7 > file7 &&
+	git add file7 &&
+	git commit -m K &&
+	GIT_EDITOR=: git rebase -i -p branch1 &&
+	test $(git rev-parse branch2^^) = $(git rev-parse branch1) &&
+	test "23" = "$(cat file1)" &&
+	test "" = "$(cat file6)" &&
+	test "file7" = "$(cat file7)" &&
+
+	git checkout branch1 &&
+	git reset --hard H &&
+	git checkout branch2 &&
+	git reset --hard I
+'
+
+# A - B - C - D - E
+#   \             \ \
+#     F - G - H -- L \        -->   L
+#       \            |               \
+#         I -- G2 -- J -- K           I -- G2 -- K
+# G2 = different changes as G
+test_expect_success 'keep different-resolution merges with -p' '
+	git checkout branch1 &&
+	! git merge E &&
+	echo 23 > file1 &&
+	git add file1 &&
+	git commit -m L &&
+	git checkout branch2 &&
+	echo 4 > file1 &&
+	git commit -a -m G2 &&
+	! git merge E &&
+	echo 24 > file1 &&
+	git add file1 &&
+	git commit -m J &&
+	echo file7 > file7 &&
+	git add file7 &&
+	git commit -m K &&
+	! GIT_EDITOR=: git rebase -i -p branch1 &&
+	echo 234 > file1 &&
+	git add file1 &&
+	GIT_EDITOR=: git rebase --continue &&
+	test $(git rev-parse branch2^^^) = $(git rev-parse branch1) &&
+	test "234" = "$(cat file1)" &&
+	test "" = "$(cat file6)" &&
+	test "file7" = "$(cat file7)" &&
+
+	git checkout branch1 &&
+	git reset --hard H &&
+	git checkout branch2 &&
+	git reset --hard I
+'
+
+test_done
+
-- 
1.6.0.2
