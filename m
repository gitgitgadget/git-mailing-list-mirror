From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC] rebase: Handle cases where format-patch fails
Date: Fri,  5 Oct 2012 00:53:10 -0400
Message-ID: <1349412790-6087-2-git-send-email-andrew.kw.w@gmail.com>
References: <506E1327.1070602@gmail.com>
 <1349412790-6087-1-git-send-email-andrew.kw.w@gmail.com>
Cc: alex.kostikov@gmail.com, Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 08:49:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1ip-0002My-66
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 08:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304Ab2JEGtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 02:49:08 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64876 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2JEGtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 02:49:05 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3008023iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jtB3NN+Jg3SHa4eF8OjhSzqHRmkT01Lu6iYGqeSGI1A=;
        b=sx3Te8xbLR3HSrubAJBnyVjXmOmcH0FAWbvcW26DxYO6quXkWuB67fwsTP6QXZ7sj+
         JtKDy61XUBDeU4/znAK8pBdPKllXEB1EXAHND0r2n3di5CaVGCot2528zFcfr97kjbR4
         +ym2V75+f52j5LorwQcqXRcWqO5D8oJfTSxs51DzABjQRzHELB1J3ZPdCMxCLmNx7Q/e
         sJ3COcPalUsyinfFRJGrJVkUyVy1tmhRXMXLMcjaAiLDemjgIwvKJX6qCl1UY7CPyjTk
         sivkm3htQOvNPbitnAgRYJdwlpticVlhvWeUcxLzRYYeUE6Fceh1MXCuxf/3WRtdDV2I
         vltg==
Received: by 10.50.209.71 with SMTP id mk7mr147527igc.34.1349412975556;
        Thu, 04 Oct 2012 21:56:15 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id p8sm99609igl.16.2012.10.04.21.56.13
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:56:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc0.18.gf84667d
In-Reply-To: <1349412790-6087-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207073>

'format-patch' could fail due to reasons such as out of memory. Such
failures are not detected or handled, which causes rebase to incorrectly
think that it completed successfully and continue with cleanup. i.e.
calling move_to_original_branch

Since only the exit status of the last command in the pipeline is
available, we rely on || to detect whether 'format-patch' has failed.

Also print messages to help user with how to recover from such failures.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--am.sh | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 392ebc9..8dae804 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -26,10 +26,43 @@ then
 	# makes this easy
 	git cherry-pick --allow-empty "$revisions"
 else
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	( git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" |
+		--no-renames $root_flag "$revisions" ||
+		echo $? > "$GIT_DIR"/format-patch-failed ) |
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
+	ret=$?
+	if test -f "$GIT_DIR"/format-patch-failed
+	then
+		ret=1
+		rm -f "$GIT_DIR"/format-patch-failed
+		if test -d "$state_dir"
+		then
+			echo
+			echo "'git format-patch' seems to have failed in the middle of 'git am'."
+			echo "If you continue rebasing, you will likely be losing some commits."
+			echo "It is recommended that you abort rebasing by running:"
+			echo
+			echo "    git rebase --abort"
+			echo
+		else
+			echo
+			echo "'git format-patch' seems to have failed before 'git am' started."
+			echo "It is impossible to continue or abort rebasing."
+			echo "You have to use the following to return to your original head:"
+			echo
+			case "$head_name" in
+			refs/*)
+				echo "    git checkout $head_name"
+				;;
+			*)
+				echo "    git checkout $orig_head"
+				;;
+			esac
+			echo
+		fi
+	fi
+	test 0 != $ret && false
 fi && move_to_original_branch
 
 ret=$?
-- 
1.8.0.rc0.18.gf84667d
