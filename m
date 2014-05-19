From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH] git-prompt.sh: don't assume the shell expands the value of PS1
Date: Mon, 19 May 2014 18:55:37 -0400
Message-ID: <1400540137-29994-1-git-send-email-rhansen@bbn.com>
Cc: caleb@calebthompson.io
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 00:56:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWTS-0002rC-1T
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 00:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbaESWz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 18:55:57 -0400
Received: from smtp.bbn.com ([128.33.0.80]:47616 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaESWz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 18:55:57 -0400
Received: from socket.bbn.com ([192.1.120.102]:50323)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WmWTL-0005Yg-DP; Mon, 19 May 2014 18:55:55 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 1FB36401F7
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249632>

Not all shells subject the prompt string to parameter expansion.  Test
whether the shell will expand the value of PS1, and use the result to
control whether raw ref names are included directly in PS1.

This fixes a regression introduced in commit 8976500 ("git-prompt.sh:
don't put unsanitized branch names in $PS1"):  zsh does not expand PS1
by default, but that commit assumed it did.  The bug resulted in
prompts containing the literal string '${__git_ps1_branch_name}'
instead of the actual branch name.

Reported-by: Caleb Thompson <caleb@calebthompson.io>
Signed-off-by: Richard Hansen <rhansen@bbn.com>
---

To prevent a regression like this from happening again, I plan on
adding new zsh test cases and expanding the bash test cases (to test
the behavior with 'shopt -u promptvars').  I'd like the zsh tests to
cover the same stuff as the bash tests.  These are the steps I am
considering:

  1. delete the last test case in t9903 ("prompt - zsh color pc mode")
  2. add two new functions to t/lib-bash.sh:
         ps1_expansion_enable () { shopt -s promptvars; }
         ps1_expansion_disable () { shopt -u promptvars; }
  3. loop over the relevant test cases twice:  once after calling
     ps1_expansion_enable and once after calling ps1_expansion_disable
     (with appropriate adjustments to the expected output)
  4. move the test cases in t9903 to a separate library file and
     source it from t9903-bash-prompt.sh
  5. create two new files:
       * t/lib-zsh.sh (same as t/lib-bash.sh but tweaked for zsh)
       * t/t9904-zsh-prompt.sh (same as t/t9903-bash-prompt.sh but
         tweaked for zsh)

Does this approach sound reasonable?

 contrib/completion/git-prompt.sh | 56 ++++++++++++++++++++++++++++------------
 t/t9903-bash-prompt.sh           |  6 ++---
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 853425d..9d684b1 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -209,9 +209,7 @@ __git_ps1_show_upstream ()
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream" 2>/dev/null)
-			if [ $pcmode = yes ]; then
-				# see the comments around the
-				# __git_ps1_branch_name variable below
+			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
 				p="$p \${__git_ps1_upstream_name}"
 			else
 				p="$p ${__git_ps1_upstream_name}"
@@ -308,6 +306,43 @@ __git_ps1 ()
 		;;
 	esac
 
+	# ps1_expanded:  This variable is set to 'yes' if the shell
+	# subjects the value of PS1 to parameter expansion:
+	#
+	#   * bash does unless the promptvars option is disabled
+	#   * zsh does not unless the PROMPT_SUBST option is set
+	#   * POSIX shells always do
+	#
+	# If the shell would expand the contents of PS1 when drawing
+	# the prompt, a raw ref name must not be included in PS1.
+	# This protects the user from arbitrary code execution via
+	# specially crafted ref names.  For example, a ref named
+	# 'refs/heads/$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' might cause the
+	# shell to execute 'sudo rm -rf /' when the prompt is drawn.
+	#
+	# Instead, the ref name should be placed in a separate global
+	# variable (in the __git_ps1_* namespace to avoid colliding
+	# with the user's environment) and that variable should be
+	# referenced from PS1.  For example:
+	#
+	#     __git_ps1_foo=$(do_something_to_get_ref_name)
+	#     PS1="...stuff...\${__git_ps1_foo}...stuff..."
+	#
+	# If the shell does not expand the contents of PS1, the raw
+	# ref name must be included in PS1.
+	#
+	# The value of this variable is only relevant when in pcmode.
+	#
+	# Assume that the shell follows the POSIX specification and
+	# expands PS1 unless determined otherwise.  (This is more
+	# likely to be correct if the user has a non-bash, non-zsh
+	# shell and safer than the alternative if the assumption is
+	# incorrect.)
+	#
+	local ps1_expanded=yes
+	[ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
+	[ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=no
+
 	local repo_info rev_parse_exit_code
 	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
 		--is-bare-repository --is-inside-work-tree \
@@ -457,21 +492,8 @@ __git_ps1 ()
 	fi
 
 	b=${b##refs/heads/}
-	if [ $pcmode = yes ]; then
-		# In pcmode (and only pcmode) the contents of
-		# $gitstring are subject to expansion by the shell.
-		# Avoid putting the raw ref name in the prompt to
-		# protect the user from arbitrary code execution via
-		# specially crafted ref names (e.g., a ref named
-		# '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' would execute
-		# 'sudo rm -rf /' when the prompt is drawn).  Instead,
-		# put the ref name in a new global variable (in the
-		# __git_ps1_* namespace to avoid colliding with the
-		# user's environment) and reference that variable from
-		# PS1.
+	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
 		__git_ps1_branch_name=$b
-		# note that the $ is escaped -- the variable will be
-		# expanded later (when it's time to draw the prompt)
 		b="\${__git_ps1_branch_name}"
 	fi
 
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6efd0d9..9150984 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -578,12 +578,12 @@ test_expect_success 'prompt - bash color pc mode - untracked files status indica
 '
 
 test_expect_success 'prompt - zsh color pc mode' '
-	printf "BEFORE: (%%F{green}\${__git_ps1_branch_name}%%f):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (%%F{green}master%%f):AFTER" >expected &&
 	(
 		ZSH_VERSION=5.0.0 &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" >"$actual"
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
-- 
1.9.3
