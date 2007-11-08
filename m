From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase: operate on a detached HEAD
Date: Thu, 8 Nov 2007 18:19:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081818330.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 08 19:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqByZ-0001Nv-DT
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 19:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761879AbXKHSTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 13:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761862AbXKHSTR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 13:19:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:49860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761690AbXKHSTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 13:19:15 -0500
Received: (qmail invoked by alias); 08 Nov 2007 18:19:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 08 Nov 2007 19:19:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193NkMLNCp3xoV31YufzoXYveLKDkrVBntJPGnscC
	ttyfwJbVNBAdRw
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64058>


The interactive version of rebase does all the operations on a detached
HEAD, so that after a successful rebase, <branch>@{1} is the pre-rebase
state.  The reflogs of "HEAD" still show all the actions in detail.

This teaches the non-interactive version to do the same.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase.sh           |   56 ++++++++++++++++++++++++++++++++++++++++++----
 t/t3402-rebase-merge.sh |    7 +++++-
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8814be9..3684a31 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -88,7 +88,7 @@ call_merge () {
 	cmt="$(cat "$dotest/cmt.$1")"
 	echo "$cmt" > "$dotest/current"
 	hd=$(git rev-parse --verify HEAD)
-	cmt_name=$(git symbolic-ref HEAD)
+	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
 	msgnum=$(cat "$dotest/msgnum")
 	end=$(cat "$dotest/end")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
@@ -116,7 +116,24 @@ call_merge () {
 	esac
 }
 
+move_to_original_branch () {
+	test -z "$head_name" &&
+		head_name="$(cat "$dotest"/head-name)" &&
+		onto="$(cat "$dotest"/onto)" &&
+		orig_head="$(cat "$dotest"/orig-head)"
+	case "$head_name" in
+	refs/*)
+		message="rebase finished: $head_name onto $onto"
+		git update-ref -m "$message" \
+			$head_name $(git rev-parse HEAD) $orig_head &&
+		git symbolic-ref HEAD $head_name ||
+		die "Could not move back to $head_name"
+		;;
+	esac
+}
+
 finish_rb_merge () {
+	move_to_original_branch
 	rm -r "$dotest"
 	echo "All done."
 }
@@ -175,16 +192,23 @@ do
 			finish_rb_merge
 			exit
 		fi
-		git am -3 --skip --resolvemsg="$RESOLVEMSG"
+		head_name=$(cat .dotest/head-name) &&
+		onto=$(cat .dotest/onto) &&
+		orig_head=$(cat .dotest/orig-head) &&
+		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
+		move_to_original_branch
 		exit
 		;;
 	--abort)
 		git rerere clear
 		if test -d "$dotest"
 		then
+			move_to_original_branch
 			rm -r "$dotest"
 		elif test -d .dotest
 		then
+			dotest=.dotest
+			move_to_original_branch
 			rm -r .dotest
 		else
 			die "No rebase in progress?"
@@ -320,6 +344,19 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
+# move to a detached HEAD
+orig_head=$(git rev-parse HEAD^0)
+head_name=$(git symbolic-ref HEAD 2> /dev/null)
+case "$head_name" in
+'')
+	head_name="detached HEAD"
+	;;
+*)
+	git checkout "$orig_head" > /dev/null 2>&1 ||
+		die "could not detach HEAD"
+	;;
+esac
+
 # Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
 echo "First, rewinding head to replay your work on top of it..."
 git-reset --hard "$onto"
@@ -329,14 +366,21 @@ git-reset --hard "$onto"
 if test "$mb" = "$branch"
 then
 	echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	move_to_original_branch
 	exit 0
 fi
 
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream "$upstream"..ORIG_HEAD |
-	git am $git_am_opt --binary -3 -k --resolvemsg="$RESOLVEMSG"
-	exit $?
+	git am $git_am_opt --binary -3 -k --resolvemsg="$RESOLVEMSG" &&
+	move_to_original_branch
+	ret=$?
+	test 0 != $ret -a -d .dotest &&
+		echo $head_name > .dotest/head-name &&
+		echo $onto > .dotest/onto &&
+		echo $orig_head > .dotest/orig-head
+	exit $ret
 fi
 
 # start doing a rebase with git-merge
@@ -345,8 +389,10 @@ fi
 mkdir -p "$dotest"
 echo "$onto" > "$dotest/onto"
 echo "$onto_name" > "$dotest/onto_name"
-prev_head=`git rev-parse HEAD^0`
+prev_head=$orig_head
 echo "$prev_head" > "$dotest/prev_head"
+echo "$orig_head" > "$dotest/orig-head"
+echo "$head_name" > "$dotest/head-name"
 
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$upstream"..ORIG_HEAD`
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 0779aaa..7b7d072 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -48,9 +48,14 @@ test_expect_success 'reference merge' '
 	git merge -s recursive "reference merge" HEAD master
 '
 
+PRE_REBASE=$(git rev-parse test-rebase)
 test_expect_success rebase '
 	git checkout test-rebase &&
-	git rebase --merge master
+	GIT_TRACE=1 git rebase --merge master
+'
+
+test_expect_success 'test-rebase@{1} is pre rebase' '
+	test $PRE_REBASE = $(git rev-parse test-rebase@{1})
 '
 
 test_expect_success 'merge and rebase should match' '
-- 
1.5.3.5.1634.g0fa78
