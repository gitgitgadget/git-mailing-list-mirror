From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH 4/4] status: add new tests for status during rebase -i
Date: Thu,  4 Jun 2015 00:00:25 +0200
Message-ID: <1433368825-24617-4-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 00:01:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0GiQ-00030K-P7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 00:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbbFCWAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 18:00:48 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:34798 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753154AbbFCWAk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 18:00:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4170F281C;
	Thu,  4 Jun 2015 00:00:39 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fnOpElQvBDoF; Thu,  4 Jun 2015 00:00:39 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2588E27E9;
	Thu,  4 Jun 2015 00:00:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 1E5B120E4;
	Thu,  4 Jun 2015 00:00:39 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ga5LgFy4ZWGr; Thu,  4 Jun 2015 00:00:39 +0200 (CEST)
Received: from localhost.localdomain (pas38-h02-176-189-96-8.dsl.sta.abo.bbox.fr [176.189.96.8])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id A12A320DF;
	Thu,  4 Jun 2015 00:00:38 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.342.g726a850
In-Reply-To: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270745>

---
 t/t7512-status-help.sh | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 4dd201a..dff912b 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -856,4 +856,92 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'prepare for different number of commits rebased' '
+	git reset --hard master &&
+	git checkout -b several_commits &&
+	test_commit one_commit main.txt one &&
+	test_commit two_commit main.txt two &&
+	test_commit three_commit main.txt three &&
+	test_commit four_commit main.txt four
+'
+
+
+test_expect_success 'status: one command done nothing remaining' '
+	FAKE_LINES=" exec_exit_15" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=$(git rev-parse --short HEAD~3) &&
+	(git rebase -i HEAD~3 || true)&&
+       cat >expected <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last command(s) done (1 command(s) done):
+   exec exit 15
+No command remaining.
+You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'status: two commands done, two remainings' '
+	FAKE_LINES="1 exec_exit_15 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=$(git rev-parse --short HEAD~3) &&
+	COMMIT4=$(git rev-parse HEAD) &&
+	COMMIT3=$(git rev-parse HEAD^) &&
+	COMMIT2=$(git rev-parse HEAD^^) &&
+	(git rebase -i HEAD~3 || true)&&
+       cat >expected <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   pick $COMMIT2 two_commit
+   exec exit 15
+Next command(s) to do (2 remaining command(s)):
+   pick $COMMIT3 three_commit
+   pick $COMMIT4 four_commit
+  (use git rebase --edit-todo to view and edit)
+You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'status: more than two commands done, two remainings' '
+	FAKE_LINES="1 2 exec_exit_15 3 4" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=$(git rev-parse --short HEAD~4) &&
+	COMMIT4=$(git rev-parse HEAD) &&
+	COMMIT3=$(git rev-parse HEAD^) &&
+	COMMIT2=$(git rev-parse HEAD^^) &&
+	(git rebase -i HEAD~4 || true)&&
+	cat >expected <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last command(s) done (3 command(s) done):
+   pick $COMMIT2 two_commit
+   exec exit 15
+  (see more at .git/rebase-merge/done)
+Next command(s) to do (2 remaining command(s)):
+   pick $COMMIT3 three_commit
+   pick $COMMIT4 four_commit
+  (use git rebase --edit-todo to view and edit)
+You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
 test_done
-- 
2.4.2.342.g3cebd9b
