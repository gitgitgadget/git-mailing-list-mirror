From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never, and only
Date: Mon, 17 Mar 2008 20:27:13 -0800
Message-ID: <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 05:28:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbTQf-0000mj-N9
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 05:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbYCRE1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 00:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbYCRE1V
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 00:27:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:59084 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYCRE1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 00:27:19 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2108615fgb.17
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 21:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MjbZMGt6JVONl7Juk1NfGU3Y/XCNChOssChPx5B0hJQ=;
        b=cgqZ829T3z8NUXIFvfdFouevpvB6dKETmya0yNHt76pGO6CWDyPNXfbAliFNIgYYONPdlffkjk7kH9ZtAqVALQvIM2oAvRxuP6AwbvHe2wjMm6KxuQwi8+zDwsYCG90Eomf3oIbP62/uG5pP7Xq+6yvOYnX9wsjfmgKw7h0mzNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IDJP3nyWr+JOZCegnUxJrelGoxtZupZR23teqvT7NjgtgSfz5nr1a43s9tjiLoQMZieaoeleL+T2afPBwjA5wG0PX2XZN/Ds3KLceYZo2tckU55apYQEnYhCCOtsmvkn2FAdtUTjPApLfZM1kq2j8j/hYCyeHW+5HC6d4UDVYTo=
Received: by 10.82.148.7 with SMTP id v7mr1517584bud.37.1205814433494;
        Mon, 17 Mar 2008 21:27:13 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Mon, 17 Mar 2008 21:27:13 -0700 (PDT)
In-Reply-To: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77487>

New fast forward strategies, only, is introduced.  This new fast
forward strategy prevents real merges.

FF strategy "only" fails if the specified heads and HEAD can not
be reduced down to only one real parent.  The only allowed
outcome is a fast forward unless HEAD is up to date with
the specified heads.

This patch also uses the real heads found instead of those
specified for real merges.  This means that merge startegies
that only take two heads can now accept more than two heads
if they can be reduced down to only two real heads.  However,
fast-forward of head in combination with a real merge is
handled as before.

See the documentation for further explanation of this feature.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/fast-forward-options.txt |   69 +++
 Documentation/git-merge.txt            |    6 +-
 Documentation/git-pull.txt             |    2 +
 Documentation/merge-options.txt        |    9 +-
 git-merge.sh                           |  246 +++++++-----
 git-pull.sh                            |    4 +-
 t/t7600-merge.sh                       |    5 -
 t/t7601-merge-ff-options.sh            |  722 ++++++++++++++++++++++++++++++++
 8 files changed, 946 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/fast-forward-options.txt
 create mode 100755 t/t7601-merge-ff-options.sh

diff --git a/Documentation/fast-forward-options.txt
b/Documentation/fast-forward-options.txt
new file mode 100644
index 0000000..87fd0ae
--- /dev/null
+++ b/Documentation/fast-forward-options.txt
@@ -0,0 +1,69 @@
+FAST FORWARD OPTIONS
+--------------------
+
+allow::
+       Do not generate a merge commit if the merge resolved as a
+       fast-forward, only update the branch pointer.  This is the
+       default behavior.  This option is equivalent of '--ff' without
+       any argument.
+
+never::
+       Generate a merge commit even if the merge resolved as a
+       fast-forward.  This option is equivalent of '--no-ff'.
+
+only::
+       Only allow a fast-forward.  The merge will fail unless HEAD is
+       up to date or the merge resolved as a fast-forward.
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
+resulted in a fast forward without '--ff=never'.  The last merge of
+topicA would have failed with '--ff=only'.  Topic A consist of those
+commits that can be reached from master^2 without passing through any
+of the first-parent ancestries of master.
+
+However, if your workflow require a linear history for the special
+branch ("master"), topic branches must be rebased before merging them
+back to "master".  A pull or a merge from the "master branch of a
+topic branch may accidentally introduce a merge commit that was not
+already in the topic branch if the topic that were merged was not
+properly rebased.  This will creating a none linear history.
+
+Using "only fast forward" policy ensures that whenever a pull or a
+merge is performed it will fail unless the merge can be resolved as a
+fast forward.  This will however not guarantee a linear history since
+the topic branches that are merged in may have merge commits recorded.
+You may therefor need to use this policy on the topic branches as
+well.
+
+"Only fast forward" policy on the "master" branch can be enforced by
+setting the mergeoptions for that branch using git config:
+
+------------
+% git config branch.master.mergeoptions --ff=only
+------------
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
index 7378943..222482f 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -50,6 +50,8 @@ include::pull-fetch-param.txt[]

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
index 7dbbb1d..a98cd77 100755
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
@@ -163,18 +161,33 @@ parse_config () {
                --no-commit)
                        no_commit=t ;;
                --ff)
