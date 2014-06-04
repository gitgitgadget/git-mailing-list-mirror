From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 07/11] t9903: move prompt tests to a new lib-prompt-tests.sh file
Date: Wed,  4 Jun 2014 17:01:23 -0400
Message-ID: <1401915687-8602-8-git-send-email-rhansen@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIK6-0005VM-Oi
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbaFDVCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 17:02:00 -0400
Received: from smtp.bbn.com ([128.33.0.80]:55925 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbaFDVBx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2014 17:01:53 -0400
Received: from socket.bbn.com ([192.1.120.102]:34539)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsIJk-000IYF-OP; Wed, 04 Jun 2014 17:01:52 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7A0E93FFFC
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250788>

This is a step toward creating a new test script that runs the same
prompt tests as t9903 but with Zsh instead of Bash.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-prompt-tests.sh  | 653 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t9903-bash-prompt.sh | 626 +----------------------------------------=
------
 2 files changed, 654 insertions(+), 625 deletions(-)
 create mode 100644 t/lib-prompt-tests.sh

diff --git a/t/lib-prompt-tests.sh b/t/lib-prompt-tests.sh
new file mode 100644
index 0000000..7aaeb8e
--- /dev/null
+++ b/t/lib-prompt-tests.sh
@@ -0,0 +1,653 @@
+# Copyright (c) 2012 SZEDER G=C3=A1bor
+
+# To use this library:
+#   1. set the variable shellname to the name of the shell (e.g.,
+#      "Bash")
+#   2. define functions named ps1_expansion_enable and
+#      ps1_expansion_disable that, upon return, guarantee that the
+#      shell will and will not (respectively) perform parameter
+#      expansion on PS1, if supported by the shell.  If it is not
+#      possible to configure the shell to disable (enable) PS1
+#      expansion, ps1_expansion_enable should simply return 0
+#      (non-zero) and ps1_expansion_disable should simply return
+#      non-zero (0)
+#   3. define a function named set_ps1_format_vars that sets the
+#      variables c_red, c_green, c_lblue, and c_clear to the strings
+#      that __git_ps1 uses to add color to the prompt.  The values of
+#      these variables are used in the first argument to the printf
+#      command, so they must be escaped appropriately.
+#   4. source this library
+
+# sanity checks
+[ -n "$shellname" ] || error "shellname must be set to the name of the=
 shell"
+for i in ps1_expansion_enable ps1_expansion_disable set_ps1_format_var=
s
+do
+	command -v "$i" >/dev/null 2>&1 || error "function $i not defined"
+done
+(ps1_expansion_enable || ps1_expansion_disable) \
+	|| error "either ps1_expansion_enable or ps1_expansion_disable must r=
eturn true"
+
+. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
+
+actual=3D"$TRASH_DIRECTORY/actual"
+set_ps1_format_vars
+
+test_expect_success "setup for $shellname prompt tests" '
+	git init otherrepo &&
+	echo 1 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git tag -a -m msg1 t1 &&
+	git checkout -b b1 &&
+	echo 2 >file &&
+	git commit -m "second b1" file &&
+	echo 3 >file &&
+	git commit -m "third b1" file &&
+	git tag -a -m msg2 t2 &&
+	git checkout -b b2 master &&
+	echo 0 >file &&
+	git commit -m "second b2" file &&
+	echo 00 >file &&
+	git commit -m "another b2" file &&
+	echo 000 >file &&
+	git commit -m "yet another b2" file &&
+	git checkout master
+'
+
+pfx=3D"$shellname prompt"
+
+test_expect_success "$pfx - branch name" '
+	printf " (master)" >expected &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success SYMLINKS "$pfx - branch name - symlink symref" '
+	printf " (master)" >expected &&
+	test_when_finished "git checkout master" &&
+	test_config core.preferSymlinkRefs true &&
+	git checkout master &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - unborn branch" '
+	printf " (unborn)" >expected &&
+	git checkout --orphan unborn &&
+	test_when_finished "git checkout master" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+repo_with_newline=3D'repo
+with
+newline'
+
+if mkdir "$repo_with_newline" 2>/dev/null
+then
+	test_set_prereq FUNNYNAMES
+else
+	say 'Your filesystem does not allow newlines in filenames.'
+fi
+
+test_expect_success FUNNYNAMES "$pfx - with newline in path" '
+	printf " (master)" >expected &&
+	git init "$repo_with_newline" &&
+	test_when_finished "rm -rf \"$repo_with_newline\"" &&
+	mkdir "$repo_with_newline"/subdir &&
+	(
+		cd "$repo_with_newline/subdir" &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - detached head" '
+	printf " ((%s...))" $(git log -1 --format=3D"%h" --abbrev=3D13 b1^) >=
expected &&
+	test_config core.abbrev 13 &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - describe detached head - contains" '
+	printf " ((t2~1))" >expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		GIT_PS1_DESCRIBE_STYLE=3Dcontains &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - describe detached head - branch" '
+	printf " ((b1~1))" >expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		GIT_PS1_DESCRIBE_STYLE=3Dbranch &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - describe detached head - describe" '
+	printf " ((t1-1-g%s))" $(git log -1 --format=3D"%h" b1^) >expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		GIT_PS1_DESCRIBE_STYLE=3Ddescribe &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - describe detached head - default" '
+	printf " ((t2))" >expected &&
+	git checkout --detach b1 &&
+	test_when_finished "git checkout master" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - inside .git directory" '
+	printf " (GIT_DIR!)" >expected &&
+	(
+		cd .git &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - deep inside .git directory" '
+	printf " (GIT_DIR!)" >expected &&
+	(
+		cd .git/refs/heads &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - inside bare repository" '
+	printf " (BARE:master)" >expected &&
+	git init --bare bare.git &&
+	test_when_finished "rm -rf bare.git" &&
+	(
+		cd bare.git &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - interactive rebase" '
+	printf " (b1|REBASE-i 2/3)" >expected
+	write_script fake_editor.sh <<-\EOF &&
+		echo "exec echo" >"$1"
+		echo "edit $(git log -1 --format=3D"%h")" >>"$1"
+		echo "exec echo" >>"$1"
+	EOF
+	test_when_finished "rm -f fake_editor.sh" &&
+	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
+	git checkout b1 &&
+	test_when_finished "git checkout master" &&
+	git rebase -i HEAD^ &&
+	test_when_finished "git rebase --abort"
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - rebase merge" '
+	printf " (b2|REBASE-m 1/3)" >expected &&
+	git checkout b2 &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git rebase --merge b1 b2 &&
+	test_when_finished "git rebase --abort" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - rebase" '
+	printf " (b2|REBASE 1/3)" >expected &&
+	git checkout b2 &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git rebase b1 b2 &&
+	test_when_finished "git rebase --abort" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - merge" '
+	printf " (b1|MERGING)" >expected &&
+	git checkout b1 &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git merge b2 &&
+	test_when_finished "git reset --hard" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - cherry-pick" '
+	printf " (master|CHERRY-PICKING)" >expected &&
+	test_must_fail git cherry-pick b1 &&
+	test_when_finished "git reset --hard" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - bisect" '
+	printf " (master|BISECTING)" >expected &&
+	git bisect start &&
+	test_when_finished "git bisect reset" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - clean" '
+	printf " (master)" >expected &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - dirty worktree" '
+	printf " (master *)" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - dirty index" '
+	printf " (master +)" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - dirty index and w=
orktree" '
+	printf " (master *+)" >expected &&
+	echo "dirty index" >file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	echo "dirty worktree" >file &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - before root commi=
t" '
+	printf " (master #)" >expected &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		cd otherrepo &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - shell variable un=
set with config disabled" '
+	printf " (master)" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState false &&
+	(
+		sane_unset GIT_PS1_SHOWDIRTYSTATE &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - shell variable un=
set with config enabled" '
+	printf " (master)" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState true &&
+	(
+		sane_unset GIT_PS1_SHOWDIRTYSTATE &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - shell variable se=
t with config disabled" '
+	printf " (master)" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState false &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - shell variable se=
t with config enabled" '
+	printf " (master *)" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState true &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - dirty status indicator - not shown inside =
=2Egit directory" '
+	printf " (GIT_DIR!)" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		cd .git &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - stash status indicator - no stash" '
+	printf " (master)" >expected &&
+	(
+		GIT_PS1_SHOWSTASHSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - stash status indicator - stash" '
+	printf " (master $)" >expected &&
+	echo 2 >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	git pack-refs --all &&
+	(
+		GIT_PS1_SHOWSTASHSTATE=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - stash status indicator - not shown inside =
=2Egit directory" '
+	printf " (GIT_DIR!)" >expected &&
+	echo 2 >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	(
+		GIT_PS1_SHOWSTASHSTATE=3Dy &&
+		cd .git &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - untracked files status indicator - no untr=
acked files" '
+	printf " (master)" >expected &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		cd otherrepo &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - untracked files status indicator - untrack=
ed files" '
+	printf " (master %%)" >expected &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - untracked files status indicator - shell v=
ariable unset with config disabled" '
+	printf " (master)" >expected &&
+	test_config bash.showUntrackedFiles false &&
+	(
+		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - untracked files status indicator - shell v=
ariable unset with config enabled" '
+	printf " (master)" >expected &&
+	test_config bash.showUntrackedFiles true &&
+	(
+		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - untracked files status indicator - shell v=
ariable set with config disabled" '
+	printf " (master)" >expected &&
+	test_config bash.showUntrackedFiles false &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - untracked files status indicator - shell v=
ariable set with config enabled" '
+	printf " (master %%)" >expected &&
+	test_config bash.showUntrackedFiles true &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - untracked files status indicator - not sho=
wn inside .git directory" '
+	printf " (GIT_DIR!)" >expected &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		cd .git &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success "$pfx - format string starting with dash" '
+	printf -- "-master" >expected &&
+	__git_ps1 "-%s" >"$actual" &&
+	test_cmp expected "$actual"
+'
+
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
+	ps1expansion=3D$1; shift
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
+	test_expect_success "$shellname prompt - pc mode (PS1 expansion $ps1e=
xpansion)" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (%s):AFTER\\n%s" master &&
+		printf "" >expected_output &&
+		(
+			__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
+			test_cmp expected_output "$actual" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	pfx=3D"$shellname prompt - color pc mode (PS1 expansion $ps1expansion=
)"
+
+	test_expect_success "$pfx - branch name" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear}):AFTER\\n%s" master=
 &&
+		(
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			__git_ps1 "BEFORE:" ":AFTER" >"$actual"
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "$pfx - detached head" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_red}%s${c_clear}):AFTER\\n%s" "($(git =
log -1 --format=3D"%h" b1^)...)" &&
+		git checkout b1^ &&
+		test_when_finished "git checkout master" &&
+		(
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "$pfx - dirty status indicator - dirty worktree" =
'
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}*${c_clear}=
):AFTER\\n%s" master &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "$pfx - dirty status indicator - dirty index" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_green}+${c_clea=
r}):AFTER\\n%s" master &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		git add -u &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "$pfx - dirty status indicator - dirty index and =
worktree" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}*${c_green}=
+${c_clear}):AFTER\\n%s" master &&
+		echo "dirty index" >file &&
+		test_when_finished "git reset --hard" &&
+		git add -u &&
+		echo "dirty worktree" >file &&
+		(
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "$pfx - dirty status indicator - before root comm=
it" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_green}#${c_clea=
r}):AFTER\\n%s" master &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			cd otherrepo &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "$pfx - inside .git directory" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear}):AFTER\\n%s" "GIT_D=
IR!" &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			cd .git &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "$pfx - stash status indicator" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_lblue}\$${c_cle=
ar}):AFTER\\n%s" master &&
+		echo 2 >file &&
+		git stash &&
+		test_when_finished "git stash drop" &&
+		(
+			GIT_PS1_SHOWSTASHSTATE=3Dy &&
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+
+	test_expect_success "$pfx - untracked files status indicator" '
+		set_ps1expansion &&
+		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}%%${c_clear=
}):AFTER\\n%s" master &&
+		(
+			GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+			GIT_PS1_SHOWCOLORHINTS=3Dy &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			pcmode_actual
+		) &&
+		test_cmp expected "$actual"
+	'
+}
+
+run_pcmode_tests () {
+	_run_pcmode_tests on
+	_run_pcmode_tests off
+}
+
+run_pcmode_tests
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index fe60cf9..b698fe9 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -6,630 +6,6 @@
 test_description=3D'test git-specific bash prompt functions'
