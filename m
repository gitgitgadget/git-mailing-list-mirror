From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/9] Bisect: factorise some logging into "bisect_write".
Date: Mon, 22 Oct 2007 07:48:54 +0200
Message-ID: <20071022074854.b1362e76.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq3D-0007e1-Hw
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXJVFlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbXJVFlx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:41:53 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36364 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbXJVFlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:41:52 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 394F91AB2DC;
	Mon, 22 Oct 2007 07:41:51 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id E29481AB2DB;
	Mon, 22 Oct 2007 07:41:50 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61943>

Also use "die" instead of "echo >&2 something ; exit 1".
And simplify "bisect_replay".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   46 +++++++++++++---------------------------------
 1 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 82aa404..d7f0a20 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -106,12 +106,11 @@ bisect_start() {
 		        die "'$arg' does not appear to be a valid revision"
 		    break
 		}
-		if [ $bad_seen -eq 0 ]; then
-		    bad_seen=1
-		    bisect_write 'bad' "$rev"
-		else
-		    bisect_write 'good' "$rev"
-		fi
+		case $bad_seen in
+		0) state='bad' ; bad_seen=1 ;;
+		*) state='good' ;;
+		esac
+		bisect_write "$state" "$rev" 'nolog'
 		shift
 		;;
 	    esac
@@ -132,6 +131,7 @@ bisect_write() {
 	esac
 	echo "$rev" >"$GIT_DIR/refs/bisect/$tag"
 	echo "# $state: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+	test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
 bisect_bad() {
@@ -145,7 +145,6 @@ bisect_bad() {
 		usage ;;
 	esac || exit
 	bisect_write 'bad' "$rev"
-	echo "git-bisect bad $rev" >>"$GIT_DIR/BISECT_LOG"
 	bisect_auto_next
 }
 
@@ -160,7 +159,6 @@ bisect_good() {
 	do
 		rev=$(git rev-parse --verify "$rev^{commit}") || exit
 		bisect_write 'good' "$rev"
-		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
 	done
 	bisect_auto_next
 }
@@ -176,7 +174,6 @@ bisect_skip() {
 	do
 		rev=$(git rev-parse --verify "$rev^{commit}") || exit
 		bisect_write 'skip' "$rev"
-		echo "git-bisect skip $rev" >>"$GIT_DIR/BISECT_LOG"
 	done
 	bisect_auto_next
 }
@@ -352,10 +349,8 @@ bisect_reset() {
 	   else
 	       branch=master
 	   fi ;;
-	1) git show-ref --verify --quiet -- "refs/heads/$1" || {
-	       echo >&2 "$1 does not seem to be a valid branch"
-	       exit 1
-	   }
+	1) git show-ref --verify --quiet -- "refs/heads/$1" ||
+	       die "$1 does not seem to be a valid branch"
 	   branch="$1" ;;
 	*)
 	    usage ;;
@@ -375,10 +370,7 @@ bisect_clean_state() {
 }
 
 bisect_replay () {
-	test -r "$1" || {
-		echo >&2 "cannot read $1 for replaying"
-		exit 1
-	}
+	test -r "$1" || die "cannot read $1 for replaying"
 	bisect_reset
 	while read bisect command rev
 	do
@@ -386,23 +378,11 @@ bisect_replay () {
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
-			eval "$cmd"
-			;;
-		good)
-			bisect_write 'good' "$rev"
-			echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
-			;;
-		bad)
-			bisect_write 'bad' "$rev"
-			echo "git-bisect bad $rev" >>"$GIT_DIR/BISECT_LOG"
-			;;
-		skip)
-			bisect_write 'skip' "$rev"
-			echo "git-bisect skip $rev" >>"$GIT_DIR/BISECT_LOG"
-			;;
+			eval "$cmd" ;;
+		good|bad|skip)
+			bisect_write "$command" "$rev" ;;
 		*)
-			echo >&2 "?? what are you talking about?"
-			exit 1 ;;
+			die "?? what are you talking about?" ;;
 		esac
 	done <"$1"
 	bisect_auto_next
-- 
1.5.3.3.136.g591d1-dirty