-                       allow_fast_forward=t ;;
+                       case "$2" in
+                       allow|never|only)
+                               fast_forward=$2; shift ;;
+                       -*)
+                               fast_forward=allow ;;
+                       *)
+                               die "Available fast-forward strategies
are: allow, newer, and only" ;;
+                       esac
+                       ;;
+               --ff=*)
+                       fast_forward=${1#--ff=}
+                       case "$fast_forward" in
+                           allow|never|only)
+                               ;;
+                           *)
+                               die "Available fast-forward strategies
are: allow, newer, and only" ;;
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
                        *" $1 "*)
                                use_strategies="$use_strategies$1 " ;;
                        *)
-                               die "available strategies are:
$all_strategies" ;;
+                               die "Available strategies are:
$all_strategies" ;;
                        esac
                        ;;
                -m|--message)
@@ -279,24 +292,68 @@ do
 done
 set x $remoteheads ; shift

+echo "$head" >"$GIT_DIR/ORIG_HEAD"
+
+if test $fast_forward = never
+then
+       real_parents=$(git rev-parse "$@")
+       ff_head=$head
+       common=
+else
+       if test $# = 1
+       then
+               common=$(git merge-base --all $head "$1")
+               if test "$common" = $head
+               then
+                       real_parents=
+                       ff_head=$1
+               elif test "$common" = "$1"
+               then
+                       real_parents=
+                       ff_head=$head
+               else
+                       real_parents=$1
+                       ff_head=$head
+
+               fi
+       else
+               real_parents=$(git show-branch --independent $head "$@")
+               ff_head=${real_parents%%$LF*}
+               real_parents=${real_parents#$ff_head}
+               real_parents=${real_parents#$LF}
+               common=
+       fi
+fi
+
+if test -n "$real_parents"
+then
+       if test $fast_forward = only
+       then
+               die "--ff=only can not handle more than one real parent"
+       elif test $head != $ff_head
+       then
+               real_parents="$ff_head$LF$real_parents"
+       fi
+fi
+
 case "$use_strategies" in
 '')
-       case "$#" in
-       1)
-               var="`git config --get pull.twohead`"
+       case "$real_parents" in
+       ?*"$LF"?*)
+               var="`git config --get pull.octopus`"
                if test -n "$var"
                then
                        use_strategies="$var"
                else
-                       use_strategies="$default_twohead_strategies"
+                       use_strategies="$default_octopus_strategies"
                fi ;;
        *)
-               var="`git config --get pull.octopus`"
+               var="`git config --get pull.twohead`"
                if test -n "$var"
                then
                        use_strategies="$var"
                else
-                       use_strategies="$default_octopus_strategies"
+                       use_strategies="$default_twohead_strategies"
                fi ;;
        esac
        ;;
@@ -308,7 +365,7 @@ do
        do
                case " $s " in
                *" $ss "*)
-                       allow_fast_forward=f
+                       fast_forward=never
                        break
                        ;;
                esac
@@ -323,88 +380,72 @@ do
                esac
        done
 done
-
-case "$#" in
-1)
-       common=$(git merge-base --all $head "$@")
-       ;;
-*)
-       common=$(git show-branch --merge-base $head "$@")
-       ;;
-esac
-echo "$head" >"$GIT_DIR/ORIG_HEAD"
-
-case "$allow_fast_forward,$#,$common,$no_commit" in
-?,*,'',*)
-       # No common ancestors found. We need a real merge.
-       ;;
-?,1,"$1",*)
-       # If head can reach all the merge then we are up to date.
-       # but first the most common case of merging one remote.
-       finish_up_to_date "Already up-to-date."
-       exit 0
-       ;;
-t,1,"$head",*)
-       # Again the most common case of merging one remote.
-       echo "Updating $(git rev-parse --short $head)..$(git rev-parse
--short $1)"
-       git update-index --refresh 2>/dev/null
-       msg="Fast forward"
-       if test -n "$have_message"
+if test -z "$real_parents"
+then
+       if test $head = $ff_head
        then
