From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/2] rebase -i -p: fix parent rewriting
Date: Wed, 13 Aug 2008 23:41:24 +0200
Message-ID: <e345bea8d069f267772d323ca5f76182083f2f6b.1218663527.git.trast@student.ethz.ch>
References: <20080813205806.GC10758@leksak.fem-net>
 <f3d190b3dde04470c0f431d93cf6be6e3990c510.1218663527.git.trast@student.ethz.ch>
Cc: gitster@pobox.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 23:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTO6q-00023r-8r
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYHMVlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbYHMVlW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:41:22 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:27266 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbYHMVlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:41:20 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 23:41:18 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 23:41:18 +0200
X-Mailer: git-send-email 1.6.0.rc2.69.g29dd9
In-Reply-To: <f3d190b3dde04470c0f431d93cf6be6e3990c510.1218663527.git.trast@student.ethz.ch>
In-Reply-To: <f3d190b3dde04470c0f431d93cf6be6e3990c510.1218663527.git.trast@student.ethz.ch>
References: <f3d190b3dde04470c0f431d93cf6be6e3990c510.1218663527.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Aug 2008 21:41:18.0250 (UTC) FILETIME=[51ABF8A0:01C8FD8D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92279>

The existing parent rewriting did not handle the case where a previous
commit was amended (via edit or squash).  Fix by always putting the
new sha1 of the last commit into the $REWRITTEN map.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-rebase--interactive.sh    |    6 ++----
 t/t3404-rebase-interactive.sh |   12 ++++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 58126bd..929d681 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -165,14 +165,14 @@ pick_one_preserving_merges () {
 		die "Cannot write current commit's replacement sha1"
 	fi
 
+	echo $sha1 > "$DOTEST"/current-commit
+
 	# rewrite parents; if none were rewritten, we can fast-forward.
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
@@ -189,7 +189,6 @@ pick_one_preserving_merges () {
 	case $fast_forward in
 	t)
 		output warn "Fast forward to $sha1"
-		test $preserve = f || echo $sha1 > "$REWRITTEN"/$sha1
 		output git reset --hard $sha1 ||
 			die "Cannot fast forward to $sha1"
 		;;
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
1.6.0.rc2.69.g29dd9
