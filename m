From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v2 RFC] Fix interactive rebase on dropped commits.
Date: Fri, 3 Oct 2008 13:32:46 -0500
Organization: Exigence
Message-ID: <20081003133246.bae6b657.stephen@exigencecorp.com>
References: <20081001011107.0971ce32.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: ae@op5.se, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 20:38:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlpXu-0005SR-F2
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 20:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYJCSe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 14:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYJCSe2
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 14:34:28 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:50398 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbYJCSe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 14:34:27 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 978959B2A1E;
	Fri,  3 Oct 2008 14:34:25 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id A36329B2A9A;
	Fri,  3 Oct 2008 14:32:57 -0400 (EDT)
In-Reply-To: <20081001011107.0971ce32.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97442>

Interactive rebase got it's rev-list of commits to keep by --left-right and
--cherry-pick. Adding --cherry-pick would throw out commits that were just
duplicating changes already in the rebase target.

Which is cool, except the dropped commit was forgotten about when it came to
rewriting the parents of its descendents, so the descendents would get
cherry-picked as-in and essentially make the rebase a noop.

This change adds a $DOTEST/dropped directory to remember dropped commits and
rewrite its children's parents as the children's grandparents (possibly
rewritten).

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---

This includes 3410, which borrows the 3404 DAG in a separate
test to do more a complex test of the dropped commits than my
previous test.

The implementation is also simpler--instead of following all
of a dropped commit's parents, we follow just the first. We can
trust rev-list is telling us to drop it for a reason, so only
the first-parent is needed so we can correctly rewrite commits
based on top of ours.

t3404 is still passing. (Finally.)

 git-rebase--interactive.sh                |   37 +++++++-
 t/t3410-rebase-preserve-dropped-merges.sh |  140 +++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 t/t3410-rebase-preserve-dropped-merges.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index edb6ec6..e8cb8a2 100755
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
+				pend="$pend $(cat "$DROPPED"/$p)"
+			else
+				new_parents="$new_parents $new_p"
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
