From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] Restructure git-merge.sh
Date: Wed, 21 May 2008 18:16:47 -0700
Message-ID: <1211419009-9741-5-git-send-email-gitster@pobox.com>
References: <1211419009-9741-1-git-send-email-gitster@pobox.com>
 <1211419009-9741-2-git-send-email-gitster@pobox.com>
 <1211419009-9741-3-git-send-email-gitster@pobox.com>
 <1211419009-9741-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 03:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyzRs-0002NR-Ct
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 03:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762702AbYEVBRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 21:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762644AbYEVBRX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 21:17:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762099AbYEVBRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 21:17:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EFABD6862
	for <git@vger.kernel.org>; Wed, 21 May 2008 21:17:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AB1AB685F for <git@vger.kernel.org>; Wed, 21 May 2008 21:17:18 -0400
 (EDT)
X-Mailer: git-send-email 1.5.5.1.499.g878b8
In-Reply-To: <1211419009-9741-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D3052816-279C-11DD-8FBE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82597>

From: Sverre Hvammen Johansen <hvammen@gmail.com>

Restructure git-merge.sh for preparation of new feature:

       Head reduction before selecting merge strategy

Some aspects of this patch does not make much sense without
the next patch in this series.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 git-merge.sh |  186 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 105 insertions(+), 81 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 91fada7..fc14c4b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -213,6 +213,47 @@ parse_config () {
 	args_left=$#
 }
 
+# Find reduced parents
+# The following variables are set as follow:
+#   reduced_parents: The reduced parents of those specified on the command line.
+#                    However, the actual parents are included if we never ff.
+#   common:          All common ancestors or not_queried
+#   ff_head:         Head or an reduced parent that may be a candidate for fast forward
+find_reduced_parents () {
+	if test $fast_forward = never
+	then
+		reduced_parents=$(git rev-parse "$@")
+		ff_head=$head
+		common=not_queried
+	else
+		if test $# = 1
+		then
+			common=$(git merge-base --all $head "$1")
+			if test "$common" = $head
+			then
+				reduced_parents=
+				ff_head=$1
+			elif test "$common" = "$1"
+			then
+				reduced_parents=
+				ff_head=$head
+			else
+				reduced_parents=$1
+				ff_head=$head
+
+			fi
+		else
+			reduced_parents=$(git show-branch --independent $head "$@")
+			# Here we may actually lie about which bransh is ff of head.
+			# This will preserve the order the user gave.
+			ff_head=${reduced_parents%%$LF*}
+			reduced_parents=${reduced_parents#$ff_head}
+			reduced_parents=${reduced_parents#$LF}
+			common=not_queried
+		fi
+	fi
+}
+
 test $# != 0 || usage
 
 have_message=
@@ -301,24 +342,28 @@ do
 done
 set x $remoteheads ; shift
 
+find_reduced_parents "$@"
+
+actual_parents=$(git rev-parse "$@")
+
 case "$use_strategies" in
 '')
-	case "$#" in
-	1)
-		var="`git config --get pull.twohead`"
+	case "$actual_parents" in
+	?*"$LF"?*)
+		var="`git config --get pull.octopus`"
 		if test -n "$var"
 		then
 			use_strategies="$var"
 		else
-			use_strategies="$default_twohead_strategies"
+			use_strategies="$default_octopus_strategies"
 		fi ;;
 	*)
-		var="`git config --get pull.octopus`"
+		var="`git config --get pull.twohead`"
 		if test -n "$var"
 		then
 			use_strategies="$var"
 		else
-			use_strategies="$default_octopus_strategies"
+			use_strategies="$default_twohead_strategies"
 		fi ;;
 	esac
 	;;
@@ -346,87 +391,66 @@ do
 	done
 done
 
-case "$#" in
-1)
-	common=$(git merge-base --all $head "$@")
-	;;
-*)
-	common=$(git show-branch --merge-base $head "$@")
-	;;
-esac
 echo "$head" >"$GIT_DIR/ORIG_HEAD"
 
-case "$fast_forward,$#,$common,$no_commit" in
-*,*,'',*)
-	# No common ancestors found. We need a real merge.
-	;;
-*,1,"$1",*)
-	# If head can reach all the merge then we are up to date.
-	# but first the most common case of merging one remote.
-	finish_up_to_date "Already up-to-date."
-	exit 0
-	;;
-allow,1,"$head",*)
-	# Again the most common case of merging one remote.
-	echo "Updating $(git rev-parse --short $head)..$(git rev-parse --short $1)"
-	git update-index --refresh 2>/dev/null
-	msg="Fast forward"
-	if test -n "$have_message"
+if test -z "$reduced_parents"
+then
+	if test $head = $ff_head
 	then
