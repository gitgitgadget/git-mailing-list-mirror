X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Loosen "working file will be lost" check in Porcelain-ish
Date: Mon, 04 Dec 2006 17:11:02 -0800
Message-ID: <7vbqmjkuzd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 01:11:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33280>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOpz-0005Rc-2r for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967956AbWLEBLG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967955AbWLEBLG
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:11:06 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36549 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967956AbWLEBLD (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 20:11:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205011102.WMUE5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 20:11:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id upBC1V00B1kojtg0000000; Mon, 04 Dec 2006
 20:11:12 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This uses the previous update to read-tree in Porcelain-ish
commands "git checkout" and "git merge" to loosen the check
when switching branches.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-checkout.sh |    5 +++--
 git-merge.sh    |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 737abd0..a2be213 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -161,7 +161,7 @@ then
     git-read-tree --reset -u $new
 else
     git-update-index --refresh >/dev/null
-    merge_error=$(git-read-tree -m -u $old $new 2>&1) || (
+    merge_error=$(git-read-tree -m -u --ignore=.gitignore $old $new 2>&1) || (
 	case "$merge" in
 	'')
 		echo >&2 "$merge_error"
@@ -172,7 +172,8 @@ else
     	git diff-files --name-only | git update-index --remove --stdin &&
 	work=`git write-tree` &&
 	git read-tree --reset -u $new &&
-	git read-tree -m -u --aggressive $old $new $work || exit
+	git read-tree -m -u --aggressive --ignore=.gitignore $old $new $work ||
+	exit
 
 	if result=`git write-tree 2>/dev/null`
 	then
diff --git a/git-merge.sh b/git-merge.sh
index 272f004..830f471 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -264,7 +264,7 @@ f,*)
 	echo "Updating $(git-rev-parse --short $head)..$(git-rev-parse --short $1)"
 	git-update-index --refresh 2>/dev/null
 	new_head=$(git-rev-parse --verify "$1^0") &&
-	git-read-tree -u -v -m $head "$new_head" &&
+	git-read-tree -v -m -u --ignore=.gitignore $head "$new_head" &&
 	finish "$new_head" "Fast forward"
 	dropsave
 	exit 0
-- 
1.4.4.1.ga37e

