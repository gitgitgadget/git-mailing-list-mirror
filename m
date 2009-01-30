From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] t3412: use log|name-rev instead of log --graph
Date: Fri, 30 Jan 2009 23:47:01 +0100
Message-ID: <1233355621-4783-2-git-send-email-trast@student.ethz.ch>
References: <200901302343.39921.trast@student.ethz.ch>
 <1233355621-4783-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT2A5-0007bo-M4
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 23:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbZA3WrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 17:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbZA3WrJ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 17:47:09 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:25598 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754625AbZA3WrH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 17:47:07 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:47:03 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:47:02 +0100
X-Mailer: git-send-email 1.6.1.2.464.g6066
In-Reply-To: <1233355621-4783-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 30 Jan 2009 22:47:02.0661 (UTC) FILETIME=[AAF2D350:01C9832C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107879>

Replace all 'git log --graph' calls for history verification with the
combination of 'git log ...| git name-rev' first introduced by a6c7a27
(rebase -i: correctly remember --root flag across --continue,
2009-01-26).  This should be less susceptible to format changes than
the --graph code.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t3412-rebase-root.sh |   65 ++++++++++++++++++++++++++++-------------------
 1 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 8a9154a..57a3cad 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -10,6 +10,12 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
 GIT_EDITOR=:
 export GIT_EDITOR
 
+log_with_names () {
+	git rev-list --topo-order --parents --pretty="tformat:%s" HEAD |
+	git name-rev --stdin --name-only --refs=refs/heads/$1
+}
+
+
 test_expect_success 'prepare repository' '
 	test_commit 1 A &&
 	test_commit 2 A &&
@@ -102,21 +108,25 @@ test_expect_success 'set up merge history' '
 	git merge side
 '
 
-sed 's/#/ /g' > expect-side <<'EOF'
-*   Merge branch 'side' into other
-|\##
-| * 5
-* | 4
-|/##
-* 3
-* 2
-* 1
+cat > expect-side <<'EOF'
+commit work6 work6~1 work6^2
+Merge branch 'side' into other
+commit work6^2 work6~2
+5
+commit work6~1 work6~2
+4
+commit work6~2 work6~3
+3
+commit work6~3 work6~4
+2
+commit work6~4
+1
 EOF
 
 test_expect_success 'rebase -i -p with merge' '
 	git checkout -b work6 other &&
 	git rebase -i -p --root --onto master &&
-	git log --graph --topo-order --pretty=tformat:"%s" > rebased6 &&
+	log_with_names work6 > rebased6 &&
 	test_cmp expect-side rebased6
 '
 
@@ -129,25 +139,29 @@ test_expect_success 'set up second root and merge' '
 	git merge third
 '
 
-sed 's/#/ /g' > expect-third <<'EOF'
-*   Merge branch 'third' into other
-|\##
-| * 6
-* |   Merge branch 'side' into other
-|\ \##
-| * | 5
-* | | 4
-|/ /##
-* | 3
-|/##
-* 2
-* 1
+cat > expect-third <<'EOF'
+commit work7 work7~1 work7^2
+Merge branch 'third' into other
+commit work7^2 work7~4
+6
+commit work7~1 work7~2 work7~1^2
+Merge branch 'side' into other
+commit work7~1^2 work7~3
+5
+commit work7~2 work7~3
+4
+commit work7~3 work7~4
+3
+commit work7~4 work7~5
+2
+commit work7~5
+1
 EOF
 
 test_expect_success 'rebase -i -p with two roots' '
 	git checkout -b work7 other &&
 	git rebase -i -p --root --onto master &&
-	git log --graph --topo-order --pretty=tformat:"%s" > rebased7 &&
+	log_with_names work7 > rebased7 &&
 	test_cmp expect-third rebased7
 '
 
@@ -263,8 +277,7 @@ test_expect_success 'fix the conflict' '
 
 test_expect_success 'rebase -i -p --root with conflict (second part)' '
 	git rebase --continue &&
-	git rev-list --topo-order --parents --pretty="tformat:%s" HEAD |
-	git name-rev --stdin --name-only --refs=refs/heads/conflict3 >out &&
+	log_with_names conflict3 >out &&
 	test_cmp expect-conflict-p out
 '
 
-- 
1.6.1.2.464.g6066
