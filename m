From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 3/4] rebase -i: Teach "--edit-todo" action
Date: Mon, 17 Sep 2012 21:28:09 -0400
Message-ID: <1347931690-20625-4-git-send-email-andrew.kw.w@gmail.com>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
 <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 04:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDnZU-0002lx-6l
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 04:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398Ab2IRC3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 22:29:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35308 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab2IRC3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 22:29:37 -0400
Received: by yhmm54 with SMTP id m54so1696069yhm.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 19:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JH+sHnDAIFfHkFzgpnUFpmAbed6DXOoVfRrK4kANZ7E=;
        b=UcBqMXKfU6S6pWTN7QQvgjvpYeaQE8vi8tB3o8jCzntnJkAxCFLnv4/Ufvt7lyhMrr
         lpJKsRYdQW4y5+EZRBoEuS3o7VGnV79SVsRyje19KPw8tndsLzwkCFulB0DryxrllMIv
         hmvFGUCOAgvzIzyZWl1BRd6eqWYcbYmwWZUTYEpcx5Zj8VoNXno6x1Cb6L8dOq5FzoRB
         dx1/Y5Q8ARClLhmteNo01dDbA3YlhA2/9/mbq4UGCPLyTHpTefkIVwfVjP9Ttwg+40Ff
         83YXIuGxfduLJkjFTuV8Rm6zkgFuuIZcAcPLa8BmC3XX0nJZp/dKxblfYDxbikwb4TQN
         oLgw==
Received: by 10.236.177.42 with SMTP id c30mr13728558yhm.37.1347935376784;
        Mon, 17 Sep 2012 19:29:36 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id s12sm11226868anh.2.2012.09.17.19.29.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 19:29:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g79683ba.dirty
In-Reply-To: <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205783>

This allows users to edit the todo file while they're stopped in the
middle of an interactive rebase. When this action is executed, all
comments from the original todo file are stripped, and new help messages
are appended to the end.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 Documentation/git-rebase.txt |  5 ++++-
 git-rebase--interactive.sh   | 17 +++++++++++++++++
 git-rebase.sh                | 13 +++++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

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
index 4d57e50..2b8f2a9 100644
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
+		die "Could not execute editor"
+
+	exit
+	;;
 esac
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
diff --git a/git-rebase.sh b/git-rebase.sh
index e6b43a2..b2f1c76 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -8,7 +8,7 @@ OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
-git-rebase --continue | --abort | --skip
+git-rebase --continue | --abort | --skip | --edit-todo
 --
  Available options are
 v,verbose!         display a diffstat of what changed upstream
@@ -38,6 +38,7 @@ C=!                passed to 'git apply'
 continue!          continue
 abort!             abort and check out the original branch
 skip!              skip current patch and continue
+edit-todo!         edit the todo list during an interactive rebase
 "
 . git-sh-setup
 . git-sh-i18n
@@ -190,7 +191,7 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=
 		;;
-	--continue|--skip|--abort)
+	--continue|--skip|--abort|--edit-todo)
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
@@ -306,6 +307,11 @@ then
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
@@ -338,6 +344,9 @@ abort)
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
