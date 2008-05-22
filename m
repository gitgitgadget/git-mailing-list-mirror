From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] bisect: fix left over "BISECT_START" file when starting
 with junk rev
Date: Fri, 23 May 2008 00:38:59 +0200
Message-ID: <20080523003859.bf137d31.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 23 00:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzJNX-0007Yq-DJ
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760093AbYEVWe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760074AbYEVWe0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:34:26 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53013 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760009AbYEVWeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:34:25 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 60B021AB2AE;
	Fri, 23 May 2008 00:34:24 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 1F7131AB2A8;
	Fri, 23 May 2008 00:34:24 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82664>

Before this patch, when using for example:

$ git bisect start <stuff1> <stuff2>

with <stuff1> or <stuff2> that cannot be parsed as a revision, we
could leave a ".git/BISECT_START" file, from a previous
"git bisect start", alone.

This patch makes sure that it does not happen by removing the
"BISECT_START" file in "bisect_clean_state" and then always writing
it again at the end of "bisect_start".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   16 +++++++---------
 t/t6030-bisect-porcelain.sh |    2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 164e8ed..0dcb526 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -81,8 +81,8 @@ bisect_start() {
 	start_head=''
 	case "$head" in
 	refs/heads/bisect)
-		branch=`cat "$GIT_DIR/BISECT_START"`
-		git checkout $branch || exit
+		start_head=$(cat "$GIT_DIR/BISECT_START")
+		git checkout "$start_head" || exit
 		;;
 	refs/heads/*|$_x40)
 		# This error message should only be triggered by cogito usage,
@@ -134,7 +134,7 @@ bisect_start() {
 	done
 
 	sq "$@" >"$GIT_DIR/BISECT_NAMES"
-	test -n "$start_head" && echo "$start_head" >"$GIT_DIR/BISECT_START"
+	echo "$start_head" >"$GIT_DIR/BISECT_START"
 	eval "$eval"
 	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG"
 	bisect_auto_next
@@ -392,12 +392,7 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	if git checkout "$branch"; then
-		# Cleanup head-name if it got left by an old version of git-bisect
-		rm -f "$GIT_DIR/head-name"
-		rm -f "$GIT_DIR/BISECT_START"
-		bisect_clean_state
-	fi
+	git checkout "$branch" && bisect_clean_state
 }
 
 bisect_clean_state() {
@@ -407,9 +402,12 @@ bisect_clean_state() {
 	do
 		git update-ref -d $ref $hash
 	done
+	rm -f "$GIT_DIR/BISECT_START"
 	rm -f "$GIT_DIR/BISECT_LOG"
 	rm -f "$GIT_DIR/BISECT_NAMES"
 	rm -f "$GIT_DIR/BISECT_RUN"
+	# Cleanup head-name if it got left by an old version of git-bisect
+	rm -f "$GIT_DIR/head-name"
 }
 
 bisect_replay () {
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 7557fa1..68b5440 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -138,7 +138,7 @@ test_expect_success 'bisect start: back in good branch' '
 	grep "* other" branch.output > /dev/null
 '
 
-test_expect_failure 'bisect start: no ".git/BISECT_START" if junk rev' '
+test_expect_success 'bisect start: no ".git/BISECT_START" if junk rev' '
 	git bisect start $HASH4 $HASH1 -- &&
 	git bisect good &&
 	test_must_fail git bisect start $HASH4 foo -- &&
-- 
1.5.5.1.501.g204d8.dirty
