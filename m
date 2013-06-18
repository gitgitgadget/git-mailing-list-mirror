From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 03/13] completion,
 bash prompt: move __gitdir() tests to completion test suite
Date: Tue, 18 Jun 2013 04:16:56 +0200
Message-ID: <1371521826-3225-4-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:17:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolUR-0005ia-Vh
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab3FRCRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:17:44 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:58903 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab3FRCRn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:17:43 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MMHYT-1UgosF0ASj-008at7; Tue, 18 Jun 2013 04:17:42 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:W09SQKZFqyiHTBXLKO1FGtjTae1L5ZzyGYM4upmyyny
 E7yXbdtH7uggtZUx5oGIu3viJLCeNcMx93Ql802ZLze6Hs7wrn
 ZwX2SoEQ9sNmeGz9Gvtf7Lzojqx/ZsCnlzRO9C6O/oO4wOy2nc
 DAzgcSrcLqnlZaX8f9tSf+VzunA8wzRtHK3lqMrGo3xbsSU6Ut
 Ra8Rwx774ZiO9Fbet3ShVUcIYTN9vCX/hh8HjKCZacMdYDly4R
 HCaK3oi9rp/rBc2BBRmejN6ST05grEk4v/c/TUD6I0W+yIZXS4
 rhHhFrkgI1qnM8/4ebahTVslglHE+l9MuQaiOiTRFoclM3SoDS
 nYqHOtNMXrto9Hru9VsqU36DlojOn2TLeeBMifZmCH/bgg90Om
 o+B+RyJkBKdDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228135>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Currently __gitdir() is duplicated in the git completion and prompt
scripts, while its tests are in the prompt test suite.  This patch
series is about to change __git_ps1() in a way that it won't need
__gitdir() anymore and __gitdir() will be removed from the prompt
script.

So move all __gitdir() test from the prompt test suite over to the
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
index b0af5d5f..1047c664 100755
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
1.8.3.1.487.g8f4672d