-               msg="$msg (no commit created; -m option ignored)"
-       fi
-       new_head=$(git rev-parse --verify "$1^0") &&
-       git read-tree -v -m -u --exclude-per-directory=.gitignore
$head "$new_head" &&
-       finish "$new_head" "$msg" || exit
-       dropsave
-       exit 0
-       ;;
-?,1,?*"$LF"?*,*)
-       # We are not doing octopus and not fast forward.  Need a
-       # real merge.
-       ;;
-?,1,*,)
-       # We are not doing octopus, not fast forward, and have only
-       # one common.
-       git update-index --refresh 2>/dev/null
-       case "$allow_trivial_merge" in
-       t)
-               # See if it is really trivial.
-               git var GIT_COMMITTER_IDENT >/dev/null || exit
-               echo "Trying really trivial in-index merge..."
-               if git read-tree --trivial -m -u -v $common $head "$1" &&
-                  result_tree=$(git write-tree)
-               then
-                       echo "Wonderful."
-                       result_commit=$(
-                               printf '%s\n' "$merge_msg" |
-                               git commit-tree $result_tree -p HEAD -p "$1"
-                       ) || exit
-                       finish "$result_commit" "In-index merge"
-                       dropsave
-                       exit 0
-               fi
-               echo "Nope."
-       esac
-       ;;
-*)
-       # An octopus.  If we can reach all the remote we are up to date.
-       up_to_date=t
-       for remote
-       do
-               common_one=$(git merge-base --all $head $remote)
-               if test "$common_one" != "$remote"
+               finish_up_to_date "Already up-to-date."
+               exit 0
+       elif test $fast_forward = never
+       then
+               real_parents="$ff_head"
+               ff_head=$head
+       else
+               echo "Updating $(git rev-parse --short $head)..$(git
rev-parse --short $ff_head)"
+               git update-index --refresh 2>/dev/null
+               msg="Fast forward"
+               if test -n "$have_message"
                then
-                       up_to_date=f
-                       break
+                       msg="$msg (no commit created; -m option ignored)"
                fi
-       done
-       if test "$up_to_date" = t
-       then
-               finish_up_to_date "Already up-to-date. Yeeah!"
+               new_head=$(git rev-parse --verify "$ff_head^0") &&
+               git read-tree -v -m -u
--exclude-per-directory=.gitignore $head "$new_head" &&
+               finish "$new_head" "$msg" || exit
+               dropsave
                exit 0
        fi
+else
+       if test $head != $ff_head -a $fast_forward = never
+       then
+               real_parents="$ff_head$LF$real_parents"
+       fi
+fi
+
+case "$real_parents" in
+?*"$LF"?*)
+       # We have more than one parent
+       common=$(git show-branch --merge-base $head $real_parents)
        ;;
+*)
+       # We have exactly one parent
+       test -n "$common" || common=$(git merge-base --all $head $real_parents)
+       case "$common" in
+       ?*"$LF"?*)
+               # We are not doing octopus and not fast forward.  Need a
+               # real merge.
+               ;;
+       *)
+               git update-index --refresh 2>/dev/null
+               if test "$allow_trivial_merge" = t
+               then
+                       # See if it is really trivial.
+                       git var GIT_COMMITTER_IDENT >/dev/null || exit
+                       echo "Trying really trivial in-index merge..."
+                       if git read-tree --trivial -m -u -v $common
$head $real_parents &&
+                               result_tree=$(git write-tree)
+                       then
+                               echo "Wonderful."
+                               result_commit=$(
+                                       printf '%s\n' "$merge_msg" |
+                                       git commit-tree $result_tree
-p HEAD -p $real_parents
+                               ) || exit
+                               finish "$result_commit" "In-index merge"
+                               dropsave
+                               exit 0
+                       fi
+                       echo "Nope."
+               fi ;;
+       esac ;;
 esac

 # We are going to make a new commit.
@@ -445,7 +486,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy

-    git-merge-$strategy $common -- "$head_arg" "$@"
+    git-merge-$strategy $common -- "$head_arg" $real_parents
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
@@ -481,17 +522,12 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    if test "$allow_fast_forward" = "t"
-    then
-        parents=$(git show-branch --independent "$head" "$@")
-    else
-        parents=$(git rev-parse "$head" "$@")
-    fi
-    parents=$(echo "$parents" | sed -e 's/^/-p /')
-    result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree
$result_tree $parents) || exit
-    finish "$result_commit" "Merge made by $wt_strategy."
-    dropsave
-    exit 0
+       test $head = $ff_head && real_parents="$head$LF$real_parents"
+       parents=$(echo "$real_parents" | sed -e 's/^/-p /')
+       result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree
$result_tree $parents) || exit
+       finish "$result_commit" "Merge made by $wt_strategy."
+       dropsave
+       exit 0
 fi

 # Pick the result from the best strategy and have the user fix it up.
