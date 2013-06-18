From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH mz/rebase-tests] rebase topology tests: fix commit names on
 case-insensitive file systems
Date: Tue, 18 Jun 2013 09:28:07 +0200
Message-ID: <51C00C07.6080600@viscovery.net>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com> <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:28:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoqKt-0000Ca-AY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab3FRH2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:28:11 -0400
Received: from so.liwest.at ([212.33.55.13]:9040 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650Ab3FRH2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:28:10 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UoqKl-0003z4-Sx; Tue, 18 Jun 2013 09:28:08 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9E6EA1660F;
	Tue, 18 Jun 2013 09:28:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228167>

From: Johannes Sixt <j6t@kdbg.org>

The recently introduced tests used uppercase letters to denote
cherry-picks of commits having the corresponding lowercase letter names.
The helper functions also set up tags with the names of the commits.

But this constellation fails on case-insensitive file systems because
there cannot be distinct tags with names that differ only in case.

Use a less subtle convention for the names of cherry-picked commits.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Knowing that the tests would take their time to complete on Windows,
 today was the first time I ran them, and there were some unexpected
 issues. Fixed by this patch.

 t/t3421-rebase-topology-linear.sh | 20 ++++++++++----------
 t/t3425-rebase-topology-merges.sh | 16 ++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index e67add6..9c55cba 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -79,9 +79,9 @@ test_run_rebase success -p
 #      /
 # a---b---c---g---h
 #      \
-#       d---G---i
+#       d---gp--i
 #
-# uppercase = cherry-picked
+# gp = cherry-picked g
 # h = reverted g
 #
 # Reverted patches are there for tests to be able to check if a commit
@@ -94,7 +94,7 @@ test_expect_success 'setup of linear history for range selection tests' '
 	test_commit g &&
 	revert h g &&
 	git checkout d &&
-	cherry_pick G g &&
+	cherry_pick gp g &&
 	test_commit i &&
 	git checkout b &&
 	test_commit f
@@ -120,7 +120,7 @@ test_run_rebase () {
 	shift
 	test_expect_$result "rebase $* can drop last patch if in upstream" "
 		reset_rebase &&
-		git rebase $* h G &&
+		git rebase $* h gp &&
 		test_cmp_rev h HEAD^ &&
 		test_linear_range 'd' h..
 	"
@@ -152,7 +152,7 @@ test_run_rebase () {
 		reset_rebase &&
 		git rebase $* --onto h f i &&
 		test_cmp_rev h HEAD~3 &&
-		test_linear_range 'd G i' h..
+		test_linear_range 'd gp i' h..
 	"
 }
 test_run_rebase success ''
@@ -222,9 +222,9 @@ test_run_rebase failure -p
 #      /
 # a---b---c---g
 #
-# x---y---B
+# x---y---bp
 #
-# uppercase = cherry-picked
+# bp = cherry-picked b
 # m = reverted b
 #
 # Reverted patches are there for tests to be able to check if a commit
@@ -239,7 +239,7 @@ test_expect_success 'setup of linear history for test involving root' '
 	git rm -rf . &&
 	test_commit x &&
 	test_commit y &&
-	cherry_pick B b
+	cherry_pick bp b
 '
 
 test_run_rebase () {
@@ -277,7 +277,7 @@ test_run_rebase () {
 	shift
 	test_expect_$result "rebase $* --onto --root drops patch in onto" "
 		reset_rebase &&
-		git rebase $* --onto m --root B &&
+		git rebase $* --onto m --root bp &&
 		test_cmp_rev m HEAD~2 &&
 		test_linear_range 'x y' m..
 	"
@@ -308,7 +308,7 @@ test_run_rebase () {
 	shift
 	test_expect_$result "rebase $* without --onto --root with disjoint history drops patch in onto" "
 		reset_rebase &&
-		git rebase $* m B &&
+		git rebase $* m bp &&
 		test_cmp_rev m HEAD~2 &&
 		test_linear_range 'x y' m..
 	"
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 5400a05..1d195fb 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -30,7 +30,7 @@ test_expect_success 'setup of non-linear-history' '
 	test_commit g &&
 	revert h g &&
 	git checkout d &&
-	cherry_pick G g &&
+	cherry_pick gp g &&
 	test_commit i &&
 	git checkout b &&
 	test_commit f
@@ -154,11 +154,11 @@ test_expect_success "rebase -p can re-create two branches on onto" "
 #      /
 # a---b---c---g---h
 #      \
-#       d---G---i
+#       d---gp--i
 #        \       \
 #         e-------u
 #
-# uppercase = cherry-picked
+# gp = cherry-picked g
 # h = reverted g
 test_expect_success 'setup of non-linear-history for patch-equivalence tests' '
 	git checkout e &&
@@ -186,24 +186,24 @@ test_expect_success "rebase -p --onto in merged history does not drop patches in
 	git rebase -p --onto h f u &&
 	test_cmp_rev h HEAD~3 &&
 	test_cmp_rev HEAD^2~2 HEAD~2 &&
-	test_revision_subjects 'd G i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD
+	test_revision_subjects 'd gp i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD
 "
 
 # a---b---c---g---h
 #      \
-#       d---G---s
+#       d---gp--s
 #        \   \ /
 #         \   X
 #          \ / \
 #           e---t
 #
-# uppercase = cherry-picked
+# gp = cherry-picked g
 # h = reverted g
 test_expect_success 'setup of non-linear-history for dropping whole side' '
-	git checkout G &&
+	git checkout gp &&
 	test_merge s e &&
 	git checkout e &&
-	test_merge t G
+	test_merge t gp
 '
 
 test_expect_failure "rebase -p drops merge commit when entire first-parent side is dropped" "
-- 
1.8.3.1.1749.g223650b
