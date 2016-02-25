From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 16/21] completion: respect 'git -C <path>'
Date: Thu, 25 Feb 2016 23:50:45 +0100
Message-ID: <1456440650-32623-17-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:54:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4nG-0006z7-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbcBYWxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:53:55 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35855 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWxy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:53:54 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4n7-0007uU-I6; Thu, 25 Feb 2016 23:53:51 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440831.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287465>

'git -C <path>' option(s) on the command line should be taken into
account during completion, because

  - like '--git-dir=3D<path>', it can lead us to a different repository=
,
    and

  - a few git commands executed in the completion script do actually
    care about from which directory they are executed from.

However, unlike '--git-dir=3D<path>', the '-C <path>' option can be
specified multiple times and their effect is cumulative, so we can't
just store a single '<path>' in a variable.  Nor can we simply
concatenate a path from '-C <path1> -C <path2> ...', because e.g. (in
an arguably pathological corner case) a relative path might be
followed by an absolute path.

Instead, store all '-C <path>' options word by word in the
$__git_C_args array in the main git completion function, and pass this
array, if present, to 'git rev-parse --absolute-git-dir' when
discovering the repository in __gitdir(), and let it take care of
multiple options, relative paths, absolute paths and everything.

Also pass all '-C <path> options via the $__git_C_args array to those
git executions which require a worktree and for which it matters from
which directory they are executed from.  There are only three such
cases:

  - 'git diff-index' and 'git ls-files' in __git_ls_files_helper()
    used for git-aware filename completion, and

  - the 'git ls-tree' used for completing the 'ref:path' notation.

The other git commands executed in the completion script don't need
these '-C <path>' options, because __gitdir() already took those
options into account.  It would not hurt them, either, but let's not
induce unnecessary code churn.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 19 ++++++--
 t/t9902-completion.sh                  | 87 ++++++++++++++++++++++++++=
++++++++
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5e5437d7a5c2..9ffea9580ff7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -39,7 +39,11 @@ esac
 __gitdir ()
 {
 	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
+		if [ -n "${__git_C_args-}" ]; then
+			git "${__git_C_args[@]}" \
+				${__git_dir:+--git-dir=3D"$__git_dir"} \
+				rev-parse --absolute-git-dir 2>/dev/null
+		elif [ -n "${__git_dir-}" ]; then
 			test -d "$__git_dir" || return 1
 			echo "$__git_dir"
 		elif [ -n "${GIT_DIR-}" ]; then
@@ -286,10 +290,10 @@ __git_ls_files_helper ()
 	local dir=3D"$(__gitdir)"
=20
 	if [ "$2" =3D=3D "--committable" ]; then
-		git --git-dir=3D"$dir" -C "$1" diff-index --name-only --relative HEA=
D
+		git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir=3D"$dir" -C "$1"=
 diff-index --name-only --relative HEAD
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
-		git --git-dir=3D"$dir" -C "$1" ls-files --exclude-standard $2
+		git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir=3D"$dir" -C "$1"=
 ls-files --exclude-standard $2
 	fi 2>/dev/null
 }
=20
@@ -521,7 +525,7 @@ __git_complete_revlist_file ()
 		*)   pfx=3D"$ref:$pfx" ;;
 		esac
=20
-		__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" ls-tree "$ls" 2>/dev/n=
ull \
+		__gitcomp_nl "$(git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir=3D=
"$(__gitdir)" ls-tree "$ls" 2>/dev/null \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -2650,6 +2654,7 @@ _git_whatchanged ()
 __git_main ()
 {
 	local i c=3D1 command __git_dir
+	local __git_C_args C_args_count=3D0
=20
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
@@ -2658,7 +2663,11 @@ __git_main ()
 		--git-dir)   ((c++)) ; __git_dir=3D"${words[c]}" ;;
 		--bare)      __git_dir=3D"." ;;
 		--help) command=3D"help"; break ;;
-		-c|-C|--work-tree|--namespace) ((c++)) ;;
+		-c|--work-tree|--namespace) ((c++)) ;;
+		-C)	__git_C_args[C_args_count++]=3D-C
+			((c++))
+			__git_C_args[C_args_count++]=3D"${words[c]}"
+			;;
 		-*) ;;
 		*) command=3D"$i"; break ;;
 		esac
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d172199ed256..f68b3383caa3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -211,6 +211,87 @@ test_expect_success '__gitdir - $GIT_DIR set while=
 .git directory in parent' '
 	test_cmp expected "$actual"
 '
=20
+test_expect_success '__gitdir - from command line while "git -C"' '
+	echo "$ROOT/.git" >expected &&
+	(
+		__git_dir=3D"$ROOT/.git" &&
+		__git_C_args=3D(-C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - relative dir from command line and "gi=
t -C"' '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		cd subdir &&
+		__git_dir=3D"otherrepo/.git" &&
+		__git_C_args=3D(-C ..) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - $GIT_DIR set while "git -C"' '
+	echo "$ROOT/.git" >expected &&
+	(
+		GIT_DIR=3D"$ROOT/.git" &&
+		export GIT_DIR &&
+		__git_C_args=3D(-C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - relative dir in $GIT_DIR and "git -C"'=
 '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		cd subdir &&
+		GIT_DIR=3D"otherrepo/.git" &&
+		export GIT_DIR &&
+		__git_C_args=3D(-C ..) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - "git -C" while .git directory in cwd' =
'
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		__git_C_args=3D(-C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - "git -C" while cwd is a .git directory=
' '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		cd .git &&
+		__git_C_args=3D(-C .. -C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - "git -C" while .git directory in paren=
t' '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		cd subdir &&
+		__git_C_args=3D(-C .. -C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - non-existing path in "git -C"' '
+	(
+		__git_C_args=3D(-C non-existing) &&
+		test_must_fail __gitdir >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
 test_expect_success '__gitdir - non-existing path in $__git_dir' '
 	(
 		__git_dir=3D"non-existing" &&
@@ -775,6 +856,12 @@ test_expect_success 'checkout completes ref names'=
 '
 	EOF
 '
=20
+test_expect_success 'git -C <path> checkout uses the right repo' '
+	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo che=
ckout b" <<-\EOF
+	branch Z
+	EOF
+'
+
 test_expect_success 'show completes all refs' '
 	test_completion "git show m" <<-\EOF
 	master Z
--=20
2.7.2.410.g92cb358
