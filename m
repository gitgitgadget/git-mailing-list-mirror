From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH 3/5] Restructure git-merge.sh
Date: Sun, 30 Mar 2008 20:29:12 -0800
Message-ID: <402c10cd0803302129o396e5d37u944f76cd345d672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 06:30:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgBev-0002H7-O3
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 06:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbYCaE3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 00:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYCaE3U
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 00:29:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:6848 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYCaE3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 00:29:19 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1681453fgb.17
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 21:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=FOIXUc7z08VlT1sZWpeLPb7Oj9y6wiYaxi4nMa2OzO4=;
        b=ktTZtvoS5VmfFtKvWvk90Av5cF4TRRfkXQh0YqVfXwUjClLzL7HAx8TgpjfSgtRFsUxCbaDAYxuxIo/43dyUaIjtVywflCGyLxwbzlbD/UydX3KcIXXjaJ6p584jZrX544VtMGgCD+DReiIBWNx5jEoJHbYFs/WKgCIkMOpnG5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hHm9PvI/Fe0xtnWb2rlHTo+EcQNGZyN9DMhdCGj7ENW27tI7KHbtA5291BGJT7Mps32XAdPftWWZ3vVIWDmuquWtTzUcHxVCgaquHrQybne3Az2I23cEZKK0cYuDViT8yrBqYDlvOtdceCzSOMowO/uygYtGvT8MJGvfzP5eNHs=
Received: by 10.82.184.2 with SMTP id h2mr15872487buf.1.1206937757519;
        Sun, 30 Mar 2008 21:29:17 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Sun, 30 Mar 2008 21:29:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78554>

Restructure git-merge.sh for preparation of new feature:

       Head reduction before selecting merge strategy

Some aspects of this patch does not make much sense without
the next patch in this series.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 git-merge.sh |  186 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 105 insertions(+), 81 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 17f40f2..7c34b6c 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -207,6 +207,47 @@ parse_config () {
        args_left=$#
 }

+# Find reduced parents
+# The following variables are set as follow:
+#   reduced_parents: The reduced parents of those specified on the
command line.
+#                    However, the actual parents are included if we never ff.
+#   common:          All common ancestors or not_queried
+#   ff_head:         Head or an reduced parent that may be a
candidate for fast forward
+find_reduced_parents () {
+       if test $fast_forward = never
+       then
+               reduced_parents=$(git rev-parse "$@")
+               ff_head=$head
+               common=not_queried
+       else
+               if test $# = 1
+               then
+                       common=$(git merge-base --all $head "$1")
+                       if test "$common" = $head
+                       then
+                               reduced_parents=
+                               ff_head=$1
+                       elif test "$common" = "$1"
+                       then
+                               reduced_parents=
+                               ff_head=$head
+                       else
+                               reduced_parents=$1
+                               ff_head=$head
+
+                       fi
+               else
+                       reduced_parents=$(git show-branch
--independent $head "$@")
+                       # Here we may actually lie about which bransh
is ff of head.
+                       # This will preserve the order the user gave.
+                       ff_head=${reduced_parents%%$LF*}
+                       reduced_parents=${reduced_parents#$ff_head}
+                       reduced_parents=${reduced_parents#$LF}
+                       common=not_queried
+               fi
+       fi
+}
+
 test $# != 0 || usage

 have_message=
@@ -294,24 +335,28 @@ do
 done
 set x $remoteheads ; shift

+find_reduced_parents "$@"
+
+actual_parents=$(git rev-parse "$@")
+
 case "$use_strategies" in
 '')
-       case "$#" in
-       1)
-               var="`git config --get pull.twohead`"
+       case "$actual_parents" in
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
@@ -339,87 +384,66 @@ do
        done
 done

-case "$#" in
-1)
-       common=$(git merge-base --all $head "$@")
-       ;;
-*)
-       common=$(git show-branch --merge-base $head "$@")
-       ;;
-esac
 echo "$head" >"$GIT_DIR/ORIG_HEAD"

-case "$fast_forward,$#,$common,$no_commit" in
-*,*,'',*)
-       # No common ancestors found. We need a real merge.
-       ;;
-*,1,"$1",*)
-       # If head can reach all the merge then we are up to date.
-       # but first the most common case of merging one remote.
-       finish_up_to_date "Already up-to-date."
-       exit 0
-       ;;
-allow,1,"$head",*)
-       # Again the most common case of merging one remote.
-       echo "Updating $(git rev-parse --short $head)..$(git rev-parse
--short $1)"
-       git update-index --refresh 2>/dev/null
-       msg="Fast forward"
-       if test -n "$have_message"
+if test -z "$reduced_parents"
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
-*,1,?*"$LF"?*,*)
-       # We are not doing octopus and not fast forward.  Need a
-       # real merge.
-       ;;
-*,1,*,)
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
+       elif test $fast_forward != never
+       then
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
+fi
+
+case "$actual_parents" in
+?*"$LF"?*)
+       # We have more than one actual parent
+       common=$(git show-branch --merge-base $head $actual_parents)
        ;;
+*)
+       # We have exactly one actual parent
+       test "$common" != not_queried || common=$(git merge-base --all
$head $actual_parents)
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
$head $actual_parents &&
+                               result_tree=$(git write-tree)
+                       then
+                               echo "Wonderful."
+                               result_commit=$(
+                                       printf '%s\n' "$merge_msg" |
+                                       git commit-tree $result_tree
-p HEAD -p $actual_parents
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
@@ -460,7 +484,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy

-    git-merge-$strategy $common -- "$head_arg" "$@"
+    git-merge-$strategy $common -- "$head_arg" $actual_parents
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
@@ -530,7 +554,7 @@ case "$best_strategy" in
        echo "Rewinding the tree to pristine..."
        restorestate
        echo "Using the $best_strategy to prepare resolving by hand."
-       git-merge-$best_strategy $common -- "$head_arg" "$@"
+       git-merge-$best_strategy $common -- "$head_arg" $actual_parents
        ;;
 esac

-- 
Sverre Hvammen Johansen
