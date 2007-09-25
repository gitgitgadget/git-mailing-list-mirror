From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/5] rebase -i: work on a detached HEAD
Date: Tue, 25 Sep 2007 16:43:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251643080.28395@racer.site>
References: <Pine.LNX.4.64.0709251640360.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 25 17:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaCaZ-0002cF-Qs
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 17:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616AbXIYPoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 11:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758574AbXIYPoU
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 11:44:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:45937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758539AbXIYPoS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 11:44:18 -0400
Received: (qmail invoked by alias); 25 Sep 2007 15:44:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 25 Sep 2007 17:44:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nHF1mpFMnNBWxKZ/x79V/tudQGqZWzq1LfPX2YJ
	+L9XVoRack6PRy
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709251640360.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59141>


Earlier, rebase -i refused to rebase a detached HEAD.  Now it no longer
does.

Incidentally, this fixes "git gc --auto" shadowing the true exit status.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    |   23 +++++++++++++++--------
 t/t3404-rebase-interactive.sh |    8 ++++++++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4f46a15..445a299 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -312,17 +312,20 @@ do_next () {
 	else
 		NEWHEAD=$(git rev-parse HEAD)
 	fi &&
-	message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
-	git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
-	git symbolic-ref HEAD $HEADNAME && {
+	case $HEADNAME in
+	refs/*)
+		message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
+		git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
+		git symbolic-ref HEAD $HEADNAME
+		;;
+	esac && {
 		test ! -f "$DOTEST"/verbose ||
 			git diff --stat $(cat "$DOTEST"/head)..HEAD
 	} &&
 	rm -rf "$DOTEST" &&
+	git gc --auto &&
 	warn "Successfully rebased and updated $HEADNAME."
 
-	git gc --auto
-
 	exit
 }
 
@@ -362,7 +365,11 @@ do
 
 		HEADNAME=$(cat "$DOTEST"/head-name)
 		HEAD=$(cat "$DOTEST"/head)
-		git symbolic-ref HEAD $HEADNAME &&
+		case $HEADNAME in
+		refs/*)
+			git symbolic-ref HEAD $HEADNAME
+			;;
+		esac &&
 		output git reset --hard $HEAD &&
 		rm -rf "$DOTEST"
 		exit
@@ -439,8 +446,8 @@ do
 		test -z "$ONTO" && ONTO=$UPSTREAM
 
 		: > "$DOTEST"/interactive || die "Could not mark as interactive"
-		git symbolic-ref HEAD > "$DOTEST"/head-name ||
-			die "Could not get HEAD"
+		git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
+			echo "detached HEAD" > "$DOTEST"/head-name
 
 		echo $HEAD > "$DOTEST"/head
 		echo $UPSTREAM > "$DOTEST"/upstream
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1af73a4..f2214dd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -309,4 +309,12 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 	test $parent = $(git rev-parse HEAD^)
 '
 
+test_expect_success 'rebase a detached HEAD' '
+	grandparent=$(git rev-parse HEAD~2) &&
+	git checkout $(git rev-parse HEAD) &&
+	test_tick &&
+	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
+	test $grandparent = $(git rev-parse HEAD~2)
+'
+
 test_done
-- 
1.5.3.2.1057.gf4dc1