-		msg="$msg (no commit created; -m option ignored)"
-	fi
-	new_head=$(git rev-parse --verify "$1^0") &&
-	git read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
-	finish "$new_head" "$msg" || exit
-	dropsave
-	exit 0
-	;;
-*,1,?*"$LF"?*,*)
-	# We are not doing octopus and not fast forward.  Need a
-	# real merge.
-	;;
-*,1,*,)
-	# We are not doing octopus, not fast forward, and have only
-	# one common.
-	git update-index --refresh 2>/dev/null
-	case "$allow_trivial_merge" in
-	t)
-		# See if it is really trivial.
-		git var GIT_COMMITTER_IDENT >/dev/null || exit
-		echo "Trying really trivial in-index merge..."
-		if git read-tree --trivial -m -u -v $common $head "$1" &&
-		   result_tree=$(git write-tree)
-		then
-			echo "Wonderful."
-			result_commit=$(
-				printf '%s\n' "$merge_msg" |
-				git commit-tree $result_tree -p HEAD -p "$1"
-			) || exit
-			finish "$result_commit" "In-index merge"
-			dropsave
-			exit 0
-		fi
-		echo "Nope."
-	esac
-	;;
-*)
-	# An octopus.  If we can reach all the remote we are up to date.
-	up_to_date=t
-	for remote
-	do
-		common_one=$(git merge-base --all $head $remote)
-		if test "$common_one" != "$remote"
+		finish_up_to_date "Already up-to-date."
+		exit 0
+	elif test $fast_forward != never
+	then
+		echo "Updating $(git rev-parse --short $head)..$(git rev-parse --short $ff_head)"
+		git update-index --refresh 2>/dev/null
+		msg="Fast forward"
+		if test -n "$have_message"
 		then
-			up_to_date=f
-			break
+			msg="$msg (no commit created; -m option ignored)"
 		fi
-	done
-	if test "$up_to_date" = t
-	then
-		finish_up_to_date "Already up-to-date. Yeeah!"
+		new_head=$(git rev-parse --verify "$ff_head^0") &&
+		git read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
+		finish "$new_head" "$msg" || exit
+		dropsave
 		exit 0
 	fi
+fi
+
+case "$actual_parents" in
+?*"$LF"?*)
+	# We have more than one actual parent
+	common=$(git show-branch --merge-base $head $actual_parents)
 	;;
+*)
+	# We have exactly one actual parent
+	test "$common" != not_queried || common=$(git merge-base --all $head $actual_parents)
+	case "$common" in
+	?*"$LF"?*)
+		# We are not doing octopus and not fast forward.  Need a
+		# real merge.
+		;;
+	*)
+		git update-index --refresh 2>/dev/null
+		if test "$allow_trivial_merge" = t
+		then
+			# See if it is really trivial.
+			git var GIT_COMMITTER_IDENT >/dev/null || exit
+			echo "Trying really trivial in-index merge..."
+			if git read-tree --trivial -m -u -v $common $head $actual_parents &&
+				result_tree=$(git write-tree)
+			then
+				echo "Wonderful."
+				result_commit=$(
+					printf '%s\n' "$merge_msg" |
+					git commit-tree $result_tree -p HEAD -p $actual_parents
+				) || exit
+				finish "$result_commit" "In-index merge"
+				dropsave
+				exit 0
+			fi
+			echo "Nope."
+		fi ;;
+	esac ;;
 esac
 
 # We are going to make a new commit.
@@ -467,7 +491,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy
 
-    git-merge-$strategy $common -- "$head_arg" "$@"
+    git-merge-$strategy $common -- "$head_arg" $actual_parents
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
@@ -537,7 +561,7 @@ case "$best_strategy" in
 	echo "Rewinding the tree to pristine..."
 	restorestate
 	echo "Using the $best_strategy to prepare resolving by hand."
-	git-merge-$best_strategy $common -- "$head_arg" "$@"
+	git-merge-$best_strategy $common -- "$head_arg" $actual_parents
 	;;
 esac
 
-- 
1.5.5.1.499.g878b8
