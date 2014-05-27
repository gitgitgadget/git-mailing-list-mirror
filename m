From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 05/10] t9903: include "Bash" in test names via new $shellname var
Date: Tue, 27 May 2014 03:40:55 -0400
Message-ID: <1401176460-31564-6-git-send-email-rhansen@bbn.com>
References: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
 <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 09:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpC1H-0003wg-7D
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 09:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaE0Hly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 03:41:54 -0400
Received: from smtp.bbn.com ([128.33.0.80]:19172 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbaE0Hlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 03:41:31 -0400
Received: from socket.bbn.com ([192.1.120.102]:50702)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WpC0o-000PHE-Ou; Tue, 27 May 2014 03:41:30 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 5FC324037C
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250156>

Define a new 'shellname' variable in lib-bash.sh and use it in the
prompt test names.  This is a step toward moving the shell prompt
tests to a separate library file so that they can be reused to test
prompting in Zsh.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-bash.sh          |  2 ++
 t/t9903-bash-prompt.sh | 86 ++++++++++++++++++++++++++------------------------
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index 37a48fd..a0f4e16 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -14,6 +14,8 @@ else
 	exit 0
 fi
 
+shellname=Bash
+
 ps1_expansion_enable () { shopt -s promptvars; }
 ps1_expansion_disable () { shopt -u promptvars; }
 
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index fbd77e6..05ff246 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -15,7 +15,7 @@ c_green='\\[\\e[32m\\]'
 c_lblue='\\[\\e[1;34m\\]'
 c_clear='\\[\\e[0m\\]'
 
-test_expect_success 'setup for prompt tests' '
+test_expect_success "setup for $shellname prompt tests" '
 	git init otherrepo &&
 	echo 1 >file &&
 	git add file &&
@@ -38,13 +38,15 @@ test_expect_success 'setup for prompt tests' '
 	git checkout master
 '
 
-test_expect_success 'prompt - branch name' '
+pfx="$shellname prompt"
+
+test_expect_success "$pfx - branch name" '
 	printf " (master)" >expected &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
+test_expect_success SYMLINKS "$pfx - branch name - symlink symref" '
 	printf " (master)" >expected &&
 	test_when_finished "git checkout master" &&
 	test_config core.preferSymlinkRefs true &&
@@ -53,7 +55,7 @@ test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - unborn branch' '
+test_expect_success "$pfx - unborn branch" '
 	printf " (unborn)" >expected &&
 	git checkout --orphan unborn &&
 	test_when_finished "git checkout master" &&
@@ -72,7 +74,7 @@ else
 	say 'Your filesystem does not allow newlines in filenames.'
 fi
 
-test_expect_success FUNNYNAMES 'prompt - with newline in path' '
+test_expect_success FUNNYNAMES "$pfx - with newline in path" '
 	printf " (master)" >expected &&
 	git init "$repo_with_newline" &&
 	test_when_finished "rm -rf \"$repo_with_newline\"" &&
@@ -84,7 +86,7 @@ test_expect_success FUNNYNAMES 'prompt - with newline in path' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - detached head' '
+test_expect_success "$pfx - detached head" '
 	printf " ((%s...))" $(git log -1 --format="%h" --abbrev=13 b1^) >expected &&
 	test_config core.abbrev 13 &&
 	git checkout b1^ &&
@@ -93,7 +95,7 @@ test_expect_success 'prompt - detached head' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - describe detached head - contains' '
+test_expect_success "$pfx - describe detached head - contains" '
 	printf " ((t2~1))" >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
@@ -104,7 +106,7 @@ test_expect_success 'prompt - describe detached head - contains' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - describe detached head - branch' '
+test_expect_success "$pfx - describe detached head - branch" '
 	printf " ((b1~1))" >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
@@ -115,7 +117,7 @@ test_expect_success 'prompt - describe detached head - branch' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - describe detached head - describe' '
+test_expect_success "$pfx - describe detached head - describe" '
 	printf " ((t1-1-g%s))" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
@@ -126,7 +128,7 @@ test_expect_success 'prompt - describe detached head - describe' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - describe detached head - default' '
+test_expect_success "$pfx - describe detached head - default" '
 	printf " ((t2))" >expected &&
 	git checkout --detach b1 &&
 	test_when_finished "git checkout master" &&
@@ -134,7 +136,7 @@ test_expect_success 'prompt - describe detached head - default' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - inside .git directory' '
+test_expect_success "$pfx - inside .git directory" '
 	printf " (GIT_DIR!)" >expected &&
 	(
 		cd .git &&
@@ -143,7 +145,7 @@ test_expect_success 'prompt - inside .git directory' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - deep inside .git directory' '
+test_expect_success "$pfx - deep inside .git directory" '
 	printf " (GIT_DIR!)" >expected &&
 	(
 		cd .git/refs/heads &&
@@ -152,7 +154,7 @@ test_expect_success 'prompt - deep inside .git directory' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - inside bare repository' '
+test_expect_success "$pfx - inside bare repository" '
 	printf " (BARE:master)" >expected &&
 	git init --bare bare.git &&
 	test_when_finished "rm -rf bare.git" &&
@@ -163,7 +165,7 @@ test_expect_success 'prompt - inside bare repository' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - interactive rebase' '
+test_expect_success "$pfx - interactive rebase" '
 	printf " (b1|REBASE-i 2/3)" >expected
 	write_script fake_editor.sh <<-\EOF &&
 		echo "exec echo" >"$1"
@@ -180,7 +182,7 @@ test_expect_success 'prompt - interactive rebase' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - rebase merge' '
+test_expect_success "$pfx - rebase merge" '
 	printf " (b2|REBASE-m 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
@@ -190,7 +192,7 @@ test_expect_success 'prompt - rebase merge' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - rebase' '
+test_expect_success "$pfx - rebase" '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
@@ -200,7 +202,7 @@ test_expect_success 'prompt - rebase' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - merge' '
+test_expect_success "$pfx - merge" '
 	printf " (b1|MERGING)" >expected &&
 	git checkout b1 &&
 	test_when_finished "git checkout master" &&
@@ -210,7 +212,7 @@ test_expect_success 'prompt - merge' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - cherry-pick' '
+test_expect_success "$pfx - cherry-pick" '
 	printf " (master|CHERRY-PICKING)" >expected &&
 	test_must_fail git cherry-pick b1 &&
 	test_when_finished "git reset --hard" &&
@@ -218,7 +220,7 @@ test_expect_success 'prompt - cherry-pick' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - bisect' '
+test_expect_success "$pfx - bisect" '
 	printf " (master|BISECTING)" >expected &&
 	git bisect start &&
 	test_when_finished "git bisect reset" &&
@@ -226,7 +228,7 @@ test_expect_success 'prompt - bisect' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - clean' '
+test_expect_success "$pfx - dirty status indicator - clean" '
 	printf " (master)" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
@@ -235,7 +237,7 @@ test_expect_success 'prompt - dirty status indicator - clean' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - dirty worktree' '
+test_expect_success "$pfx - dirty status indicator - dirty worktree" '
 	printf " (master *)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
@@ -246,7 +248,7 @@ test_expect_success 'prompt - dirty status indicator - dirty worktree' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - dirty index' '
+test_expect_success "$pfx - dirty status indicator - dirty index" '
 	printf " (master +)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
@@ -258,7 +260,7 @@ test_expect_success 'prompt - dirty status indicator - dirty index' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - dirty index and worktree' '
+test_expect_success "$pfx - dirty status indicator - dirty index and worktree" '
 	printf " (master *+)" >expected &&
 	echo "dirty index" >file &&
 	test_when_finished "git reset --hard" &&
@@ -271,7 +273,7 @@ test_expect_success 'prompt - dirty status indicator - dirty index and worktree'
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - before root commit' '
+test_expect_success "$pfx - dirty status indicator - before root commit" '
 	printf " (master #)" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
@@ -281,7 +283,7 @@ test_expect_success 'prompt - dirty status indicator - before root commit' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - shell variable unset with config disabled' '
+test_expect_success "$pfx - dirty status indicator - shell variable unset with config disabled" '
 	printf " (master)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
@@ -293,7 +295,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable unset with
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - shell variable unset with config enabled' '
+test_expect_success "$pfx - dirty status indicator - shell variable unset with config enabled" '
 	printf " (master)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
@@ -305,7 +307,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable unset with
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - shell variable set with config disabled' '
+test_expect_success "$pfx - dirty status indicator - shell variable set with config disabled" '
 	printf " (master)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
@@ -317,7 +319,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable set with c
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - shell variable set with config enabled' '
+test_expect_success "$pfx - dirty status indicator - shell variable set with config enabled" '
 	printf " (master *)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
@@ -329,7 +331,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable set with c
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - not shown inside .git directory' '
+test_expect_success "$pfx - dirty status indicator - not shown inside .git directory" '
 	printf " (GIT_DIR!)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
@@ -341,7 +343,7 @@ test_expect_success 'prompt - dirty status indicator - not shown inside .git dir
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - stash status indicator - no stash' '
+test_expect_success "$pfx - stash status indicator - no stash" '
 	printf " (master)" >expected &&
 	(
 		GIT_PS1_SHOWSTASHSTATE=y &&
@@ -350,7 +352,7 @@ test_expect_success 'prompt - stash status indicator - no stash' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - stash status indicator - stash' '
+test_expect_success "$pfx - stash status indicator - stash" '
 	printf " (master $)" >expected &&
 	echo 2 >file &&
 	git stash &&
@@ -363,7 +365,7 @@ test_expect_success 'prompt - stash status indicator - stash' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - stash status indicator - not shown inside .git directory' '
+test_expect_success "$pfx - stash status indicator - not shown inside .git directory" '
 	printf " (GIT_DIR!)" >expected &&
 	echo 2 >file &&
 	git stash &&
@@ -376,7 +378,7 @@ test_expect_success 'prompt - stash status indicator - not shown inside .git dir
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - untracked files status indicator - no untracked files' '
+test_expect_success "$pfx - untracked files status indicator - no untracked files" '
 	printf " (master)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
@@ -386,7 +388,7 @@ test_expect_success 'prompt - untracked files status indicator - no untracked fi
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - untracked files status indicator - untracked files' '
+test_expect_success "$pfx - untracked files status indicator - untracked files" '
 	printf " (master %%)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
@@ -395,7 +397,7 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - untracked files status indicator - shell variable unset with config disabled' '
+test_expect_success "$pfx - untracked files status indicator - shell variable unset with config disabled" '
 	printf " (master)" >expected &&
 	test_config bash.showUntrackedFiles false &&
 	(
@@ -405,7 +407,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - untracked files status indicator - shell variable unset with config enabled' '
+test_expect_success "$pfx - untracked files status indicator - shell variable unset with config enabled" '
 	printf " (master)" >expected &&
 	test_config bash.showUntrackedFiles true &&
 	(
@@ -415,7 +417,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - untracked files status indicator - shell variable set with config disabled' '
+test_expect_success "$pfx - untracked files status indicator - shell variable set with config disabled" '
 	printf " (master)" >expected &&
 	test_config bash.showUntrackedFiles false &&
 	(
@@ -425,7 +427,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - untracked files status indicator - shell variable set with config enabled' '
+test_expect_success "$pfx - untracked files status indicator - shell variable set with config enabled" '
 	printf " (master %%)" >expected &&
 	test_config bash.showUntrackedFiles true &&
 	(
@@ -435,7 +437,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - untracked files status indicator - not shown inside .git directory' '
+test_expect_success "$pfx - untracked files status indicator - not shown inside .git directory" '
 	printf " (GIT_DIR!)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
@@ -445,7 +447,7 @@ test_expect_success 'prompt - untracked files status indicator - not shown insid
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - format string starting with dash' '
+test_expect_success "$pfx - format string starting with dash" '
 	printf -- "-master" >expected &&
 	__git_ps1 "-%s" >"$actual" &&
 	test_cmp expected "$actual"
@@ -476,7 +478,7 @@ _run_pcmode_tests () {
 	*) error "invalid argument to _run_pcmode_tests: $ps1expansion";;
 	esac
 
-	test_expect_success "prompt - pc mode (PS1 expansion $ps1expansion)" '
+	test_expect_success "$shellname prompt - pc mode (PS1 expansion $ps1expansion)" '
 		pcmode_expected "BEFORE: (%s):AFTER\\n%s" master &&
 		printf "" >expected_output &&
 		(
@@ -487,7 +489,7 @@ _run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	pfx="prompt - bash color pc mode (PS1 expansion $ps1expansion)"
+	pfx="$shellname prompt - color pc mode (PS1 expansion $ps1expansion)"
 
 	test_expect_success "$pfx - branch name" '
 		pcmode_expected "BEFORE: (${c_green}%s${c_clear}):AFTER\\n%s" master &&
-- 
1.9.3
