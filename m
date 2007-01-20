From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] honor GIT_REFLOG_ACTION in git-commit
Date: Fri, 19 Jan 2007 17:12:11 -0800
Message-ID: <7vfya6bixg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 20 02:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84mL-00080K-Tv
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbXATBMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbXATBMS
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:12:18 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51978 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965081AbXATBMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:12:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120011212.ZIDW9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 20:12:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DDCV1W00S1kojtg0000000; Fri, 19 Jan 2007 20:12:29 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37238>

This allows git-cherry-pick and git-revert to properly identify
themselves in the resulting reflog entries.  Earlier they were
recorded as what git-commit has done.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-commit.sh b/git-commit.sh
index e23918c..eb211e5 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -524,6 +524,7 @@ else
 	rloga='commit (initial)'
 	current=''
 fi
+set_reflog_action "$rloga"
 
 if test -z "$no_edit"
 then
@@ -598,7 +599,7 @@ then
 	fi &&
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
 	rlogm=$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
-	git-update-ref -m "$rloga: $rlogm" HEAD $commit "$current" &&
+	git-update-ref -m "$GIT_REFLOG_ACTION: $rlogm" HEAD $commit "$current" &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" &&
 	if test -f "$NEXT_INDEX"
 	then
diff --git a/git-revert.sh b/git-revert.sh
index bb8f1ca..8207c9e 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -54,6 +54,8 @@ do
 	shift
 done
 
+set_reflog_action "$me"
+
 test "$me,$replay" = "revert,t" && usage
 
 case "$no_commit" in
