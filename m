From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH 1/4] Introduce -ff=<fast forward option>
Date: Tue, 25 Mar 2008 19:53:59 -0800
Message-ID: <402c10cd0803252053r7e9d1056r9dc7a1e798bbce6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 05:12:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1JeN02-0003Jq-7l
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 05:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbYCZDyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 23:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbYCZDyJ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 23:54:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:27857 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbYCZDyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 23:54:06 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3825033fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 20:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=DfYDEiX05/ZIuIhZvLVLUCc2nQL9TAxcwgxw5T1Bqhc=;
        b=B1fY6VMapI8mxHGjyuL04+5+1Me25CJAmHYZX4jCm1h6HUGq2/qa37a67v5j27QJ2oo0J8kR8FNYCSgezDCyevFhqxYLARzU/IuXcHIza+xx1Zaumyn93qp3RNv6ujRIE6IHftv1n637hjefPr274CEBRlO+S6x3Y/+ydwgUxe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gQa/3fBNSflRUGMZCinOTbIeGeTtWoH7woRhy7bdvWJuML73DoRkIZId8OvjDaN/7rEwozLc3K7qP1EzaU9zW3hbFBwS7MsMC6SeH0MAVB+t1Vf89bCGRaOXutzRgdbMSb18sZMQzVd5+EDglrv8G+o8rzwX8xJFTKAdpkOHFYg=
Received: by 10.82.186.19 with SMTP id j19mr23237297buf.2.1206503644138;
        Tue, 25 Mar 2008 20:54:04 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 25 Mar 2008 20:53:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78250>

--ff now takes an argument allowing --ff to be written
as --ff=allow and -no-ff to be written as --ff=never.
This change allow other fast forward options to be
introduced later.

See the documentation for a further explanation of these options.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/fast-forward-options.txt |   44 +++
 Documentation/git-merge.txt            |    6 +-
 Documentation/git-pull.txt             |    2 +
 Documentation/merge-options.txt        |    9 +-
 git-merge.sh                           |   47 ++-
 git-pull.sh                            |    4 +-
 t/t7601-merge-ff-options.sh            |  639 ++++++++++++++++++++++++++++++++
 7 files changed, 728 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/fast-forward-options.txt
 create mode 100755 t/t7601-merge-ff-options.sh

diff --git a/Documentation/fast-forward-options.txt
b/Documentation/fast-forward-options.txt
new file mode 100644
index 0000000..95d0e6f
--- /dev/null
+++ b/Documentation/fast-forward-options.txt
@@ -0,0 +1,44 @@
+FAST FORWARD OPTIONS
+--------------------
+
+allow::
+
+       Do not generate a merge commit if the merge resolves as a
+       fast-forward, only update the branch pointer.  This option is
+       equivalent of '--ff' without any argument.  This is the
+       default behavior.
+
+never::
+       Generate a merge commit even if the merge resolves as a
+       fast-forward.  This option is equivalent of '--no-ff'.
+
+If your workflow is always to branch from the special branch
+("master") when working on a topic and merge that back to "master", if
+you happen to have worked only on a single topic and the "master" was
+never advanced during the time you worked on that topic, merging the
+topic back to "master" will result in a fast-forward.  When you look
+back that history, you will not be able to tell where the topic
+started and ended by following the ancestry chain of the "master"
+branch.
+
+Using "never fast forward" policy on such a special branch will be a
+way to make sure that all commits on the first-parent ancestry of that
+special branch will be merges from something else.  From the history
+you can determine where the topic started and ended.
+
+The following shows two branches forked off from "master".  The branch
+"master" have merged in changes from branch "topicA" twice and
+"topicB" once:
+
+------------
+         o---o---o---o---o  topicA
+        /     \           \
+    ---*-------*-------*---*  master
+      /         \     /
+                 o---o  topicB
+------------
+
+The first merge of topicA or the only merge of topicB would have
+resulted in a fast forward without '--ff=never'.  Topic A consist of
+those commits that can be reached from master^2 without passing
+through any of the first-parent ancestries of master.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c136b10..2af33d8 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,7 +9,8 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git-merge' [-n] [--summary] [--no-commit] [--squash] [-s <strategy>]...
+'git-merge' [-n] [--summary] [--no-commit] [--squash]
+       [-s <strategy>]... [--ff[=<fast forward option>]]
        [-m <msg>] <remote> <remote>...
 'git-merge' <msg> HEAD <remote>...

