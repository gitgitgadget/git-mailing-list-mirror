From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH 2/4] Restructuring git-merge.sh
Date: Tue, 25 Mar 2008 19:56:37 -0800
Message-ID: <402c10cd0803252056n122cae6cv1a6f4e46a5fb5096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 04:57:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeMlb-00067q-Cp
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 04:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbYCZD4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 23:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbYCZD4k
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 23:56:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:33708 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbYCZD4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 23:56:39 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3826019fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 20:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=NT/MR0rHH46PPKbGlRfIEHeY6Ped6agxHDOf2Zc+e9c=;
        b=QPVrSMetabho4C5yRslCmvjfBRjYBP8qkng/DitLisi90q8IR/uUSSSFiMxQd2GiQVavE+0Xr9KS/tmVEoV56yjS7O0n9RCFcQP24f4hV/iSx4wKjAoxxvvlaX9YzmEkrUbXHs36RidKR/3s+xybgUE9Cuwlmu2xXhds/6aVOe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rtMnHrxoYdj2DBjnGUsH6/tjXE+u/DKjvffRxX4yqd6QO1W0FUelfE1R1LeoEPxn8oabAiqrjrvPx1hEB2lqpjVASulpr6oUeMTkT+/JW6GLHSzciOCDu+GHcdHKA/qxGZWmmyMZW+Q7CwfOIt6Q3ZhyBpH3SQ0vluSlULMjeE4=
Received: by 10.82.124.10 with SMTP id w10mr23154396buc.18.1206503797649;
        Tue, 25 Mar 2008 20:56:37 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 25 Mar 2008 20:56:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78252>

for preparation of new feature:

   Head reduction before selecting merge strategy

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 git-merge.sh |  166 ++++++++++++++++++++++++++++++----------------------------
 1 files changed, 85 insertions(+), 81 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 17f40f2..2acd2cc 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -207,6 +207,29 @@ parse_config () {
        args_left=$#
 }

+# Find real parents
+# Set the following variables as followd:
+#   real_parents: The parents specified on the command line
+#   common:       All common ancestors or not_queried
+#   ff_head:      Fast forward of head
+find_real_parents () {
+       real_parents=$(git rev-parse "$@")
+       real_parents=${real_parents#$LF}
+       if test $# = 1
+       then
+               common=$(git merge-base --all $head "$@")
+               if test "$common" = $head
+               then
+                       ff_head=$1
+               else
+                       ff_head=$head
+               fi
+       else
+               common=not_queried
+               ff_head=$head
+       fi
+}
+
 test $# != 0 || usage

 have_message=
@@ -294,24 +317,26 @@ do
 done
 set x $remoteheads ; shift

+find_real_parents "$@"
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
@@ -339,87 +364,66 @@ do
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
+if true
+then
+       if test $head = $ff_head -a "$common" = "$real_parents"
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
+       elif test $fast_forward != never -a $ff_head = "$real_parents"
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
+case "$real_parents" in
+?*"$LF"?*)
+       # We have more than one parent
+       common=$(git show-branch --merge-base $head $real_parents)
        ;;
+*)
+       # We have exactly one parent
+       test "$common" != not_queried || common=$(git merge-base --all
$head $real_parents)
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
@@ -460,7 +464,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy

-    git-merge-$strategy $common -- "$head_arg" "$@"
+    git-merge-$strategy $common -- "$head_arg" $real_parents
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
@@ -530,7 +534,7 @@ case "$best_strategy" in
        echo "Rewinding the tree to pristine..."
        restorestate
        echo "Using the $best_strategy to prepare resolving by hand."
-       git-merge-$best_strategy $common -- "$head_arg" "$@"
+       git-merge-$best_strategy $common -- "$head_arg" $real_parents
        ;;
 esac

-- 
Sverre Hvammen Johansen
