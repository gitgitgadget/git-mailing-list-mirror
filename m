From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-merge: do up-to-date check also for all strategies
Date: Wed, 15 Aug 2007 23:19:55 -0700
Message-ID: <7vwsvwj910.fsf@gitster.siamese.dyndns.org>
References: <20070809120831.19319.qmail@a61af064a2a242.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 08:20:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILYiH-0001Gd-5l
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 08:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957AbXHPGUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 02:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757981AbXHPGUF
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 02:20:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963AbXHPGUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 02:20:03 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4103711CC67;
	Thu, 16 Aug 2007 02:20:19 -0400 (EDT)
In-Reply-To: <20070809120831.19319.qmail@a61af064a2a242.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Thu, 9 Aug 2007 12:08:31 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55981>

How about doing this instead?  When "subtree" is used for
criss-cross (which is not recommended), you should not allow
fast-forward.  Also "ours" should not allow fast-forward, as the
result will be their tree and by definition that is not what
"ours" want.  All strategies including "ours" and "subtree"
should allow up-to-date (i.e. we are ahead of them).

Looking at git-merge again after a long while makes me wonder 
if it makes sense to support only a single strategy.  Back when
we did not know which one of recursive or multi-head resolve was
the right way to go, being able to try multiple strategies and
pick the "best" result sounded like a fun plan, but I do not
think anybody uses this capability.

-- >8 --
[PATCH] git-merge: do up-to-date check also for all strategies

This clarifies the logic to omit fast-forward check and omit
trivial merge before running the specified strategy.

The "index_merge" variable started out as a flag to say "do not
do anything clever", but when recursive was changed to skip the
trivial merge, the semantics were changed and the variable alone
does not make sense anymore.

This splits the variable into two, allow_fast_forward (which is
almost always true, and avoids making a merge commit when the
other commit is a descendant of our branch, but is set to false
for ours and subtree) and allow_trivial_merge (which is false
for ours, recursive and subtree).

Unlike the earlier implementation, the "ours" strategy allows an
up-to-date condition.  When we are up-to-date, the result will
be our commit, and by definition, we will have our tree as the
result.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 git-merge.sh                |   35 +++++++++++--------
 t/t6028-merge-up-to-date.sh |   77 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 15 deletions(-)
 create mode 100755 t/t6028-merge-up-to-date.sh

diff --git a/git-merge.sh b/git-merge.sh
index 5ccf282..3a01db0 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -19,10 +19,12 @@ LF='
 all_strategies='recur recursive octopus resolve stupid ours subtree'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
-no_trivial_merge_strategies='ours subtree'
+no_fast_forward_strategies='subtree ours'
+no_trivial_strategies='recursive recur subtree ours'
 use_strategies=
 
-index_merge=t
+allow_fast_forward=t
+allow_trivial_merge=t
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
@@ -265,11 +267,20 @@ esac
 
 for s in $use_strategies
 do
-	for nt in $no_trivial_merge_strategies
+	for ss in $no_fast_forward_strategies
 	do
 		case " $s " in
-		*" $nt "*)
-			index_merge=f
+		*" $ss "*)
+			allow_fast_forward=f
+			break
+			;;
+		esac
+	done
+	for ss in $no_trivial_strategies
+	do
+		case " $s " in
+		*" $ss "*)
+			allow_trivial_merge=f
 			break
 			;;
 		esac
@@ -286,10 +297,7 @@ case "$#" in
 esac
 echo "$head" >"$GIT_DIR/ORIG_HEAD"
 
-case "$index_merge,$#,$common,$no_commit" in
-f,*)
-	# We've been told not to try anything clever.  Skip to real merge.
-	;;
+case "$allow_fast_forward,$#,$common,$no_commit" in
 ?,*,'',*)
 	# No common ancestors found. We need a real merge.
 	;;
@@ -299,7 +307,7 @@ f,*)
 	finish_up_to_date "Already up-to-date."
 	exit 0
 	;;
-?,1,"$head",*)
+t,1,"$head",*)
 	# Again the most common case of merging one remote.
 	echo "Updating $(git rev-parse --short $head)..$(git rev-parse --short $1)"
 	git update-index --refresh 2>/dev/null
@@ -322,11 +330,8 @@ f,*)
 	# We are not doing octopus, not fast forward, and have only
 	# one common.
 	git update-index --refresh 2>/dev/null
-	case " $use_strategies " in
-	*' recursive '*|*' recur '*)
-		: run merge later
-		;;
-	*)
+	case "$allow_trivial_merge" in
+	t)
 		# See if it is really trivial.
 		git var GIT_COMMITTER_IDENT >/dev/null || exit
 		echo "Trying really trivial in-index merge..."
diff --git a/t/t6028-merge-up-to-date.sh b/t/t6028-merge-up-to-date.sh
new file mode 100755
index 0000000..f8f3e3f
--- /dev/null
+++ b/t/t6028-merge-up-to-date.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+test_description='merge fast forward and up to date'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git tag c0 &&
+
+	echo second >file &&
+	git add file &&
+	test_tick &&
+	git commit -m second &&
+	git tag c1 &&
+	git branch test
+'
+
+test_expect_success 'merge -s recursive up-to-date' '
+
+	git reset --hard c1 &&
+	test_tick &&
+	git merge -s recursive c0 &&
+	expect=$(git rev-parse c1) &&
+	current=$(git rev-parse HEAD) &&
+	test "$expect" = "$current"
+
+'
+
+test_expect_success 'merge -s recursive fast-forward' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge -s recursive c1 &&
+	expect=$(git rev-parse c1) &&
+	current=$(git rev-parse HEAD) &&
+	test "$expect" = "$current"
+
+'
+
+test_expect_success 'merge -s ours up-to-date' '
+
+	git reset --hard c1 &&
+	test_tick &&
+	git merge -s ours c0 &&
+	expect=$(git rev-parse c1) &&
+	current=$(git rev-parse HEAD) &&
+	test "$expect" = "$current"
+
+'
+
+test_expect_success 'merge -s ours fast-forward' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge -s ours c1 &&
+	expect=$(git rev-parse c0^{tree}) &&
+	current=$(git rev-parse HEAD^{tree}) &&
+	test "$expect" = "$current"
+
+'
+
+test_expect_success 'merge -s subtree up-to-date' '
+
+	git reset --hard c1 &&
+	test_tick &&
+	git merge -s subtree c0 &&
+	expect=$(git rev-parse c1) &&
+	current=$(git rev-parse HEAD) &&
+	test "$expect" = "$current"
+
+'
+
+test_done