=20
 . ./lib-bash.sh
-
-. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
-
-actual=3D"$TRASH_DIRECTORY/actual"
-set_ps1_format_vars
-
-test_expect_success "setup for $shellname prompt tests" '
-	git init otherrepo &&
-	echo 1 >file &&
-	git add file &&
-	test_tick &&
-	git commit -m initial &&
-	git tag -a -m msg1 t1 &&
-	git checkout -b b1 &&
-	echo 2 >file &&
-	git commit -m "second b1" file &&
-	echo 3 >file &&
-	git commit -m "third b1" file &&
-	git tag -a -m msg2 t2 &&
-	git checkout -b b2 master &&
-	echo 0 >file &&
-	git commit -m "second b2" file &&
-	echo 00 >file &&
-	git commit -m "another b2" file &&
-	echo 000 >file &&
-	git commit -m "yet another b2" file &&
-	git checkout master
-'
-
-pfx=3D"$shellname prompt"
-
-test_expect_success "$pfx - branch name" '
-	printf " (master)" >expected &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success SYMLINKS "$pfx - branch name - symlink symref" '
-	printf " (master)" >expected &&
-	test_when_finished "git checkout master" &&
-	test_config core.preferSymlinkRefs true &&
-	git checkout master &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - unborn branch" '
-	printf " (unborn)" >expected &&
-	git checkout --orphan unborn &&
-	test_when_finished "git checkout master" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-repo_with_newline=3D'repo
-with
-newline'
-
-if mkdir "$repo_with_newline" 2>/dev/null
-then
-	test_set_prereq FUNNYNAMES
-else
-	say 'Your filesystem does not allow newlines in filenames.'
-fi
-
-test_expect_success FUNNYNAMES "$pfx - with newline in path" '
-	printf " (master)" >expected &&
-	git init "$repo_with_newline" &&
-	test_when_finished "rm -rf \"$repo_with_newline\"" &&
-	mkdir "$repo_with_newline"/subdir &&
-	(
-		cd "$repo_with_newline/subdir" &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - detached head" '
-	printf " ((%s...))" $(git log -1 --format=3D"%h" --abbrev=3D13 b1^) >=
expected &&
-	test_config core.abbrev 13 &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - describe detached head - contains" '
-	printf " ((t2~1))" >expected &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	(
-		GIT_PS1_DESCRIBE_STYLE=3Dcontains &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - describe detached head - branch" '
-	printf " ((b1~1))" >expected &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	(
-		GIT_PS1_DESCRIBE_STYLE=3Dbranch &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - describe detached head - describe" '
-	printf " ((t1-1-g%s))" $(git log -1 --format=3D"%h" b1^) >expected &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	(
-		GIT_PS1_DESCRIBE_STYLE=3Ddescribe &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - describe detached head - default" '
-	printf " ((t2))" >expected &&
-	git checkout --detach b1 &&
-	test_when_finished "git checkout master" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - inside .git directory" '
-	printf " (GIT_DIR!)" >expected &&
-	(
-		cd .git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - deep inside .git directory" '
-	printf " (GIT_DIR!)" >expected &&
-	(
-		cd .git/refs/heads &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - inside bare repository" '
-	printf " (BARE:master)" >expected &&
-	git init --bare bare.git &&
-	test_when_finished "rm -rf bare.git" &&
-	(
-		cd bare.git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - interactive rebase" '
-	printf " (b1|REBASE-i 2/3)" >expected
-	write_script fake_editor.sh <<-\EOF &&
-		echo "exec echo" >"$1"
-		echo "edit $(git log -1 --format=3D"%h")" >>"$1"
-		echo "exec echo" >>"$1"
-	EOF
-	test_when_finished "rm -f fake_editor.sh" &&
-	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
-	git checkout b1 &&
-	test_when_finished "git checkout master" &&
-	git rebase -i HEAD^ &&
-	test_when_finished "git rebase --abort"
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - rebase merge" '
-	printf " (b2|REBASE-m 1/3)" >expected &&
-	git checkout b2 &&
-	test_when_finished "git checkout master" &&
-	test_must_fail git rebase --merge b1 b2 &&
-	test_when_finished "git rebase --abort" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - rebase" '
-	printf " (b2|REBASE 1/3)" >expected &&
-	git checkout b2 &&
-	test_when_finished "git checkout master" &&
-	test_must_fail git rebase b1 b2 &&
-	test_when_finished "git rebase --abort" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - merge" '
-	printf " (b1|MERGING)" >expected &&
-	git checkout b1 &&
-	test_when_finished "git checkout master" &&
-	test_must_fail git merge b2 &&
-	test_when_finished "git reset --hard" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - cherry-pick" '
-	printf " (master|CHERRY-PICKING)" >expected &&
-	test_must_fail git cherry-pick b1 &&
-	test_when_finished "git reset --hard" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - bisect" '
-	printf " (master|BISECTING)" >expected &&
-	git bisect start &&
-	test_when_finished "git bisect reset" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - clean" '
-	printf " (master)" >expected &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - dirty worktree" '
-	printf " (master *)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - dirty index" '
-	printf " (master +)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	git add -u &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - dirty index and w=
orktree" '
-	printf " (master *+)" >expected &&
-	echo "dirty index" >file &&
-	test_when_finished "git reset --hard" &&
-	git add -u &&
-	echo "dirty worktree" >file &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - before root commi=
t" '
-	printf " (master #)" >expected &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		cd otherrepo &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - shell variable un=
set with config disabled" '
-	printf " (master)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	test_config bash.showDirtyState false &&
-	(
-		sane_unset GIT_PS1_SHOWDIRTYSTATE &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - shell variable un=
set with config enabled" '
-	printf " (master)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	test_config bash.showDirtyState true &&
-	(
-		sane_unset GIT_PS1_SHOWDIRTYSTATE &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - shell variable se=
t with config disabled" '
-	printf " (master)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	test_config bash.showDirtyState false &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - shell variable se=
t with config enabled" '
-	printf " (master *)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	test_config bash.showDirtyState true &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - dirty status indicator - not shown inside =
=2Egit directory" '
-	printf " (GIT_DIR!)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		cd .git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - stash status indicator - no stash" '
-	printf " (master)" >expected &&
-	(
-		GIT_PS1_SHOWSTASHSTATE=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - stash status indicator - stash" '
-	printf " (master $)" >expected &&
-	echo 2 >file &&
-	git stash &&
-	test_when_finished "git stash drop" &&
-	git pack-refs --all &&
-	(
-		GIT_PS1_SHOWSTASHSTATE=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - stash status indicator - not shown inside =
=2Egit directory" '
-	printf " (GIT_DIR!)" >expected &&
-	echo 2 >file &&
-	git stash &&
-	test_when_finished "git stash drop" &&
-	(
-		GIT_PS1_SHOWSTASHSTATE=3Dy &&
-		cd .git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - untracked files status indicator - no untr=
acked files" '
-	printf " (master)" >expected &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		cd otherrepo &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - untracked files status indicator - untrack=
ed files" '
-	printf " (master %%)" >expected &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - untracked files status indicator - shell v=
ariable unset with config disabled" '
-	printf " (master)" >expected &&
-	test_config bash.showUntrackedFiles false &&
-	(
-		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - untracked files status indicator - shell v=
ariable unset with config enabled" '
-	printf " (master)" >expected &&
-	test_config bash.showUntrackedFiles true &&
-	(
-		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - untracked files status indicator - shell v=
ariable set with config disabled" '
-	printf " (master)" >expected &&
-	test_config bash.showUntrackedFiles false &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - untracked files status indicator - shell v=
ariable set with config enabled" '
-	printf " (master %%)" >expected &&
-	test_config bash.showUntrackedFiles true &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - untracked files status indicator - not sho=
wn inside .git directory" '
-	printf " (GIT_DIR!)" >expected &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		cd .git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success "$pfx - format string starting with dash" '
-	printf -- "-master" >expected &&
-	__git_ps1 "-%s" >"$actual" &&
-	test_cmp expected "$actual"
-'
-
-pcmode_expected () {
-	case $ps1expansion in
-	on) printf "$1" '${__git_ps1_branch_name}' "$2";;
-	off) printf "$1" "$2" "";;
-	esac >expected
-}
-
-pcmode_actual () {
-	case $ps1expansion in
-	on) printf %s\\n%s "$PS1" "${__git_ps1_branch_name}";;
-	off) printf %s\\n "$PS1";;
-	esac >"$actual"
-}
-
-set_ps1expansion () {
-	case $ps1expansion in
-	on) ps1_expansion_enable;;
-	off) ps1_expansion_disable;;
-	*) error "invalid argument to _run_pcmode_tests: $ps1expansion";;
-	esac
-}
-
-_run_pcmode_tests () {
-	ps1expansion=3D$1; shift
-
-	# Test whether the shell supports enabling/disabling PS1
-	# expansion by running set_ps1expansion.  If not, quietly skip
-	# this set of tests.
-	#
-	# Even though set_ps1expansion is run here, it must also be
-	# run inside each individual test case because the state of
-	# the shell might be reset in some fashion before executing
-	# the test code.  (Notably, Zsh shell emulation causes the
-	# PROMPT_SUBST option to be reset each time a test is run.)
-	set_ps1expansion || return 0
-
-	test_expect_success "$shellname prompt - pc mode (PS1 expansion $ps1e=
xpansion)" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (%s):AFTER\\n%s" master &&
-		printf "" >expected_output &&
-		(
-			__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
-			test_cmp expected_output "$actual" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	pfx=3D"$shellname prompt - color pc mode (PS1 expansion $ps1expansion=
)"
-
-	test_expect_success "$pfx - branch name" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear}):AFTER\\n%s" master=
 &&
-		(
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			__git_ps1 "BEFORE:" ":AFTER" >"$actual"
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	test_expect_success "$pfx - detached head" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_red}%s${c_clear}):AFTER\\n%s" "($(git =
log -1 --format=3D"%h" b1^)...)" &&
-		git checkout b1^ &&
-		test_when_finished "git checkout master" &&
-		(
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			__git_ps1 "BEFORE:" ":AFTER" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	test_expect_success "$pfx - dirty status indicator - dirty worktree" =
'
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}*${c_clear}=
):AFTER\\n%s" master &&
-		echo "dirty" >file &&
-		test_when_finished "git reset --hard" &&
-		(
-			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			__git_ps1 "BEFORE:" ":AFTER" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	test_expect_success "$pfx - dirty status indicator - dirty index" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_green}+${c_clea=
r}):AFTER\\n%s" master &&
-		echo "dirty" >file &&
-		test_when_finished "git reset --hard" &&
-		git add -u &&
-		(
-			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			__git_ps1 "BEFORE:" ":AFTER" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	test_expect_success "$pfx - dirty status indicator - dirty index and =
worktree" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}*${c_green}=
+${c_clear}):AFTER\\n%s" master &&
-		echo "dirty index" >file &&
-		test_when_finished "git reset --hard" &&
-		git add -u &&
-		echo "dirty worktree" >file &&
-		(
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-			__git_ps1 "BEFORE:" ":AFTER" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	test_expect_success "$pfx - dirty status indicator - before root comm=
it" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_green}#${c_clea=
r}):AFTER\\n%s" master &&
-		(
-			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			cd otherrepo &&
-			__git_ps1 "BEFORE:" ":AFTER" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	test_expect_success "$pfx - inside .git directory" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear}):AFTER\\n%s" "GIT_D=
IR!" &&
-		echo "dirty" >file &&
-		test_when_finished "git reset --hard" &&
-		(
-			GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			cd .git &&
-			__git_ps1 "BEFORE:" ":AFTER" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	test_expect_success "$pfx - stash status indicator" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_lblue}\$${c_cle=
ar}):AFTER\\n%s" master &&
-		echo 2 >file &&
-		git stash &&
-		test_when_finished "git stash drop" &&
-		(
-			GIT_PS1_SHOWSTASHSTATE=3Dy &&
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			__git_ps1 "BEFORE:" ":AFTER" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-
-	test_expect_success "$pfx - untracked files status indicator" '
-		set_ps1expansion &&
-		pcmode_expected "BEFORE: (${c_green}%s${c_clear} ${c_red}%%${c_clear=
}):AFTER\\n%s" master &&
-		(
-			GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-			GIT_PS1_SHOWCOLORHINTS=3Dy &&
-			__git_ps1 "BEFORE:" ":AFTER" &&
-			pcmode_actual
-		) &&
-		test_cmp expected "$actual"
-	'
-}
-
-run_pcmode_tests () {
-	_run_pcmode_tests on
-	_run_pcmode_tests off
-}
-
-run_pcmode_tests
+. "$TEST_DIRECTORY"/lib-prompt-tests.sh
=20
 test_done
--=20
2.0.0
