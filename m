From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 12:14:43 -0400
Message-ID: <1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 18:15:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6e0-00058E-My
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094Ab2IJQPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:15:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62772 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab2IJQPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:15:14 -0400
Received: by iahk25 with SMTP id k25so1902061iah.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fcNdc6AjoxGHPPCbUMwVo1vpdIuLv8H10AjK314igs0=;
        b=SkYrcvL0JZh2+tJJVk40/PHJpJkWdKQObjLmd22mUnXDAlOb+/SfsGFFigcLKcno3X
         5ypZ50afbtajvge2A3ax53xbgok3hAPfEtUbeISrn24LipuxkDAtE/QGn6D6XMiGHwyb
         xPzlZzN3LwnHvhPlL2Hd46fAy5RL4GtkzO20C4AcM37cbxKpcA5Nc74ebppdmCFnVuJz
         Q7yL9M1yckIByl1G8w93pxrmJm/5WMEvvp6xdwW1dnvW2MIbN2Oj97V17d+ecyckKZyL
         n6pd1+b4Ky/d9BO38pPaML9Lg6gGn42I/fIv2qEQzxxSxtKgCnSIeQZKyM+BqcRalcCV
         1Irw==
Received: by 10.50.104.201 with SMTP id gg9mr11731484igb.67.1347293713436;
        Mon, 10 Sep 2012 09:15:13 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id ho1sm12253218igc.3.2012.09.10.09.15.12
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Sep 2012 09:15:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.289.g0ce9864.dirty
In-Reply-To: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205134>

This allows users to edit the todo list while they're in the middle of
an interactive rebase.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh |  6 ++++++
 git-rebase.sh              | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a09e842..e9dbcf3 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -775,6 +775,12 @@ skip)
 
 	do_rest
 	;;
+edit)
+  git_sequence_editor "$todo" ||
+    die_abort "Could not execute editor"
+
+  exit
+  ;;
 esac
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
diff --git a/git-rebase.sh b/git-rebase.sh
index 15da926..c394b8d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -38,6 +38,7 @@ C=!                passed to 'git apply'
 continue!          continue
 abort!             abort and check out the original branch
 skip!              skip current patch and continue
+edit!              edit the todo list during interactive rebase
 "
 . git-sh-setup
 . git-sh-i18n
@@ -194,6 +195,10 @@ do
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
+	--edit)
+		test $total_argc -eq 2 || usage
+		action=${1##--}
+		;;
 	--onto)
 		test 2 -le "$#" || usage
 		onto="$2"
@@ -306,6 +311,12 @@ then
 	fi
 fi
 
+if test "$action" = "edit" &&
+  test "$type" != "interactive"
+then
+  die "$(gettext "The --edit action can only be used during interactive rebase.")"
+fi
+
 case "$action" in
 continue)
 	# Sanity check
@@ -338,6 +349,9 @@ abort)
 	rm -r "$state_dir"
 	exit
 	;;
+edit)
+	run_specific_rebase
+  ;;
 esac
 
 # Make sure no rebase is in progress
-- 
1.7.12.289.g0ce9864.dirty
