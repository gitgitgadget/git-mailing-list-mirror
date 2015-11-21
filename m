From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/3] bash prompt: test dirty index and worktree while on an orphan branch
Date: Sat, 21 Nov 2015 12:30:07 +0100
Message-ID: <1448105409-4494-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 21 12:31:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a06OD-0006Qt-CV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 12:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbbKULbQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2015 06:31:16 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52714 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754268AbbKULaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2015 06:30:25 -0500
Received: from x4db28c43.dyn.telefonica.de ([77.178.140.67] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a06Mx-0003r7-Ka; Sat, 21 Nov 2015 12:30:17 +0100
X-Mailer: git-send-email 2.6.3.402.geb6a0f7
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1448105417.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281554>

There is only a single test exercising the dirty state indicator on an
orphan branch, and in that test neither the index nor the worktree are
dirty.

Add two failing tests to check the dirty state indicator while either
the index is dirty or while both the index and the worktree are dirty
on an orphan branch, and to show that the dirtiness of the index is
not displayed in these cases (the forth combination, i.e. clean index
and dirty worktree are impossible on an orphan branch).  Update the
existing dirty state indicator on clean orphan branch test to match
the style of the two new tests, most importantly to use 'git checkout
--orphan' instead of cd-ing into a repository that just happens to be
empty and clean.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6b68777b98..2c9d1f928a 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -273,11 +273,36 @@ test_expect_success 'prompt - dirty status indica=
tor - dirty index and worktree'
 	test_cmp expected "$actual"
 '
=20
-test_expect_success 'prompt - dirty status indicator - before root com=
mit' '
-	printf " (master #)" >expected &&
+test_expect_success 'prompt - dirty status indicator - orphan branch -=
 clean' '
+	printf " (orphan #)" >expected &&
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	git reset --hard &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure 'prompt - dirty status indicator - orphan branch -=
 dirty index' '
+	printf " (orphan +)" >expected &&
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure 'prompt - dirty status indicator - orphan branch -=
 dirty index and worktree' '
+	printf " (orphan *+)" >expected &&
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	>file &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		cd otherrepo &&
 		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
--=20
2.6.3.402.geb6a0f7
