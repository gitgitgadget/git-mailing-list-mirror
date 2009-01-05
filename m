From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3.2] rebase: learn to rebase root commit
Date: Mon,  5 Jan 2009 18:35:16 +0100
Message-ID: <1231176916-14929-1-git-send-email-trast@student.ethz.ch>
References: <1230939915-3638-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 18:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJtNU-00079f-0x
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 18:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbZAERfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 12:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbZAERfN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 12:35:13 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:18693 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbZAERfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 12:35:11 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jan 2009 18:35:08 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jan 2009 18:35:07 +0100
X-Mailer: git-send-email 1.6.1.197.g6666
In-Reply-To: <1230939915-3638-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 05 Jan 2009 17:35:07.0394 (UTC) FILETIME=[F373F620:01C96F5B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104588>

Teach git-rebase a new option --root, which instructs it to rebase the
entire history leading up to <branch>.  This option must be used with
--onto <newbase>, and causes commits that already exist in <newbase>
to be skipped.  (Normal operation skips commits that already exist in
<upstream> instead.)

The main use-case is with git-svn: suppose you start hacking (perhaps
offline) on a new project, but later notice you want to commit this
work to SVN.  You will have to rebase the entire history, including
the root commit, on a (possibly empty) commit coming from git-svn, to
establish a history connection.  This previously had to be done by
cherry-picking the root commit manually.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

Since this is still in 'pu', can you replace it again?  The test case
I designed for v3, to check that it also skips identical commits,
actually makes the _root_ commit a duplicate.  I could sleep better at
night if the root commit was actually part of the rebase :-)

3/4 is not affected patch-wise, though it of course inherits the same
test history.

Thanks!


Interdiff:

>> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
>> index 1978512..dd91910 100755
>> --- a/t/t3412-rebase-root.sh
>> +++ b/t/t3412-rebase-root.sh
>> @@ -15,12 +15,12 @@ test_expect_success 'prepare repository' '
>>         git commit -m 2 &&
>>         git symbolic-ref HEAD refs/heads/other &&
>>         rm .git/index &&
>> -       echo 1 > A &&
>> -       git add A &&
>> -       git commit -m 1b &&
>>         echo 3 > B &&
>>         git add B &&
>>         git commit -m 3 &&
>> +       echo 1 > A &&
>> +       git add A &&
>> +       git commit -m 1b &&
>>         echo 4 > B &&
>>         git add B &&
>>         git commit -m 4


 git-rebase.sh          |   52 ++++++++++++++++++++--------
 t/t3412-rebase-root.sh |   86 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 15 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index ebd4df3..d1083f1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
+USAGE='[--interactive | -i] [-v] [--onto <newbase>] [<upstream>|--root] [<branch>]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -47,6 +47,7 @@ dotest="$GIT_DIR"/rebase-merge
 prec=4
 verbose=
 git_am_opt=
+rebase_root=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -297,6 +298,9 @@ do
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
+	--root)
+		rebase_root=t
+		;;
 	-*)
 		usage
 		;;
@@ -344,17 +348,28 @@ case "$diff" in
 	;;
 esac
 
+if test -z "$rebase_root"; then
 # The upstream head must be given.  Make sure it is valid.
-upstream_name="$1"
-upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-    die "invalid upstream $upstream_name"
+	upstream_name="$1"
+	shift
+	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+	die "invalid upstream $upstream_name"
+	unset root_flag
+	upstream_arg="$upstream_name"
+else
+	test -z "$newbase" && die "--root must be used with --onto"
+	unset upstream_name
+	unset upstream
+	root_flag="--root"
+	upstream_arg="$root_flag"
+fi
 
 # Make sure the branch to rebase onto is valid.
 onto_name=${newbase-"$upstream_name"}
 onto=$(git rev-parse --verify "${onto_name}^0") || exit
 
 # If a hook exists, give it a chance to interrupt
-run_pre_rebase_hook ${1+"$@"}
+run_pre_rebase_hook "$upstream_arg" "$@"
 
 # If the branch to rebase is given, that is the branch we will rebase
 # $branch_name -- branch being rebased, or HEAD (already detached)
@@ -362,16 +377,16 @@ run_pre_rebase_hook ${1+"$@"}
 # $head_name -- refs/heads/<that-branch> or "detached HEAD"
 switch_to=
 case "$#" in
