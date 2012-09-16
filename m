From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v2 2/3] rebase -i: Teach "--edit-todo" action
Date: Sun, 16 Sep 2012 11:17:02 -0400
Message-ID: <1347808623-1058-2-git-send-email-andrew.kw.w@gmail.com>
References: <7vwqzuxxmp.fsf@alter.siamese.dyndns.org>
 <1347808623-1058-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 18:19:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDHZ3-0005oH-17
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 18:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab2IPQTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 12:19:13 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:32881 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab2IPQTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 12:19:11 -0400
Received: by mail-qc0-f174.google.com with SMTP id o28so3947818qcr.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fqzaeZr+bZbBq9ApdK3SN0gmEzFrwB4UsjppKsdWE0Q=;
        b=DfGeemFaWk92knhmC9Kd6KrLnv9LX3ZK1ZcmYIK7E3TubbklbvVtIJbmKvj5jRokg7
         O6EJLYON9X12Zym384VwVgCHTMg4rPBUOvftoLRIrC9xP2fT6QczOPeq4IvabNGSVEFb
         +Bdo+DjRM0GF3wUrlM+4z8vQdvLE4c5G0z4Afg7juxCmjEbLInzPCfVDVmG8NNz4ePRJ
         4lpq0sAcy7FeiRUFGyO0EZCY4Sk0gAx+k6kPVkz5i+wdk3uzaQHnT37ngm8gKMvP3Y4Q
         NikNJSgye67A9zVKAnCrWRS0vYL5HpeLNvW49EVkFEnOEMnbld40wydDc/jrIqKdzg7C
         1Mrg==
Received: by 10.224.173.84 with SMTP id o20mr21925368qaz.3.1347812351221;
        Sun, 16 Sep 2012 09:19:11 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id ha5sm11433393qab.1.2012.09.16.09.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 09:19:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g79683ba.dirty
In-Reply-To: <1347808623-1058-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205629>

This allows users to edit the todo file while they're stopped in the
middle of an interactive rebase. When this action is executed, all
comments from the original todo file are stripped, and new help messages
are appended to the end.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 Documentation/git-rebase.txt |  5 ++++-
 git-rebase--interactive.sh   | 17 +++++++++++++++++
 git-rebase.sh                | 13 +++++++++++++
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
index 4d57e50..fcd15be 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -792,6 +792,23 @@ skip)
 
 	do_rest
 	;;
+edit-todo)
+	sed -e '/^#/d' < "$todo" > "$todo".new
+	mv -f "$todo".new "$todo"
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
index 15da926..e5a289c 100755
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
@@ -306,6 +311,11 @@ then
 	fi
 fi
 
+if test "$action" = "edit-todo" && test "$type" != "interactive"
+then
+	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
+fi
+
 case "$action" in
 continue)
 	# Sanity check
@@ -338,6 +348,9 @@ abort)
 	rm -r "$state_dir"
 	exit
 	;;
+edit-todo)
+	run_specific_rebase
+	;;
 esac
 
 # Make sure no rebase is in progress
-- 
1.7.12.318.g79683ba.dirty
