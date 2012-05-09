From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 07/19] completion: make __gitdir() store repository path in
	$__git_dir
Date: Wed,  9 May 2012 02:44:38 +0200
Message-ID: <1336524290-30023-8-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv2j-00050T-Qm
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab2EIAqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:46:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52138 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab2EIAqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:46:05 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MNiNa-1SUdni2kh8-007JwC; Wed, 09 May 2012 02:46:04 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:acWpsSH+zuuyE10FiqF422fPgCYtFh+HQpVfT+jWtG2
 bX1OwtKs5r+4ZaRXduBt/+UcisdqMgD2y+Bq8yZi6ebhdSpVBQ
 2irnEkHE/1Uau1HALsBnRFCpj37b8ksGoTMTZI5jvLWtqAwoL6
 0lJWVKSgT+TFraRWAGBnE+hYAm4ghSolKhbQkLUNMLY0Gdb7KB
 XJRzunk+U8a+tDddabgLK8Y8tR38vLselLMbNQAPH/aCT200i0
 SKoBSQoll1b9muWUh/Auy/8QkuS2eOa3KgSgPuyf71YWqVpfTW
 KA7AuWFaPH83Ex2Z9ywk7HF0QPZcORpOnGAJ/rDpDWiVpdt2xZ
 Kzmdrv5j0/VLdMniMsgqhS+FFpUfw//+bc0fTkwk+w298ft9mN
 MPyr3cQWA7XfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197438>

The __gitdir() helper function is responsible for finding out the path
to the repository, and it's invoked from several completion (helper)
functions and from __git_ps1().  The path of the repository is printed
to stdout, therefore it's invoked in a command substitution.  This has
the following drawbacks:

  1. The command substitution involves the forking of a subshell,
     which has a considerable overhead.

  2. There are a few cases, where __gitdir() is called more than once
     during a single completion, which means multiple command
     substitutions and eventual multiple 'git rev-parse --git-dir'
     executions.  For example, __gitdir() is invoked twice during the
     completion of options for 'gitk', 'git log', 'git rebase', but
     for certain aliases it might be invoked three times.

Now, _git(), the top-level git completion function declares the local
$__git_dir variable for storing the repository path given as parameter
to the '--git-dir=3D' option.  Since $__git_dir is declared at the
top-level, it is already available in all completion functions, but
it's only used in __gitdir() (if set then there's no need to
autodetect the path to the repository).  This means that we can use
$__git_dir to always store the path to the repository found by
__gitdir().

This way we can address both of the above drawbacks.  We won't need
the command substitution when invoking __gitdir(), because won't need
__gitdir()'s output anymore: the path to the repository will be
available in $__git_dir.  Furthermore, onlyt the first __gitdir()
invocation will perform the search for the repository, and all
subsequent calls will see the path already stored in $__git_dir by the
first call.

So change __gitdir() to store the path to the repository in
$__git_dir.  However, still print the found path, because there might
be user-supplied completion functions relying on it.

Also declare $__git_dir as local in __git_ps1() and _gitk() to prevent
the variable from leaking into the environment when they call
__gitdir() (that would break completion and bash prompt when the user
moves to a different git repository).

=46inally, extend the __gitdir() tests to check the value of $__git_dir=
,
too.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 20 ++++----
 t/t9903-bash-prompt.sh                 | 85 +++++++++++++++++++++++---=
--------
 2 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index eaa3df9d..85b933f2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -71,25 +71,27 @@ case "$COMP_WORDBREAKS" in
 esac
=20
 # __gitdir accepts 0 or 1 arguments (i.e., location)
-# returns location of .git repo
+# Prints the path to the .git directory, and stores it in $__git_dir a=
s well.
 __gitdir ()
 {
 	if [ -z "${1-}" ]; then
 		if [ -n "${__git_dir-}" ]; then
-			echo "$__git_dir"
+			:
 		elif [ -n "${GIT_DIR-}" ]; then
 			test -d "${GIT_DIR-}" || return 1
-			echo "$GIT_DIR"
+			__git_dir=3D"$GIT_DIR"
 		elif [ -d .git ]; then
-			echo .git
+			__git_dir=3D.git
 		else
-			git rev-parse --git-dir 2>/dev/null
+			__git_dir=3D"$(git rev-parse --git-dir 2>/dev/null)" || return 1
 		fi
 	elif [ -d "$1/.git" ]; then
-		echo "$1/.git"
+		__git_dir=3D"$1/.git"
 	else
-		echo "$1"
+		__git_dir=3D"$1"
 	fi
+
+	echo "$__git_dir"
 }