@@ -515,7 +551,7 @@ case "$best_strategy" in
        echo "Rewinding the tree to pristine..."
        restorestate
        echo "Using the $best_strategy to prepare resolving by hand."
-       git-merge-$best_strategy $common -- "$head_arg" "$@"
+       git-merge-$best_strategy $common -- "$head_arg" $real_parents
        ;;
 esac

diff --git a/git-pull.sh b/git-pull.sh
index 3ce32b5..5bc84a6 100755
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
+       --ff=allow|--ff=only|--ff=never)
+               no_ff=$1 ;;
        -s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
                --strateg=*|--strategy=*|\
        -s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5d16628..085f55f 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -428,11 +428,6 @@ test_expect_success 'merge c0 with c1 (no-ff)' '

 test_debug 'gitk --all'

-test_expect_success 'combining --squash and --no-ff is refused' '
-       test_must_fail git merge --squash --no-ff c1 &&
-       test_must_fail git merge --no-ff --squash c1
-'
-
 test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
        git reset --hard c0 &&
        git config branch.master.mergeoptions "--no-ff" &&
diff --git a/t/t7601-merge-ff-options.sh b/t/t7601-merge-ff-options.sh
new file mode 100755
index 0000000..e78d32e
--- /dev/null
+++ b/t/t7601-merge-ff-options.sh
@@ -0,0 +1,722 @@
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
+test_expect_success 'merge c0 with c1 (--ff=only overrides --no-ff)' '
+       git reset --hard c0 &&
+       git config branch.master.mergeoptions "--no-ff" &&
+       git merge --ff=only c1 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--ff=only in config)' '
+       git reset --hard c0 &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       git merge c1 &&
+       test_tick &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only in config)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       git merge c0 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff=only in config)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       test_must_fail git merge c2 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--ff=only)' '
+       git reset --hard c0 &&
+       test_tick &&
+       git merge --ff=only c1 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git merge --ff=only c0 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2 (--ff=only)' '
+       git reset --hard c0 &&
+       test_must_fail git merge --ff=only c1 c2 &&
+       verify_merge file result.0 &&
+       verify_head $c0
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git merge --ff=only c0 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff=only overrides --no-ff)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "--no-ff" &&
+       test_tick &&
+       test_must_fail git merge c2 --ff=only &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--no-ff overrides --ff=only)' '
+       git reset --hard c0 &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       test_tick &&
+       git merge --no-ff c1 &&
+       verify_merge file result.1 &&
+       verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff owerrides --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       test_tick &&
+       git merge --ff c2 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
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
+test_expect_success 'merge c1 with x0 (--squash combined with --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge x0 --squash --ff=only &&
+       verify_merge file result.1-5 &&
+       verify_head $c1 &&
+       git commit &&
+       verify_parents $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--squash combined with --ff=only)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 --squash --ff=only &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 (--squash combined with --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge c2 --squash --ff=only &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with x0 (--squash combined with --ff=never)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge x0 --squash --ff=never &&
+       verify_merge file result.1-5 &&
+       verify_head $c1 &&
+       git commit &&
+       verify_parents $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--squash combined with --ff=never)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 --squash --ff=never &&
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
+       git merge c2 --squash --ff=never &&
+       verify_merge file result.1-5 &&
+       verify_head $c1 &&
+       git commit &&
+       verify_parents $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with x0 (--no-commit combined with --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge x0 --no-commit --ff=only &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--no-commit combined with --ff=only)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 --no-commit --ff=only &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 (--no-commit combined with --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge c2 --no-commit --ff=only &&
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
+test_expect_success 'merge c1 with x1 (pull --ff=only)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git pull --ff=only clone refs/heads/master &&
+       verify_merge file result.1-13 &&
+       verify_head $x1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x2 with x1 (pull --ff=only)' '
+       git reset --hard x2 &&
+       test_tick &&
+       test_must_fail git pull --ff=only clone refs/heads/master &&
+       verify_merge file result.5-13 &&
+       verify_head $x2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with new repository (pull --ff=only)' '
+       git reset --hard c1 &&
+       test_tick &&
+       test_must_fail git pull --ff=only new refs/heads/master &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_done

-- 
Sverre Hvammen Johansen
