From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 02/19] tests: add tests for the bash prompt functions in the
	completion script
Date: Wed,  9 May 2012 02:44:33 +0200
Message-ID: <1336524290-30023-3-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv2I-0004qr-Qm
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab2EIApe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:45:34 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:49976 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223Ab2EIAp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:45:27 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LapmW-1RhXeY1WXo-00l0Hl; Wed, 09 May 2012 02:45:26 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:nfbPQ8c3aNRvegyyapZlHyGIklypabelwYW/jPZmi+l
 UgSKCmDs+lwINc9MK/q2gKQR4q7UZXlAi7O3bcSeGd4bnKTTY9
 P7aUaR6oBNSTGefwG9j/YQnb+86aZJH92QzP3ArUilK7eP0P1+
 RK3JBAwpik4jRNqZ1FVDsy7pa5tERevvL55Rya57FcB87Rq9O/
 PtLBSvGOF9Wl6f3DlRqF5hnsu/bpahZMZCDS+wC5buCrN6OXNX
 KcOp2gWiQf+Z1H5YrPYbgzUXv2AJ76dgrrZwuNdczMmPkRYD0U
 SOG6+6NMJ5qntfV51qWJSWdOCqMLyBzplYtONhjZyNS1iU5M/D
 6Rg78oE341wkl8z1fG9CzFFzraXWb3YrYLU5ve7Y2i4QZAQ81X
 ambE7Ko3MPCEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197435>

