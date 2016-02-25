From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 21/21] completion: cache the path to the repository
Date: Thu, 25 Feb 2016 23:50:50 +0100
Message-ID: <1456440650-32623-22-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:54:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4o4-0007Z9-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbcBYWyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:54:31 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35905 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741AbcBYWya (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:54:30 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4nh-0007uU-CS; Thu, 25 Feb 2016 23:54:27 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440867.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287470>

After the previous changes in this series there are only a handful of
$(__gitdir) command substitutions left in the completion script, but
there is still a bit of room for improvements:

  1. The command substitution involves the forking of a subshell,
     which has considerable overhead on some platforms.

  2. There are a few cases, where this command substitution is
     executed more than once during a single completion, which means
     multiple subshells and possibly multiple 'git rev-parse'
     executions.  __gitdir() is invoked twice while completing refs
     for e.g. 'git log', 'git rebase', 'gitk', or while completing
     remote refs for 'git fetch' or 'git push'.

Both of these points can be addressed by using the
__git_find_repo_path() helper function introduced in the previous
commit:

  1. __git_find_repo_path() stores the path to the repository in a
     variable instead of printing it, so the command substitution
     around the function can be avoided.  Or rather: the command
     substitution should be avoided to make the new value of the
     variable set inside the function visible to the callers.
     (Yes, there is now a command substitution inside
     __git_find_repo_path() around each 'git rev-parse', but that's
     executed only if necessary, and only once per completion, see
     point 2. below.)

  2. $__git_repo_path, the variable holding the path to the
     repository, is declared local in the toplevel completion
     functions __git_main() and __gitk_main().  Thus, once set, the
     path is visible in all completion functions, including all
     subsequent calls to __git_find_repo_path(), meaning that they
     wouldn't have to re-discover the path to the repository.

So call __git_find_repo_path() and use $__git_repo_path instead of the
$(__gitdir) command substitution to access paths in the .git
directory.  Turn tests checking __gitdir()'s repository discovery into
tests of __git_find_repo_path() such that only the tested function
changes but the expected results don't, ensuring that repo discovery
keeps working as it did before.

As __gitdir() is not used anymore in the completion script, mark it as
deprecated and direct users' attention to __git_find_repo_path() and
$__git_repo_path.  Yet keep four __gitdir() tests to ensure that it
handles success and failure of __git_find_repo_path() and that it
still handles its optional remote argument.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |  46 ++++++----
 t/t9902-completion.sh                  | 155 +++++++++++++++++++++----=
--------
 2 files changed, 126 insertions(+), 75 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 69000a33bcfa..7300a2b64bab 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -39,6 +39,11 @@ esac
 # variable.
 __git_find_repo_path ()
 {
+	if [ -n "$__git_repo_path" ]; then
+		# we already know where it is
+		return
+	fi
+
 	if [ -n "${__git_C_args-}" ]; then
 		__git_repo_path=3D"$(git "${__git_C_args[@]}" \
 			${__git_dir:+--git-dir=3D"$__git_dir"} \
@@ -56,6 +61,7 @@ __git_find_repo_path ()
 	fi
 }
=20
+# Deprecated: use __git_find_repo_path() and $__git_repo_path instead
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
@@ -350,10 +356,13 @@ __git_tags ()
 #    'git checkout's tracking DWIMery (optional; ignored, if set but e=
mpty).
 __git_refs ()
 {
-	local i hash dir=3D"$(__gitdir)" track=3D"${2-}"
+	local i hash dir track=3D"${2-}"
 	local from_local=3Dy remote=3D"${1-}" named_remote=3Dn
 	local format refs
=20
+	__git_find_repo_path
+	dir=3D"$__git_repo_path"
+
 	if [ -z "$dir" ] && [ -z "$remote" ]; then
 		return
 	fi
@@ -460,8 +469,8 @@ __git_refs_remotes ()
=20
 __git_remotes ()
 {
-	local d=3D"$(__gitdir)"
-	test -d "$d/remotes" && ls -1 "$d/remotes"
+	__git_find_repo_path
+	test -d "$__git_repo_path/remotes" && ls -1 "$__git_repo_path/remotes=
"
 	__git remote
 }
=20
@@ -915,8 +924,8 @@ __git_whitespacelist=3D"nowarn warn error error-all=
 fix"
=20
 _git_am ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ]; then
+	__git_find_repo_path
+	if [ -d "$__git_repo_path"/rebase-apply ]; then
 		__gitcomp "--skip --continue --resolved --abort"
 		return
 	fi
