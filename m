From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH 2/5] Introduce -ff=<fast forward option>
Date: Sun, 30 Mar 2008 20:23:40 -0800
Message-ID: <402c10cd0803302123i2111a54fp58f7c24224bfb01c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 06:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgBZK-0001Ay-Qi
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 06:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYCaEXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 00:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYCaEXo
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 00:23:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:58126 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYCaEXn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 00:23:43 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1679356fgb.17
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 21:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=dcli8LTZPHSPnMVgzESECoVfH9fkT9lElmcH4TGXdyQ=;
        b=YXyThJt+tjHFU6TvcJr+ycUYOfpKxzY9D1rW1BNIZ9qvUjiHp3gRNkYCsAH4yCa6y+MykRXT0Od1P7Q8S2bl6hrfB5qp6EI8dvOmPG+Xxzt1Jt3R+WeQ5VM+4luJsl5U1399dcwEX7WS05lc0ydS8kFx/rE83olKhxv2uXZj0Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=riAwnsusWaywJdd9FBmsIdVmrsNae240eYf4QtuTJkzG2mj2RcUAR3X0kNxHfm+AO0RKr5MRRcz7ShXLbNxGuaxdy0dWK/S/2+EspKNy1UuiVjUsnvBB72snldQqt5cl0+sgyu1Kr8F9iBZgs6vUnd2VoBKmCMgiB9Lg8Q6IH4w=
Received: by 10.82.174.20 with SMTP id w20mr14174531bue.38.1206937421041;
        Sun, 30 Mar 2008 21:23:41 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Sun, 30 Mar 2008 21:23:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78553>

--ff now takes an argument allowing --ff to be written
as --ff=allow and -no-ff to be written as --ff=never.
This change allow other fast forward options to be
introduced later.

See the documentation for a further explanation of these options.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/fast-forward-options.txt |   44 ++++++++
 Documentation/git-merge.txt            |    6 +-
 Documentation/git-pull.txt             |    2 +
 Documentation/merge-options.txt        |    9 +-
 git-merge.sh                           |   47 +++++---
 git-pull.sh                            |    4 +-
 t/t7601-merge-ff-options.sh            |  188 ++++++++++++++++++++++++++++++++
 7 files changed, 277 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/fast-forward-options.txt

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
index 408122e..2749f4f 100755
--- a/t/t7601-merge-ff-options.sh
+++ b/t/t7601-merge-ff-options.sh
@@ -458,4 +458,192 @@ test_expect_success 'merge c1 with c2 and x1' '

 test_debug 'gitk --all'

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
 test_done

-- 
Sverre Hvammen Johansen
