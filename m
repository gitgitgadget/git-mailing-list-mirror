From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Tue, 12 Jun 2012 10:05:12 +0200
Message-ID: <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 10:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeM6f-0000H4-Gn
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 10:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab2FLIFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 04:05:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38192 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab2FLIFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 04:05:16 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5C7u5CY032038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 09:56:05 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5C85C9K025731;
	Tue, 12 Jun 2012 10:05:12 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q5C85CHt007169;
	Tue, 12 Jun 2012 10:05:12 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q5C85Cmp007168;
	Tue, 12 Jun 2012 10:05:12 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 12 Jun 2012 09:56:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5C7u5CY032038
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1340092568.30044@+EN07C77qvrip2qjVFE28w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199769>

This patch provides a way to automatically add these "exec" lines
between each commit applications. For instance, running 'git rebase -i
--exec "make test"' lets you check that intermediate commits are
compilable. It is also compatible with the option --autosquash. At
this point, you can't use --exec without the interactive mode (-i).

Tests about this new command are also added in
t3404-rebase-interactive.sh.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
The last test is changed to be consistent with the other
(thanks Johannes for reviewing the code).

 Documentation/git-rebase.txt  |   43 ++++++++++++++-
 git-rebase--interactive.sh    |   23 ++++++++
 git-rebase.sh                 |   20 ++++++-
 t/t3404-rebase-interactive.sh |  117 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 147fa1a..a2f1514 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,9 +8,9 @@ git-rebase - Forward-port local commits to the updated upstream head
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [options] [--onto <newbase>]
+'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	[<upstream>] [<branch>]
-'git rebase' [-i | --interactive] [options] --onto <newbase>
+'git rebase' [-i | --interactive] [options] [--exec <cmd>] --onto <newbase>
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort
 
@@ -210,6 +210,27 @@ rebase.autosquash::
 
 OPTIONS
 -------
+-x <cmd>::
+--exec <cmd>::
+	Append "exec <cmd>" after each commit application line. <cmd>
+	will be interpreted as one or more shell commands (see
+	INTERACTIVE MODE below).
++
+This option has to be used along with the `--interactive` option
+explicitly.  You may execute several commands between each commit
+applications.  For this, you can use one instance of exec:
++
+	git rebase -i --exec "cmd1; cmd2; ...".
++
+You can also insert several instances of exec, if you wish to only
+have one command per line. For example:
++
+	git rebase -i --exec "cmd1" --exec "cmd2" ...
++
+If --autosquash is used, the "exec" lines will not be appended for the
+intermediate commits, and will only appear at the end of each
+squash/fixup series.
+
 <newbase>::
 	Starting point at which to create the new commits. If the
 	--onto option is not specified, the starting point is
@@ -521,6 +542,24 @@ in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
 use shell features (like "cd", ">", ";" ...). The command is run from
 the root of the working tree.
 
+----------------------------------
+$ git rebase -i --exec "make test"
+----------------------------------
+
+This command lets you check that intermediate commits are compilable.
+The todo list becomes like that:
+
+--------------------
+pick 5928aea one
+exec make test
+pick 04d0fda two
+exec make test
+pick ba46169 three
+exec make test
+pick f4593f9 four
+exec make test
+--------------------
+
 SPLITTING COMMITS
 -----------------
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..5f56672 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -684,6 +684,27 @@ rearrange_squash () {
 	rm -f "$1.sq" "$1.rearranged"
 }
 
+# Add commands after a pick or after a squash/fixup serie
+# in the todo list.
+add_exec_commands () {
+	{
+		first=t
+		while read -r insn rest
+		do
+			case $insn in
+			pick)
+				test -n "$first" ||
+				printf "%s" "$cmd"
+				;;
+			esac
+			printf "%s %s\n" "$insn" "$rest"
+			first=
+		done
+		printf "%s" "$cmd"
+	} <"$1" >"$1.new" &&
+	mv "$1.new" "$1"
+}
+
 case "$action" in
 continue)
 	# do we have anything to commit?
@@ -857,6 +878,8 @@ fi
 
 test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
