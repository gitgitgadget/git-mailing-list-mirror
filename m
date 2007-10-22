From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/9] Bisect: factorise "bisect_{bad,good,skip}" into
 "bisect_state".
Date: Mon, 22 Oct 2007 07:49:11 +0200
Message-ID: <20071022074911.978e02f6.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:42:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq3V-0007gj-1I
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbXJVFmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbXJVFmK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:42:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36438 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbXJVFmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:42:09 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E26571AB2C0;
	Mon, 22 Oct 2007 07:42:07 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 95E4F1AB2B1;
	Mon, 22 Oct 2007 07:42:07 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61945>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   82 +++++++++++++++++++++-----------------------------------
 1 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index d7f0a20..89f443b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -134,47 +134,33 @@ bisect_write() {
 	test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
-bisect_bad() {
+bisect_state() {
 	bisect_autostart
-	case "$#" in
-	0)
-		rev=$(git rev-parse --verify HEAD) ;;
-	1)
-		rev=$(git rev-parse --verify "$1^{commit}") ;;
+	state=$1
+	case "$#,$state" in
+	0,*)
+		die "Please call 'bisect_state' with at least one argument." ;;
+	1,bad|1,good|1,skip)
+		rev=$(git rev-parse --verify HEAD) ||
+			die "Bad rev input: HEAD"
+		bisect_write "$state" "$rev" ;;
+	2,bad)
+		rev=$(git rev-parse --verify "$2^{commit}") ||
+			die "Bad rev input: $2"
+		bisect_write "$state" "$rev" ;;
+	*,good|*,skip)
+		shift
+		revs=$(git rev-parse --revs-only --no-flags "$@") &&
+			test '' != "$revs" || die "Bad rev input: $@"
+		for rev in $revs
+		do
+			rev=$(git rev-parse --verify "$rev^{commit}") ||
+				die "Bad rev commit: $rev^{commit}"
+			bisect_write "$state" "$rev"
+		done ;;
 	*)
 		usage ;;
-	esac || exit
-	bisect_write 'bad' "$rev"
-	bisect_auto_next
-}
-
-bisect_good() {
-	bisect_autostart
-	case "$#" in
-	0)    revs=$(git rev-parse --verify HEAD) || exit ;;
-	*)    revs=$(git rev-parse --revs-only --no-flags "$@") &&
-		test '' != "$revs" || die "Bad rev input: $@" ;;
 	esac
-	for rev in $revs
-	do
-		rev=$(git rev-parse --verify "$rev^{commit}") || exit
-		bisect_write 'good' "$rev"
-	done
-	bisect_auto_next
-}
-
-bisect_skip() {
-	bisect_autostart
-	case "$#" in
-	0)    revs=$(git rev-parse --verify HEAD) || exit ;;
-	*)    revs=$(git rev-parse --revs-only --no-flags "$@") &&
-		test '' != "$revs" || die "Bad rev input: $@" ;;
-	esac
-	for rev in $revs
-	do
-		rev=$(git rev-parse --verify "$rev^{commit}") || exit
-		bisect_write 'skip' "$rev"
-	done
 	bisect_auto_next
 }
 
@@ -404,24 +390,22 @@ bisect_run () {
 	  exit $res
       fi
 
-      # Use "bisect_good" or "bisect_bad"
-      # depending on run success or failure.
+      # Find current state depending on run success or failure.
       if [ $res -gt 0 ]; then
-	  next_bisect='bisect_bad'
+	  state='bad'
       else
-	  next_bisect='bisect_good'
+	  state='good'
       fi
 
-      # We have to use a subshell because bisect_good or
-      # bisect_bad functions can exit.
-      ( $next_bisect > "$GIT_DIR/BISECT_RUN" )
+      # We have to use a subshell because "bisect_state" can exit.
+      ( bisect_state $state > "$GIT_DIR/BISECT_RUN" )
       res=$?
 
       cat "$GIT_DIR/BISECT_RUN"
 
       if [ $res -ne 0 ]; then
 	  echo >&2 "bisect run failed:"
-	  echo >&2 "$next_bisect exited with error code $res"
+	  echo >&2 "'bisect_state $state' exited with error code $res"
 	  exit $res
       fi
 
@@ -443,12 +427,8 @@ case "$#" in
     case "$cmd" in
     start)
         bisect_start "$@" ;;
-    bad)
-        bisect_bad "$@" ;;
-    good)
-        bisect_good "$@" ;;
-    skip)
-        bisect_skip "$@" ;;
+    bad|good|skip)
+        bisect_state "$cmd" "$@" ;;
     next)
         # Not sure we want "next" at the UI level anymore.
         bisect_next "$@" ;;
-- 
1.5.3.3.136.g591d1-dirty
