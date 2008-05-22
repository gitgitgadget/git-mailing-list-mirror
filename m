From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] Head reduction before selecting merge strategy
Date: Wed, 21 May 2008 18:16:48 -0700
Message-ID: <1211419009-9741-6-git-send-email-gitster@pobox.com>
References: <1211419009-9741-1-git-send-email-gitster@pobox.com>
 <1211419009-9741-2-git-send-email-gitster@pobox.com>
 <1211419009-9741-3-git-send-email-gitster@pobox.com>
 <1211419009-9741-4-git-send-email-gitster@pobox.com>
 <1211419009-9741-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 03:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyzRt-0002NR-2D
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 03:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762902AbYEVBRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 21:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762870AbYEVBR3
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 21:17:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762644AbYEVBR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 21:17:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7820A6865
	for <git@vger.kernel.org>; Wed, 21 May 2008 21:17:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4EFE46863 for <git@vger.kernel.org>; Wed, 21 May 2008 21:17:23 -0400
 (EDT)
X-Mailer: git-send-email 1.5.5.1.499.g878b8
In-Reply-To: <1211419009-9741-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D77F2914-279C-11DD-A78E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82596>

From: Sverre Hvammen Johansen <hvammen@gmail.com>

This commit uses the reduced parents instead of the actual
parents specified for selecting the merge strategy when doing
a merge.  The recorded parents and the commit message stays
the same.

Some cases where we before needed an octopus strategy may now be
done using a two head strategy.

See the documentation for further details.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/git-merge.txt |   20 +++++++++-------
 git-merge.sh                |   50 ++++++++++++++++++++++++-------------------
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 9cf761d..845d0ed 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -36,7 +36,7 @@ include::merge-options.txt[]
 <remote>::
 	Other branch head merged into our branch.  You need at
 	least one <remote>.  Specifying more than one <remote>
-	obviously means you are trying an Octopus.
+	usually means you are trying an Octopus.
 
 
 include::fast-forward-options.txt[]
@@ -158,11 +158,12 @@ After seeing a conflict, you can do two things:
 JOINING MORE THAN TWO HISTORIES
 -------------------------------
 
-More than one remote may be specified on the command line.  Those
-remotes are used for selecting the merge startegy and is also used in
-the merge commit message.  However, some of these remotes may not be
-independent.  Only remotes with independent heads (reduced parents)
-will be recorded in the merge commit object.
+More than one remote may be specified on the command line.  Some of
+these remotes may not have independent heads.  Git will only use the
+remotes with independent heads (reduced parents) for selecting the
+merge startegy.  The reduced parents are the parents recorded in the
+merge commit object.  However, the commit message will reflect the
+remotes specified on the command line.
 
 The following shows master and two topic branches.  topicB is based
 on topicA, topicA is previously branched off from master:
@@ -177,9 +178,10 @@ on topicA, topicA is previously branched off from master:
 ------------
 
 Merging topicA and topicB to the master branch will select the merge
-strategy based on all three branches (an Octopus).  master and topicB
-are the reduced parents and are therefore the only parents recorded in
-the merge commit object:
+strategy based on the two independent branch heads, tip of the master
+branch and the tip of the topicB branch (a two head strategy).  The
+commits are also the reduced parents recorded in the merge commit
+object:
 
 ------------
 
diff --git a/git-merge.sh b/git-merge.sh
index fc14c4b..775dae7 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -344,11 +344,16 @@ set x $remoteheads ; shift
 
 find_reduced_parents "$@"
 
-actual_parents=$(git rev-parse "$@")
+# ff_head may be included here or later in actual parents
+if test -n "$reduced_parents"
+then
+	test $head = $ff_head ||
+		reduced_parents="$ff_head$LF$reduced_parents"
+fi
 
 case "$use_strategies" in
 '')
-	case "$actual_parents" in
+	case "$reduced_parents" in
 	?*"$LF"?*)
 		var="`git config --get pull.octopus`"
 		if test -n "$var"
@@ -413,17 +418,23 @@ then
 		finish "$new_head" "$msg" || exit
 		dropsave
 		exit 0
+	else
+		reduced_parents="$ff_head"
+		ff_head=$head
 	fi
+else
+	test $head != $ff_head -a $fast_forward = never &&
+		reduced_parents="$ff_head$LF$reduced_parents"
 fi
 
-case "$actual_parents" in
+case "$reduced_parents" in
 ?*"$LF"?*)
-	# We have more than one actual parent
-	common=$(git show-branch --merge-base $head $actual_parents)
+	# We have more than one reduced parent
+	common=$(git show-branch --merge-base $head $reduced_parents)
 	;;
 *)
-	# We have exactly one actual parent
-	test "$common" != not_queried || common=$(git merge-base --all $head $actual_parents)
+	# We have exactly one reduced parent
+	test "$common" != not_queried || common=$(git merge-base --all $head $reduced_parents)
 	case "$common" in
 	?*"$LF"?*)
 		# We are not doing octopus and not fast forward.  Need a
@@ -436,13 +447,13 @@ case "$actual_parents" in
 			# See if it is really trivial.
 			git var GIT_COMMITTER_IDENT >/dev/null || exit
 			echo "Trying really trivial in-index merge..."
-			if git read-tree --trivial -m -u -v $common $head $actual_parents &&
+			if git read-tree --trivial -m -u -v $common $head $reduced_parents &&
 				result_tree=$(git write-tree)
 			then
 				echo "Wonderful."
 				result_commit=$(
 					printf '%s\n' "$merge_msg" |
-					git commit-tree $result_tree -p HEAD -p $actual_parents
+					git commit-tree $result_tree -p HEAD -p $reduced_parents
 				) || exit
 				finish "$result_commit" "In-index merge"
 				dropsave
@@ -491,7 +502,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy
 
-    git-merge-$strategy $common -- "$head_arg" $actual_parents
+    git-merge-$strategy $common -- "$head_arg" $reduced_parents
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
@@ -527,17 +538,12 @@ done
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
-    result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree $result_tree $parents) || exit
-    finish "$result_commit" "Merge made by $wt_strategy."
-    dropsave
-    exit 0
+	test $head = $ff_head && reduced_parents="$head$LF$reduced_parents"
+	parents=$(echo "$reduced_parents" | sed -e 's/^/-p /')
+	result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree $result_tree $parents) || exit
+	finish "$result_commit" "Merge made by $wt_strategy."
+	dropsave
+	exit 0
 fi
 
 # Pick the result from the best strategy and have the user fix it up.
@@ -561,7 +567,7 @@ case "$best_strategy" in
 	echo "Rewinding the tree to pristine..."
 	restorestate
 	echo "Using the $best_strategy to prepare resolving by hand."
-	git-merge-$best_strategy $common -- "$head_arg" $actual_parents
+	git-merge-$best_strategy $common -- "$head_arg" $reduced_parents
 	;;
 esac
 
-- 
1.5.5.1.499.g878b8
