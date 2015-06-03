From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [RFC/PATCH 2/2] status: fix tests to handle new verbose git status during rebase
Date: Wed,  3 Jun 2015 10:35:45 +0200
Message-ID: <1433320545-14244-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
References: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 10:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z049b-00064k-La
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 10:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbbFCIf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 04:35:57 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:60178 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753178AbbFCIfw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 04:35:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D1C4827B0;
	Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1cPtSnC7nLbQ; Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id BFC5727A8;
	Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id B861E20E4;
	Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eGQRyo97Z-gX; Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
Received: from guillaume-W35-37ET.grenet.fr (wificampus-029182.grenet.fr [130.190.29.182])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8925420DF;
	Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.340.g37f3f38
In-Reply-To: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270668>

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
---
 t/t7512-status-help.sh | 227 +++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 file changed, 213 insertions(+), 14 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 68ad2d7..242124f 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -134,9 +134,13 @@ test_expect_success 'prepare for rebase_i_conflict=
s' '
 test_expect_success 'status during rebase -i when conflicts unresolved=
' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
+	LAST_COMMIT=3D$(git rev-parse rebase_i_conflicts_second) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (1 command(s) done):
+   pick $LAST_COMMIT one_second
+No command remaining.
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on=
 '\''$ONTO'\''.
   (fix conflicts and then run "git rebase --continue")
   (use "git rebase --skip" to skip this patch)
@@ -159,10 +163,14 @@ test_expect_success 'status during rebase -i afte=
r resolving conflicts' '
 	git reset --hard rebase_i_conflicts_second &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
+	LAST_COMMIT=3D$(git rev-parse rebase_i_conflicts_second) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (1 command(s) done):
+   pick $LAST_COMMIT one_second
+No command remaining.
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on=
 '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
=20
@@ -183,14 +191,20 @@ test_expect_success 'status when rebasing -i in e=
dit mode' '
 	git checkout -b rebase_i_edit &&
 	test_commit one_rebase_i main.txt one &&
 	test_commit two_rebase_i main.txt two &&
+	COMMIT2=3D$(git rev-parse rebase_i_edit) &&
 	test_commit three_rebase_i main.txt three &&
+	COMMIT3=3D$(git rev-parse rebase_i_edit) &&
 	FAKE_LINES=3D"1 edit 2" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short HEAD~2) &&
 	git rebase -i HEAD~2 &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   pick $COMMIT2 two_rebase_i
+   edit $COMMIT3 three_rebase_i
+No command remaining.
 You are currently editing a commit while rebasing branch '\''rebase_i_=
edit'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -207,8 +221,11 @@ test_expect_success 'status when splitting a commi=
t' '
 	git checkout -b split_commit &&
 	test_commit one_split main.txt one &&
 	test_commit two_split main.txt two &&
+	COMMIT2=3D$(git rev-parse split_commit) &&
 	test_commit three_split main.txt three &&
+	COMMIT3=3D$(git rev-parse split_commit) &&
 	test_commit four_split main.txt four &&
+	COMMIT4=3D$(git rev-parse split_commit) &&
 	FAKE_LINES=3D"1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
@@ -216,7 +233,13 @@ test_expect_success 'status when splitting a commi=
t' '
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   pick $COMMIT2 two_split
+   edit $COMMIT3 three_split
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_split
+  (use git rebase --edit-todo to view and edit)
 You are currently splitting a commit while rebasing branch '\''split_c=
ommit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -239,7 +262,9 @@ test_expect_success 'status after editing the last =
commit with --amend during a
 	test_commit one_amend main.txt one &&
 	test_commit two_amend main.txt two &&
 	test_commit three_amend main.txt three &&
+	COMMIT3=3D$(git rev-parse amend_last) &&
 	test_commit four_amend main.txt four &&
+	COMMIT4=3D$(git rev-parse amend_last) &&
 	FAKE_LINES=3D"1 2 edit 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
