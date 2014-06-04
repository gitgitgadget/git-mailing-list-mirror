From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 04/11] t9903: run pc mode tests again with PS1 expansion disabled
Date: Wed,  4 Jun 2014 17:01:20 -0400
Message-ID: <1401915687-8602-5-git-send-email-rhansen@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:01:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIJk-0005IH-5l
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbaFDVBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 17:01:47 -0400
Received: from smtp.bbn.com ([128.33.1.81]:44006 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbaFDVBq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:01:46 -0400
Received: from socket.bbn.com ([192.1.120.102]:36566)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsIJp-000DMQ-0Z; Wed, 04 Jun 2014 17:01:57 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 25A313FFFC
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250783>

Bash has a shell option that makes it possible to disable parameter
expansion in PS1.  Test __git_ps1's ability to detect and react to
disabled PS1 expansion by running the "pc mode" tests twice:  once
with PS1 parameter expansion enabled and once with it disabled.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-bash.sh          |  3 ++
 t/t9903-bash-prompt.sh | 96 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 76 insertions(+), 23 deletions(-)

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
index d29dd2b..eb5a167 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -451,57 +451,97 @@ test_expect_success 'prompt - format string starting with dash' '
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
+set_ps1expansion () {
+	case $ps1expansion in
+	on) ps1_expansion_enable;;
+	off) ps1_expansion_disable;;
+	*) error "invalid argument to _run_pcmode_tests: $ps1expansion";;
+	esac
+}
+
+_run_pcmode_tests () {
+	ps1expansion=$1; shift
+
+	# Test whether the shell supports enabling/disabling PS1
+	# expansion by running set_ps1expansion.  If not, quietly skip
+	# this set of tests.
+	#
+	# Even though set_ps1expansion is run here, it must also be
+	# run inside each individual test case because the state of
+	# the shell might be reset in some fashion before executing
+	# the test code.  (Notably, Zsh shell emulation causes the
+	# PROMPT_SUBST option to be reset each time a test is run.)
+	set_ps1expansion || return 0
+
+	test_expect_success "prompt - pc mode (PS1 expansion $ps1expansion)" '
+		set_ps1expansion &&
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
+		set_ps1expansion &&
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
+		set_ps1expansion &&
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
+		set_ps1expansion &&
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
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_green}+${c_clear}):AFTER\\n%s" master &&
 		echo "dirty" >file &&
 		test_when_finished "git reset --hard" &&
 		git add -u &&
@@ -509,13 +549,14 @@ run_pcmode_tests () {
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
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\n%s" master &&
 		echo "dirty index" >file &&
 		test_when_finished "git reset --hard" &&
 		git add -u &&
@@ -524,25 +565,27 @@ run_pcmode_tests () {
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
+		set_ps1expansion &&
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
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear}):AFTER\\n%s" "GIT_DIR!" &&
 		echo "dirty" >file &&
 		test_when_finished "git reset --hard" &&
 		(
@@ -550,13 +593,14 @@ run_pcmode_tests () {
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
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_lblue}\$${c_clear}):AFTER\\n%s" master &&
 		echo 2 >file &&
 		git stash &&
 		test_when_finished "git stash drop" &&
@@ -564,23 +608,29 @@ run_pcmode_tests () {
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
+		set_ps1expansion &&
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
2.0.0
