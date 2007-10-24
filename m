From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] Bisect: refactor some logging into "bisect_write".
Date: Wed, 24 Oct 2007 07:01:13 +0200
Message-ID: <20071024070113.38fcbd67.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 06:54:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkYGV-0000R1-0S
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 06:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbXJXEyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 00:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbXJXEyM
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 00:54:12 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:39782 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbXJXEyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 00:54:11 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 595DF1AB2B2;
	Wed, 24 Oct 2007 06:54:10 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0E3E81AB2AB;
	Wed, 24 Oct 2007 06:54:10 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62191>

Also use "die" instead of "echo >&2 something ; exit 1".
And simplify "bisect_replay".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-bisect.sh |   47 ++++++++++++++---------------------------------
 1 files changed, 14 insertions(+), 33 deletions(-)

	The 'nolog="$3"' line is back in this patch.

diff --git a/git-bisect.sh b/git-bisect.sh
index 82aa404..61a2956 100755
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
@@ -125,6 +124,7 @@ bisect_start() {
 bisect_write() {
 	state="$1"
 	rev="$2"
+	nolog="$3"
 	case "$state" in
 		bad)		tag="$state" ;;
 		good|skip)	tag="$state"-"$rev" ;;
@@ -132,6 +132,7 @@ bisect_write() {
 	esac
 	echo "$rev" >"$GIT_DIR/refs/bisect/$tag"
 	echo "# $state: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+	test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
 bisect_bad() {
@@ -145,7 +146,6 @@ bisect_bad() {
 		usage ;;
 	esac || exit
 	bisect_write 'bad' "$rev"
-	echo "git-bisect bad $rev" >>"$GIT_DIR/BISECT_LOG"
 	bisect_auto_next
 }
 
@@ -160,7 +160,6 @@ bisect_good() {
 	do
 		rev=$(git rev-parse --verify "$rev^{commit}") || exit
 		bisect_write 'good' "$rev"
-		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
 	done
 	bisect_auto_next
 }
@@ -176,7 +175,6 @@ bisect_skip() {
 	do
 		rev=$(git rev-parse --verify "$rev^{commit}") || exit
 		bisect_write 'skip' "$rev"
-		echo "git-bisect skip $rev" >>"$GIT_DIR/BISECT_LOG"
 	done
 	bisect_auto_next
 }
@@ -352,10 +350,8 @@ bisect_reset() {
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
@@ -375,10 +371,7 @@ bisect_clean_state() {
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
@@ -386,23 +379,11 @@ bisect_replay () {
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
1.5.3.4.215.g187cf
