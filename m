From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 08/11] lib-prompt-tests.sh: put all tests inside a function
Date: Wed,  4 Jun 2014 17:01:24 -0400
Message-ID: <1401915687-8602-9-git-send-email-rhansen@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:03:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsILE-0006ML-5W
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbaFDVB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 17:01:59 -0400
Received: from smtp.bbn.com ([128.33.1.81]:52249 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbaFDVB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:01:56 -0400
Received: from socket.bbn.com ([192.1.120.102]:36570)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsIJz-000DMm-Kx; Wed, 04 Jun 2014 17:02:07 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id BE67B3FFFC
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250791>

Modify lib-prompt-tests.sh so that it does nothing when sourced except
define a function for running the prompt tests (plus some "private"
helper functions).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-prompt-tests.sh  | 802 ++++++++++++++++++++++++-------------------------
 t/t9903-bash-prompt.sh |   2 +
 2 files changed, 403 insertions(+), 401 deletions(-)

diff --git a/t/lib-prompt-tests.sh b/t/lib-prompt-tests.sh
index 7aaeb8e..ba22acc 100644
--- a/t/lib-prompt-tests.sh
+++ b/t/lib-prompt-tests.sh
@@ -17,6 +17,7 @@
 #      these variables are used in the first argument to the printf
 #      command, so they must be escaped appropriately.
 #   4. source this library
+#   5. invoke the run_prompt_tests function
 
 # sanity checks
 [ -n "$shellname" ] || error "shellname must be set to the name of the shell"
@@ -27,448 +28,445 @@ done
 (ps1_expansion_enable || ps1_expansion_disable) \
 	|| error "either ps1_expansion_enable or ps1_expansion_disable must return true"
 
-. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
+_run_non_pcmode_tests () {
+	test_expect_success "setup for $shellname prompt tests" '
+		git init otherrepo &&
+		echo 1 >file &&
+		git add file &&
+		test_tick &&
+		git commit -m initial &&
+		git tag -a -m msg1 t1 &&
+		git checkout -b b1 &&
+		echo 2 >file &&
+		git commit -m "second b1" file &&
+		echo 3 >file &&
+		git commit -m "third b1" file &&
+		git tag -a -m msg2 t2 &&
+		git checkout -b b2 master &&
+		echo 0 >file &&
+		git commit -m "second b2" file &&
+		echo 00 >file &&
+		git commit -m "another b2" file &&
+		echo 000 >file &&
+		git commit -m "yet another b2" file &&
+		git checkout master
+	'
 
-actual="$TRASH_DIRECTORY/actual"
-set_ps1_format_vars
+	pfx="$shellname prompt"
 
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
+	test_expect_success "$pfx - branch name" '
+		printf " (master)" >expected &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-pfx="$shellname prompt"
+	test_expect_success SYMLINKS "$pfx - branch name - symlink symref" '
+		printf " (master)" >expected &&
+		test_when_finished "git checkout master" &&
+		test_config core.preferSymlinkRefs true &&
+		git checkout master &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - branch name" '
-	printf " (master)" >expected &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - unborn branch" '
+		printf " (unborn)" >expected &&
+		git checkout --orphan unborn &&
+		test_when_finished "git checkout master" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
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
-repo_with_newline='repo
+	repo_with_newline='repo
 with
 newline'
 
-if mkdir "$repo_with_newline" 2>/dev/null
-then
-	test_set_prereq FUNNYNAMES
-else
-	say 'Your filesystem does not allow newlines in filenames.'
-fi
+	if mkdir "$repo_with_newline" 2>/dev/null
+	then
+		test_set_prereq FUNNYNAMES
+	else
+		say 'Your filesystem does not allow newlines in filenames.'
+	fi
 
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
+	test_expect_success FUNNYNAMES "$pfx - with newline in path" '
+		printf " (master)" >expected &&
+		git init "$repo_with_newline" &&
+		test_when_finished "rm -rf \"$repo_with_newline\"" &&
+		mkdir "$repo_with_newline"/subdir &&
+		(
+			cd "$repo_with_newline/subdir" &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - detached head" '
-	printf " ((%s...))" $(git log -1 --format="%h" --abbrev=13 b1^) >expected &&
-	test_config core.abbrev 13 &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - detached head" '
+		printf " ((%s...))" $(git log -1 --format="%h" --abbrev=13 b1^) >expected &&
+		test_config core.abbrev 13 &&
+		git checkout b1^ &&
+		test_when_finished "git checkout master" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - describe detached head - contains" '
-	printf " ((t2~1))" >expected &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	(
-		GIT_PS1_DESCRIBE_STYLE=contains &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - describe detached head - contains" '
+		printf " ((t2~1))" >expected &&
+		git checkout b1^ &&
+		test_when_finished "git checkout master" &&
+		(
+			GIT_PS1_DESCRIBE_STYLE=contains &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - describe detached head - branch" '
-	printf " ((b1~1))" >expected &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	(
-		GIT_PS1_DESCRIBE_STYLE=branch &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - describe detached head - branch" '
+		printf " ((b1~1))" >expected &&
+		git checkout b1^ &&
+		test_when_finished "git checkout master" &&
+		(
+			GIT_PS1_DESCRIBE_STYLE=branch &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - describe detached head - describe" '
-	printf " ((t1-1-g%s))" $(git log -1 --format="%h" b1^) >expected &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	(
-		GIT_PS1_DESCRIBE_STYLE=describe &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - describe detached head - describe" '
+		printf " ((t1-1-g%s))" $(git log -1 --format="%h" b1^) >expected &&
+		git checkout b1^ &&
+		test_when_finished "git checkout master" &&
+		(
+			GIT_PS1_DESCRIBE_STYLE=describe &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - describe detached head - default" '
-	printf " ((t2))" >expected &&
-	git checkout --detach b1 &&
-	test_when_finished "git checkout master" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - describe detached head - default" '
+		printf " ((t2))" >expected &&
+		git checkout --detach b1 &&
+		test_when_finished "git checkout master" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - inside .git directory" '
-	printf " (GIT_DIR!)" >expected &&
-	(
-		cd .git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - inside .git directory" '
+		printf " (GIT_DIR!)" >expected &&
+		(
+			cd .git &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - deep inside .git directory" '
-	printf " (GIT_DIR!)" >expected &&
-	(
-		cd .git/refs/heads &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - deep inside .git directory" '
+		printf " (GIT_DIR!)" >expected &&
+		(
+			cd .git/refs/heads &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
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
+	test_expect_success "$pfx - inside bare repository" '
+		printf " (BARE:master)" >expected &&
+		git init --bare bare.git &&
+		test_when_finished "rm -rf bare.git" &&
+		(
+			cd bare.git &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - interactive rebase" '
-	printf " (b1|REBASE-i 2/3)" >expected
-	write_script fake_editor.sh <<-\EOF &&
-		echo "exec echo" >"$1"
-		echo "edit $(git log -1 --format="%h")" >>"$1"
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
+	test_expect_success "$pfx - interactive rebase" '
+		printf " (b1|REBASE-i 2/3)" >expected
+		write_script fake_editor.sh <<-\EOF &&
+			echo "exec echo" >"$1"
+			echo "edit $(git log -1 --format="%h")" >>"$1"
+			echo "exec echo" >>"$1"
+		EOF
+		test_when_finished "rm -f fake_editor.sh" &&
+		test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
+		git checkout b1 &&
+		test_when_finished "git checkout master" &&
+		git rebase -i HEAD^ &&
+		test_when_finished "git rebase --abort"
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - rebase merge" '
-	printf " (b2|REBASE-m 1/3)" >expected &&
-	git checkout b2 &&
-	test_when_finished "git checkout master" &&
-	test_must_fail git rebase --merge b1 b2 &&
-	test_when_finished "git rebase --abort" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - rebase merge" '
+		printf " (b2|REBASE-m 1/3)" >expected &&
+		git checkout b2 &&
+		test_when_finished "git checkout master" &&
+		test_must_fail git rebase --merge b1 b2 &&
+		test_when_finished "git rebase --abort" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - rebase" '
-	printf " (b2|REBASE 1/3)" >expected &&
-	git checkout b2 &&
-	test_when_finished "git checkout master" &&
-	test_must_fail git rebase b1 b2 &&
-	test_when_finished "git rebase --abort" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - rebase" '
+		printf " (b2|REBASE 1/3)" >expected &&
+		git checkout b2 &&
+		test_when_finished "git checkout master" &&
+		test_must_fail git rebase b1 b2 &&
+		test_when_finished "git rebase --abort" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - merge" '
-	printf " (b1|MERGING)" >expected &&
-	git checkout b1 &&
-	test_when_finished "git checkout master" &&
-	test_must_fail git merge b2 &&
-	test_when_finished "git reset --hard" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - merge" '
+		printf " (b1|MERGING)" >expected &&
+		git checkout b1 &&
+		test_when_finished "git checkout master" &&
+		test_must_fail git merge b2 &&
+		test_when_finished "git reset --hard" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - cherry-pick" '
-	printf " (master|CHERRY-PICKING)" >expected &&
-	test_must_fail git cherry-pick b1 &&
-	test_when_finished "git reset --hard" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - cherry-pick" '
+		printf " (master|CHERRY-PICKING)" >expected &&
+		test_must_fail git cherry-pick b1 &&
+		test_when_finished "git reset --hard" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - bisect" '
-	printf " (master|BISECTING)" >expected &&
-	git bisect start &&
-	test_when_finished "git bisect reset" &&
-	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - bisect" '
+		printf " (master|BISECTING)" >expected &&
+		git bisect start &&
+		test_when_finished "git bisect reset" &&
+		__git_ps1 >"$actual" &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - clean" '
-	printf " (master)" >expected &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - dirty status indicator - clean" '
+		printf " (master)" >expected &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - dirty worktree" '
-	printf " (master *)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - dirty status indicator - dirty worktree" '
+		printf " (master *)" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - dirty index" '
-	printf " (master +)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	git add -u &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - dirty status indicator - dirty index" '
+		printf " (master +)" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		git add -u &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - dirty index and worktree" '
-	printf " (master *+)" >expected &&
-	echo "dirty index" >file &&
-	test_when_finished "git reset --hard" &&
-	git add -u &&
-	echo "dirty worktree" >file &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - dirty status indicator - dirty index and worktree" '
+		printf " (master *+)" >expected &&
+		echo "dirty index" >file &&
+		test_when_finished "git reset --hard" &&
+		git add -u &&
+		echo "dirty worktree" >file &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - before root commit" '
-	printf " (master #)" >expected &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		cd otherrepo &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - dirty status indicator - before root commit" '
+		printf " (master #)" >expected &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			cd otherrepo &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - shell variable unset with config disabled" '
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
+	test_expect_success "$pfx - dirty status indicator - shell variable unset with config disabled" '
+		printf " (master)" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		test_config bash.showDirtyState false &&
+		(
+			sane_unset GIT_PS1_SHOWDIRTYSTATE &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - shell variable unset with config enabled" '
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
+	test_expect_success "$pfx - dirty status indicator - shell variable unset with config enabled" '
+		printf " (master)" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		test_config bash.showDirtyState true &&
+		(
+			sane_unset GIT_PS1_SHOWDIRTYSTATE &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - shell variable set with config disabled" '
-	printf " (master)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	test_config bash.showDirtyState false &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - dirty status indicator - shell variable set with config disabled" '
+		printf " (master)" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		test_config bash.showDirtyState false &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - shell variable set with config enabled" '
-	printf " (master *)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	test_config bash.showDirtyState true &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - dirty status indicator - shell variable set with config enabled" '
+		printf " (master *)" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		test_config bash.showDirtyState true &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - dirty status indicator - not shown inside .git directory" '
-	printf " (GIT_DIR!)" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		cd .git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - dirty status indicator - not shown inside .git directory" '
+		printf " (GIT_DIR!)" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			cd .git &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - stash status indicator - no stash" '
-	printf " (master)" >expected &&
-	(
-		GIT_PS1_SHOWSTASHSTATE=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - stash status indicator - no stash" '
+		printf " (master)" >expected &&
+		(
+			GIT_PS1_SHOWSTASHSTATE=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - stash status indicator - stash" '
-	printf " (master $)" >expected &&
-	echo 2 >file &&
-	git stash &&
-	test_when_finished "git stash drop" &&
-	git pack-refs --all &&
-	(
-		GIT_PS1_SHOWSTASHSTATE=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - stash status indicator - stash" '
+		printf " (master $)" >expected &&
+		echo 2 >file &&
+		git stash &&
+		test_when_finished "git stash drop" &&
+		git pack-refs --all &&
+		(
+			GIT_PS1_SHOWSTASHSTATE=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - stash status indicator - not shown inside .git directory" '
-	printf " (GIT_DIR!)" >expected &&
-	echo 2 >file &&
-	git stash &&
-	test_when_finished "git stash drop" &&
-	(
-		GIT_PS1_SHOWSTASHSTATE=y &&
-		cd .git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - stash status indicator - not shown inside .git directory" '
+		printf " (GIT_DIR!)" >expected &&
+		echo 2 >file &&
+		git stash &&
+		test_when_finished "git stash drop" &&
+		(
+			GIT_PS1_SHOWSTASHSTATE=y &&
+			cd .git &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - untracked files status indicator - no untracked files" '
-	printf " (master)" >expected &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=y &&
-		cd otherrepo &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - untracked files status indicator - no untracked files" '
+		printf " (master)" >expected &&
+		(
+			GIT_PS1_SHOWUNTRACKEDFILES=y &&
+			cd otherrepo &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - untracked files status indicator - untracked files" '
-	printf " (master %%)" >expected &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - untracked files status indicator - untracked files" '
+		printf " (master %%)" >expected &&
+		(
+			GIT_PS1_SHOWUNTRACKEDFILES=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - untracked files status indicator - shell variable unset with config disabled" '
-	printf " (master)" >expected &&
-	test_config bash.showUntrackedFiles false &&
-	(
-		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - untracked files status indicator - shell variable unset with config disabled" '
+		printf " (master)" >expected &&
+		test_config bash.showUntrackedFiles false &&
+		(
+			sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - untracked files status indicator - shell variable unset with config enabled" '
-	printf " (master)" >expected &&
-	test_config bash.showUntrackedFiles true &&
-	(
-		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - untracked files status indicator - shell variable unset with config enabled" '
+		printf " (master)" >expected &&
+		test_config bash.showUntrackedFiles true &&
+		(
+			sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - untracked files status indicator - shell variable set with config disabled" '
-	printf " (master)" >expected &&
-	test_config bash.showUntrackedFiles false &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - untracked files status indicator - shell variable set with config disabled" '
+		printf " (master)" >expected &&
+		test_config bash.showUntrackedFiles false &&
+		(
+			GIT_PS1_SHOWUNTRACKEDFILES=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - untracked files status indicator - shell variable set with config enabled" '
-	printf " (master %%)" >expected &&
-	test_config bash.showUntrackedFiles true &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=y &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - untracked files status indicator - shell variable set with config enabled" '
+		printf " (master %%)" >expected &&
+		test_config bash.showUntrackedFiles true &&
+		(
+			GIT_PS1_SHOWUNTRACKEDFILES=y &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - untracked files status indicator - not shown inside .git directory" '
-	printf " (GIT_DIR!)" >expected &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=y &&
-		cd .git &&
-		__git_ps1 >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - untracked files status indicator - not shown inside .git directory" '
+		printf " (GIT_DIR!)" >expected &&
+		(
+			GIT_PS1_SHOWUNTRACKEDFILES=y &&
+			cd .git &&
+			__git_ps1 >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success "$pfx - format string starting with dash" '
-	printf -- "-master" >expected &&
-	__git_ps1 "-%s" >"$actual" &&
-	test_cmp expected "$actual"
-'
+	test_expect_success "$pfx - format string starting with dash" '
+		printf -- "-master" >expected &&
+		__git_ps1 "-%s" >"$actual" &&
+		test_cmp expected "$actual"
+	'
+}
 
 pcmode_expected () {
 	case $ps1expansion in
@@ -645,9 +643,11 @@ _run_pcmode_tests () {
 	'
 }
 
-run_pcmode_tests () {
+run_prompt_tests () {
+	. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
+	actual="$TRASH_DIRECTORY/actual"
+	set_ps1_format_vars
+	_run_non_pcmode_tests
 	_run_pcmode_tests on
 	_run_pcmode_tests off
 }
-
-run_pcmode_tests
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index b698fe9..858f0cd 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -8,4 +8,6 @@ test_description='test git-specific bash prompt functions'
 . ./lib-bash.sh
 . "$TEST_DIRECTORY"/lib-prompt-tests.sh
 
+run_prompt_tests
+
 test_done
-- 
2.0.0
