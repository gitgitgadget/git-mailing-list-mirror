From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] rebase -i -p: fix parent rewriting
Date: Wed, 13 Aug 2008 12:04:17 +0200
Message-ID: <65932ae2b77a1249da300e384704394d65696caf.1218621695.git.trast@student.ethz.ch>
References: <200808121116.41535.trast@student.ethz.ch>
 <8bbecf58e7fba14497720afe5cdaf52fec6bcb40.1218621695.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTDEo-00035o-Pf
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 12:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbYHMKEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 06:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYHMKEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 06:04:16 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:27550 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbYHMKEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 06:04:14 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 12:04:11 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 12:04:11 +0200
X-Mailer: git-send-email 1.6.0.rc2.37.g65932
In-Reply-To: <8bbecf58e7fba14497720afe5cdaf52fec6bcb40.1218621695.git.trast@student.ethz.ch>
In-Reply-To: <8bbecf58e7fba14497720afe5cdaf52fec6bcb40.1218621695.git.trast@student.ethz.ch>
References: <8bbecf58e7fba14497720afe5cdaf52fec6bcb40.1218621695.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Aug 2008 10:04:11.0185 (UTC) FILETIME=[EECC5A10:01C8FD2B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92201>

The existing parent rewriting did not handle the case where a previous
commit was amended (via edit or squash).  Fix by always putting the
new sha1 of the last commit into the $REWRITTEN map.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-rebase--interactive.sh    |    6 ++----
 t/t3404-rebase-interactive.sh |   12 ++++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 51a6147..929d681 100755
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
@@ -201,7 +200,6 @@ pick_one_preserving_merges () {
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
1.6.0.rc2.38.g33ece.dirty
