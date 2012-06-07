From: konglu@minatec.inpg.fr
Subject: Re: commit a63d7ed3017e312ddc752ac89a7d292a745d5f11 broken on MacOS
Date: Thu, 07 Jun 2012 16:20:32 +0200
Message-ID: <20120607162032.Horde.3lGNYXwdC4BP0LiwzlCRupA@webmail.minatec.grenoble-inp.fr>
References: <4FD0964E.7040302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Torsten =?iso-8859-1?b?QvZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 07 16:20:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScdZq-0002yi-2x
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 16:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760424Ab2FGOUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 10:20:37 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:53957 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751772Ab2FGOUg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 10:20:36 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 3C9FC1A030B;
	Thu,  7 Jun 2012 16:20:33 +0200 (CEST)
Received: from wifi-028144.grenet.fr (wifi-028144.grenet.fr
 [130.190.28.144]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Thu, 07 Jun 2012 16:20:32 +0200
In-Reply-To: <4FD0964E.7040302@web.de>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199409>


Torsten B=F6gershausen <tboegi@web.de> a =E9crit=A0:

> commit a63d7ed3017e312ddc752ac89a7d292a745d5f11
> Author: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
> Date:   Wed Jun 6 12:34:16 2012 +0200
>
>     rebase [-i --exec | -ix] <cmd>...
> ....
>     Tests about this new command are also added in =20
> t3404-rebase-interactive.sh.
> ....
>
>
> This test doesn't pass on my Mac Os box.
>
> I run it with --debug --verbose, and it looks like another sed =20
> problem on Mac OS, may be.
> (My sed is /usr/bin, Mac OS X 10.6.8)
>
> I haven't been able to dig very deep into this, but the line
> "sed: 1: "/^pick .*/i\t\t\t\texec  gi ...": command i expects \ =20
> followed by text"
> looks suspicious.

Does it work if the whitespaces are deleted so that it becomes
/^pick .*/i\exec gi..." ? (see the patch corrected below).


-------->8 ------
 From 1820dd24d6c93e0ba3b7a19a205f0fce79777751 Mon Sep 17 00:00:00 2001
=46rom: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Date: Sat, 2 Jun 2012 13:04:19 +0200
Subject: rebase [-i --exec | -ix] <CMD>...

This patch provides a way to automatically add these "exec" lines
between each commit applications. For instance, running 'git rebase -i
--exec "make test"' lets you check that intermediate commits are
compilable. It is also compatible with the option --autosquash. At
this point, you can't use --exec without the interactive mode (-i).

Tests about this new command are also added in
t3404-rebase-interactive.sh.

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
---
  Documentation/git-rebase.txt  |   54 +++++++++++++++--
  git-rebase--interactive.sh    |   18 ++++++
  git-rebase.sh                 |   20 ++++++-
  t/t3404-rebase-interactive.sh |  124 =20
+++++++++++++++++++++++++++++++++++++++++
  4 files changed, 206 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 147fa1a..1dd95c4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,9 +8,9 @@ git-rebase - Forward-port local commits to the updated =
=20
upstream head
  SYNOPSIS
  --------
  [verse]
-'git rebase' [-i | --interactive] [options] [--onto <newbase>]
+'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <ne=
wbase>]
  	[<upstream>] [<branch>]
-'git rebase' [-i | --interactive] [options] --onto <newbase>
+'git rebase' [-i | --interactive] [options] [--exec <cmd>] --onto <new=
base>
  	--root [<branch>]
  'git rebase' --continue | --skip | --abort

@@ -210,11 +210,29 @@ rebase.autosquash::

  OPTIONS
  -------
-<newbase>::
-	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
-	<upstream>.  May be any valid commit, and not just an
-	existing branch name.
+-x <cmd>::
+--exec <cmd>::
+	Automatically add "exec" followed by <cmd> between each commit
+	applications. Using this option along with --autosquash adds
+	the exec line after the squash/fixeup series only. <cmd>
+	stands for shell commands. The --exec option has to be
+	specified. (see INTERACTIVE MODE below)
++
+This has to be used along with the `--interactive` option explicitly.
+You may execute several commands between each commit applications.
+For this, you can use one instance of exec:
+	git rebase -i --exec "cmd1; cmd2; ...".
+You can also insert several instances of exec, if you wish to
+only have one command per line for example:
+	git rebase -i --exec "cmd1" --exec "cmd2" ...
+
+--onto <newbase>::
+	With this option, git rebase takes all commits from <branch>,
+	that are not in <upstream>, and transplant them on top of
+	<newbase>. <newbase> is the starting point at which to create
+	the new commits. If the --onto option is not specified, the
+	starting point is <upstream>.  May be any valid commit, and
+	not just an existing branch name.
  +
  As a special case, you may use "A\...B" as a shortcut for the
  merge base of A and B if there is exactly one merge base. You can
