From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 2/3] rebase -i: Teach "--edit-todo" action
Date: Sat, 15 Sep 2012 16:08:28 -0400
Message-ID: <1347739709-15289-3-git-send-email-andrew.kw.w@gmail.com>
References: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
 <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzdf-0004gH-3s
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab2IOVKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:10:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35063 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2IOVJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:09:47 -0400
Received: by iahk25 with SMTP id k25so4417650iah.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5LydeyKoSrfcVwomshG3b9zSxbPSpI4YLJEcJU04lak=;
        b=vJ5VdGV878tzRhFZWx1dezPNiITlaSX2OqxFJl3fAXp31svVKelUPtEJU8Wy5CW5j2
         os4B35rU3NapMS7O8jtt8rlAyJXWg08RShyRC8zG0JEVT5vt7mHwR7gCvh0pPihEORLs
         8jRaxJQMe6jYnZ4UvxQHfr2X5F8qgPnWWy+EDic5CPjbizuct25oqToWMxfpSQ2VnjJP
         NIKQ5ArwjqLCz9glE8r/nEtjHMssLb6m8aqTRYI5PtXn+wPu8JY1yKJkrG/fvueHLayh
         h8PYBIrzehfT8FjBXuizeW+fnm05v0KvAg+aMj7JaiITTFSdJqhlGis1+R0FfTpmau5x
         XCgQ==
Received: by 10.43.13.195 with SMTP id pn3mr5609474icb.47.1347743387318;
        Sat, 15 Sep 2012 14:09:47 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id d19sm2172495igp.6.2012.09.15.14.09.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 14:09:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g08bf5ad.dirty
In-Reply-To: <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205572>

This allows users to edit the todo file while they're stopped in the
middle of an interactive rebase. When this action is executed, all
comments from the original todo file are stripped, and new help messages
are appended to the end.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 Documentation/git-rebase.txt |  5 ++++-
 git-rebase--interactive.sh   | 16 ++++++++++++++++
 git-rebase.sh                | 14 ++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index fd535b0..da067ec 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[<upstream>] [<branch>]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' --continue | --skip | --abort
+'git rebase' --continue | --skip | --abort | --edit-todo
 
 DESCRIPTION
 -----------
@@ -245,6 +245,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --skip::
 	Restart the rebasing process by skipping the current patch.
 
+--edit-todo::
+	Edit the todo list during an interactive rebase.
+
 -m::
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4d57e50..ca55fac 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -792,6 +792,22 @@ skip)
 
 	do_rest
 	;;
+edit-todo)
+	sed -i '/^#/d' "$todo"
+	append_todo_help
+	cat >> "$todo" << EOF
+#
+# You are editing the todo file of an ongoing interactive rebase.
+# To continue rebase after editing, run:
+#     git rebase --continue
+#
+EOF
+
+	git_sequence_editor "$todo" ||
+	die_abort "Could not execute editor"
+
+	exit
+	;;
 esac
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
diff --git a/git-rebase.sh b/git-rebase.sh
index 15da926..e660203 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -38,6 +38,7 @@ C=!                passed to 'git apply'
 continue!          continue
 abort!             abort and check out the original branch
 skip!              skip current patch and continue
+edit-todo!         edit the todo list during an interactive rebase
 "
 . git-sh-setup
 . git-sh-i18n
@@ -194,6 +195,10 @@ do
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
+	--edit-todo)
+		test $total_argc -eq 2 || usage
+		action=${1##--}
+		;;
 	--onto)
 		test 2 -le "$#" || usage
 		onto="$2"
@@ -306,6 +311,12 @@ then
 	fi
 fi
 
+if test "$action" = "edit-todo" &&
+	test "$type" != "interactive"
+then
+	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
+fi
+
 case "$action" in
 continue)
 	# Sanity check
@@ -338,6 +349,9 @@ abort)
 	rm -r "$state_dir"
 	exit
 	;;
+edit-todo)
+	run_specific_rebase
+	;;
 esac
 
 # Make sure no rebase is in progress
-- 
1.7.12.318.g08bf5ad.dirty
