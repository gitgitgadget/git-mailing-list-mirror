From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/2] mergetools: split config files for vim and gvim
Date: Wed, 28 Mar 2012 15:58:12 -0400
Message-ID: <1332964693-4058-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 28 21:58:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCz16-0006zW-NU
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264Ab2C1T6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:58:43 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:40527 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2C1T6m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:58:42 -0400
Received: by qadc11 with SMTP id c11so1066535qad.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uhqIm7uDDY/bA6mBXxKcgQ0lx9lrzMlIoSFXNRSOY0g=;
        b=kLSLdqd5IyvXod9PS1f0x6/2BAlEZboTgtj746Drrxz1v9xgLWXm7vIob0m4XybG1R
         YIDNu2/8bhTfDvNSg5XuYjch9yHMl5TqJghhaPBulXVi+Yt6BKPsbgqazmHOMi9KA0LB
         erFYDrszduFlsTeKcGXcVhrcTxiv9FA8M6NcuMmPsleUAurKJbLZhveKRP5MwYSUW5SE
         lAsF+hDOttux9ux0xNEsTq7zYm4gQKw7BrnyGfJy6DLEvlPTCY0KGOF1ss2XzZQzeEz6
         qQxUE38PpuX2VBrPLBNLgVcRpErQP3sb9CL6JPi6lYac4eQgOF65ZZv7TVPGZQ2vEGxW
         CtSw==
Received: by 10.224.215.10 with SMTP id hc10mr40571051qab.28.1332964722293;
        Wed, 28 Mar 2012 12:58:42 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id cv8sm8218379qab.12.2012.03.28.12.58.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 12:58:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc2.21.g8cb1a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194179>

In ae69fd0 (mergetool-lib: combine vimdiff and gvimdiff run blocks),
the config files for these two tools were combined since they were
nearly identical.  This remains true, but having a single config
file for both makes it difficult to test that each is installed
and capable of running.

This commit splits the two config files. Now 'vim' and 'gvim'
follow the pattern used by all the other diff/merge tools:
  - There is a single file per tool
  - To use the tool, 'diff.tool' (or other similar option) may be
    set to the exact name of the file.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This series should apply cleanly on the current master, but it was
developed on top of the series that implements the 'difftool --dir-diff'
option (currently th/difftool-diffall branched from pu).

This patch does some cleanup needed to be compatible with the new
'--dir-diff' option for 'difftool'.

One side-effect of this change which may be a problem is that we
lose support for the 'vimdiff2' and 'gvimdiff2' tools that were
created in 0008669 (mergetool-lib: make the three-way diff the
default for vim/gvim).  The 2-panel options were not advertised in
any way, so I don't know if it is important to keep them.


 git-mergetool--lib.sh |    9 +--------
 mergetools/gvim       |   21 +++++++++++++++++++++
 mergetools/vim        |   41 +++++++++--------------------------------
 3 files changed, 31 insertions(+), 40 deletions(-)
 create mode 100644 mergetools/gvim

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index ed630b2..89b16dc 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -44,14 +44,7 @@ valid_tool () {
 }
 
 setup_tool () {
-	case "$1" in
-	vim*|gvim*)
-		tool=vim
-		;;
-	*)
-		tool="$1"
-		;;
-	esac
+	tool="$1"
 	mergetools="$(git --exec-path)/mergetools"
 
 	# Load the default definitions
diff --git a/mergetools/gvim b/mergetools/gvim
new file mode 100644
index 0000000..b746e6f
--- /dev/null
+++ b/mergetools/gvim
@@ -0,0 +1,21 @@
+diff_cmd () {
+	"$merge_tool_path" -R -f -d \
+		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" -f -d -c 'wincmd J' \
+			"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+	else
+		"$merge_tool_path" -f -d -c 'wincmd l' \
+			"$LOCAL" "$MERGED" "$REMOTE"
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	echo gvim
+}
diff --git a/mergetools/vim b/mergetools/vim
index 619594a..6817708 100644
--- a/mergetools/vim
+++ b/mergetools/vim
@@ -1,44 +1,21 @@
 diff_cmd () {
-	case "$1" in
-	gvimdiff|vimdiff)
-		"$merge_tool_path" -R -f -d \
-			-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
-		;;
-	gvimdiff2|vimdiff2)
-		"$merge_tool_path" -R -f -d \
-			-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
-		;;
-	esac
+	"$merge_tool_path" -R -f -d \
+		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
 }
 
 merge_cmd () {
 	touch "$BACKUP"
-	case "$1" in
-	gvimdiff|vimdiff)
-		if $base_present
-		then
-			"$merge_tool_path" -f -d -c 'wincmd J' \
-				"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
-		else
-			"$merge_tool_path" -f -d -c 'wincmd l' \
-				"$LOCAL" "$MERGED" "$REMOTE"
-		fi
-		;;
-	gvimdiff2|vimdiff2)
+	if $base_present
+	then
+		"$merge_tool_path" -f -d -c 'wincmd J' \
+			"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+	else
 		"$merge_tool_path" -f -d -c 'wincmd l' \
 			"$LOCAL" "$MERGED" "$REMOTE"
-		;;
-	esac
+	fi
 	check_unchanged
 }
 
 translate_merge_tool_path() {
-	case "$1" in
-	gvimdiff|gvimdiff2)
-		echo gvim
-		;;
-	vimdiff|vimdiff2)
-		echo vim
-		;;
-	esac
+	echo vim
 }
-- 
1.7.10.rc2.21.g8cb1a