@@ -521,6 +539,28 @@ in `$SHELL`, or the default shell if `$SHELL` is =20
not set), so you can
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
+If the option '-i' is missing, The command will return a message
+error. If there is no <cmd> specified behind --exec, the command will
+return a message error and the usage page of 'git rebase'.
+
  SPLITTING COMMITS
  -----------------

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..dc9e7e9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -684,6 +684,22 @@ rearrange_squash () {
  	rm -f "$1.sq" "$1.rearranged"
  }

+# Add commands after a pick or after a squash/fixup serie
+# in the todo list.
+add_exec_commands () {
+	OIFS=3D$IFS
+	IFS=3D$LF
+	for i in $cmd
+	do
+		tmp=3D$(sed "/^pick .*/i\exec $i" "$1")
+		echo "$tmp" >"$1"
+		tmp=3D$(sed '1d' "$1")
+		echo "$tmp" >"$1"
+		echo "exec $i" >>"$1"
+	done
+	IFS=3D$OIFS
+}
+
  case "$action" in
  continue)
  	# do we have anything to commit?
@@ -857,6 +873,8 @@ fi

  test -s "$todo" || echo noop >> "$todo"
  test -n "$autosquash" && rearrange_squash "$todo"
+test -n "$cmd" && add_exec_commands "$todo"
+
  cat >> "$todo" << EOF

  # Rebase $shortrevisions onto $shortonto
diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..19ead1a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,8 @@
  # Copyright (c) 2005 Junio C Hamano.
  #

-USAGE=3D'[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] =20
[--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
+USAGE=3D'[--interactive | -i] [--exec | -x <cmd>] [-v] [--force-rebase=
 | -f]
+       [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] =20
[--quiet | -q]'
  LONG_USAGE=3D'git-rebase replaces <branch> with a new branch of the
  same name.  When the --onto option is provided the new branch starts
  out with a HEAD equal to <newbase>, otherwise it is equal to <upstrea=
m>
@@ -30,8 +31,8 @@ Example:       git-rebase master~1 topic
  SUBDIRECTORY_OK=3DYes
  OPTIONS_KEEPDASHDASH=3D
  OPTIONS_SPEC=3D"\
-git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
-git rebase [-i] [options] --onto <newbase> --root [<branch>]
+git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] =20
[<upstream>] [<branch>]
+git rebase [-i] [options] [--exec <cmd>] --onto <newbase> --root [<bra=
nch>]
  git-rebase [-i] --continue | --abort | --skip
  --
   Available options are
@@ -43,6 +44,7 @@ s,strategy=3D!       use the given merge strategy
  no-ff!             cherry-pick all commits, even if unchanged
  m,merge!           use merging strategies to rebase
  i,interactive!     let the user edit the list of commits to rebase
+x,exec=3D!           add exec lines after each commit of the editable =
list
  k,keep-empty	   preserve empty commits during rebase
  f,force-rebase!    force rebase even if branch is up to date
  X,strategy-option=3D! pass the argument through to the merge strategy
@@ -76,6 +78,7 @@ If you would prefer to skip this patch, instead run =20
\"git rebase --skip\".
  To check out the original branch and stop rebasing run \"git rebase =20
--abort\".
  "
  unset onto
+cmd=3D
  strategy=3D
  strategy_opts=3D
  do_merge=3D
@@ -219,6 +222,11 @@ do
  		onto=3D"$2"
  		shift
  		;;
+	-x)
+		test 2 -le "$#" || usage
+		cmd=3D"${cmd:+"$cmd$LF"} $2"
+		shift
+		;;
  	-i)
  		interactive_rebase=3Dexplicit
  		;;
@@ -304,6 +312,12 @@ do
  done
  test $# -gt 2 && usage

+if test -n "$cmd" &&
+   test "$interactive_rebase" !=3D explicit
+then
+	die "--exec option must be used with --interactive option\n"
+fi
+
  if test -n "$action"
  then
  	test -z "$in_progress" && die "No rebase in progress?"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 025c1c6..4fe98d5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,128 @@ test_expect_success 'rebase-i history with funny =
=20
messages' '
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
+		FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
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
+	git reset --hard execute &&
+	git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase -ix git show HEAD"' '
+	git reset --hard execute &&
+	git rebase -ix "git show HEAD" HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several <CMD>' '
+	git reset --hard execute &&
+	git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &=
&
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
+	git reset --hard execute &&
+	git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD exec_pwd 2
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
+		FAKE_LINES=3D"1 fixup 3 fixup 4 exec_git_show_HEAD 2 exec_git_show_H=
EAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~4 >expected
+	) &&
+	sed '1,13d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase --exec without -i shows error message' '
+	git reset --hard execute &&
+	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
+	echo "--exec option must be used with --interactive option\n" >expect=
ed &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -i --exec without <CMD> shows error =20
message and usage' '
+	git reset --hard execute &&
+	test_must_fail git rebase -i --exec 2>actual &&
+	sed '1d' actual >tmp &&
+	mv tmp actual &&
+	test_must_fail git rebase -h >expected &&
+	test_cmp expected actual &&
+	git checkout master
+'
+
  test_done
--=20
1.7.8
