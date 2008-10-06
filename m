From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH RFC] rebase--interactive: if preserving merges, use
 first-parent to limit what is shown.
Date: Mon, 6 Oct 2008 10:21:18 -0500
Organization: Exigence
Message-ID: <20081006102118.3e817a0f.stephen@exigencecorp.com>
References: <48E8DD7E.9040706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 17:32:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmruq-0003VQ-5H
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 17:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYJFPVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbYJFPVU
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 11:21:20 -0400
Received: from smtp142.sat.emailsrvr.com ([66.216.121.142]:54894 "EHLO
	smtp142.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYJFPVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 11:21:20 -0400
Received: from relay4.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay4.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 24CD927B486;
	Mon,  6 Oct 2008 11:21:19 -0400 (EDT)
Received: by relay4.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id B01EF27B2FB;
	Mon,  6 Oct 2008 11:21:18 -0400 (EDT)
In-Reply-To: <48E8DD7E.9040706@redhat.com>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97594>

This commit fixes Avi Kivity's use case of squashing two commits on either side
of a merge together.

Changes include:

- Delaying storing the rewrite information if the current commit we are
  applying is being squashed. This means storing multiple lines in the
  current-commit file and recording each of them as rewritten to the
  same HEAD on the next commit.

- Move the "no squashing merges" check into the case statement for
  merges as previously it was catching catching even single-parent
  squashes.

- Conditionally pass "--first-parent" to `git rev-list` based on whether
  this is a rebase is preserving merges or not.

- At the end, just take the current head for the new branch ref instead
  of trying to look up what the OLDHEAD was rewritten to. This fails
  because the OLDHEAD was squashed/moved up earlier in the timeline, so
  even if we can find its rewritten HEAD, that is no longer what we
  ended up at.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---

I agree with Avi on what the rebase -i -p behavior should be for his
scenario. This patch makes it so. However, the bane of my existence,
t3404 is failing ~12 tests in, which is a real PITA to debug, so please
let me know if this is a worthwhile tangent to continue on.

(That last change of dropping the OLDHEAD->NEWHEAD guessing is probably
what is causing t3404 to fail, but I can't reason why it'd need to do
that rather than just use HEAD.)

I've read in the archives about the git-sequencer stuff, which sounds
cool, my thought is that, if anything, this will clarify git rebase -i -p
behavior and add tests that can later be ensured to still pass when
git-sequencer is dropped in.

 git-rebase--interactive.sh               |   53 ++++++++++---------
 t/t3411-rebase-preserve-around-merges.sh |   83 ++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 25 deletions(-)
 create mode 100644 t/t3411-rebase-preserve-around-merges.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index edb6ec6..9914111 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -159,13 +159,18 @@ pick_one_preserving_merges () {
 
 	if test -f "$DOTEST"/current-commit
 	then
-		current_commit=$(cat "$DOTEST"/current-commit) &&
-		git rev-parse HEAD > "$REWRITTEN"/$current_commit &&
-		rm "$DOTEST"/current-commit ||
-		die "Cannot write current commit's replacement sha1"
+		if [ "$fast_forward" == "t" ]
+		then
+			cat "$DOTEST"/current-commit | while read current_commit
+			do
+				git rev-parse HEAD > "$REWRITTEN"/$current_commit
+			done
+			rm "$DOTEST"/current-commit ||
+			die "Cannot write current commit's replacement sha1"
+		fi
 	fi
 
-	echo $sha1 > "$DOTEST"/current-commit
+	echo $sha1 >> "$DOTEST"/current-commit
 
 	# rewrite parents; if none were rewritten, we can fast-forward.
 	new_parents=
@@ -193,15 +198,19 @@ pick_one_preserving_merges () {
 			die "Cannot fast forward to $sha1"
 		;;
 	f)
-		test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
-
 		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
-		# detach HEAD to current parent
-		output git checkout $first_parent 2> /dev/null ||
-			die "Cannot move HEAD to $first_parent"
+
+		if [ "$1" != "-n" ]
+		then
+			# detach HEAD to current parent
+			output git checkout $first_parent 2> /dev/null ||
+				die "Cannot move HEAD to $first_parent"
+		fi
 
 		case "$new_parents" in
 		' '*' '*)
+			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
+
 			# redo merge
 			author_script=$(get_author_ident_from_commit $sha1)
 			eval "$author_script"
@@ -350,20 +359,7 @@ do_next () {
 	HEADNAME=$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=$(cat "$DOTEST"/head) &&
 	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
-	if test -d "$REWRITTEN"
-	then
-		test -f "$DOTEST"/current-commit &&
-			current_commit=$(cat "$DOTEST"/current-commit) &&
-			git rev-parse HEAD > "$REWRITTEN"/$current_commit
-		if test -f "$REWRITTEN"/$OLDHEAD
-		then
-			NEWHEAD=$(cat "$REWRITTEN"/$OLDHEAD)
-		else
-			NEWHEAD=$OLDHEAD
-		fi
-	else
-		NEWHEAD=$(git rev-parse HEAD)
-	fi &&
+	NEWHEAD=$(git rev-parse HEAD) &&
 	case $HEADNAME in
 	refs/*)
 		message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
@@ -561,11 +557,18 @@ first and then run 'git rebase --continue' again."
 			MERGES_OPTION=--no-merges
 		fi
 
+		if test t = "$PRESERVE_MERGES"
+		then
+			first_parent="--first-parent"
+		else
+			first_parent=""
+		fi
+
 		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
 		SHORTHEAD=$(git rev-parse --short $HEAD)
 		SHORTONTO=$(git rev-parse --short $ONTO)
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --cherry-pick \
+			--abbrev=7 --reverse --left-right --cherry-pick $first_parent \
 			$UPSTREAM...$HEAD | \
 			sed -n "s/^>/pick /p" > "$TODO"
 		cat >> "$TODO" << EOF
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
new file mode 100644
index 0000000..b130f5f
--- /dev/null
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Stephen Haberman
+#
+
+test_description='git rebase preserve merges
+
+This test runs git rebase with and tries to squash a commit from after a merge
+to before the merge.
+'
+. ./test-lib.sh
+
+# Copy/paste from t3404-rebase-interactive.sh
+echo "#!$SHELL_PATH" >fake-editor.sh
+cat >> fake-editor.sh <<\EOF
+case "$1" in
+*/COMMIT_EDITMSG)
+	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
+	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
+	exit
+	;;
+esac
+test -z "$EXPECT_COUNT" ||
+	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
+	exit
+test -z "$FAKE_LINES" && exit
+grep -v '^#' < "$1" > "$1".tmp
+rm -f "$1"
+cat "$1".tmp
+action=pick
+for line in $FAKE_LINES; do
+	case $line in
+	squash|edit)
+		action="$line";;
+	*)
+		echo sed -n "${line}s/^pick/$action/p"
+		sed -n "${line}p" < "$1".tmp
+		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
+		action=pick;;
+	esac
+done
+EOF
+
+test_set_editor "$(pwd)/fake-editor.sh"
+chmod a+x fake-editor.sh
+
+# set up two branches like this:
+#
+# A - B - D - E - F
+#      \     /
+#       - C -
+
+test_expect_success 'setup' '
+	touch a &&
+	touch b &&
+	git add a &&
+	git commit -m A &&
+	git add b &&
+	git commit -m B &&
+	git tag B &&
+	git checkout -b branch &&
+	touch c &&
+	git add c &&
+	git commit -m C &&
+	git checkout master &&
+	touch d &&
+	git add d &&
+	git commit -m D &&
+	git merge branch &&
+	touch f &&
+	git add f &&
+	git commit -m F &&
+	git tag F
+'
+
+test_expect_success 'squash F into D' '
+	FAKE_LINES="1 squash 3 2" git rebase -i -p B &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse branch)" &&
+	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B)"
+'
+
+test_done
+
-- 
1.6.0.2
