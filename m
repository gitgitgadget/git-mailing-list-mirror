From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] rebase -i: handle --continue more like non-interactive
 rebase
Date: Sun, 8 Jul 2007 03:01:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080300440.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 08 04:08:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7MCY-0000fW-SD
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 04:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbXGHCIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 22:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbXGHCIk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 22:08:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:47292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754684AbXGHCIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 22:08:40 -0400
Received: (qmail invoked by alias); 08 Jul 2007 02:08:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 08 Jul 2007 04:08:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UiAdovV3UPKLmNqrgt5i2tghiY5nuuyH8bEkcg8
	DKbXzDfUCTVdba
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51855>


Non-interactive rebase requires the working tree to be clean, but
applies what is in the index without requiring the user to do it
herself.  Imitate that, but (since we are interactive, after all)
fire up an editor with the commit message.

It also fixes a subtle bug: a forgotten "continue" was removed, which
led to an infinite loop when continuing without remaining patches.

Both issues noticed by Frank Lichtenheld.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    |   25 ++++++++++++++++---------
 t/t3404-rebase-interactive.sh |   16 +++++++++++++++-
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c2a969..67f2ee2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -59,6 +59,10 @@ make_patch () {
 }
 
 die_with_patch () {
+	test -f "$DOTEST"/message ||
+		git cat-file commit $sha1 | sed "1,/^$/d" > "$DOTEST"/message
+	test -f "$DOTEST"/author-script ||
+		get_author_ident_from_commit $sha1 > "$DOTEST"/author-script
 	make_patch "$1"
 	die "$2"
 }
@@ -140,10 +144,7 @@ pick_one_preserving_merges () {
 			if ! git merge $STRATEGY -m "$msg" $new_parents
 			then
 				echo "$msg" > "$GIT_DIR"/MERGE_MSG
-				warn Error redoing merge $sha1
-				warn
-				warn After fixup, please use
-				die "$author_script git commit"
+				die Error redoing merge $sha1
 			fi
 			;;
 		*)
@@ -154,11 +155,12 @@ pick_one_preserving_merges () {
 }
 
 do_next () {
+	test -f "$DOTEST"/message && rm "$DOTEST"/message
+	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	\#|'')
 		mark_action_done
-		continue
 		;;
 	pick)
 		comment_for_reflog pick
@@ -201,6 +203,7 @@ do_next () {
 		git cat-file commit $sha1 | sed -e '1,/^$/d' >> "$MSG"
 		git reset --soft HEAD^
 		author_script=$(get_author_ident_from_commit $sha1)
+		echo "$author_script" > "$DOTEST"/author-script
 		case $failed in
 		f)
 			# This is like --amend, but with a different message
@@ -212,10 +215,6 @@ do_next () {
 			cp "$MSG" "$GIT_DIR"/MERGE_MSG
 			warn
 			warn "Could not apply $sha1... $rest"
-			warn "After you fixed that, commit the result with"
-			warn
-			warn "  $(echo $author_script | tr '\012' ' ') \\"
-			warn "	  git commit -F \"$GIT_DIR\"/MERGE_MSG -e"
 			die_with_patch $sha1 ""
 		esac
 		;;
@@ -265,6 +264,14 @@ do
 
 		test -d "$DOTEST" || die "No interactive rebase running"
 
+		# commit if necessary
+		git rev-parse --verify HEAD > /dev/null &&
+		git update-index --refresh &&
+		git diff-files --quiet &&
+		! git diff-index --cached --quiet HEAD &&
+		. "$DOTEST"/author-script &&
+		git commit -F "$DOTEST"/message -e
+
 		require_clean_work_tree
 		do_rest
 		;;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 883cf29..c251336 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -63,7 +63,10 @@ test_expect_success 'setup' '
 
 cat > fake-editor.sh << EOF
 #!/bin/sh
-test "\$1" = .git/COMMIT_EDITMSG && exit
+test "\$1" = .git/COMMIT_EDITMSG && {
+	test -z "\$FAKE_COMMIT_MESSAGE" || echo "\$FAKE_COMMIT_MESSAGE" > "\$1"
+	exit
+}
 test -z "\$FAKE_LINES" && exit
 grep -v "^#" < "\$1" > "\$1".tmp
 rm "\$1"
@@ -181,6 +184,7 @@ test_expect_success 'preserve merges with -p' '
 	echo C > file1 &&
 	test_tick &&
 	git commit -m K file1 &&
+	test_tick &&
 	git rebase -i -p --onto branch1 master &&
 	test $(git rev-parse HEAD^^2) = $(git rev-parse to-be-preserved) &&
 	test $(git rev-parse HEAD~3) = $(git rev-parse branch1) &&
@@ -188,4 +192,14 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD~2:file1) = B
 '
 
+test_expect_success '--continue tries to commit' '
+	test_tick &&
+	! git rebase -i --onto new-branch1 HEAD^ &&
+	echo resolved > file1 &&
+	git add file1 &&
+	FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue &&
+	test $(git rev-parse HEAD^) = $(git rev-parse new-branch1) &&
+	git show HEAD | grep chouette
+'
+
 test_done
-- 
1.5.3.rc0.2712.g125b7f
