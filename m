From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-fetch: add --quiet
Date: Sun, 25 Feb 2007 13:29:20 -0800
Message-ID: <7vzm72q633.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 22:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLQw1-0007LX-ND
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 22:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbXBYV3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 16:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbXBYV3W
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 16:29:22 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65495 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133AbXBYV3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 16:29:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225212921.UNPS2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 16:29:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TxVL1W00h1kojtg0000000; Sun, 25 Feb 2007 16:29:21 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40578>

Pass it to underlying fetch-pack, and also have it affect if -v
is passed to http-fetch and rsync.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * As I am only using git native protocols these days myself, I
   did not check http or rsync -- they might be broken.  Tests
   and fixes are appreciated from people who care about them
   ;-).

 git-fetch.sh |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 851ed6b..0b4922b 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -26,6 +26,7 @@ keep=
 shallow_depth=
 no_progress=
 test -t 1 || no_progress=--no-progress
+quiet=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -56,6 +57,9 @@ do
 	--update-head-o|--update-head-ok)
 		update_head_ok=t
 		;;
+	-q|--q|--qu|--qui|--quie|--quiet)
+		quiet=--quiet
+		;;
 	-v|--verbose)
 		verbose=Yes
 		;;
@@ -328,7 +332,8 @@ fetch_main () {
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
 		die "No such ref $remote_name at $remote"
 	  echo >&2 "Fetching $remote_name from $remote using $proto"
-	  git-http-fetch -v -a "$head" "$remote/" || exit
+	  case "$quiet" in '') v=-v ;; *) v= ;; esac
+	  git-http-fetch $v -a "$head" "$remote/" || exit
 	  ;;
       rsync://*)
 	  test -n "$shallow_depth" &&
@@ -337,8 +342,9 @@ fetch_main () {
 	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
 	  head=$(git-rev-parse --verify TMP_HEAD)
 	  rm -f "$TMP_HEAD"
+	  case "$quiet" in '') v=-v ;; *) v= ;; esac
 	  test "$rsync_slurped_objects" || {
-	      rsync -av --ignore-existing --exclude info \
+	      rsync -a $v --ignore-existing --exclude info \
 		  "$remote/objects/" "$GIT_OBJECT_DIRECTORY/" || exit
 
 	      # Look at objects/info/alternates for rsync -- http will
@@ -379,8 +385,8 @@ fetch_main () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
-	  git-fetch-pack --thin $exec $keep $shallow_depth $no_progress \
-		"$remote" $rref ||
+	  git-fetch-pack --thin $exec $keep $shallow_depth \
+	      $quiet $no_progress "$remote" $rref ||
 	  echo failed "$remote"
       ) |
       (
-- 
1.5.0.1.791.g4c9a
