From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2] bash prompt: test the prompt with newline in repository
 path
Date: Sat, 17 Aug 2013 11:01:58 +0200
Message-ID: <1376730118-11102-1-git-send-email-szeder@ira.uka.de>
References: <520E7A81.5080302@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 11:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAcOl-0002a1-T2
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 11:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab3HQJCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Aug 2013 05:02:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:62201 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab3HQJCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 05:02:10 -0400
Received: from localhost6.localdomain6 (f051130156.adsl.alicedsl.de [78.51.130.156])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MXXss-1VdmXZ3Aco-00WYCv; Sat, 17 Aug 2013 11:02:08 +0200
X-Mailer: git-send-email 1.8.4.rc3.31.g0f99442
In-Reply-To: <520E7A81.5080302@kdbg.org>
X-Provags-ID: V02:K0:54VDOOOxCWbvhfQSiMdWuDxRF1MOI625EoZScxRQ2ne
 eXGNRBc0WuGNzdovmwRbXMyI2rlwAg9fHKBNjXkyjj8tBK8xmF
 Zg+W7YOr5Wb2yK70iUnFc9R8QYHajh6XbbDm2pOsXrHvEoIaUI
 tPy1YwLM4BKNCaw7omfE3LtuUUNp1LkntYxnemeknozodiiSjI
 oqEQ8CXSBJcN+uHbtRm+qC5yxtRdgWe+/hD/IfLpJMq1Hcv+oX
 yPG14qpxGciS9xOCRTpTRGWXZ4+F9RBT76a1+ACdmkYo2RMy4l
 8rqVFWrAHRg39dMBoQcUOG11G5yduN1PffuOGZjlZwbnLfMcCW
 9+RVF7UYK0cbVS3ByYPHuWIwzfIAojhUp0tH5eqUrVEV/7aQvy
 2MyfS7aiqmJVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232454>

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
explain it in the log message or in an in-code comment back then, so
add a test to excercise the prompt with newline characters in the path
to the repository.  Guard this test with the FUNNYNAMES prerequisite,
because not all filesystems support newlines in filenames.  Note that
'git rev-parse --git-dir' prints '.git' or '.' when at the top of the
worktree or the repository, respectively, and only prints the full
path to the repository when in a subdirectory, hence the need for
changing into a subdir in the test.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

Added FUNNYNAMES prerequisite and Eric's typofix.

 t/t9903-bash-prompt.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 3c3e4e8c38..59f875e830 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -61,6 +61,29 @@ test_expect_success 'prompt - unborn branch' '
 	test_cmp expected "$actual"
 '
=20
+repo_with_newline=3D'repo
+with
+newline'
+
+if mkdir "$repo_with_newline" 2>/dev/null
+then
+	test_set_prereq FUNNYNAMES
+else
+	say 'Your filesystem does not allow newlines in filenames.'
+fi
+
+test_expect_success FUNNYNAMES 'prompt - with newline in path' '
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
1.8.4.rc3.31.g0f99442
