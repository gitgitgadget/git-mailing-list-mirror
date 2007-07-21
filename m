From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: call editor just once for a multi-squash
Date: Sat, 21 Jul 2007 18:09:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707211807430.14781@racer.site>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com> <20070712132937.GQ19386@genesis.frugalware.org>
 <Pine.LNX.4.64.0707121451290.4516@racer.site> <20070713103025.GR1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jul 21 19:10:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICITA-0007ro-8Z
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 19:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbXGURJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 13:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXGURJ6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 13:09:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:42343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751161AbXGURJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 13:09:57 -0400
Received: (qmail invoked by alias); 21 Jul 2007 17:09:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 21 Jul 2007 19:09:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FlLoLqeCF9O9IL0TPIBIT5/0nnA+OdBkF6QoTCT
	Z0yreZEjw9E1bj
X-X-Sender: gene099@racer.site
In-Reply-To: <20070713103025.GR1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53173>


Sometimes you want to squash more than two commits.  Before this patch,
the editor was fired up for each squash command.  Now the editor is
started only with the last squash command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 13 Jul 2007, Sven Verdoolaege wrote:

	> If I squash a whole series of commits, how do I prevent 
	> git-rebase -i from firing up an editor after every single commit 
	> in the series?

	By applying this patch ;-)

 git-rebase--interactive.sh    |   56 +++++++++++++++++++++++++++++++++-------
 t/t3404-rebase-interactive.sh |    9 ++++++
 2 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a2d4d09..579a45e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -19,6 +19,8 @@ require_work_tree
 DOTEST="$GIT_DIR/.dotest-merge"
 TODO="$DOTEST"/todo
 DONE="$DOTEST"/done
+MSG="$DOTEST"/message
+SQUASH_MSG="$DOTEST"/message-squash
 REWRITTEN="$DOTEST"/rewritten
 PRESERVE_MERGES=
 STRATEGY=
@@ -158,6 +160,38 @@ pick_one_preserving_merges () {
 	esac
 }
 
+nth_string () {
+	case "$1" in
+	*1[0-9]|*[04-9]) echo "$1"th;;
+	*1) echo "$1"st;;
+	*2) echo "$1"nd;;
+	*3) echo "$1"rd;;
+	esac
+}
+
+make_squash_message () {
+	if [ -f "$SQUASH_MSG" ]; then
+		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([0-9]\+\).*/\1/p" \
+			< "$SQUASH_MSG" | tail -n 1)+1))
+		echo "# This is a combination of $COUNT commits."
+		sed -n "2,\$p" < "$SQUASH_MSG"
+	else
+		COUNT=2
+		echo "# This is a combination of two commits."
+		echo "# The first commit's message is:"
+		echo
+		git cat-file commit HEAD | sed -e '1,/^$/d'
+		echo
+	fi
+	echo "# This is the $(nth_string $COUNT) commit message:"
+	echo
+	git cat-file commit $1 | sed -e '1,/^$/d'
+}
+
+peek_next_command () {
+	sed -n "1s/ .*$//p" < "$TODO"
+}
+
 do_next () {
 	test -f "$DOTEST"/message && rm "$DOTEST"/message
 	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
@@ -194,17 +228,19 @@ do_next () {
 			die "Cannot 'squash' without a previous commit"
 
 		mark_action_done
-		MSG="$DOTEST"/message
-		echo "# This is a combination of two commits." > "$MSG"
-		echo "# The first commit's message is:" >> "$MSG"
-		echo >> "$MSG"
-		git cat-file commit HEAD | sed -e '1,/^$/d' >> "$MSG"
-		echo >> "$MSG"
+		make_squash_message $sha1 > "$MSG"
+		case "$(peek_next_command)" in
+		squash)
+			EDIT_COMMIT=
+			cp "$MSG" "$SQUASH_MSG"
+		;;
+		*)
+			EDIT_COMMIT=-e
+			test -f "$SQUASH_MSG" && rm "$SQUASH_MSG"
+		esac
+
 		failed=f
 		pick_one -n $sha1 || failed=t
-		echo "# And this is the 2nd commit message:" >> "$MSG"
-		echo >> "$MSG"
-		git cat-file commit $sha1 | sed -e '1,/^$/d' >> "$MSG"
 		git reset --soft HEAD^
 		author_script=$(get_author_ident_from_commit $sha1)
 		echo "$author_script" > "$DOTEST"/author-script
@@ -213,7 +249,7 @@ do_next () {
 			# This is like --amend, but with a different message
 			eval "$author_script"
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
-			git commit -F "$MSG" -e
+			git commit -F "$MSG" $EDIT_COMMIT
 			;;
 		t)
 			cp "$MSG" "$GIT_DIR"/MERGE_MSG
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 43a6675..8206436 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -65,6 +65,7 @@ cat > fake-editor.sh << EOF
 #!/bin/sh
 test "\$1" = .git/COMMIT_EDITMSG && {
 	test -z "\$FAKE_COMMIT_MESSAGE" || echo "\$FAKE_COMMIT_MESSAGE" > "\$1"
+	test -z "\$FAKE_COMMIT_AMEND" || echo "\$FAKE_COMMIT_AMEND" >> "\$1"
 	exit
 }
 test -z "\$FAKE_LINES" && exit
@@ -212,4 +213,12 @@ test_expect_success 'verbose flag is heeded, even after --continue' '
 	grep "^ file1 |    2 +-$" output
 '
 
+test_expect_success 'multi-squash only fires up editor once' '
+	base=$(git rev-parse HEAD~4) &&
+	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 squash 2 squash 3 squash 4" \
+		git rebase -i $base &&
+	test $base = $(git rev-parse HEAD^) &&
+	test 1 = $(git show | grep ONCE | wc -l)
+'
+
 test_done
-- 
1.5.3.rc1.16.g9d6f-dirty
