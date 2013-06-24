From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 03/16] completion,
 bash prompt: move __gitdir() tests to completion test suite
Date: Mon, 24 Jun 2013 18:39:13 +0200
Message-ID: <1372091966-19315-4-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:43:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9rE-0002hJ-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab3FXQnI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:43:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:56275 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab3FXQnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:43:07 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Lj7Eo-1UHYBj3VPS-00dUV3; Mon, 24 Jun 2013 18:43:06 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:ydFFyTsBtGrDBI7LR3rNo8HiLnD1zOSGsHtN4Y0de7P
 ucRc+PGT5DQpNSNcsasw+KQoeFG9oQvJVmYwBhSFwRdu08PHoe
 8cxW9GD5sRfoAHAyhz0gXR2lAJroDPynPP25Ztgdwj+/WPSxEI
 9481qAvKTmT2qeyC9OF/d0ED3N2Voyqr/FTMEbM4jmxtDGNDM1
 30sWX2tnJSZwy7OF9SHOid3usZHlrWzv2phy2MkYoeb8PZepEK
 jgUd5b5Oz6tjnqU7GlNlMH19/Hxb3+W2fruBtmfvRcTk1DJ3za
 8xvJLqt7o9ftGcOWMKRoGHvOPwdgsVCRxYRZUw3AA7rzdys3mq
 WIVBZIw7RDrOGScr/CtueRiYtG2UCBQ3aPo6Xi5rTivifEZ9UG
 SB7QzJYE6V8Xw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228854>

Currently __gitdir() is duplicated in the git completion and prompt
scripts, while its tests are in the prompt test suite.  This patch
series is about to change __git_ps1() in a way that it won't need
__gitdir() anymore and __gitdir() will be removed from the prompt
script.

So move all __gitdir() tests from the prompt test suite over to the
completion test suite.  Update the setup tests so that they perform
only those steps that are necessary for each test suite.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh  | 134 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t9903-bash-prompt.sh | 128 -----------------------------------------=
-----
 2 files changed, 134 insertions(+), 128 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 81a1657e..5469dee8 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -122,6 +122,140 @@ test_gitcomp_nl ()
=20
 invalid_variable_name=3D'${foo.bar}'
=20
+actual=3D"$TRASH_DIRECTORY/actual"
+
+test_expect_success 'setup for __gitdir tests' '
+	mkdir -p subdir/subsubdir &&
+	git init otherrepo
+'
+
+test_expect_success '__gitdir - from command line (through $__git_dir)=
' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	(
+		__git_dir=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - repo as argument' '
+	echo "otherrepo/.git" >expected &&
+	__gitdir "otherrepo" >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - remote as argument' '
+	echo "remote" >expected &&
+	__gitdir "remote" >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - .git directory in cwd' '
+	echo ".git" >expected &&
+	__gitdir >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - .git directory in parent' '
+	echo "$(pwd -P)/.git" >expected &&
+	(
+		cd subdir/subsubdir &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - cwd is a .git directory' '
+	echo "." >expected &&
+	(
+		cd .git &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - parent is a .git directory' '
+	echo "$(pwd -P)/.git" >expected &&
+	(
+		cd .git/refs/heads &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - $GIT_DIR set while .git directory in c=
wd' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	(
+		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		export GIT_DIR &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - $GIT_DIR set while .git directory in p=
arent' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	(
+		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		export GIT_DIR &&
+		cd subdir &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - non-existing $GIT_DIR' '
+	(
+		GIT_DIR=3D"$TRASH_DIRECTORY/non-existing" &&
+		export GIT_DIR &&
+		test_must_fail __gitdir
+	)
+'
+
+test_expect_success '__gitdir - gitfile in cwd' '
+	echo "$(pwd -P)/otherrepo/.git" >expected &&
+	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
+	test_when_finished "rm -f subdir/.git" &&
+	(
+		cd subdir &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - gitfile in parent' '
+	echo "$(pwd -P)/otherrepo/.git" >expected &&
+	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
+	test_when_finished "rm -f subdir/.git" &&
+	(
+		cd subdir/subsubdir &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success SYMLINKS '__gitdir - resulting path avoids symlink=
s' '
+	echo "$(pwd -P)/otherrepo/.git" >expected &&
+	mkdir otherrepo/dir &&
+	test_when_finished "rm -rf otherrepo/dir" &&
+	ln -s otherrepo/dir link &&
+	test_when_finished "rm -f link" &&
+	(
+		cd link &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - not a git repository' '
+	(
+		cd subdir/subsubdir &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
+		export GIT_CEILING_DIRECTORIES &&
+		test_must_fail __gitdir
+	)
+'
+
 test_expect_success '__gitcomp - trailing space - options' '
 	test_gitcomp "--re" "--dry-run --reuse-message=3D --reedit-message=3D
 		--reset-author" <<-EOF
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 442b9a20..df36239a 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -12,7 +12,6 @@ test_description=3D'test git-specific bash prompt fun=
ctions'
 actual=3D"$TRASH_DIRECTORY/actual"
=20
 test_expect_success 'setup for prompt tests' '
-	mkdir -p subdir/subsubdir &&
 	git init otherrepo &&
 	echo 1 >file &&
 	git add file &&
@@ -35,133 +34,6 @@ test_expect_success 'setup for prompt tests' '
 	git checkout master
 '
=20
-test_expect_success 'gitdir - from command line (through $__git_dir)' =
'
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
-	(
-		__git_dir=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - repo as argument' '
-	echo "otherrepo/.git" >expected &&
-	__gitdir "otherrepo" >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - remote as argument' '
-	echo "remote" >expected &&
-	__gitdir "remote" >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - .git directory in cwd' '
-	echo ".git" >expected &&
-	__gitdir >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - .git directory in parent' '
-	echo "$(pwd -P)/.git" >expected &&
-	(
-		cd subdir/subsubdir &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - cwd is a .git directory' '
-	echo "." >expected &&
-	(
-		cd .git &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - parent is a .git directory' '
-	echo "$(pwd -P)/.git" >expected &&
-	(
-		cd .git/refs/heads &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
-	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
-		export GIT_DIR &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - $GIT_DIR set while .git directory in par=
ent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
-	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
-		export GIT_DIR &&
-		cd subdir &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - non-existing $GIT_DIR' '
-	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/non-existing" &&
-		export GIT_DIR &&
-		test_must_fail __gitdir
-	)
-'
-
-test_expect_success 'gitdir - gitfile in cwd' '
-	echo "$(pwd -P)/otherrepo/.git" >expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
-	test_when_finished "rm -f subdir/.git" &&
-	(
-		cd subdir &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - gitfile in parent' '
-	echo "$(pwd -P)/otherrepo/.git" >expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
-	test_when_finished "rm -f subdir/.git" &&
-	(
-		cd subdir/subsubdir &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks'=
 '
-	echo "$(pwd -P)/otherrepo/.git" >expected &&
-	mkdir otherrepo/dir &&
-	test_when_finished "rm -rf otherrepo/dir" &&
-	ln -s otherrepo/dir link &&
-	test_when_finished "rm -f link" &&
-	(
-		cd link &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'gitdir - not a git repository' '
-	(
-		cd subdir/subsubdir &&
-		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
-		export GIT_CEILING_DIRECTORIES &&
-		test_must_fail __gitdir
-	)
-'
-
 test_expect_success 'prompt - branch name' '
 	printf " (master)" >expected &&
 	__git_ps1 >"$actual" &&
--=20
1.8.3.1.599.g4459181
