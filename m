From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] bisect: trap critical errors in "bisect_start"
Date: Fri, 23 May 2008 00:39:22 +0200
Message-ID: <20080523003922.2cba6656.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 23 00:35:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzJNs-0007fy-DC
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760240AbYEVWet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760213AbYEVWet
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:34:49 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53114 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758137AbYEVWes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:34:48 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8586F1AB2AB;
	Fri, 23 May 2008 00:34:47 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 3E7F21AB2B2;
	Fri, 23 May 2008 00:34:47 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82665>

Before this patch, when using "git bisect start" with mistaken revs
or when the checkout of the branch we want to test failed, we exited
after having written files like ".git/BISECT_START",
".git/BISECT_NAMES" and after having written "refs/bisect/bad" and
"refs/bisect/good-*" refs.

With this patch we trap all errors that can happen when writing the
new state and when we are in "bisect_next". So that we can try to
clean up everything in case of problems, using "bisect_clean_state".

This patch also contains a "bisect_write" cleanup to make it exit
on error and return 0 otherwise.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   30 ++++++++++++++++++++++++------
 t/t6030-bisect-porcelain.sh |   10 ++++------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 0dcb526..57168b0 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -133,11 +133,29 @@ bisect_start() {
 	    esac
 	done
 
-	sq "$@" >"$GIT_DIR/BISECT_NAMES"
-	echo "$start_head" >"$GIT_DIR/BISECT_START"
-	eval "$eval"
-	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG"
+	#
+	# Change state.
+	# In case of mistaken revs or checkout error, or signals received,
+	# "bisect_auto_next" below may exit or misbehave.
+	# We have to trap this to be able to clean up using
+	# "bisect_clean_state".
+	#
+	trap 'bisect_clean_state' 0
+	trap 'exit 255' 1 2 3 15
+
+	#
+	# Write new start state.
+	#
+	sq "$@" >"$GIT_DIR/BISECT_NAMES" &&
+	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
+	eval "$eval" &&
+	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
+	#
+	# Check if we can proceed to the next bisect state.
+	#
 	bisect_auto_next
+
+	trap '-' 0
 }
 
 bisect_write() {
@@ -149,9 +167,9 @@ bisect_write() {
 		good|skip)	tag="$state"-"$rev" ;;
 		*)		die "Bad bisect_write argument: $state" ;;
 	esac
-	git update-ref "refs/bisect/$tag" "$rev"
+	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
-	test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
+	test -n "$nolog" || echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
 bisect_state() {
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 68b5440..c4f074d 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -147,7 +147,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if junk rev' '
 	test_must_fail test -e .git/BISECT_START
 '
 
-test_expect_failure 'bisect start: no ".git/BISECT_START" if mistaken rev' '
+test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken rev' '
 	git bisect start $HASH4 $HASH1 -- &&
 	git bisect good &&
 	test_must_fail git bisect start $HASH1 $HASH4 -- &&
@@ -156,19 +156,17 @@ test_expect_failure 'bisect start: no ".git/BISECT_START" if mistaken rev' '
 	test_must_fail test -e .git/BISECT_START
 '
 
-test_expect_failure 'bisect start: no ".git/BISECT_START" if checkout error' '
+test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 	echo "temp stuff" > hello &&
 	test_must_fail git bisect start $HASH4 $HASH1 -- &&
 	git branch &&
 	git branch > branch.output &&
 	grep "* other" branch.output > /dev/null &&
 	test_must_fail test -e .git/BISECT_START &&
-	test -z "$(git for-each-ref "refs/bisect/*")"
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	git checkout HEAD hello
 '
 
-# This cleanup is needed whatever the result of the above test.
-git checkout HEAD hello
-
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
-- 
1.5.5.1.501.g204d8.dirty
