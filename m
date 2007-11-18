From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: use "$GIT_DIR/BISECT_NAMES" to check if we are
 bisecting.
Date: Sun, 18 Nov 2007 16:34:03 +0100
Message-ID: <20071118163403.a6238371.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 16:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itm3g-0001Wo-LM
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 16:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXKRP1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 10:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbXKRP1Y
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 10:27:24 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:53641 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbXKRP1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 10:27:23 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 499BB1AB2CE;
	Sun, 18 Nov 2007 16:27:21 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 130D91AB309;
	Sun, 18 Nov 2007 16:27:21 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65372>

Previously we tested if the "$GIT_DIR/refs/bisect" directory
existed, to check if we were bisecting.

Now with packed refs, it is simpler to check if the file
"$GIT_DIR/BISECT_NAMES" exists, as it is already created when
starting bisection and removed when reseting bisection.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 4748c6a..01593eb 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -37,7 +37,7 @@ sq() {
 }
 
 bisect_autostart() {
-	test -d "$GIT_DIR/refs/bisect" || {
+	test -f "$GIT_DIR/BISECT_NAMES" || {
 		echo >&2 'You need to start by "git bisect start"'
 		if test -t 0
 		then
@@ -83,7 +83,6 @@ bisect_start() {
 	# Get rid of any old bisect state
 	#
 	bisect_clean_state
-	mkdir "$GIT_DIR/refs/bisect"
 
 	#
 	# Check for one bad and then some good revisions.
@@ -192,7 +191,7 @@ bisect_next_check() {
 		;;
 	*)
 		THEN=''
-		test -d "$GIT_DIR/refs/bisect" || {
+		test -f "$GIT_DIR/BISECT_NAMES" || {
 			echo >&2 'You need to start by "git bisect start".'
 			THEN='then '
 		}
@@ -349,8 +348,6 @@ bisect_reset() {
 }
 
 bisect_clean_state() {
-	rm -fr "$GIT_DIR/refs/bisect"
-
 	# There may be some refs packed during bisection.
 	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* refs/heads/bisect |
 	while read ref hash
-- 
1.5.3.5.1815.g9445b-dirty