-2)
+1)
 	# Is it "rebase other $branchname" or "rebase other $commit"?
-	branch_name="$2"
-	switch_to="$2"
+	branch_name="$1"
+	switch_to="$1"
 
-	if git show-ref --verify --quiet -- "refs/heads/$2" &&
-	   branch=$(git rev-parse -q --verify "refs/heads/$2")
+	if git show-ref --verify --quiet -- "refs/heads/$1" &&
+	   branch=$(git rev-parse -q --verify "refs/heads/$1")
 	then
-		head_name="refs/heads/$2"
-	elif branch=$(git rev-parse -q --verify "$2")
+		head_name="refs/heads/$1"
+	elif branch=$(git rev-parse -q --verify "$1")
 	then
 		head_name="detached HEAD"
 	else
@@ -393,7 +408,8 @@ case "$#" in
 esac
 orig_head=$branch
 
-# Now we are rebasing commits $upstream..$branch on top of $onto
+# Now we are rebasing commits $upstream..$branch (or with --root,
+# everything leading up to $branch) on top of $onto
 
 # Check if we are already based on $onto with linear history,
 # but this should be done only when upstream and onto are the same.
@@ -429,10 +445,16 @@ then
 	exit 0
 fi
 
+if test ! -z "$rebase_root"; then
+	revisions="$onto..$orig_head"
+else
+	revisions="$upstream..$orig_head"
+fi
+
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		"$upstream..$orig_head" |
+		$root_flag "$revisions" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
@@ -455,7 +477,7 @@ echo "$orig_head" > "$dotest/orig-head"
 echo "$head_name" > "$dotest/head-name"
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$upstream..$orig_head"`
+for cmt in `git rev-list --reverse --no-merges "$revisions"`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
new file mode 100755
index 0000000..dd91910
--- /dev/null
+++ b/t/t3412-rebase-root.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description='git rebase --root
+
+Tests if git rebase --root --onto <newparent> can rebase the root commit.
+'
+. ./test-lib.sh
+
+test_expect_success 'prepare repository' '
+	echo 1 > A &&
+	git add A &&
+	git commit -m 1 &&
+	echo 2 > A &&
+	git add A &&
+	git commit -m 2 &&
+	git symbolic-ref HEAD refs/heads/other &&
+	rm .git/index &&
+	echo 3 > B &&
+	git add B &&
+	git commit -m 3 &&
+	echo 1 > A &&
+	git add A &&
+	git commit -m 1b &&
+	echo 4 > B &&
+	git add B &&
+	git commit -m 4
+'
+
+test_expect_success 'rebase --root expects --onto' '
+	test_must_fail git rebase --root
+'
+
+test_expect_success 'setup pre-rebase hook' '
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/pre-rebase <<EOF &&
+#!$SHELL_PATH
+echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+EOF
+	chmod +x .git/hooks/pre-rebase
+'
+cat > expect <<EOF
+4
+3
+2
+1
+EOF
+
+test_expect_success 'rebase --root --onto <newbase>' '
+	git checkout -b work &&
+	git rebase --root --onto master &&
+	git log --pretty=tformat:"%s" > rebased &&
+	test_cmp expect rebased
+'
+
+test_expect_success 'pre-rebase got correct input (1)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,
+'
+
+test_expect_success 'rebase --root --onto <newbase> <branch>' '
+	git branch work2 other &&
+	git rebase --root --onto master work2 &&
+	git log --pretty=tformat:"%s" > rebased2 &&
+	test_cmp expect rebased2
+'
+
+test_expect_success 'pre-rebase got correct input (2)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work2
+'
+
+test_expect_success 'setup pre-rebase hook that fails' '
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/pre-rebase <<EOF &&
+#!$SHELL_PATH
+false
+EOF
+	chmod +x .git/hooks/pre-rebase
+'
+
+test_expect_success 'pre-rebase hook stops rebase' '
+	git checkout -b stops1 other &&
+	GIT_EDITOR=: test_must_fail git rebase --root --onto master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops1
+	test 0 = $(git rev-list other...stops1 | wc -l)
+'
+
+test_done
-- 
tg: (f62b77f..) t/rr-normal (depends on: origin/master t/rebase-hook-order)