The tests cover the discovery of the '.git' directory in the
__gitdir() function in different scenarios, and the prompt itself,
i.e. branch name, detached heads, operations (rebase, merge,
cherry-pick, bisect), and status indicators (dirty, stash, untracked
files; but not the upstream status).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 448 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 448 insertions(+)
 create mode 100755 t/t9903-bash-prompt.sh

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
new file mode 100755
index 00000000..a6c9ce94
--- /dev/null
+++ b/t/t9903-bash-prompt.sh
@@ -0,0 +1,448 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 SZEDER G=C3=A1bor
+#
+
+test_description=3D'test git-specific bash prompt functions'
+
+. ./lib-bash.sh
+
+. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+
+actual=3D"$TRASH_DIRECTORY/actual"
+
+test_expect_success 'setup for prompt tests' '
+	mkdir -p subdir/subsubdir &&
+	git init otherrepo &&
+	echo 1 > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git tag -a -m msg1 t1 &&
+	git checkout -b b1 &&
+	echo 2 > file &&
+	git commit -m "second b1" file &&
+	echo 3 > file &&
+	git commit -m "third b1" file &&
+	git tag -a -m msg2 t2 &&
+	git checkout -b b2 master &&
+	echo 0 > file &&
+	git commit -m "second b2" file &&
+	git checkout master
+'
+
+test_expect_success 'gitdir - from command line (through $__git_dir)' =
'
+	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	(
+		__git_dir=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - repo as argument' '
+	echo "otherrepo/.git" > expected &&
+	__gitdir "otherrepo" > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - remote as argument' '
+	echo "remote" > expected &&
+	__gitdir "remote" > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - .git directory in cwd' '
+	echo ".git" > expected &&
+	__gitdir > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - .git directory in parent' '
+	echo "$TRASH_DIRECTORY/.git" > expected &&
+	(
+		cd subdir/subsubdir &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - cwd is a .git directory' '
+	echo "." > expected &&
+	(
+		cd .git &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - parent is a .git directory' '
+	echo "$TRASH_DIRECTORY/.git" > expected &&
+	(
+		cd .git/refs/heads &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	(
+		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		export GIT_DIR &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - $GIT_DIR set while .git directory in par=
ent' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	(
+		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		export GIT_DIR &&
+		cd subdir &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - gitfile in cwd' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	test_when_finished "rm -f subdir/.git" &&
+	(
+		cd subdir &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - gitfile in parent' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	test_when_finished "rm -f subdir/.git" &&
+	(
+		cd subdir/subsubdir &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks'=
 '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	mkdir otherrepo/dir &&
+	test_when_finished "rm -rf otherrepo/dir" &&
+	ln -s otherrepo/dir link &&
+	test_when_finished "rm -f link" &&
+	(
+		cd link &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'gitdir - not a git repository' '
+	(
+		cd subdir/subsubdir &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
+		export GIT_CEILING_DIRECTORIES &&
+		test_must_fail __gitdir
+	)
+'
+
+test_expect_success 'prompt - branch name' '
+	printf " (master)" > expected &&
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - detached head' '
+	printf " ((%s...))" $(git log -1 --format=3D"%h" b1^) > expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - describe detached head - contains' '
+	printf " ((t2~1))" > expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		GIT_PS1_DESCRIBE_STYLE=3Dcontains &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - describe detached head - branch' '
+	printf " ((b1~1))" > expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		GIT_PS1_DESCRIBE_STYLE=3Dbranch &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - describe detached head - describe' '
+	printf " ((t1-1-g%s))" $(git log -1 --format=3D"%h" b1^) > expected &=
&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		GIT_PS1_DESCRIBE_STYLE=3Ddescribe &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - describe detached head - default' '
+	printf " ((t2))" > expected &&
+	git checkout --detach b1 &&
+	test_when_finished "git checkout master" &&
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - inside .git directory' '
+	printf " (GIT_DIR!)" > expected &&
+	(
+		cd .git &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - deep inside .git directory' '
+	printf " (GIT_DIR!)" > expected &&
+	(
+		cd .git/refs/heads &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - inside bare repository' '
+	printf " (BARE:master)" > expected &&
+	git init --bare bare.git &&
+	test_when_finished "rm -rf bare.git" &&
+	(
+		cd bare.git &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - interactive rebase' '
+	printf " (b1|REBASE-i)" > expected
+	echo "#!$SHELL_PATH" >fake_editor.sh &&
+	cat >>fake_editor.sh <<\EOF &&
+echo "edit $(git log -1 --format=3D"%h")" > "$1"
+EOF
+	test_when_finished "rm -f fake_editor.sh" &&
+	chmod a+x fake_editor.sh &&
+	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
+	git checkout b1 &&
+	test_when_finished "git checkout master" &&
+	git rebase -i HEAD^ &&
+	test_when_finished "git rebase --abort"
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - rebase merge' '
+	printf " (b2|REBASE-m)" > expected &&
+	git checkout b2 &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git rebase --merge b1 b2 &&
+	test_when_finished "git rebase --abort" &&
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - rebase' '
+	printf " ((t2)|REBASE)" > expected &&
+	git checkout b2 &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git rebase b1 b2 &&
+	test_when_finished "git rebase --abort" &&
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - merge' '
+	printf " (b1|MERGING)" > expected &&
+	git checkout b1 &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git merge b2 &&
+	test_when_finished "git reset --hard" &&
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - cherry-pick' '
+	printf " (master|CHERRY-PICKING)" > expected &&
+	test_must_fail git cherry-pick b1 &&
+	test_when_finished "git reset --hard" &&
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bisect' '
+	printf " (master|BISECTING)" > expected &&
+	git bisect start &&
+	test_when_finished "git bisect reset" &&
+	__git_ps1 > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - clean' '
+	printf " (master)" > expected &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - dirty worktree'=
 '
+	printf " (master *)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - dirty index' '
+	printf " (master +)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - dirty index and=
 worktree' '
+	printf " (master *+)" > expected &&
+	echo "dirty index" > file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	echo "dirty worktree" > file &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - before root com=
mit' '
+	printf " (master #)" > expected &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		cd otherrepo &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - disabled by con=
fig' '
+	printf " (master)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState false &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - not shown insid=
e .git directory' '
+	printf " (GIT_DIR!)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
+		cd .git &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - stash status indicator - no stash' '
+	printf " (master)" > expected &&
+	(
+		GIT_PS1_SHOWSTASHSTATE=3Dy &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - stash status indicator - stash' '
+	printf " (master $)" > expected &&
+	echo 2 >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	(
+		GIT_PS1_SHOWSTASHSTATE=3Dy &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - stash status indicator - not shown insid=
e .git directory' '
+	printf " (GIT_DIR!)" > expected &&
+	echo 2 >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	(
+		GIT_PS1_SHOWSTASHSTATE=3Dy &&
+		cd .git &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - untracked files status indicator - no un=
tracked files' '
+	printf " (master)" > expected &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		cd otherrepo &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - untracked files status indicator - untra=
cked files' '
+	printf " (master %%)" > expected &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - untracked files status indicator - not s=
hown inside .git directory' '
+	printf " (GIT_DIR!)" > expected &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		cd .git &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - format string starting with dash' '
+	printf -- "-master" > expected &&
+	__git_ps1 "-%s" > "$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_done
--=20
1.7.10.1.541.gb1be298