=20
 # stores the divergence from upstream in $p
@@ -216,6 +218,7 @@ __git_ps1_show_upstream ()
 # returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
 {
+	local __git_dir=3D""
 	local g=3D"$(__gitdir)"
 	if [ -z "$g" ]; then
 		return
@@ -2606,7 +2609,7 @@ _git_whatchanged ()
=20
 _git ()
 {
-	local i c=3D1 command __git_dir
+	local i c=3D1 command __git_dir=3D""
=20
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
@@ -2690,6 +2693,7 @@ _gitk ()
=20
 	__git_has_doubledash && return
=20
+	local __git_dir=3D""
 	local g=3D"$(__gitdir)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 96468ceb..496e04ad 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -10,6 +10,7 @@ test_description=3D'test git-specific bash prompt fun=
ctions'
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
=20
 actual=3D"$TRASH_DIRECTORY/actual"
+actual_var=3D"$TRASH_DIRECTORY/actual_var"
=20
 test_expect_success 'setup for prompt tests' '
 	mkdir -p subdir/subsubdir &&
@@ -35,54 +36,74 @@ test_expect_success 'gitdir - from command line (th=
rough $__git_dir)' '
 	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
 	(
 		__git_dir=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - repo as argument' '
 	echo "otherrepo/.git" > expected &&
-	__gitdir "otherrepo" > "$actual" &&
-	test_cmp expected "$actual"
+	(
+		__gitdir "otherrepo" > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - remote as argument' '
 	echo "remote" > expected &&
-	__gitdir "remote" > "$actual" &&
-	test_cmp expected "$actual"
+	(
+		__gitdir "remote" > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - .git directory in cwd' '
 	echo ".git" > expected &&
-	__gitdir > "$actual" &&
-	test_cmp expected "$actual"
+	(
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - .git directory in parent' '
 	echo "$TRASH_DIRECTORY/.git" > expected &&
 	(
 		cd subdir/subsubdir &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - cwd is a .git directory' '
 	echo "." > expected &&
 	(
 		cd .git &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - parent is a .git directory' '
 	echo "$TRASH_DIRECTORY/.git" > expected &&
 	(
 		cd .git/refs/heads &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
@@ -90,9 +111,11 @@ test_expect_success 'gitdir - $GIT_DIR set while .g=
it directory in cwd' '
 	(
 		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
 		export GIT_DIR &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - $GIT_DIR set while .git directory in par=
ent' '
@@ -101,16 +124,19 @@ test_expect_success 'gitdir - $GIT_DIR set while =
=2Egit directory in parent' '
 		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
 		export GIT_DIR &&
 		cd subdir &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - non-existing $GIT_DIR' '
 	(
 		GIT_DIR=3D"$TRASH_DIRECTORY/non-existing" &&
 		export GIT_DIR &&
-		test_must_fail __gitdir
+		test_must_fail __gitdir &&
+		test -z "$__git_dir"
 	)
 '
=20
@@ -120,9 +146,11 @@ test_expect_success 'gitdir - gitfile in cwd' '
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - gitfile in parent' '
@@ -131,9 +159,11 @@ test_expect_success 'gitdir - gitfile in parent' '
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks'=
 '
@@ -144,9 +174,11 @@ test_expect_success SYMLINKS 'gitdir - resulting p=
ath avoids symlinks' '
 	test_when_finished "rm -f link" &&
 	(
 		cd link &&
-		__gitdir > "$actual"
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
 	) &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
 '
=20
 test_expect_success 'gitdir - not a git repository' '
@@ -154,7 +186,8 @@ test_expect_success 'gitdir - not a git repository'=
 '
 		cd subdir/subsubdir &&
 		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
 		export GIT_CEILING_DIRECTORIES &&
-		test_must_fail __gitdir
+		test_must_fail __gitdir &&
+		test -z "$__git_dir"
 	)
 '
=20
--=20
1.7.10.1.541.gb1be298
