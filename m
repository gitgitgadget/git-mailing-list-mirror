From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Fri, 23 May 2008 01:28:57 +0200
Message-ID: <20080523012857.acce6457.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 23 01:25:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzK9p-0005m8-Fe
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 01:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758360AbYEVXYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 19:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758331AbYEVXYZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 19:24:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:44794 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758319AbYEVXYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 19:24:24 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 002BF1AB2AC;
	Fri, 23 May 2008 01:24:23 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 9EA581AB2AE;
	Fri, 23 May 2008 01:24:22 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82670>

When "git bisect" was first written, it was not possible to
checkout a detached HEAD. The detached feature appeared latter.

That's why before this patch the "git bisect" process used a
"bisect" branch to checkout new revisions to be tested (and also
a "new-bisect" one to check if the checkouts could work).

This patch makes "git bisect" checkout revisions to be tested on
a detached HEAD. This simplifies the code a bit.

The tests to check that "git bisect" does not start if a
"bisect" or a "new-bisect" branch exists are removed as they
are not relevant any more.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   53 ++++++++++++++++++++----------------------
 t/t6030-bisect-porcelain.sh |   38 +++++++++++++++---------------
 2 files changed, 44 insertions(+), 47 deletions(-)

	This patch should be applied on top of the series I just sent.
	But it may be for after v1.5.6.

diff --git a/git-bisect.sh b/git-bisect.sh
index 57168b0..8ec8d04 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -63,40 +63,39 @@ bisect_autostart() {
 
 bisect_start() {
 	#
-	# Verify HEAD. If we were bisecting before this, reset to the
-	# top-of-line master first!
+	# Verify HEAD.
 	#
 	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref -q HEAD) ||
 	head=$(GIT_DIR="$GIT_DIR" git rev-parse --verify HEAD) ||
 	die "Bad HEAD - I need a HEAD"
+
 	#
-	# Check that we either already have BISECT_START, or that the
-	# branches bisect, new-bisect don't exist, to not override them.
+	# Check if we are bisecting.
 	#
-	test -s "$GIT_DIR/BISECT_START" ||
-		if git show-ref --verify -q refs/heads/bisect ||
-		    git show-ref --verify -q refs/heads/new-bisect; then
-			die 'The branches "bisect" and "new-bisect" must not exist.'
-		fi
 	start_head=''
-	case "$head" in
-	refs/heads/bisect)
+	if test -s "$GIT_DIR/BISECT_START"; then
+		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
 		git checkout "$start_head" || exit
-		;;
-	refs/heads/*|$_x40)
-		# This error message should only be triggered by cogito usage,
-		# and cogito users should understand it relates to cg-seek.
-		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
-		start_head="${head#refs/heads/}"
-		;;
-	*)
-		die "Bad HEAD - strange symbolic ref"
-		;;
-	esac
+	else
+		# Get rev from where we start.
+		case "$head" in
+		refs/heads/*|$_x40)
+			# This error message should only be triggered by
+			# cogito usage, and cogito users should understand
+			# it relates to cg-seek.
+			[ -s "$GIT_DIR/head-name" ] &&
+				die "won't bisect on seeked tree"
+			start_head="${head#refs/heads/}"
+			;;
+		*)
+			die "Bad HEAD - strange symbolic ref"
+			;;
+		esac
+	fi
 
 	#
-	# Get rid of any old bisect state
+	# Get rid of any old bisect state.
 	#
 	bisect_clean_state
 
@@ -118,7 +117,7 @@ bisect_start() {
 		break
 		;;
 	    *)
-		rev=$(git rev-parse --verify "$arg^{commit}" 2>/dev/null) || {
+		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
 		        die "'$arg' does not appear to be a valid revision"
 		    break
@@ -366,9 +365,7 @@ bisect_next() {
 	exit_if_skipped_commits "$bisect_rev"
 
 	echo "Bisecting: $bisect_nr revisions left to test after this"
-	git branch -D new-bisect 2> /dev/null
-	git checkout -q -b new-bisect "$bisect_rev" || exit
-	git branch -M new-bisect bisect
+	git checkout -q "$bisect_rev" || exit
 	git show-branch "$bisect_rev"
 }
 
@@ -415,7 +412,7 @@ bisect_reset() {
 
 bisect_clean_state() {
 	# There may be some refs packed during bisection.
-	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* refs/heads/bisect |
+	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
 	while read ref hash
 	do
 		git update-ref -d $ref $hash
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index c4f074d..0626544 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -322,25 +322,6 @@ test_expect_success 'bisect starting with a detached HEAD' '
 	test $HEAD = $(cat .git/BISECT_START) &&
 	git bisect reset &&
 	test $HEAD = $(git rev-parse --verify HEAD)
-
-'
-
-test_expect_success 'bisect refuses to start if branch bisect exists' '
-	git bisect reset &&
-	git branch bisect &&
-	test_must_fail git bisect start &&
-	git branch -d bisect &&
-	git checkout -b bisect &&
-	test_must_fail git bisect start &&
-	git checkout master &&
-	git branch -d bisect
-'
-
-test_expect_success 'bisect refuses to start if branch new-bisect exists' '
-	git bisect reset &&
-	git branch new-bisect &&
-	test_must_fail git bisect start &&
-	git branch -d new-bisect
 '
 
 test_expect_success 'bisect errors out if bad and good are mistaken' '
@@ -350,6 +331,25 @@ test_expect_success 'bisect errors out if bad and good are mistaken' '
 	git bisect reset
 '
 
+test_expect_success 'bisect does not create a "bisect" branch' '
+	git bisect reset &&
+	git bisect start $HASH7 $HASH1 &&
+	git branch bisect &&
+	rev_hash4=$(git rev-parse --verify HEAD) &&
+	test "$rev_hash4" = "$HASH4" &&
+	git branch -D bisect &&
+	git bisect good &&
+	git branch bisect &&
+	rev_hash6=$(git rev-parse --verify HEAD) &&
+	test "$rev_hash6" = "$HASH6" &&
+	git bisect good > my_bisect_log.txt &&
+	grep "$HASH7 is first bad commit" my_bisect_log.txt &&
+	git bisect reset &&
+	rev_hash6=$(git rev-parse --verify bisect) &&
+	test "$rev_hash6" = "$HASH6" &&
+	git branch -D bisect
+'
+
 #
 #
 test_done
-- 
1.5.5.1.502.gb8b73.dirty
