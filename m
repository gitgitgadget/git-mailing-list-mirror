From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] rebase -i: several cleanups
Date: Mon, 25 Jun 2007 18:56:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706251856300.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 25 19:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2soI-0008QF-Dw
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 19:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbXFYR5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 13:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbXFYR5G
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 13:57:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:58425 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbXFYR5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 13:57:05 -0400
Received: (qmail invoked by alias); 25 Jun 2007 17:57:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 25 Jun 2007 19:57:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18mirASJU0mcgLo+35FhsEaoMZBZgJBgp6jTfyR4w
	LTo613Bcnp5VZW
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50909>


Support "--verbose" in addition to "-v", show short names in the list
comment, clean up if there is nothing to do, and add several "test_ticks"
in the test script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    |   19 +++++++++++++++----
 t/t3404-rebase-interactive.sh |    2 ++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ab36572..b95fe86 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -60,6 +60,11 @@ die_with_patch () {
 	die "$2"
 }
 
+die_abort () {
+	rm -rf "$DOTEST" 2> /dev/null
+	die "$1"
+}
+
 pick_one () {
 	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
 	git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
@@ -212,7 +217,7 @@ do
 	-C*)
 		die "Interactive rebase uses merge, so $1 does not make sense"
 		;;
-	-v)
+	-v|--verbose)
 		VERBOSE=t
 		;;
 	-i|--interactive)
@@ -264,8 +269,11 @@ do
 		echo $ONTO > "$DOTEST"/onto
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
 
+		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
+		SHORTHEAD=$(git rev-parse --short $HEAD)
+		SHORTONTO=$(git rev-parse --short $ONTO)
 		cat > "$TODO" << EOF
-# Rebasing $UPSTREAM..$HEAD onto $ONTO
+# Rebasing $SHORTUPSTREAM)..$SHORTHEAD onto $SHORTONTO
 #
 # Commands:
 #  pick = use commit
@@ -277,13 +285,16 @@ EOF
 			sed "s/^/pick /" >> "$TODO"
 
 		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
-			die "Nothing to do"
+			die_abort "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
 		${VISUAL:-${EDITOR:-vi}} "$TODO" ||
 			die "Could not execute editor"
 
-		git reset --hard $ONTO && do_rest
+		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
+			die_abort "Nothing to do"
+
+		git checkout $ONTO && do_rest
 	esac
 	shift
 done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 48aa8ea..19a3a8e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -140,6 +140,7 @@ test_expect_success 'abort' '
 test_expect_success 'retain authorship' '
 	echo A > file7 &&
 	git add file7 &&
+	test_tick &&
 	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
 	git tag twerp &&
 	git rebase -i --onto master HEAD^ &&
@@ -149,6 +150,7 @@ test_expect_success 'retain authorship' '
 test_expect_success 'squash' '
 	git reset --hard twerp &&
 	echo B > file7 &&
+	test_tick &&
 	GIT_AUTHOR_NAME="Nitfol" git commit -m "nitfol" file7 &&
 	echo "******************************" &&
 	FAKE_LINES="1 squash 2" git rebase -i --onto master HEAD~2 &&
-- 
1.5.2.2.3172.ge55a1-dirty
