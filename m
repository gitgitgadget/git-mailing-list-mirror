From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 2/2] Add tests for rebase -i --root without --onto
Date: Tue, 26 Jun 2012 14:36:33 +0100
Message-ID: <a00f5d0e6ae7e2d07a26b506788ef1270af57558.1340717793.git.chris@arachsys.com>
References: <20120626133339.GT9682@arachsys.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 15:36:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjVwo-0001gA-23
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 15:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756951Ab2FZNgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 09:36:48 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:41707 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718Ab2FZNgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 09:36:47 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjVwj-0004JU-QO; Tue, 26 Jun 2012 14:36:46 +0100
X-Mailer: git-send-email 1.7.10
In-Reply-To: <20120626133339.GT9682@arachsys.com>
In-Reply-To: <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
References: <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200642>

Test for likely breakages in t3404, including successful reordering of
non-conflicting changes with a new root, correct preservation of commit
message and author in a root commit when it is squashed with the
sentinel, and presence of the sentinel following a conflicting
cherry-pick of a new root.

Remove test_must_fail for git rebase --root without --onto from t3412 as
this case will now be successfully handled by an implicit git rebase -i.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 t/t3404-rebase-interactive.sh |   27 +++++++++++++++++++++++++++
 t/t3412-rebase-root.sh        |    4 ----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 025c1c6..6ffc9c2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,31 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase -i --root re-order and drop commits' '
+	git checkout E &&
+	FAKE_LINES="3 1 2 5" git rebase -i --root &&
+	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test B = $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test A = $(git cat-file commit HEAD^^ | sed -ne \$p) &&
+	test C = $(git cat-file commit HEAD^^^ | sed -ne \$p) &&
+	test 0 = $(git cat-file commit HEAD^^^ | grep -c ^parent\ )
+'
+
+test_expect_success 'rebase -i --root retain root commit author and message' '
+	git checkout A &&
+	echo B >file7 &&
+	git add file7 &&
+	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
+	FAKE_LINES="2" git rebase -i --root &&
+	git cat-file commit HEAD | grep -q "^author Twerp Snog" &&
+	git cat-file commit HEAD | grep -q "^different author$"
+'
+
+test_expect_success 'rebase -i --root temporary sentinel commit' '
+	git checkout B &&
+	FAKE_LINES="2" test_must_fail git rebase -i --root &&
+	git cat-file commit HEAD | grep "^tree 4b825dc642cb" &&
+	git rebase --abort
+'
+
 test_done
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 086c91c..e4f9da8 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -22,10 +22,6 @@ test_expect_success 'prepare repository' '
 	test_commit 4 B
 '
 
-test_expect_success 'rebase --root expects --onto' '
-	test_must_fail git rebase --root
-'
-
 test_expect_success 'setup pre-rebase hook' '
 	mkdir -p .git/hooks &&
 	cat >.git/hooks/pre-rebase <<EOF &&
-- 
1.7.10