@@ -37,6 +38,9 @@ include::merge-options.txt[]
        least one <remote>.  Specifying more than one <remote>
        obviously means you are trying an Octopus.

+
+include::fast-forward-options.txt[]
+
 include::merge-strategies.txt[]


diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 3405ca0..e4e013c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -52,6 +52,8 @@ include::pull-fetch-param.txt[]

 include::urls-remotes.txt[]

+include::fast-forward-options.txt[]
+
 include::merge-strategies.txt[]

 DEFAULT BEHAVIOUR
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 9f1fc82..cf4881b 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -29,12 +29,11 @@

 --no-ff::
        Generate a merge commit even if the merge resolved as a
-       fast-forward.
+       fast-forward.  --no-ff is an alias for --ff=never.

---ff::
-       Do not generate a merge commit if the merge resolved as
-       a fast-forward, only update the branch pointer. This is
-       the default behavior of git-merge.
+--ff[=<fast forward option>]::
+       Select fast forward option.  --ff without any argument
+       is an alias for --ff=allow which is the default behavior.

 -s <strategy>, \--strategy=<strategy>::
        Use the given merge strategy; can be supplied more than
diff --git a/git-merge.sh b/git-merge.sh
index 7dbbb1d..17f40f2 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -12,7 +12,7 @@ summary              show a diffstat at the end of the merge
 n,no-summary         don't show a diffstat at the end of the merge
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge sucesses (default)
-ff                   allow fast forward (default)
+ff?                  fast forward options
 s,strategy=          merge strategy to use
 m,message=           message to be used for the merge commit (if any)
 "
@@ -35,7 +35,7 @@ no_fast_forward_strategies='subtree ours'
 no_trivial_strategies='recursive recur subtree ours'
 use_strategies=

-allow_fast_forward=t
+fast_forward=allow
 allow_trivial_merge=t
 squash= no_commit=

@@ -153,8 +153,6 @@ parse_config () {
                --summary)
                        show_diffstat=t ;;
                --squash)
-                       test "$allow_fast_forward" = t ||
-                               die "You cannot combine --squash with --no-ff."
                        squash=t no_commit=t ;;
                --no-squash)
                        squash= no_commit= ;;
@@ -163,11 +161,26 @@ parse_config () {
                --no-commit)
                        no_commit=t ;;
                --ff)
-                       allow_fast_forward=t ;;
+                       case "$2" in
+                       allow|never)
+                               fast_forward=$2; shift ;;
+                       -*)
+                               fast_forward=allow ;;
+                       *)
+                               die "Available fast-forward options
are: allow and newer" ;;
+                       esac
+                       ;;
+               --ff=*)
+                       fast_forward=${1#--ff=}
+                       case "$fast_forward" in
+                       allow|never)
+                               ;;
+                       *)
+                               die "Available fast-forward options
are: allow and newer" ;;
+                       esac
+                       ;;
                --no-ff)
-                       test "$squash" != t ||
-                               die "You cannot combine --squash with --no-ff."
-                       allow_fast_forward=f ;;
+                       fast_forward=never ;;
                -s|--strategy)
                        shift
                        case " $all_strategies " in
@@ -189,6 +202,8 @@ parse_config () {
                esac
                shift
        done
+       test "$fast_forward" = allow -o "$squash" = "" ||
+               die "You cannot combine --squash with --ff=never"
        args_left=$#
 }

@@ -308,7 +323,7 @@ do
        do
                case " $s " in
                *" $ss "*)
-                       allow_fast_forward=f
+                       fast_forward=never
                        break
                        ;;
                esac
