From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH 4/4] status: add new tests for status during rebase -i
Date: Tue,  9 Jun 2015 16:42:42 +0200
Message-ID: <1433860962-13222-4-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
References: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 16:43:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Kk3-0004XY-A9
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbbFIOm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 10:42:56 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:36298 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932544AbbFIOmu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 10:42:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 7396B48885;
	Tue,  9 Jun 2015 16:42:49 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oxCTe9+gZUsb; Tue,  9 Jun 2015 16:42:49 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4F9F348800;
	Tue,  9 Jun 2015 16:42:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 4CAD620E2;
	Tue,  9 Jun 2015 16:42:49 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qpEMfirOV6Pj; Tue,  9 Jun 2015 16:42:49 +0200 (CEST)
Received: from guillaume-W35-37ET.grenet.fr (wificampus-028068.grenet.fr [130.190.28.68])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 336BF20DC;
	Tue,  9 Jun 2015 16:42:49 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.342.ga3499d3
In-Reply-To: <1433860962-13222-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271186>

Expand test coverage with one or more than two commands done
and with zero, one or more than two commands remaining.

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
---
 t/t7512-status-help.sh | 87 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 87 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 0c889fa..cbe27f9 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -856,4 +856,91 @@ EOF
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
+test_expect_success 'status: one command done nothing remaining' '
+	FAKE_LINES=3D"exec_exit_15" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
+	test_must_fail git rebase -i HEAD~3 &&
+	cat >expected <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last command done (1 command done):
+   exec exit 15
+No commands remaining.
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
+test_expect_success 'status: two commands done with some white lines i=
n done file' '
+	FAKE_LINES=3D"1 > exec_exit_15  2 3" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~3) &&
+	COMMIT4=3D$(git rev-parse HEAD) &&
+	COMMIT3=3D$(git rev-parse HEAD^) &&
+	COMMIT2=3D$(git rev-parse HEAD^^) &&
+	test_must_fail git rebase -i HEAD~3 &&
+	cat >expected <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last commands done (2 commands done):
+   pick $COMMIT2 two_commit
+   exec exit 15
+Next commands to do (2 remaining commands):
+   pick $COMMIT3 three_commit
+   pick $COMMIT4 four_commit
+  (use "git rebase --edit-todo" to view and edit)
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
+test_expect_success 'status: two remaining commands with some white li=
nes in todo file' '
+	FAKE_LINES=3D"1 2 exec_exit_15 3 > 4" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=3D$(git rev-parse --short HEAD~4) &&
+	COMMIT4=3D$(git rev-parse HEAD) &&
+	COMMIT3=3D$(git rev-parse HEAD^) &&
+	COMMIT2=3D$(git rev-parse HEAD^^) &&
+	test_must_fail git rebase -i HEAD~4 &&
+	cat >expected <<EOF &&
+interactive rebase in progress; onto $ONTO
+Last commands done (3 commands done):
+   pick $COMMIT2 two_commit
+   exec exit 15
+  (see more in file .git/rebase-merge/done)
+Next commands to do (2 remaining commands):
+   pick $COMMIT3 three_commit
+   pick $COMMIT4 four_commit
+  (use "git rebase --edit-todo" to view and edit)
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
2.4.2.342.ga3499d3
