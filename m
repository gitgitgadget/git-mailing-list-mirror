From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/: work around one-shot variable assignment with test_must_fail
Date: Tue, 20 Jul 2010 16:55:31 -0500
Message-ID: <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
Cc: erick.mattos@gmail.com, avarab@gmail.com, jrnieder@gmail.com,
	jaredhance@gmail.com, drafnel@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 23:55:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObKn1-00013j-0h
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 23:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761583Ab0GTVzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 17:55:45 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42859 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab0GTVzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 17:55:44 -0400
Received: by mail.nrlssc.navy.mil id o6KLtfem013822; Tue, 20 Jul 2010 16:55:42 -0500
In-Reply-To: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Jul 2010 21:55:41.0954 (UTC) FILETIME=[4C1E3E20:01CB2856]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151369>

No time to investigate, but here is an example patch and the
results of running the affected tests.  Looks like reflog may
be creating a reflog when it is not supposed to.

Erick, I added you to cc since you appear to be the author of the tests
in question.

$ ./t2017-checkout-orphan.sh
<snip>
not ok - 8 --orphan does not make reflog when core.logAllRefUpdates = false
#
#               git checkout master &&
#               git config core.logAllRefUpdates false &&
#               git checkout --orphan epsilon &&
#               ! test -f .git/logs/refs/heads/epsilon &&
#               (
#                       PAGER= &&
#                       export PAGER &&
#                       test_must_fail git reflog show epsilon
#               ) &&
#               git commit -m Epsilon &&
#               ! test -f .git/logs/refs/heads/epsilon &&
#               (
#                       PAGER= &&
#                       export PAGER &&
#                       test_must_fail git reflog show epsilon
#               )
#
<snip>

$ ./t3200-branch.sh
<snip>
not ok - 32 checkout -b does not make reflog when core.logAllRefUpdates = false
#
#               git checkout master &&
#               git config core.logAllRefUpdates false &&
#               git checkout -b beta &&
#               ! test -f .git/logs/refs/heads/beta &&
#               (
#                       PAGER= &&
#                       export PAGER &&
#                       test_must_fail git reflog show beta
#               )
#
<snip>


--->8---
From: Brandon Casey <drafnel@gmail.com>

See e2007832552ccea9befed9003580c494f09e666e
---
 t/t2017-checkout-orphan.sh |   36 ++++++++++++++++++++++++++++++------
 t/t3200-branch.sh          |    6 +++++-
 t/t3301-notes.sh           |    6 +++++-
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index be88d4b..81cb393 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -69,7 +69,11 @@ test_expect_success '--orphan makes reflog by default' '
 	git config --unset core.logAllRefUpdates &&
 	git checkout --orphan delta &&
 	! test -f .git/logs/refs/heads/delta &&
-	test_must_fail PAGER= git reflog show delta &&
+	(
+		PAGER= &&
+		export PAGER &&
+		test_must_fail git reflog show delta
+	) &&
 	git commit -m Delta &&
 	test -f .git/logs/refs/heads/delta &&
 	PAGER= git reflog show delta
@@ -80,17 +84,29 @@ test_expect_success '--orphan does not make reflog when core.logAllRefUpdates =
 	git config core.logAllRefUpdates false &&
 	git checkout --orphan epsilon &&
 	! test -f .git/logs/refs/heads/epsilon &&
-	test_must_fail PAGER= git reflog show epsilon &&
+	(
+		PAGER= &&
+		export PAGER &&
+		test_must_fail git reflog show epsilon
+	) &&
 	git commit -m Epsilon &&
 	! test -f .git/logs/refs/heads/epsilon &&
-	test_must_fail PAGER= git reflog show epsilon
+	(
+		PAGER= &&
+		export PAGER &&
+		test_must_fail git reflog show epsilon
+	)
 '
 
 test_expect_success '--orphan with -l makes reflog when core.logAllRefUpdates = false' '
 	git checkout master &&
 	git checkout -l --orphan zeta &&
 	test -f .git/logs/refs/heads/zeta &&
-	test_must_fail PAGER= git reflog show zeta &&
+	(
+		PAGER= &&
+		export PAGER &&
+		test_must_fail git reflog show zeta
+	) &&
 	git commit -m Zeta &&
 	PAGER= git reflog show zeta
 '
@@ -99,10 +115,18 @@ test_expect_success 'giving up --orphan not committed when -l and core.logAllRef
 	git checkout master &&
 	git checkout -l --orphan eta &&
 	test -f .git/logs/refs/heads/eta &&
-	test_must_fail PAGER= git reflog show eta &&
+	(
+		PAGER= &&
+		export PAGER &&
+		test_must_fail git reflog show eta
+	) &&
 	git checkout master &&
 	! test -f .git/logs/refs/heads/eta &&
-	test_must_fail PAGER= git reflog show eta
+	(
+		PAGER= &&
+		export PAGER &&
+		test_must_fail git reflog show eta
+	)
 '
 
 test_expect_success '--orphan is rejected with an existing name' '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 859b99a..bf7747d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -237,7 +237,11 @@ test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates
 	git config core.logAllRefUpdates false &&
 	git checkout -b beta &&
 	! test -f .git/logs/refs/heads/beta &&
-	test_must_fail PAGER= git reflog show beta
+	(
+		PAGER= &&
+		export PAGER &&
+		test_must_fail git reflog show beta
+	)
 '
 
 test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates = false' '
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 2d67a40..1d82f79 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -693,7 +693,11 @@ test_expect_success 'create note from non-existing note with "git notes add -c"
 	git add a10 &&
 	test_tick &&
 	git commit -m 10th &&
-	test_must_fail MSG="yet another note" git notes add -c deadbeef &&
+	(
+		MSG="yet another note" &&
+		export MSG &&
+		test_must_fail git notes add -c deadbeef
+	) &&
 	test_must_fail git notes list HEAD
 '
 
-- 
1.6.6.2