+test -n "$cmd" && add_exec_commands "$todo"
+
 cat >> "$todo" << EOF
 
 # Rebase $shortrevisions onto $shortonto
diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..2952bc0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
+USAGE='[--interactive | -i] [--exec | -x <cmd>] [-v] [--force-rebase | -f]
+       [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -30,8 +31,8 @@ Example:       git-rebase master~1 topic
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
-git rebase [-i] [options] --onto <newbase> --root [<branch>]
+git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
+git rebase [-i] [options] [--exec <cmd>] --onto <newbase> --root [<branch>]
 git-rebase [-i] --continue | --abort | --skip
 --
  Available options are
@@ -43,6 +44,7 @@ s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
+x,exec=!           add exec lines after each commit of the editable list
 k,keep-empty	   preserve empty commits during rebase
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
@@ -76,6 +78,7 @@ If you would prefer to skip this patch, instead run \"git rebase --skip\".
 To check out the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset onto
+cmd=
 strategy=
 strategy_opts=
 do_merge=
@@ -219,6 +222,11 @@ do
 		onto="$2"
 		shift
 		;;
+	-x)
+		test 2 -le "$#" || usage
+		cmd="${cmd}exec $2${LF}"
+		shift
+		;;
 	-i)
 		interactive_rebase=explicit
 		;;
@@ -304,6 +312,12 @@ do
 done
 test $# -gt 2 && usage
 
+if test -n "$cmd" &&
+   test "$interactive_rebase" != explicit
+then
+	die "--exec option must be used with --interactive option"
+fi
+
 if test -n "$action"
 then
 	test -z "$in_progress" && die "No rebase in progress?"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 025c1c6..68d6148 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,121 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+
+test_expect_success 'prepare for rebase -i --exec' '
+	git checkout master &&
+	git checkout -b execute &&
+	test_commit one_exec main.txt one_exec &&
+	test_commit two_exec main.txt two_exec &&
+	test_commit three_exec main.txt three_exec
+'
+
+
+test_expect_success 'running "git rebase -i --exec git show HEAD"' '
+	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expect
+	) &&
+	sed -e "1,9d" expect >expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase --exec git show HEAD -i"' '
+	git reset --hard execute &&
+	git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expect
+	) &&
+	sed -e "1,9d" expect >expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase -ix git show HEAD"' '
+	git reset --hard execute &&
+	git rebase -ix "git show HEAD" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expect
+	) &&
+	sed -e "1,9d" expect >expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several <CMD>' '
+	git reset --hard execute &&
+	git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expect
+	) &&
+	sed -e "1,9d" expect >expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several instances of --exec' '
+	git reset --hard execute &&
+	git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD exec_pwd 2
+				exec_git_show_HEAD exec_pwd" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expect
+	) &&
+	sed -e "1,11d" expect >expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with --autosquash' '
+	git reset --hard execute &&
+	git checkout -b autosquash &&
+	echo second >second.txt &&
+	git add second.txt &&
+	git commit -m "fixup! two_exec" &&
+	echo bis >bis.txt &&
+	git add bis.txt &&
+	git commit -m "fixup! two_exec" &&
+	(
+		git checkout -b autosquash_actual &&
+		git rebase -i --exec "git show HEAD" --autosquash HEAD~4 >actual
+	) &&
+	git checkout autosquash &&
+	(
+		git checkout -b autosquash_expected &&
+		FAKE_LINES="1 fixup 3 fixup 4 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~4 >expect
+	) &&
+	sed -e "1,13d" expect >expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase --exec without -i shows error message' '
+	git reset --hard execute &&
+	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
+	echo "--exec option must be used with --interactive option" >expected &&
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'rebase -i --exec without <CMD>' '
+	git reset --hard execute &&
+	test_must_fail git rebase -i --exec 2>tmp &&
+	sed -e "1d" tmp >actual &&
+	test_must_fail git rebase -h >expected &&
+	test_cmp expected actual &&
+	git checkout master
+'
+
 test_done
-- 
1.7.8
