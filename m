From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v6 4/4] status: add new tests for status during rebase -i
Date: Wed,  1 Jul 2015 23:08:36 +0200
Message-ID: <1435784916-15456-4-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqk2ujoadw.fsf@anie.imag.fr>
 <1435784916-15456-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 01 23:09:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAPFk-0004Oj-BH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 23:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbbGAVJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2015 17:09:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54721 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbbGAVI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 17:08:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t61L8mbY011157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jul 2015 23:08:48 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t61L8p4n025581;
	Wed, 1 Jul 2015 23:08:51 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZAPFT-0004hT-1H; Wed, 01 Jul 2015 23:08:51 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
In-Reply-To: <1435784916-15456-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 01 Jul 2015 23:08:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t61L8mbY011157
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436389733.70809@uKOI5imBZtc5L0pzHpijgQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273203>

=46rom: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-inp.fr>

Expand test coverage with one or more than two commands done
and with zero, one or more than two commands remaining.

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
No modification.

 t/t7512-status-help.sh | 87 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 87 insertions(+)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 9be0235..49d19a3 100755
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
+	COMMIT4=3D$(git rev-parse --short HEAD) &&
+	COMMIT3=3D$(git rev-parse --short HEAD^) &&
+	COMMIT2=3D$(git rev-parse --short HEAD^^) &&
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
+	COMMIT4=3D$(git rev-parse --short HEAD) &&
+	COMMIT3=3D$(git rev-parse --short HEAD^) &&
+	COMMIT2=3D$(git rev-parse --short HEAD^^) &&
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
2.5.0.rc0.7.ge1edd74.dirty