@@ -999,7 +1008,8 @@ _git_bisect ()
 	local subcommands=3D"start bad good skip reset visualize replay log r=
un"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
-		if [ -f "$(__gitdir)"/BISECT_START ]; then
+		__git_find_repo_path
+		if [ -f "$__git_repo_path"/BISECT_START ]; then
 			__gitcomp "$subcommands"
 		else
 			__gitcomp "replay start"
@@ -1104,8 +1114,8 @@ _git_cherry ()
=20
 _git_cherry_pick ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
+	__git_find_repo_path
+	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
 		__gitcomp "--continue --quit --abort"
 		return
 	fi
@@ -1486,10 +1496,10 @@ __git_log_date_formats=3D"relative iso8601 rfc2=
822 short local default raw"
 _git_log ()
 {
 	__git_has_doubledash && return
+	__git_find_repo_path
=20
-	local g=3D"$(__gitdir)"
 	local merge=3D""
-	if [ -f "$g/MERGE_HEAD" ]; then
+	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
 		merge=3D"--merge"
 	fi
 	case "$cur" in
@@ -1727,11 +1737,12 @@ _git_push ()
=20
 _git_rebase ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -f "$dir"/rebase-merge/interactive ]; then
+	__git_find_repo_path
+	if [ -f "$__git_repo_path"/rebase-merge/interactive ]; then
 		__gitcomp "--continue --skip --abort --edit-todo"
 		return
-	elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+	elif [ -d "$__git_repo_path"/rebase-apply ] || \
+	     [ -d "$__git_repo_path"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
@@ -2355,8 +2366,8 @@ _git_reset ()
=20
 _git_revert ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -f "$dir"/REVERT_HEAD ]; then
+	__git_find_repo_path
+	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
 		__gitcomp "--continue --quit --abort"
 		return
 	fi
@@ -2720,9 +2731,10 @@ __gitk_main ()
 	__git_has_doubledash && return
=20
 	local __git_repo_path
-	local g=3D"$(__gitdir)"
+	__git_find_repo_path
+
 	local merge=3D""
-	if [ -f "$g/MERGE_HEAD" ]; then
+	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
 		merge=3D"--merge"
 	fi
 	case "$cur" in
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d44e72066328..458850641635 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -131,213 +131,216 @@ else
 	ROOT=3D"$(pwd)"
 fi
=20
-test_expect_success 'setup for __gitdir tests' '
+test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
 	mkdir -p subdir/subsubdir &&
 	git init otherrepo
 '
=20
-test_expect_success '__gitdir - from command line (through $__git_dir)=
' '
+test_expect_success '__git_find_repo_path - from command line (through=
 $__git_dir)' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		__git_dir=3D"$ROOT/otherrepo/.git" &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success '__gitdir - repo as argument' '
