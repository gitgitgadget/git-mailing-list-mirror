From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: use "$GIT_DIR/BISECT_START" to check if we are
 bisecting
Date: Wed, 28 May 2008 18:57:02 +0200
Message-ID: <20080528185702.4dcd2955.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 28 18:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Ou3-0000rE-3t
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 18:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYE1Qwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 12:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbYE1Qwh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 12:52:37 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55413 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbYE1Qwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 12:52:36 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 14E0B1AB5A9;
	Wed, 28 May 2008 18:52:34 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id CC3BC1AB2AD;
	Wed, 28 May 2008 18:52:33 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83109>

It seems simpler and safer to use the BISECT_START file everywhere
to decide if we are bisecting or not, instead of using it in some
places and BISECT_NAMES in other places.

In commit 6459c7c6786aa9bda0c7a095c9db66c36da0e5f0 (Nov 18 2007,
Bisect: use "$GIT_DIR/BISECT_NAMES" to check if we are bisecting.),
we decided to use BISECT_NAMES but code changed a lot and we now
have to check BISECT_START first in the "bisect_start" function
anyway.

This patch also makes things a little bit safer by creating
the BISECT_START file first and deleting it last, and also by
adding checks in "bisect_clean_state".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

	This is a cleanup to add on top of the detached HEAD series.
	Thanks.

diff --git a/git-bisect.sh b/git-bisect.sh
index 4bcbace..991b2ef 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -44,7 +44,7 @@ sq() {
 }
 
 bisect_autostart() {
-	test -f "$GIT_DIR/BISECT_NAMES" || {
+	test -s "$GIT_DIR/BISECT_START" || {
 		echo >&2 'You need to start by "git bisect start"'
 		if test -t 0
 		then
@@ -98,7 +98,7 @@ bisect_start() {
 	#
 	# Get rid of any old bisect state.
 	#
-	bisect_clean_state
+	bisect_clean_state || exit
 
 	#
 	# Check for one bad and then some good revisions.
@@ -146,8 +146,8 @@ bisect_start() {
 	#
 	# Write new start state.
 	#
-	sq "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
+	sq "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval" &&
 	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -226,7 +226,7 @@ bisect_next_check() {
 		;;
 	*)
 		THEN=''
-		test -f "$GIT_DIR/BISECT_NAMES" || {
+		test -s "$GIT_DIR/BISECT_START" || {
 			echo >&2 'You need to start by "git bisect start".'
 			THEN='then '
 		}
@@ -392,16 +392,12 @@ bisect_visualize() {
 }
 
 bisect_reset() {
-	test -f "$GIT_DIR/BISECT_NAMES" || {
+	test -s "$GIT_DIR/BISECT_START" || {
 		echo "We are not bisecting."
 		return
 	}
 	case "$#" in
-	0) if [ -s "$GIT_DIR/BISECT_START" ]; then
-	       branch=`cat "$GIT_DIR/BISECT_START"`
-	   else
-	       branch=master
-	   fi ;;
+	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
 	1) git show-ref --verify --quiet -- "refs/heads/$1" ||
 	       die "$1 does not seem to be a valid branch"
 	   branch="$1" ;;
@@ -416,14 +412,15 @@ bisect_clean_state() {
 	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
 	while read ref hash
 	do
-		git update-ref -d $ref $hash
+		git update-ref -d $ref $hash || exit
 	done
-	rm -f "$GIT_DIR/BISECT_START"
-	rm -f "$GIT_DIR/BISECT_LOG"
-	rm -f "$GIT_DIR/BISECT_NAMES"
-	rm -f "$GIT_DIR/BISECT_RUN"
+	rm -f "$GIT_DIR/BISECT_LOG" &&
+	rm -f "$GIT_DIR/BISECT_NAMES" &&
+	rm -f "$GIT_DIR/BISECT_RUN" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
-	rm -f "$GIT_DIR/head-name"
+	rm -f "$GIT_DIR/head-name" &&
+
+	rm -f "$GIT_DIR/BISECT_START"
 }
 
 bisect_replay () {
-- 
1.5.5.1.580.g40a12.dirty
