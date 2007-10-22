From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/9] Bisect: factorise "bisect_write_*" functions.
Date: Mon, 22 Oct 2007 07:48:42 +0200
Message-ID: <20071022074842.be5f5841.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq35-0007bR-Ng
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXJVFlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbXJVFlk
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:41:40 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36323 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbXJVFlj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:41:39 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 92E681AB2D0;
	Mon, 22 Oct 2007 07:41:38 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 493E11AB2AE;
	Mon, 22 Oct 2007 07:41:38 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61942>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   46 ++++++++++++++++++++--------------------------
 1 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index cd46190..82aa404 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -108,9 +108,9 @@ bisect_start() {
 		}
 		if [ $bad_seen -eq 0 ]; then
 		    bad_seen=1
-		    bisect_write_bad "$rev"
+		    bisect_write 'bad' "$rev"
 		else
-		    bisect_write_good "$rev"
+		    bisect_write 'good' "$rev"
 		fi
 		shift
 		;;
@@ -122,6 +122,18 @@ bisect_start() {
 	bisect_auto_next
 }
 
+bisect_write() {
+	state="$1"
+	rev="$2"
+	case "$state" in
+		bad)		tag="$state" ;;
+		good|skip)	tag="$state"-"$rev" ;;
+		*)		die "Bad bisect_write argument: $state" ;;
+	esac
+	echo "$rev" >"$GIT_DIR/refs/bisect/$tag"
+	echo "# $state: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+}
+
 bisect_bad() {
 	bisect_autostart
 	case "$#" in
@@ -132,17 +144,11 @@ bisect_bad() {
 	*)
 		usage ;;
 	esac || exit
-	bisect_write_bad "$rev"
+	bisect_write 'bad' "$rev"
 	echo "git-bisect bad $rev" >>"$GIT_DIR/BISECT_LOG"
 	bisect_auto_next
 }
 
-bisect_write_bad() {
-	rev="$1"
-	echo "$rev" >"$GIT_DIR/refs/bisect/bad"
-	echo "# bad: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
-}
-
 bisect_good() {
 	bisect_autostart
 	case "$#" in
@@ -153,18 +159,12 @@ bisect_good() {
 	for rev in $revs
 	do
 		rev=$(git rev-parse --verify "$rev^{commit}") || exit
-		bisect_write_good "$rev"
+		bisect_write 'good' "$rev"
 		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
 	done
 	bisect_auto_next
 }
 
-bisect_write_good() {
-	rev="$1"
-	echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
-	echo "# good: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
-}
-
 bisect_skip() {
 	bisect_autostart
 	case "$#" in
@@ -175,18 +175,12 @@ bisect_skip() {
 	for rev in $revs
 	do
 		rev=$(git rev-parse --verify "$rev^{commit}") || exit
-		bisect_write_skip "$rev"
+		bisect_write 'skip' "$rev"
 		echo "git-bisect skip $rev" >>"$GIT_DIR/BISECT_LOG"
 	done
 	bisect_auto_next
 }
 
-bisect_write_skip() {
-	rev="$1"
-	echo "$rev" >"$GIT_DIR/refs/bisect/skip-$rev"
-	echo "# skip: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
-}
-
 bisect_next_check() {
 	missing_good= missing_bad=
 	git show-ref -q --verify refs/bisect/bad || missing_bad=t
@@ -395,15 +389,15 @@ bisect_replay () {
 			eval "$cmd"
 			;;
 		good)
-			bisect_write_good "$rev"
+			bisect_write 'good' "$rev"
 			echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
 			;;
 		bad)
-			bisect_write_bad "$rev"
+			bisect_write 'bad' "$rev"
 			echo "git-bisect bad $rev" >>"$GIT_DIR/BISECT_LOG"
 			;;
 		skip)
-			bisect_write_skip "$rev"
+			bisect_write 'skip' "$rev"
 			echo "git-bisect skip $rev" >>"$GIT_DIR/BISECT_LOG"
 			;;
 		*)
-- 
1.5.3.3.136.g591d1-dirty
