From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 04/10] t9903: run pc mode tests again with PS1 expansion disabled
Date: Tue, 27 May 2014 03:40:54 -0400
Message-ID: <1401176460-31564-5-git-send-email-rhansen@bbn.com>
References: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
 <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 09:41:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpC11-0003Yz-2f
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 09:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbaE0Hlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 03:41:37 -0400
Received: from smtp.bbn.com ([128.33.0.80]:59752 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbaE0Hlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 03:41:31 -0400
Received: from socket.bbn.com ([192.1.120.102]:50701)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WpC0o-000PHA-CW; Tue, 27 May 2014 03:41:30 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0822440217
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250148>

Bash has a shell option that makes it possible to disable parameter
expansion in PS1.  Test __git_ps1's ability to detect and react to
disabled PS1 expansion by running the "pc mode" tests twice:  once
with PS1 parameter expansion enabled and once with it disabled.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-bash.sh          |  3 ++
 t/t9903-bash-prompt.sh | 75 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index 2be955f..37a48fd 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -14,4 +14,7 @@ else
 	exit 0
 fi
 
+ps1_expansion_enable () { shopt -s promptvars; }
+ps1_expansion_disable () { shopt -u promptvars; }
+
 . ./test-lib.sh
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d29dd2b..fbd77e6 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -451,57 +451,81 @@ test_expect_success 'prompt - format string starting with dash' '
 	test_cmp expected "$actual"
 '
 
-run_pcmode_tests () {
-	test_expect_success 'prompt - pc mode' '
-		printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\nmaster" >expected &&
+pcmode_expected () {
+	case $ps1expansion in
+	on) printf "$1" '${__git_ps1_branch_name}' "$2";;
+	off) printf "$1" "$2" "";;
+	esac >expected
+}
+
+pcmode_actual () {
+	case $ps1expansion in
+	on) printf %s\\n%s "$PS1" "${__git_ps1_branch_name}";;
+	off) printf %s\\n "$PS1";;
+	esac >"$actual"
+}
+
+_run_pcmode_tests () {
+	ps1expansion=$1; shift
+
+	case $ps1expansion in
+	# if the shell doesn't allow ps1 expansion to be enabled,
+	# quietly skip the tests (same goes for disabling)
+	on) ps1_expansion_enable || return 0;;
+	off) ps1_expansion_disable || return 0;;
+	*) error "invalid argument to _run_pcmode_tests: $ps1expansion";;
+	esac
+
+	test_expect_success "prompt - pc mode (PS1 expansion $ps1expansion)" '
+		pcmode_expected "BEFORE: (%s):AFTER\\n%s" master &&
 		printf "" >expected_output &&
 		(
 			__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
 			test_cmp expected_output "$actual" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
-	pfx="prompt - bash color pc mode"
+	pfx="prompt - bash color pc mode (PS1 expansion $ps1expansion)"
 
 	test_expect_success "$pfx - branch name" '
-		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmaster" >expected &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear}):AFTER\\n%s" master &&
 		(
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			__git_ps1 "BEFORE:" ":AFTER" >"$actual"
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
 	test_expect_success "$pfx - detached head" '
-		printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
+		pcmode_expected "BEFORE: (${c_red}%s${c_clear}):AFTER\\n%s" "($(git log -1 --format="%h" b1^)...)" &&
 		git checkout b1^ &&
 		test_when_finished "git checkout master" &&
 		(
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			__git_ps1 "BEFORE:" ":AFTER" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
 	test_expect_success "$pfx - dirty status indicator - dirty worktree" '
-		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmaster" >expected &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}*${c_clear}):AFTER\\n%s" master &&
 		echo "dirty" >file &&
 		test_when_finished "git reset --hard" &&
 		(
 			GIT_PS1_SHOWDIRTYSTATE=y &&
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			__git_ps1 "BEFORE:" ":AFTER" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
 	test_expect_success "$pfx - dirty status indicator - dirty index" '
-		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_green}+${c_clear}):AFTER\\n%s" master &&
 		echo "dirty" >file &&
 		test_when_finished "git reset --hard" &&
 		git add -u &&
@@ -509,13 +533,13 @@ run_pcmode_tests () {
 			GIT_PS1_SHOWDIRTYSTATE=y &&
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			__git_ps1 "BEFORE:" ":AFTER" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
 	test_expect_success "$pfx - dirty status indicator - dirty index and worktree" '
-		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\n%s" master &&
 		echo "dirty index" >file &&
 		test_when_finished "git reset --hard" &&
 		git add -u &&
@@ -524,25 +548,25 @@ run_pcmode_tests () {
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			GIT_PS1_SHOWDIRTYSTATE=y &&
 			__git_ps1 "BEFORE:" ":AFTER" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
 	test_expect_success "$pfx - dirty status indicator - before root commit" '
-		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmaster" >expected &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_green}#${c_clear}):AFTER\\n%s" master &&
 		(
 			GIT_PS1_SHOWDIRTYSTATE=y &&
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			cd otherrepo &&
 			__git_ps1 "BEFORE:" ":AFTER" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
 	test_expect_success "$pfx - inside .git directory" '
-		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nGIT_DIR!" >expected &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear}):AFTER\\n%s" "GIT_DIR!" &&
 		echo "dirty" >file &&
 		test_when_finished "git reset --hard" &&
 		(
@@ -550,13 +574,13 @@ run_pcmode_tests () {
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			cd .git &&
 			__git_ps1 "BEFORE:" ":AFTER" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
 	test_expect_success "$pfx - stash status indicator" '
-		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmaster" >expected &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_lblue}\$${c_clear}):AFTER\\n%s" master &&
 		echo 2 >file &&
 		git stash &&
 		test_when_finished "git stash drop" &&
@@ -564,23 +588,28 @@ run_pcmode_tests () {
 			GIT_PS1_SHOWSTASHSTATE=y &&
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			__git_ps1 "BEFORE:" ":AFTER" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 
 	test_expect_success "$pfx - untracked files status indicator" '
-		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmaster" >expected &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}%%${c_clear}):AFTER\\n%s" master &&
 		(
 			GIT_PS1_SHOWUNTRACKEDFILES=y &&
 			GIT_PS1_SHOWCOLORHINTS=y &&
 			__git_ps1 "BEFORE:" ":AFTER" &&
-			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+			pcmode_actual
 		) &&
 		test_cmp expected "$actual"
 	'
 }
 
+run_pcmode_tests () {
+	_run_pcmode_tests on
+	_run_pcmode_tests off
+}
+
 run_pcmode_tests
 
 test_done
-- 
1.9.3
