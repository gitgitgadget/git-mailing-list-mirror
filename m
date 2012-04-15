From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] tests: add tests for the bash prompt functions in the
	completion script
Date: Sun, 15 Apr 2012 22:31:49 +0200
Message-ID: <1334521909-32581-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 22:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJW81-0004Ed-10
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 22:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab2DOUcZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 16:32:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54507 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2DOUcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 16:32:24 -0400
Received: from localhost6.localdomain6 (p5B13091B.dip0.t-ipconnect.de [91.19.9.27])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Lpzv9-1Rp7e23ClT-00fA8g; Sun, 15 Apr 2012 22:32:18 +0200
X-Mailer: git-send-email 1.7.10.177.g26c39
X-Provags-ID: V02:K0:oqBoDKhkRX4qf7PY0l/3Rop+NZw80LRciFD2fKQmOhI
 dOxTZjDob4/ynTtRFOiAGinetduAXEycaxnOuQ+Ao2txit5EaW
 RGoTFBhpd2cB8/39jQKl8D/pFFU/Wa6CbGe2K/6TrMesshZlPU
 S8zkVP2PtdCLuBAqLjs2zDar4dy9r5iVzT0XbCiq6XeKvcSypB
 B5M7KuZuZrM6KQP6cTdp7XyPfZWKb/jH3MqmsA2npa16jo/Dxj
 hiE2HY1KIc7zCSn1+9bisgozyUQ0MdAx8KmZ0mDcLjFmIDG9Mr
 bTlzjkLC4JuItpAf5FhRzgva0Hd3nWv+Q6zzZnQ8IE4BbPvo86
 qtI1TzGq3h9IgT52lZjMyeYvi7crNUn1a20YEJVSBjLkWergoQ
 1xqWz8tKURCog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195587>

The tests cover the discovery of the .git directory in the __gitdir()
function in different scenarios, and the prompt itself, i.e. branch
name, detached heads, operations (rebase, merge, cherry-pick, bisect),
and status indicators (dirty, stash, untracked files; but not the
upstream status).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

Goes on top of fc/completion-tests (b8574ba7).

 t/t9902-completion.sh |  436 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 436 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3bbec79b..6edbaa72 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -114,4 +114,440 @@ test_expect_success 'double dash "git checkout"' =
'
 	test_completion "git checkout --"
 '
=20
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
+		cd subdir &&
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
+		cd .git/refs &&
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
+	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	mkdir otherrepo/dir &&
+	test_when_finished "rm -rf otherrepo/dir" &&
+	ln -s otherrepo/dir link &&
+	test_when_finished "rm -f link" &&
+	(
+		cd link &&
+		__gitdir > "$actual"
+	) &&
+	test_cmp expected actual
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
+		cd .git/refs &&
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
 test_done
--=20
1.7.10.177.g26c39
