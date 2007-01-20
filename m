From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --walk-reflogs: disallow uninteresting commits
Date: Sat, 20 Jan 2007 01:39:39 -0800
Message-ID: <7vr6tq82as.fsf@assigned-by-dhcp.cox.net>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6tqbjt8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200218290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pqmbhzg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200325380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64b29naa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701201029400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 10:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8ChQ-000289-KI
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 10:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbXATJjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 04:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbXATJjl
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 04:39:41 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65478 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965231AbXATJjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 04:39:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120093940.DJBE25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sat, 20 Jan 2007 04:39:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DMfx1W00P1kojtg0000000; Sat, 20 Jan 2007 04:39:58 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701201029400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 10:32:16 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37262>

Here is what I have at the top of the topic (after a few fixups,
so it might not apply directly).

-- >8 --
[PATCH] Fix --walk-reflog with --pretty=oneline

Now, "git log --abbrev-commit --pretty=o --walk-reflogs HEAD" is
reasonably pleasant to use.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-rev-list.txt |    4 +++-
 log-tree.c                     |    3 ++-
 reflog-walk.c                  |   33 ++++++++++++++++++++++-----------
 reflog-walk.h                  |    2 +-
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index fcc540b..a996f6c 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -27,6 +27,7 @@ SYNOPSIS
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
 	     [ \--merge ]
+	     [ \--walk-reflogs ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
@@ -203,7 +204,8 @@ this causes the output to have two extra lines of information
 taken from the reflog.  By default, 'commit@{Nth}' notation is
 used in the output.  When the starting commit is specified as
 'commit@{now}', output also uses 'commit@{timestamp}' notation
-instead.
+instead.  Under '\--pretty=oneline', the commit message is
+prefixed with this information on the same line.
 
 --merge::
 
diff --git a/log-tree.c b/log-tree.c
index f043ad3..c0fa096 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -225,7 +225,8 @@ void show_log(struct rev_info *opt, const char *sep)
 		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
 		if (opt->reflog_info)
-			show_reflog_message(opt->reflog_info);
+			show_reflog_message(opt->reflog_info,
+				    opt->commit_format == CMIT_FMT_ONELINE);;
 	}
 
 	/*
diff --git a/reflog-walk.c b/reflog-walk.c
index 989a7ae..8ccbe97 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -219,21 +219,32 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
-void show_reflog_message(struct reflog_walk_info* info)
+void show_reflog_message(struct reflog_walk_info* info, int oneline)
 {
 	if (info && info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = info->last_commit_reflog;
 		struct reflog_info *info;
 
-		printf("Reflog: %s@{", commit_reflog->reflogs->ref);
-		info = &commit_reflog->reflogs->items[commit_reflog->recno + 1];
-		if (commit_reflog->flag)
-			printf("%s", show_rfc2822_date(info->timestamp,
-						info->tz));
-		else
-			printf("%d", commit_reflog->reflogs->nr
-					- 2 - commit_reflog->recno);
-		printf("} (%s)\nReflog message: %s",
-			info->email, info->message);
+		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+		if (oneline) {
+			printf("%s@{", commit_reflog->reflogs->ref);
+			if (commit_reflog->flag)
+				printf("%s", show_date(info->timestamp, 0, 1));
+			else
+				printf("%d", commit_reflog->reflogs->nr
+				       - 2 - commit_reflog->recno);
+			printf("}: ");
+		}
+		else {
+			printf("Reflog: %s@{", commit_reflog->reflogs->ref);
+			if (commit_reflog->flag)
+				printf("%s", show_rfc2822_date(info->timestamp,
+							       info->tz));
+			else
+				printf("%d", commit_reflog->reflogs->nr
+				       - 2 - commit_reflog->recno);
+			printf("} (%s)\nReflog message: %s",
+			       info->email, info->message);
+		}
 	}
 }
diff --git a/reflog-walk.h b/reflog-walk.h
index 787996b..e63d867 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -6,6 +6,6 @@ extern void add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
-extern void show_reflog_message(struct reflog_walk_info* info);
+extern void show_reflog_message(struct reflog_walk_info *info, int);
 
 #endif
-- 
1.5.0.rc1.g33dd1
