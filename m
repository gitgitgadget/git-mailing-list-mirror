From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/7] Bisect: factorise some logging into "bisect_write".
Date: Sun, 14 Oct 2007 14:29:48 +0200
Message-ID: <20071014142948.9f08b8ed.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 14:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih2Ui-00016p-6H
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 14:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbXJNMWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 08:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbXJNMWp
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 08:22:45 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58533 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756009AbXJNMWo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 08:22:44 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6ACA91AB2C8;
	Sun, 14 Oct 2007 14:22:43 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 2687E1AB2E1;
	Sun, 14 Oct 2007 14:22:43 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60839>

Also use "die" instead of "echo >&2 something ; exit 1".
And simplify "bisect_replay".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   46 +++++++++++++---------------------------------
 1 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 847250c..e12125f 100755
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
@@ -176,7 +174,6 @@ bisect_dunno() {
 	do
 		rev=$(git rev-parse --verify "$rev^{commit}") || exit
 		bisect_write 'dunno' "$rev"
-		echo "git-bisect dunno $rev" >>"$GIT_DIR/BISECT_LOG"
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
-		dunno)
-			bisect_write 'dunno' "$rev"
-			echo "git-bisect dunno $rev" >>"$GIT_DIR/BISECT_LOG"
-			;;
+			eval "$cmd" ;;
+		good|bad|dunno)
+			bisect_write "$command" "$rev" ;;
 		*)
-			echo >&2 "?? what are you talking about?"
-			exit 1 ;;
+			die "?? what are you talking about?" ;;
 		esac
 	done <"$1"
 	bisect_auto_next
-- 
1.5.3.4.213.g68ad5