@@ -334,17 +349,17 @@ case "$#" in
 esac
 echo "$head" >"$GIT_DIR/ORIG_HEAD"

-case "$allow_fast_forward,$#,$common,$no_commit" in
-?,*,'',*)
+case "$fast_forward,$#,$common,$no_commit" in
+*,*,'',*)
        # No common ancestors found. We need a real merge.
        ;;
-?,1,"$1",*)
+*,1,"$1",*)
        # If head can reach all the merge then we are up to date.
        # but first the most common case of merging one remote.
        finish_up_to_date "Already up-to-date."
        exit 0
        ;;
-t,1,"$head",*)
+allow,1,"$head",*)
        # Again the most common case of merging one remote.
        echo "Updating $(git rev-parse --short $head)..$(git rev-parse
--short $1)"
        git update-index --refresh 2>/dev/null
@@ -359,11 +374,11 @@ t,1,"$head",*)
        dropsave
        exit 0
        ;;
-?,1,?*"$LF"?*,*)
+*,1,?*"$LF"?*,*)
        # We are not doing octopus and not fast forward.  Need a
        # real merge.
        ;;
-?,1,*,)
+*,1,*,)
        # We are not doing octopus, not fast forward, and have only
        # one common.
        git update-index --refresh 2>/dev/null
@@ -481,7 +496,7 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    if test "$allow_fast_forward" = "t"
+    if test $fast_forward = allow
     then
         parents=$(git show-branch --independent "$head" "$@")
     else
diff --git a/git-pull.sh b/git-pull.sh
index 3ce32b5..2d7293a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,7 +4,7 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.

-USAGE='[-n | --no-summary] [--[no-]commit] [--[no-]squash]
[--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
+USAGE='[-n | --no-summary] [--[no-]commit] [--[no-]squash]
[--ff=<ff-strategy>] [-s strategy]... [<fetch-options>] <repo>
<head>...'
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the
current HEAD.'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
@@ -41,6 +41,8 @@ do
                no_ff=--ff ;;
        --no-ff)
                no_ff=--no-ff ;;
+       --ff=allow|--ff=never)
+               no_ff=$1 ;;
        -s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
                --strateg=*|--strategy=*|\
        -s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
