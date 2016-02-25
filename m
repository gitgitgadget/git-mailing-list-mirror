From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 20/21] completion: extract repository discovery from __gitdir()
Date: Thu, 25 Feb 2016 23:50:49 +0100
Message-ID: <1456440650-32623-21-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4nj-0007Jl-M6
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbcBYWyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:54:24 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35895 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751624AbcBYWyY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:54:24 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4nZ-0007uU-JA; Thu, 25 Feb 2016 23:54:19 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440859.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287468>

To prepare for caching the path to the repository in the following
commit, extract the repository discovering part of __gitdir() into the
__git_find_repo_path() helper function, which stores the found path in
the $__git_repo_path variable instead of printing it.  Make __gitdir()
a wrapper around this new function.  Declare $__git_repo_path local in
the toplevel completion functions __git_main() and __gitk_main() to
prevent it from leaking into the environment and influencing
subsequent completions.

Adjust tests checking __gitdir() or any other completion function
calling __gitdir() to perform those checks in a subshell to prevent
$__git_repo_path from leaking into the test environment.  Otherwise
leave the tests unchanged to demonstrate that this change doesn't
alter __gitdir()'s behavior.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 42 +++++++++++++++++++++-----=
--------
 t/t9902-completion.sh                  | 22 +++++++++++++-----
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 605ab84296a2..69000a33bcfa 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,26 +34,35 @@ case "$COMP_WORDBREAKS" in
 *)   COMP_WORDBREAKS=3D"$COMP_WORDBREAKS:"
 esac
=20
+# Discovers the path to the git repository taking any '--git-dir=3D<pa=
th>' and
+# '-C <path>' options into account and stores it in the $__git_repo_pa=
th
+# variable.
+__git_find_repo_path ()
+{
+	if [ -n "${__git_C_args-}" ]; then
+		__git_repo_path=3D"$(git "${__git_C_args[@]}" \
+			${__git_dir:+--git-dir=3D"$__git_dir"} \
+			rev-parse --absolute-git-dir 2>/dev/null)"
+	elif [ -n "${__git_dir-}" ]; then
+		test -d "$__git_dir" &&
+		__git_repo_path=3D"$__git_dir"
+	elif [ -n "${GIT_DIR-}" ]; then
+		test -d "${GIT_DIR-}" &&
+		__git_repo_path=3D"$GIT_DIR"
+	elif [ -d .git ]; then
+		__git_repo_path=3D.git
+	else
+		__git_repo_path=3D"$(git rev-parse --git-dir 2>/dev/null)"
+	fi
+}
+
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
 {
 	if [ -z "${1-}" ]; then
-		if [ -n "${__git_C_args-}" ]; then
-			git "${__git_C_args[@]}" \
-				${__git_dir:+--git-dir=3D"$__git_dir"} \
-				rev-parse --absolute-git-dir 2>/dev/null
-		elif [ -n "${__git_dir-}" ]; then
-			test -d "$__git_dir" || return 1
-			echo "$__git_dir"
-		elif [ -n "${GIT_DIR-}" ]; then
-			test -d "${GIT_DIR-}" || return 1
-			echo "$GIT_DIR"
-		elif [ -d .git ]; then
-			echo .git
-		else
-			git rev-parse --git-dir 2>/dev/null
-		fi
+		__git_find_repo_path || return 1
+		echo "$__git_repo_path"
 	elif [ -d "$1/.git" ]; then
 		echo "$1/.git"
 	else
@@ -2641,7 +2650,7 @@ _git_whatchanged ()
=20
 __git_main ()
 {
-	local i c=3D1 command __git_dir
+	local i c=3D1 command __git_dir __git_repo_path
 	local __git_C_args C_args_count=3D0
=20
 	while [ $c -lt $cword ]; do
@@ -2710,6 +2719,7 @@ __gitk_main ()
 {
 	__git_has_doubledash && return
=20
+	local __git_repo_path
 	local g=3D"$(__gitdir)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f68b3383caa3..d44e72066328 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -147,19 +147,25 @@ test_expect_success '__gitdir - from command line=
 (through $__git_dir)' '
=20
 test_expect_success '__gitdir - repo as argument' '
 	echo "otherrepo/.git" >expected &&
-	__gitdir "otherrepo" >"$actual" &&
+	(
+		__gitdir "otherrepo" >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success '__gitdir - remote as argument' '
 	echo "remote" >expected &&
-	__gitdir "remote" >"$actual" &&
+	(
+		__gitdir "remote" >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success '__gitdir - .git directory in cwd' '
 	echo ".git" >expected &&
-	__gitdir >"$actual" &&
+	(
+		__gitdir >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
=20
@@ -455,7 +461,9 @@ test_expect_success '__git_remotes - list remotes f=
rom $GIT_DIR/remotes and from
 	git remote add remote_in_config_1 git://remote_1 &&
 	test_when_finished "git remote remove remote_in_config_2" &&
 	git remote add remote_in_config_2 git://remote_2 &&
-	__git_remotes >actual &&
+	(
+		__git_remotes >actual
+	) &&
 	test_cmp expect actual
 '
=20
@@ -464,8 +472,10 @@ test_expect_success '__git_is_configured_remote' '
 	git remote add remote_1 git://remote_1 &&
 	test_when_finished "git remote remove remote_2" &&
 	git remote add remote_2 git://remote_2 &&
-	verbose __git_is_configured_remote remote_2 &&
-	test_must_fail __git_is_configured_remote non-existent
+	(
+		verbose __git_is_configured_remote remote_2 &&
+		test_must_fail __git_is_configured_remote non-existent
+	)
 '
=20
 test_expect_success 'setup for ref completion' '
--=20
2.7.2.410.g92cb358
