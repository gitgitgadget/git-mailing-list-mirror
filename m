From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCH] rebase [-i --exec | -ix] <CMD>...
Date: Mon,  4 Jun 2012 15:47:54 +0200
Message-ID: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 15:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbXdc-0000gh-B4
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 15:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab2FDNr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 09:47:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44337 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856Ab2FDNr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 09:47:57 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54DdM04024184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 15:39:22 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q54Dls0h012877;
	Mon, 4 Jun 2012 15:47:54 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q54Dls7d023244;
	Mon, 4 Jun 2012 15:47:54 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q54DlsQF023243;
	Mon, 4 Jun 2012 15:47:54 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 15:39:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54DdM04024184
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339421963.60671@mj5s+OUzSMTH/+phHfWd5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199136>

This patch provides a way to automatically add these "exec" lines
between each commit applications. For instance, running 'git rebase -i
--exec "make test"' lets you check that intermediate commits are
compilable.  At this point, you can't use --exec without the
interactive mode (-i).

Tests about this new command are also added in
t3404-rebase-interactive.sh.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/git-rebase.txt  |   43 ++++++++++++++++++++++-
 git-rebase--interactive.sh    |   13 +++++++
 git-rebase.sh                 |   35 +++++++++++++++++--
 t/t3404-rebase-interactive.sh |   74 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 147fa1a..96dbf26 100644
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
 
@@ -210,6 +210,17 @@ rebase.autosquash::
 
 OPTIONS
 -------
+<cmd>::
+	Shell command executed between each commit applications. The
+	--exec option has to be specified.
++
+You may execute several commands between each commit applications.
+Therefore, you can use one instance of exec:
+	git rebase -i --exec "cmd1; cmd2; ...".
+You can also insert several instances of exec, if you wish to
+only have one command per line for example:
+	git rebase -i --exec "cmd1" --exec "cmd2" ...
+
 <newbase>::
 	Starting point at which to create the new commits. If the
 	--onto option is not specified, the starting point is
@@ -336,6 +347,13 @@ link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
 	user edit that list before rebasing.  This mode can also be used to
 	split commits (see SPLITTING COMMITS below).
 
+-x::
+--exec::
+	Automatically add "exec" followed by <cmd> between each commit
+	applications (see INTERACTIVE MODE below).
++
+This has to be used along with the `--interactive` option explicitly.
+
 -p::
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
@@ -521,6 +539,27 @@ in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
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
+If the option '-i' is missing, The command will return the usage page
+of "git rebase". Same if there is no <cmd> specified behind --exec.
+
 SPLITTING COMMITS
 -----------------
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..7444160 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -876,6 +876,19 @@ cat >> "$todo" << EOF
 #
 EOF
 
+if test -n "$cmd"
+then
+	OIFS=$IFS
+	IFS=','
+	for i in $cmd
+	do
+		sed "/^pick .*/aexec $i" "$todo" >tmp
+		cat tmp >"$todo"
+	done
+	rm tmp
+	IFS=$OIFS
+fi
+
 if test -z "$keep_empty"
 then
 	echo "# Note that empty commits are commented out" >>"$todo"
diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..a8b1793 100755
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
+unset cmd
 strategy=
 strategy_opts=
 do_merge=
@@ -219,6 +222,24 @@ do
 		onto="$2"
 		shift
 		;;
+	-x)
+		exec_flag=true
+		test 3 -le "$#" || usage
+		if orig_head=$(git rev-parse -q --verify "$2") ||
+		   test `expr substr "$2" 1 1` = -
+		then
+			echo "You must specify a command after --exec option\n"
+			usage
+		else
+			if test -n "$cmd"
+			then
+				cmd="$2,$cmd"
+			else
+				cmd="$2"
+			fi
+		fi
+		shift
+		;;
 	-i)
 		interactive_rebase=explicit
 		;;
@@ -304,6 +325,13 @@ do
 done
 test $# -gt 2 && usage
 
+if test -n "$exec_flag" &&
+   test -z "$interactive_rebase"
+then
+	echo "--exec option must be used with --interactive option\n"
+	usage
+fi
+
 if test -n "$action"
 then
 	test -z "$in_progress" && die "No rebase in progress?"
@@ -348,7 +376,6 @@ abort)
 	exit
 	;;
 esac
-
 # Make sure no rebase is in progress
 if test -n "$in_progress"
 then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 025c1c6..2976f07 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,78 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+
+test_expect_success 'running "git rebase -i --exec git show HEAD"' '
+	git checkout master &&
+	git checkout -b execute &&
+	test_commit one_exec main.txt one_exec &&
+	test_commit two_exec main.txt two_exec &&
+	test_commit three_exec main.txt three_exec &&
+	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase --exec git show HEAD -i"' '
+	git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase -ix git show HEAD"' '
+	git rebase -ix "git show HEAD" HEAD~2 >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several <CMD>' '
+	git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several instances of --exec' '
+	git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD exec_pwd 2
+				exec_git_show_HEAD exec_pwd" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,11d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase --exec without -i shows error message and usage ' '
+	test_must_fail git rebase --exec "git show HEAD" HEAD~2 >actual &&
+	echo "--exec option must be used with --interactive option\n" >expected &&
+	test_must_fail git rebase -h >>expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -i --exec without <CMD> shows error message and usage ' '
+	test_must_fail git rebase -i --exec HEAD~2>actual &&
+	echo "You must specify a command after --exec option\n" >expected &&
+	test_must_fail git rebase -h >>expected &&
+	test_cmp expected actual &&
+	git checkout master
+'
+
 test_done
-- 
1.7.8
