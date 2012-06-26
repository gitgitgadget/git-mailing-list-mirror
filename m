From: Chris Webb <chris@arachsys.com>
Subject: [PATCH v2 2/2] Add tests for rebase -i --root without --onto
Date: Tue, 26 Jun 2012 22:55:24 +0100
Message-ID: <f4be13ed5005aefce11e21cbba47b0dc2f743d3e.1340747724.git.chris@arachsys.com>
References: <8d50b9665c6b31af25464f92ada57da90c2ca8a7.1340747724.git.chris@arachsys.com>
Cc: Jeff King <peff@peff.net>, Chris Webb <chris@arachsys.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:56:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjdkE-00056x-Fy
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 23:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab2FZVzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 17:55:42 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:45014 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab2FZVzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 17:55:41 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjdjW-00053x-80; Tue, 26 Jun 2012 22:55:38 +0100
X-Mailer: git-send-email 1.7.10
In-Reply-To: <8d50b9665c6b31af25464f92ada57da90c2ca8a7.1340747724.git.chris@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200688>

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
