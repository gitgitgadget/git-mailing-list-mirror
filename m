From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/3] t6050-replace: make failing editor test more robust
Date: Tue,  5 Jan 2016 11:33:30 +0100
Message-ID: <1451990010-15458-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 11:33:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGOvy-0006s6-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 11:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbcAEKdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2016 05:33:43 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49756 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456AbcAEKdl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2016 05:33:41 -0500
Received: from 94-21-29-97.pool.digikabel.hu ([94.21.29.97] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aGOvo-0008F7-KD; Tue, 05 Jan 2016 11:33:38 +0100
X-Mailer: git-send-email 2.7.0.rc2.34.g28a1f98
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1451990018.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283369>

'git replace --edit' should error out when the invoked editor fails,
but the test checking this behavior would not notice if this weren't
the case.

The test in question, ever since it was added in 85f98fc037ae
(replace: add tests for --edit, 2014-05-17), has simulated a failing
editor in an unconventional way:

  test_must_fail env GIT_EDITOR=3D'./fakeeditor;false' git replace --ed=
it

I presume the reason for this unconventional editor was the fact that
'git replace --edit' requires the edited object to be different from
the original, but a mere 'false' as editor would leave the object
unchanged and 'git replace --edit' would error out anyway complaining
about the new and the original object files being the same.  Running
'fakeeditor' before 'false' was supposed to ensure that the object
file is modified and thus 'git replace --edit' errors out because of
the failed editor.

However, this editor doesn't actually modify the edited object,
because start_command() turns this editor into:

  /bin/sh -c './fakeeditor;false "$@"' './fakeeditor;false' \
          '.../.git/REPLACE_EDITOBJ'

This means that the test's fakeeditor script doesn't even get the path
of the object to be edited as argument, triggering error messages from
the commands executed inside the script ('sed' and 'mv'), and
ultimately leaving the object file unchanged.

If a patch were to remove the die() from the error path after
launch_editor(), the test would not catch it, because 'git replace'
would continue execution past launch_editor() and would error out a
bit later due to the unchanged edited object.  Though 'git replace'
would error out for the wrong reason, this would satisfy
'test_must_fail' just as well, and the test would succeed leaving the
undesired change unnoticed.

Create a proper failing fake editor script for this test to ensure
that the edited object is in fact modified and 'git replace --edit'
won't error out because the new and original object files are the
same.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

Should we be more thorough, perhaps, and check the error message to be
extra sure that 'git replace --edit' errors out for the expected
reason?  There are oh so many 'test_must_fail's in our test scripts
and we don't check the error message in most of the cases...

I looked through the output of 'git grep GIT_EDITOR t/' and didn't
notice any other similar case where GIT_EDITOR consists of multiple
commands.

 t/t6050-replace.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 4d5a25eedfef..c630aba657e9 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -351,11 +351,15 @@ test_expect_success 'test --format long' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'setup a fake editor' '
-	write_script fakeeditor <<-\EOF
+test_expect_success 'setup fake editors' '
+	write_script fakeeditor <<-\EOF &&
 		sed -e "s/A U Thor/A fake Thor/" "$1" >"$1.new"
 		mv "$1.new" "$1"
 	EOF
+	write_script failingfakeeditor <<-\EOF
+		./fakeeditor "$@"
+		false
+	EOF
 '
=20
 test_expect_success '--edit with and without already replaced object' =
'
@@ -372,7 +376,7 @@ test_expect_success '--edit with and without alread=
y replaced object' '
 test_expect_success '--edit and change nothing or command failed' '
 	git replace -d "$PARA3" &&
 	test_must_fail env GIT_EDITOR=3Dtrue git replace --edit "$PARA3" &&
-	test_must_fail env GIT_EDITOR=3D"./fakeeditor;false" git replace --ed=
it "$PARA3" &&
+	test_must_fail env GIT_EDITOR=3D"./failingfakeeditor" git replace --e=
dit "$PARA3" &&
 	GIT_EDITOR=3D./fakeeditor git replace --edit "$PARA3" &&
 	git replace -l | grep "$PARA3" &&
 	git cat-file commit "$PARA3" | grep "A fake Thor"
--=20
2.7.0.rc2.34.g28a1f98