@@ -247,7 +272,12 @@ test_expect_success 'status after editing the last=
 commit with --amend during a
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (3 command(s) done):
+   pick $COMMIT3 three_amend
+   edit $COMMIT4 four_amend
+  (see more at .git/rebase-merge/done)
+No command remaining.
 You are currently editing a commit while rebasing branch '\''amend_las=
t'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -273,11 +303,20 @@ test_expect_success 'status: (continue first edit=
) second edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -294,12 +333,21 @@ test_expect_success 'status: (continue first edit=
) second edit and split' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -321,12 +369,21 @@ test_expect_success 'status: (continue first edit=
) second edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -343,12 +400,21 @@ test_expect_success 'status: (amend first edit) s=
econd edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -366,12 +432,21 @@ test_expect_success 'status: (amend first edit) s=
econd edit and split' '
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "b" &&
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -393,13 +468,22 @@ test_expect_success 'status: (amend first edit) s=
econd edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "c" &&
 	git rebase --continue &&
 	git commit --amend -m "d" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -416,6 +500,9 @@ test_expect_success 'status: (split first edit) sec=
ond edit' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -423,7 +510,13 @@ test_expect_success 'status: (split first edit) se=
cond edit' '
 	git commit -m "e" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -440,6 +533,9 @@ test_expect_success 'status: (split first edit) sec=
ond edit and split' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -448,7 +544,13 @@ test_expect_success 'status: (split first edit) se=
cond edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -470,6 +572,9 @@ test_expect_success 'status: (split first edit) sec=
ond edit and amend' '
 	FAKE_LINES=3D"edit 1 edit 2 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	COMMIT2=3D$(git rev-parse several_edits^^) &&
+	COMMIT3=3D$(git rev-parse several_edits^) &&
+	COMMIT4=3D$(git rev-parse several_edits) &&
 	ONTO=3D$(git rev-parse --short HEAD~3) &&
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
@@ -478,7 +583,13 @@ test_expect_success 'status: (split first edit) se=
cond edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "h" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   edit $COMMIT2 two_edits
+   edit $COMMIT3 three_edits
+Next command(s) to do (1 remaining command(s)):
+   pick $COMMIT4 four_edits
+  (use git rebase --edit-todo to view and edit)
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -745,4 +856,92 @@ EOF
 	test_i18ncmp expected actual
 '
=20
+test_expect_success 'prepare for different number of commits rebased' =
'
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
+	FAKE_LINES=3D" exec_exit_15" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
+	(git rebase -i HEAD~3 || true)&&
+	cat >expected <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last command(s) done (1 command(s) done):
+   exec exit 15
+No command remaining.
+You are currently editing a commit while rebasing branch '\''several_c=
ommits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your change=
s)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=3Dno >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'status: two commands done, two remainings' '
+	FAKE_LINES=3D"1 exec_exit_15 2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
+	COMMIT4=3D$(git rev-parse HEAD) &&
+	COMMIT3=3D$(git rev-parse HEAD^) &&
+	COMMIT2=3D$(git rev-parse HEAD^^) &&
+	(git rebase -i HEAD~3 || true)&&
+	cat >expected <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last command(s) done (2 command(s) done):
+   pick $COMMIT2 two_commit
+   exec exit 15
+Next command(s) to do (2 remaining command(s)):
+   pick $COMMIT3 three_commit
+   pick $COMMIT4 four_commit
+  (use git rebase --edit-todo to view and edit)
+You are currently editing a commit while rebasing branch '\''several_c=
ommits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your change=
s)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=3Dno >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'status: more than two commands done, two remainin=
gs' '
+	FAKE_LINES=3D"1 2 exec_exit_15 3 4" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~4) &&
+	COMMIT4=3D$(git rev-parse HEAD) &&
+	COMMIT3=3D$(git rev-parse HEAD^) &&
+	COMMIT2=3D$(git rev-parse HEAD^^) &&
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
+You are currently editing a commit while rebasing branch '\''several_c=
ommits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your change=
s)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=3Dno >actual &&
+	test_i18ncmp expected actual
+'
+
 test_done
--=20
2.4.2.340.g37f3f38
