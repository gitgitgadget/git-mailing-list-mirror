From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/2] rebase -i -p: fix parent rewriting
Date: Wed, 13 Aug 2008 13:57:00 +0200
Message-ID: <9cc595258568081dd3f773ec859d552d5d892990.1218628445.git.trast@student.ethz.ch>
References: <200808131207.31616.trast@student.ethz.ch>
 <23b4780a3a7bbe06f4157b6843d1d9dab26d7087.1218628444.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 13:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTEzR-0007TY-FZ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 13:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbYHML47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 07:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754588AbYHML46
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 07:56:58 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:47922 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389AbYHML4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 07:56:55 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 13:56:53 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 13:56:53 +0200
X-Mailer: git-send-email 1.6.0.rc2.36.g234a
In-Reply-To: <23b4780a3a7bbe06f4157b6843d1d9dab26d7087.1218628444.git.trast@student.ethz.ch>
In-Reply-To: <23b4780a3a7bbe06f4157b6843d1d9dab26d7087.1218628444.git.trast@student.ethz.ch>
References: <23b4780a3a7bbe06f4157b6843d1d9dab26d7087.1218628444.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Aug 2008 11:56:53.0343 (UTC) FILETIME=[AD5BC6F0:01C8FD3B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92211>

The existing parent rewriting did not handle the case where a previous
commit was amended (via edit or squash).  Fix by always putting the
new sha1 of the last commit into the $REWRITTEN map.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-rebase--interactive.sh    |    7 ++-----
 t/t3404-rebase-interactive.sh |   12 ++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1dc24b1..929d681 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -165,15 +165,14 @@ pick_one_preserving_merges () {
 		die "Cannot write current commit's replacement sha1"
 	fi
 
+	echo $sha1 > "$DOTEST"/current-commit
+
 	# rewrite parents; if none were rewritten, we can fast-forward.
-	fast_forward=t
-	preserve=t
 	new_parents=
 	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
 	do
 		if test -f "$REWRITTEN"/$p
 		then
-			preserve=f
 			new_p=$(cat "$REWRITTEN"/$p)
 			test $p != $new_p && fast_forward=f
 			case "$new_parents" in
@@ -190,7 +189,6 @@ pick_one_preserving_merges () {
 	case $fast_forward in
 	t)
 		output warn "Fast forward to $sha1"
-		test $preserve = f || echo $sha1 > "$REWRITTEN"/$sha1
 		output git reset --hard $sha1 ||
 			die "Cannot fast forward to $sha1"
 		;;
@@ -202,7 +200,6 @@ pick_one_preserving_merges () {
 		output git checkout $first_parent 2> /dev/null ||
 			die "Cannot move HEAD to $first_parent"
 
-		echo $sha1 > "$DOTEST"/current-commit
 		case "$new_parents" in
 		' '*' '*)
 			# redo merge
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4d62b9a..5aa487a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -250,6 +250,18 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD:unrelated-file) = 1
 '
 
+test_expect_success 'edit ancestor with -p' '
+	FAKE_LINES="1 edit 2 3 4" git rebase -i -p HEAD~3 &&
+	echo 2 > unrelated-file &&
+	test_tick &&
+	git commit -m L2-modified --amend unrelated-file &&
+	git rebase --continue &&
+	git update-index --refresh &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD -- &&
+	test $(git show HEAD:unrelated-file) = 2
+'
+
 test_expect_success '--continue tries to commit' '
 	test_tick &&
 	test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
-- 
1.6.0.rc2.36.g234a
