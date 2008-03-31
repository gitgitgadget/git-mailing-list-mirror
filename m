From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH 4/5] Head reduction before selecting merge strategy
Date: Sun, 30 Mar 2008 20:30:58 -0800
Message-ID: <402c10cd0803302130g7f511312wa7eb8cdf51780fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 06:31:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgBgS-0002XG-0J
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 06:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbYCaEbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 00:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYCaEbE
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 00:31:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:8636 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYCaEbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 00:31:02 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1682145fgb.17
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 21:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=RZo9bkvgJXinzqtxVSv3XJ9GlbulpRH5iAZkfyuiE6o=;
        b=Y0UPS7Tzq3BCDprGb4033FbEfjjchTnCpDV0q/2oyGhK6fERRUppAEtkP+/oRxkQpUMRE2EYBOW/7AxZhBgE1Q16dQRDqJEOzNYi4XBbLNQaevlv8KegRFmIALkJlx/WxdMfIaWlal4C2D2rJO4qont8GWybab4E/m4a/NbQUag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DqLq4UP8ojqoikAVT4b/gcswx/l6nPswjWWPAzHb4sGlyPqZh/stWg3V0e888+mTst2CTupx0si1ANRN0piPO1a26QZcn1ne7K74+Ula/2gPoe9PJxnXVIHq/Khg3DZgsrrhgCR4G+5FEMAJ4rgMyn5OGAtFgsIN4oYMI6la9Pw=
Received: by 10.82.149.8 with SMTP id w8mr14494726bud.24.1206937858847;
        Sun, 30 Mar 2008 21:30:58 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Sun, 30 Mar 2008 21:30:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78555>

See the documentation for an explanation of this feature.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/git-merge.txt |   43 ++++++++++++++++++++++++++++++++++++-
 git-merge.sh                |   50 ++++++++++++++++++++++++-------------------
 2 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 2af33d8..f6bc96f 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -36,7 +36,7 @@ include::merge-options.txt[]
 <remote>::
        Other branch head merged into our branch.  You need at
        least one <remote>.  Specifying more than one <remote>
-       obviously means you are trying an Octopus.
+       usually means you are trying an Octopus.


 include::fast-forward-options.txt[]
@@ -133,6 +133,47 @@ merge (which is typically a fraction of the whole
tree), you can
 have local modifications in your working tree as long as they do
 not overlap with what the merge updates.

+If more than one commit are specified on the command line, git will
+try to reduce the number of commits used (reduced parents) by
+eliminating commits than can be reached from other commits.  The
+commit message will reflect the commits specified on the command line
+but the merge strategy will be selected based on the reduced parents
+including `HEAD`.  The reduced parents are the parents recorded in the
+merge commit object.
+
+The following shows master and three topic branches.  topicB is based
+on topicA, topicA is previously branched off from master, and topicC
+is based on the tip of the master branch:
+
+------------
+                    o---o---o  topicB
+                   /
+          o---o---o  topicA
+         /
+    o---o---o---o---o---o  master
+                         \
+                          o---o  topicC
+------------
+
+Merging topicA, B and C to the master branch will select the merge
+strategy based on the three branches master, topicB, and topicC
+(topicA is eliminated since it can be reached from topicB).  topicB
+and topicC are the reduced parents and are therefore the only
+parents recorded in the merge commit object:
+
+------------
+         $ git checkout master
+         $ git merge topicA topicB topicC
+
+                    o---o---o  topicB
+                   /         \
+          o---o---o  topicA   \
+         /                     \
+    o---o---o---o---o---o       o  master
+                         \     /
+                          o---o  topicC
+------------
+
 When there are conflicts, these things happen:

 1. `HEAD` stays the same.
diff --git a/git-merge.sh b/git-merge.sh
index 7c34b6c..7c70c56 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -337,11 +337,16 @@ set x $remoteheads ; shift

 find_reduced_parents "$@"

-actual_parents=$(git rev-parse "$@")
+# ff_head may be included here or later in actual parents
+if test -n "$reduced_parents"
+then
+       test $head = $ff_head ||
+               reduced_parents="$ff_head$LF$reduced_parents"
+fi

 case "$use_strategies" in
 '')
-       case "$actual_parents" in
+       case "$reduced_parents" in
        ?*"$LF"?*)
                var="`git config --get pull.octopus`"
                if test -n "$var"
@@ -406,17 +411,23 @@ then
                finish "$new_head" "$msg" || exit
                dropsave
                exit 0
+       else
+               reduced_parents="$ff_head"
+               ff_head=$head
        fi
+else
+       test $head != $ff_head -a $fast_forward = never &&
+               reduced_parents="$ff_head$LF$reduced_parents"
 fi

-case "$actual_parents" in
+case "$reduced_parents" in
 ?*"$LF"?*)
-       # We have more than one actual parent
-       common=$(git show-branch --merge-base $head $actual_parents)
+       # We have more than one reduced parent
+       common=$(git show-branch --merge-base $head $reduced_parents)
        ;;
 *)
-       # We have exactly one actual parent
-       test "$common" != not_queried || common=$(git merge-base --all
$head $actual_parents)
+       # We have exactly one reduced parent
+       test "$common" != not_queried || common=$(git merge-base --all
$head $reduced_parents)
        case "$common" in
        ?*"$LF"?*)
                # We are not doing octopus and not fast forward.  Need a
@@ -429,13 +440,13 @@ case "$actual_parents" in
                        # See if it is really trivial.
                        git var GIT_COMMITTER_IDENT >/dev/null || exit
                        echo "Trying really trivial in-index merge..."
-                       if git read-tree --trivial -m -u -v $common
$head $actual_parents &&
+                       if git read-tree --trivial -m -u -v $common
$head $reduced_parents &&
                                result_tree=$(git write-tree)
                        then
                                echo "Wonderful."
                                result_commit=$(
                                        printf '%s\n' "$merge_msg" |
-                                       git commit-tree $result_tree
-p HEAD -p $actual_parents
+                                       git commit-tree $result_tree
-p HEAD -p $reduced_parents
                                ) || exit
                                finish "$result_commit" "In-index merge"
                                dropsave
@@ -484,7 +495,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy

-    git-merge-$strategy $common -- "$head_arg" $actual_parents
+    git-merge-$strategy $common -- "$head_arg" $reduced_parents
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
@@ -520,17 +531,12 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    if test $fast_forward = allow
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
+       test $head = $ff_head && reduced_parents="$head$LF$reduced_parents"
+       parents=$(echo "$reduced_parents" | sed -e 's/^/-p /')
+       result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree
$result_tree $parents) || exit
+       finish "$result_commit" "Merge made by $wt_strategy."
+       dropsave
+       exit 0
 fi

 # Pick the result from the best strategy and have the user fix it up.
@@ -554,7 +560,7 @@ case "$best_strategy" in
        echo "Rewinding the tree to pristine..."
        restorestate
        echo "Using the $best_strategy to prepare resolving by hand."
-       git-merge-$best_strategy $common -- "$head_arg" $actual_parents
+       git-merge-$best_strategy $common -- "$head_arg" $reduced_parents
        ;;
 esac
-- 
Sverre Hvammen Johansen
