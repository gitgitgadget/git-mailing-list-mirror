From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 04/21] completion tests: consolidate getting path of current working directory
Date: Thu, 25 Feb 2016 23:50:33 +0100
Message-ID: <1456440650-32623-5-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:52:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4lb-0005uS-2e
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbcBYWwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:52:11 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35747 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807AbcBYWwL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:52:11 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4lR-0007uU-3d; Thu, 25 Feb 2016 23:52:06 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440726.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287453>

Some tests of the __gitdir() helper function use the $TRASH_DIRECTORY
variable in direct path comparisons.  In general this should be
avoided, because it might contain symbolic links.  There happens to be
no issues with this here, however, because those tests use
$TRASH_DIRECTORY both for specifying the expected result and for
specifying input which in turn is just 'echo'ed verbatim.

Other __gitdir() tests ask for the path of the trash directory by
running $(pwd -P) in each test, sometimes even twice in a single test.

Run $(pwd) only once at the beginning of the test script to store the
path of the trash directory in a variable, and use that variable in
all __gitdir() tests.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 46 ++++++++++++++++++++++---------------------=
---
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 9f591c361fab..447f57b89291 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -124,15 +124,22 @@ invalid_variable_name=3D'${foo.bar}'
=20
 actual=3D"$TRASH_DIRECTORY/actual"
=20
+if test_have_prereq MINGW
+then
+	ROOT=3D"$(pwd -W)"
+else
+	ROOT=3D"$(pwd)"
+fi
+
 test_expect_success 'setup for __gitdir tests' '
 	mkdir -p subdir/subsubdir &&
 	git init otherrepo
 '
=20
 test_expect_success '__gitdir - from command line (through $__git_dir)=
' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	echo "$ROOT/otherrepo/.git" >expected &&
 	(
-		__git_dir=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		__git_dir=3D"$ROOT/otherrepo/.git" &&
 		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
@@ -157,7 +164,7 @@ test_expect_success '__gitdir - .git directory in c=
wd' '
 '
=20
 test_expect_success '__gitdir - .git directory in parent' '
-	echo "$(pwd -P)/.git" >expected &&
+	echo "$ROOT/.git" >expected &&
 	(
 		cd subdir/subsubdir &&
 		__gitdir >"$actual"
@@ -175,7 +182,7 @@ test_expect_success '__gitdir - cwd is a .git direc=
tory' '
 '
=20
 test_expect_success '__gitdir - parent is a .git directory' '
-	echo "$(pwd -P)/.git" >expected &&
+	echo "$ROOT/.git" >expected &&
 	(
 		cd .git/refs/heads &&
 		__gitdir >"$actual"
@@ -184,9 +191,9 @@ test_expect_success '__gitdir - parent is a .git di=
rectory' '
 '
=20
 test_expect_success '__gitdir - $GIT_DIR set while .git directory in c=
wd' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	echo "$ROOT/otherrepo/.git" >expected &&
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		GIT_DIR=3D"$ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
 		__gitdir >"$actual"
 	) &&
@@ -194,9 +201,9 @@ test_expect_success '__gitdir - $GIT_DIR set while =
=2Egit directory in cwd' '
 '
=20
 test_expect_success '__gitdir - $GIT_DIR set while .git directory in p=
arent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	echo "$ROOT/otherrepo/.git" >expected &&
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		GIT_DIR=3D"$ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
 		cd subdir &&
 		__gitdir >"$actual"
@@ -206,24 +213,15 @@ test_expect_success '__gitdir - $GIT_DIR set whil=
e .git directory in parent' '
=20
 test_expect_success '__gitdir - non-existing $GIT_DIR' '
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/non-existing" &&
+		GIT_DIR=3D"$ROOT/non-existing" &&
 		export GIT_DIR &&
 		test_must_fail __gitdir
 	)
 '
=20
-function pwd_P_W () {
-	if test_have_prereq MINGW
-	then
-		pwd -W
-	else
-		pwd -P
-	fi
-}
-
 test_expect_success '__gitdir - gitfile in cwd' '
-	echo "$(pwd_P_W)/otherrepo/.git" >expected &&
-	echo "gitdir: $(pwd_P_W)/otherrepo/.git" >subdir/.git &&
+	echo "$ROOT/otherrepo/.git" >expected &&
+	echo "gitdir: $ROOT/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
@@ -233,8 +231,8 @@ test_expect_success '__gitdir - gitfile in cwd' '
 '
=20
 test_expect_success '__gitdir - gitfile in parent' '
-	echo "$(pwd_P_W)/otherrepo/.git" >expected &&
-	echo "gitdir: $(pwd_P_W)/otherrepo/.git" >subdir/.git &&
+	echo "$ROOT/otherrepo/.git" >expected &&
+	echo "gitdir: $ROOT/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
@@ -244,7 +242,7 @@ test_expect_success '__gitdir - gitfile in parent' =
'
 '
=20
 test_expect_success SYMLINKS '__gitdir - resulting path avoids symlink=
s' '
-	echo "$(pwd -P)/otherrepo/.git" >expected &&
+	echo "$ROOT/otherrepo/.git" >expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
 	ln -s otherrepo/dir link &&
@@ -259,7 +257,7 @@ test_expect_success SYMLINKS '__gitdir - resulting =
path avoids symlinks' '
 test_expect_success '__gitdir - not a git repository' '
 	(
 		cd subdir/subsubdir &&
-		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
+		GIT_CEILING_DIRECTORIES=3D"$ROOT" &&
 		export GIT_CEILING_DIRECTORIES &&
 		test_must_fail __gitdir
 	)
--=20
2.7.2.410.g92cb358