diff --git a/t/t7601-merge-ff-options.sh b/t/t7601-merge-ff-options.sh
new file mode 100755
index 0000000..636e71e
--- /dev/null
+++ b/t/t7601-merge-ff-options.sh
@@ -0,0 +1,639 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Sverre Hvammen Johansen, based on t7600 by Lars Hjemli
+#
+
+test_description='git-merge
+
+Testing basic merge operations/option parsing.'
+
+. ./test-lib.sh
+
+cat >file <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >file.1 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >file.5 <<EOF
+1
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >file.9 <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9 X
+10
+11
+12
+EOF
+
+cat  >result.0 <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat  >result.1 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >result.1-5 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+EOF
+
+cat >result.9 <<EOF
+1
+2
+3
+4
+5
+6
+7
+8
+9 X
+10
+11
+12
+EOF
+
+cat >result.1-5-9 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9 X
+10
+11
+12
+EOF
+
+cat >result.1-5-9-13 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9 X
+10
+11
+12
+13 x
+EOF
+
+cat >result.1-5-13 <<EOF
+1 X
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >result.5-13 <<EOF
+1
+2
+3
+4
+5 X
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >result.1-13 <<EOF
+1 X
+2
+3
+4
+5
+6
+7
+8
+9
+10
+11
+12
+13 x
+EOF
+
+cat >extend <<EOF
+13 x
+EOF
+
+
+create_merge_msgs() {
+       echo "Merge commit 'c2'" >msg.1-5 &&
+       echo "Merge commit 'c2'; commit 'c3'" >msg.1-5-9 &&
+       echo "Squashed commit of the following:" >squash.1 &&
+       echo >>squash.1 &&
+       git log --no-merges ^HEAD c1 >>squash.1 &&
+       echo "Squashed commit of the following:" >squash.1-5 &&
+       echo >>squash.1-5 &&
+       git log --no-merges ^HEAD c2 >>squash.1-5 &&
+       echo "Squashed commit of the following:" >squash.1-5-9 &&
+       echo >>squash.1-5-9 &&
+       git log --no-merges ^HEAD c2 c3 >>squash.1-5-9
+}
+
+verify_diff() {
+       if ! diff -u "$1" "$2"
+       then
+               echo "$3"
+               false
+       fi
+}
+
+verify_merge() {
+       verify_diff "$2" "$1" "[OOPS] bad merge result" &&
+       if test $(git ls-files -u | wc -l) -gt 0
+       then
+               echo "[OOPS] unmerged files"
+               false
+       fi &&
+       if ! git diff --exit-code
+       then
+               echo "[OOPS] working tree != index"
+               false
+       fi &&
+       if test -n "$3"
+       then
+               git show -s --pretty=format:%s HEAD >msg.act &&
+               verify_diff "$3" msg.act "[OOPS] bad merge message"
+       fi
+}
+
+verify_head() {
+       if test "$1" != "$(git rev-parse HEAD)"
+       then
+               echo "[OOPS] HEAD != $1"
+               false
+       fi
+}
+
+verify_parents() {
+       i=1
+       while test $# -gt 0
+       do
+               if test "$1" != "$(git rev-parse HEAD^$i)"
+               then
+                       echo "[OOPS] HEAD^$i != $1"
+                       return 1
+               fi
+               i=$(expr $i + 1)
+               shift
+       done
+}
+
+verify_mergeheads() {
+       i=1
+       if ! test -f .git/MERGE_HEAD
+       then
+               echo "[OOPS] MERGE_HEAD is missing"
+               false
+       fi &&
+       while test $# -gt 0
+       do
+               head=$(head -n $i .git/MERGE_HEAD | tail -n 1)
+               if test "$1" != "$head"
+               then
+                       echo "[OOPS] MERGE_HEAD $i != $1"
+                       return 1
+               fi
+               i=$(expr $i + 1)
+               shift
+       done
+}
+
+verify_no_mergehead() {
+       if test -f .git/MERGE_HEAD
+       then
+               echo "[OOPS] MERGE_HEAD exists"
+               false
+       fi
+}
+
+
+test_expect_success 'setup' '
+       git add file &&
+       test_tick &&
+       git commit -m "commit 0" &&
+       git tag c0 &&
+       c0=$(git rev-parse HEAD) &&
+
+       cp file.1 file &&
+       git add file &&
+       test_tick &&
+       git commit -m "commit 1" &&
+       git tag c1 &&
+       c1=$(git rev-parse HEAD) &&
+       test_tick &&
+
+       git reset --hard "$c0" &&
+       cp file.5 file &&
+       git add file &&
+       git commit -m "commit 2" &&
+       test_tick &&
+       git tag c2 &&
+       c2=$(git rev-parse HEAD) &&
+
+       git reset --hard "$c0" &&
+       cp file.9 file &&
+       git add file &&
+       test_tick &&
+       git commit -m "commit 3" &&
+       git tag c3 &&
+       c3=$(git rev-parse HEAD) &&
+       test_tick &&
+
+       git reset --hard "$c1" &&
+       cat extend >>file &&
+       git add file &&
+       git commit -m "commit 4" &&
+       git tag x1 &&
+       x1=$(git rev-parse HEAD) &&
+       test_tick &&
+
+       git reset --hard "$c1" &&
+       git merge "$c2" &&
+       git tag x0 &&
+       x0=$(git rev-parse HEAD) &&
+       test_tick &&
+
+       git reset --hard "$c2" &&
+       cat extend >>file &&
+       git add file &&
+       git commit -m "commit 5" &&
+       git tag x2 &&
+       x2=$(git rev-parse HEAD) &&
+       test_tick &&
+
+       git reset --hard "$x1" &&
+       git merge "$x0" &&
+       git tag y1 &&
+       y1=$(git rev-parse HEAD) &&
+       test_tick &&
+
+       git reset --hard "$x0" &&
+       git merge "$x2" &&
+       git tag y2 &&
+       y2=$(git rev-parse HEAD) &&
+       test_tick &&
+
+       git reset --hard "$y1" &&
+       git merge "$y2" &&
+       git tag y3 &&
+       y3=$(git rev-parse HEAD) &&
+       test_tick &&
+       git reset --hard "$c0" &&
+       create_merge_msgs &&
+
+       git reset --hard x1 &&
+       git clone .git clone &&
+       git config remote.clone.url clone &&
+       git config remote.clone.fetch "+refs/heads/*:refs/remotes/clone/*" &&
+
+       (mkdir new && cd new && git init && cp ../file.9 file2 && git
add file2 && test_tick && git commit -m "commit new") &&
+       git config remote.new.url new &&
+       git config remote.new.fetch "+refs/heads/*:refs/remotes/new/*"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2' '
+       git reset --hard c0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 c2 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0, c2, c0, and c1' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c0 c2 c0 c1 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge y2 with x0, c3, and c0' '
+       git reset --hard y2 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge x0 c3 c0 &&
+       verify_merge file result.1-5-9-13 &&
+       verify_parents $y2 $c3
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x0 with y2, c3, and c0' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge y2 c3 c0 &&
+       verify_merge file result.1-5-9-13 &&
+       verify_parents $y2 $c3
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 and x1' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c2 x1 &&
+       verify_merge file result.1-5-13 &&
+       verify_parents $c2 $x1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--squash combined with --ff=allow)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 --squash --ff=allow &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 (--squash combined with --ff=allow)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c2 --squash --ff=allow &&
+       verify_merge file result.1-5 &&
+       verify_head $c1 &&
+       git commit &&
+       verify_parents $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with x0 (--no-commit combined with --ff=allow)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge x0 --no-commit --ff=allow &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--no-commit combined with --ff=allow)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 --no-commit --ff=allow &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 (--no-commit combined with --ff=allow)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c2 --no-commit --ff=allow &&
+       verify_merge file result.1-5 &&
+       verify_head $c1 &&
+       git commit &&
+       verify_parents $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with x1 (pull --ff=allow)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git pull --ff=allow clone refs/heads/master &&
+       verify_merge file result.1-13 &&
+       verify_head $x1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x2 with x1 (pull --ff=allow)' '
+       git reset --hard x2 &&
+       test_tick &&
+       git pull --ff=allow clone refs/heads/master &&
+       verify_merge file result.1-5-13 &&
+       verify_parents $x2 $x1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with new repository (pull --ff=allow)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git pull --ff=allow new refs/heads/master &&
+       verify_merge file result.1 &&
+       verify_merge file2 result.9
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x0 with c1 (--squash combined with --ff=never)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge c1 --squash --ff=never &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 (--squash combined with --ff=never)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge c2 --squash --ff=never &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with x0 (--no-commit combined with --ff=never)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge x0 --no-commit --ff=never &&
+       verify_merge file result.1-5 &&
+       verify_head $c1 &&
+       git commit &&
+       verify_parents $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--no-commit combined with --ff=never)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 --no-commit --ff=never &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 (--no-commit combined with --ff=never)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c2 --no-commit --ff=never &&
+       verify_merge file result.1-5 &&
+       verify_head $c1 &&
+       git commit &&
+       verify_parents $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with x1 (pull --ff=never)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git pull --ff=never clone refs/heads/master &&
+       verify_merge file result.1-13 &&
+       verify_parents $c1 $x1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x2 with x1 (pull --ff=never)' '
+       git reset --hard x2 &&
+       test_tick &&
+       git pull --ff=never clone refs/heads/master &&
+       verify_merge file result.1-5-13 &&
+       verify_parents $x2 $x1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with new repository (pull --ff=never)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git pull --ff=never new refs/heads/master &&
+       verify_merge file result.1 &&
+       verify_merge file2 result.9
+'
+
+test_debug 'gitk --all'
+
+test_done

-- 
Sverre Hvammen Johansen
