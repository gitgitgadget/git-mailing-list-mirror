From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Properly git-bisect reset after bisecting from non-master head
Date: Sun, 12 Feb 2006 17:06:14 +0100
Message-ID: <20060212160614.GV31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 17:05:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8JjK-00026q-50
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 17:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWBLQFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 11:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBLQFj
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 11:05:39 -0500
Received: from w241.dkm.cz ([62.24.88.241]:40140 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751138AbWBLQFi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 11:05:38 -0500
Received: (qmail 512 invoked by uid 2001); 12 Feb 2006 17:06:14 +0100
To: junkio@cox.net
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15999>

git-bisect reset without an argument would return to master even
if the bisecting started at a non-master branch. This patch makes
it save the original branch name to .git/head-name and restore it
afterwards.

This is also compatible with Cogito and cg-seek, so cg-status will
show that we are seeked on the bisect branch and cg-reset will
properly restore the original branch.

git-bisect start will refuse to work if it is not on a bisect but
.git/head-name exists; this is to protect against conflicts with
other seeking tools.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit 143fc0c9a04ca38a70fbd882e38620f566415b6c
tree c93f93a984c00cfa08bbb9cb46bd1c6ba2c82de0
parent 8dcc626cd144b2c6eae2a299242bbbe905cb0059
author Petr Baudis <pasky@suse.cz> Sun, 12 Feb 2006 16:57:39 +0100
committer Petr Baudis <xpasky@machine.or.cz> Sun, 12 Feb 2006 16:57:39 +0100

 git-bisect.sh |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 51e1e44..3c024aa 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -49,9 +49,16 @@ bisect_start() {
 	die "Bad HEAD - I need a symbolic ref"
 	case "$head" in
 	refs/heads/bisect*)
-		git checkout master || exit
+		if [ -s "$GIT_DIR/head-name" ]; then
+		    branch=`cat "$GIT_DIR/head-name"`
+		else
+		    branch=master
+	        fi
+		git checkout $branch || exit
 		;;
 	refs/heads/*)
+		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
+		echo "$head" | sed 's#^refs/heads/##' >"$GIT_DIR/head-name"
 		;;
 	*)
 		die "Bad HEAD - strange symbolic ref"
@@ -159,7 +166,11 @@ bisect_visualize() {
 
 bisect_reset() {
 	case "$#" in
-	0) branch=master ;;
+	0) if [ -s "$GIT_DIR/head-name" ]; then
+	       branch=`cat "$GIT_DIR/head-name"`
+	   else
+	       branch=master
+	   fi ;;
 	1) test -f "$GIT_DIR/refs/heads/$1" || {
 	       echo >&2 "$1 does not seem to be a valid branch"
 	       exit 1
@@ -170,7 +181,7 @@ bisect_reset() {
 	esac
 	git checkout "$branch" &&
 	rm -fr "$GIT_DIR/refs/bisect"
-	rm -f "$GIT_DIR/refs/heads/bisect"
+	rm -f "$GIT_DIR/refs/heads/bisect" "$GIT_DIR/head-name"
 	rm -f "$GIT_DIR/BISECT_LOG"
 }
 


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
