From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash prompt: test the prompt with newline in repository path
Date: Fri, 16 Aug 2013 12:36:35 +0200
Message-ID: <1376649395-24363-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 12:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAHPg-0007Sx-JG
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 12:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab3HPKhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 06:37:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:61569 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab3HPKhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 06:37:39 -0400
Received: from localhost6.localdomain6 (f051096090.adsl.alicedsl.de [78.51.96.90])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MEg6X-1VLcCW2CPB-00FiDZ; Fri, 16 Aug 2013 12:37:37 +0200
X-Mailer: git-send-email 1.8.3.3.824.gb0ea0e3
X-Provags-ID: V02:K0:xQCX1RoDIU7mtqRvppNBs62jJlebSSlV4y1kIdHMQSp
 9y7eDUret7+RZSRzJBSJSzV7SuU3vOirm3jQE29Ts+HTIqz/N/
 CKBaEwugKNlv8PsasToO11soUrDDFLAJhStWskFnfSud6//625
 S7hbRXtiMQWmjo6zniEX1TSHLMETWa03iUWfA0A5Nx8LB1+lQ6
 pggBuGiNwtTPUoYJ1Qw+pXb74PLE0pvRfnh9Zh/8LPOSqeF7ZS
 ywytZHeXmyVOIJDLTja7lJWD5GKa7cGW+7xP37kbWEAb22lBki
 l7HPF8/hHxQrO6PdKo01zFrMa+NRtJKPQbIoTf2yVQ0KxhxXgj
 8GsR0Y79adW9r+TIuW2LlVGjd+QWeJoieUc/8opvcfeHhezDmu
 2EvbEJ9y1kzEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232415>

Newlines in the path to a git repository were not an issue for the
git-specific bash prompt before commit efaa0c1532 (bash prompt:
combine 'git rev-parse' executions in the main code path, 2013-06-17),
because the path returned by 'git rev-parse --git-dir' was directly
stored in a variable, and this variable was later always accessed
inside double quotes.

Newlines are not an issue after commit efaa0c1532 either, but it's
more subtle.  Since efaa0c1532 we use the following single 'git
rev-parse' execution to query various info about the repository:

  git rev-parse --git-dir --is-inside-git-dir \
          --is-bare-repository --is-inside-work-tree

The results to these queries are separated by a newline character in
the output, e.g.:

  /home/szeder/src/git/.git
  false
  false
  true

A newline in the path to the git repository could potentially break
the parsing of these results and ultimately the bash prompt, unless
the parsing is done right.  Commit efaa0c1532 got it right, as I
consciously started parsing 'git rev-parse's output from the end,
where each record is a single line containing either 'true' or 'false'
or, after e3e0b9378b (bash prompt: combine 'git rev-parse' for
detached head, 2013-06-24), the abbreviated commit object name, and
all what remains at the beginning is the path to the git repository,
no matter how many lines it is.

This subtlety really warrants its own test, especially since I didn't
explait it in the log message or in an in-code comment back then, so
add a test to excercise the prompt with newline characters in the path
to the repository.  Note that 'git rev-parse --git-dir' prints '.git'
or '.' when at the top of the worktree or the repository,
respectively, and only prints the full path to the repository when in
a subdirectory, hence the need for changing into a subdir in the test.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 3c3e4e8c38..dfe2088ef4 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -61,6 +61,22 @@ test_expect_success 'prompt - unborn branch' '
 	test_cmp expected "$actual"
 '
=20
+repo_with_newline=3D'repo
+with
+newline'
+
+test_expect_success 'prompt - with newline in path' '
+	printf " (master)" >expected &&
+	git init "$repo_with_newline" &&
+	test_when_finished "rm -rf \"$repo_with_newline\"" &&
+	mkdir "$repo_with_newline"/subdir &&
+	(
+		cd "$repo_with_newline/subdir" &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - detached head' '
 	printf " ((%s...))" $(git log -1 --format=3D"%h" --abbrev=3D13 b1^) >=
expected &&
 	test_config core.abbrev 13 &&
--=20
1.8.3.3.824.gb0ea0e3