-	echo "otherrepo/.git" >expected &&
-	(
-		__gitdir "otherrepo" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success '__gitdir - remote as argument' '
-	echo "remote" >expected &&
-	(
-		__gitdir "remote" >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - .git directory in cwd' '
+test_expect_success '__git_find_repo_path - .git directory in cwd' '
 	echo ".git" >expected &&
 	(
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - .git directory in parent' '
+test_expect_success '__git_find_repo_path - .git directory in parent' =
'
 	echo "$ROOT/.git" >expected &&
 	(
 		cd subdir/subsubdir &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - cwd is a .git directory' '
+test_expect_success '__git_find_repo_path - cwd is a .git directory' '
 	echo "." >expected &&
 	(
 		cd .git &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - parent is a .git directory' '
+test_expect_success '__git_find_repo_path - parent is a .git directory=
' '
 	echo "$ROOT/.git" >expected &&
 	(
 		cd .git/refs/heads &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - $GIT_DIR set while .git directory in c=
wd' '
+test_expect_success '__git_find_repo_path - $GIT_DIR set while .git di=
rectory in cwd' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		GIT_DIR=3D"$ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - $GIT_DIR set while .git directory in p=
arent' '
+test_expect_success '__git_find_repo_path - $GIT_DIR set while .git di=
rectory in parent' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		GIT_DIR=3D"$ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
 		cd subdir &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - from command line while "git -C"' '
+test_expect_success '__git_find_repo_path - from command line while "g=
it -C"' '
 	echo "$ROOT/.git" >expected &&
 	(
 		__git_dir=3D"$ROOT/.git" &&
 		__git_C_args=3D(-C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - relative dir from command line and "gi=
t -C"' '
+test_expect_success '__git_find_repo_path - relative dir from command =
line and "git -C"' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		cd subdir &&
 		__git_dir=3D"otherrepo/.git" &&
 		__git_C_args=3D(-C ..) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - $GIT_DIR set while "git -C"' '
+test_expect_success '__git_find_repo_path - $GIT_DIR set while "git -C=
"' '
 	echo "$ROOT/.git" >expected &&
 	(
 		GIT_DIR=3D"$ROOT/.git" &&
 		export GIT_DIR &&
 		__git_C_args=3D(-C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - relative dir in $GIT_DIR and "git -C"'=
 '
+test_expect_success '__git_find_repo_path - relative dir in $GIT_DIR a=
nd "git -C"' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		cd subdir &&
 		GIT_DIR=3D"otherrepo/.git" &&
 		export GIT_DIR &&
 		__git_C_args=3D(-C ..) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - "git -C" while .git directory in cwd' =
'
+test_expect_success '__git_find_repo_path - "git -C" while .git direct=
ory in cwd' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		__git_C_args=3D(-C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - "git -C" while cwd is a .git directory=
' '
+test_expect_success '__git_find_repo_path - "git -C" while cwd is a .g=
it directory' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		cd .git &&
 		__git_C_args=3D(-C .. -C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - "git -C" while .git directory in paren=
t' '
+test_expect_success '__git_find_repo_path - "git -C" while .git direct=
ory in parent' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		cd subdir &&
 		__git_C_args=3D(-C .. -C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - non-existing path in "git -C"' '
+test_expect_success '__git_find_repo_path - non-existing path in "git =
-C"' '
 	(
 		__git_C_args=3D(-C non-existing) &&
-		test_must_fail __gitdir >"$actual"
+		test_must_fail __git_find_repo_path &&
+		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
=20
-test_expect_success '__gitdir - non-existing path in $__git_dir' '
+test_expect_success '__git_find_repo_path - non-existing path in $__gi=
t_dir' '
 	(
 		__git_dir=3D"non-existing" &&
-		test_must_fail __gitdir >"$actual"
+		test_must_fail __git_find_repo_path &&
+		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
=20
-test_expect_success '__gitdir - non-existing $GIT_DIR' '
+test_expect_success '__git_find_repo_path - non-existing $GIT_DIR' '
 	(
 		GIT_DIR=3D"$ROOT/non-existing" &&
 		export GIT_DIR &&
-		test_must_fail __gitdir >"$actual"
+		test_must_fail __git_find_repo_path &&
+		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
=20
-test_expect_success '__gitdir - gitfile in cwd' '
+test_expect_success '__git_find_repo_path - gitfile in cwd' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	echo "gitdir: $ROOT/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - gitfile in parent' '
+test_expect_success '__git_find_repo_path - gitfile in parent' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	echo "gitdir: $ROOT/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success SYMLINKS '__gitdir - resulting path avoids symlink=
s' '
+test_expect_success SYMLINKS '__git_find_repo_path - resulting path av=
oids symlinks' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
@@ -345,21 +348,57 @@ test_expect_success SYMLINKS '__gitdir - resultin=
g path avoids symlinks' '
 	test_when_finished "rm -f link" &&
 	(
 		cd link &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
-test_expect_success '__gitdir - not a git repository' '
+test_expect_success '__git_find_repo_path - not a git repository' '
 	(
 		cd subdir/subsubdir &&
 		GIT_CEILING_DIRECTORIES=3D"$ROOT" &&
 		export GIT_CEILING_DIRECTORIES &&
+		test_must_fail __git_find_repo_path &&
+		printf "$__git_repo_path" >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success '__gitdir - finds repo' '
+	echo "$ROOT/.git" >expected &&
+	(
+		cd subdir/subsubdir &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+
+test_expect_success '__gitdir - returns error when cant find repo' '
+	(
+		__git_dir=3D"non-existing" &&
 		test_must_fail __gitdir >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
=20
+test_expect_success '__gitdir - repo as argument' '
+	echo "otherrepo/.git" >expected &&
+	(
+		__gitdir "otherrepo" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - remote as argument' '
+	echo "remote" >expected &&
+	(
+		__gitdir "remote" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__gitcomp - trailing space - options' '
 	test_gitcomp "--re" "--dry-run --reuse-message=3D --reedit-message=3D
 		--reset-author" <<-EOF
--=20
2.7.2.410.g92cb358
