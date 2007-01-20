From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] --walk-reflogs: honour --relative-date
Date: Sat, 20 Jan 2007 22:39:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701202238260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jan 20 22:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Nve-0007WE-Qh
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 22:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbXATVjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 16:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965399AbXATVjL
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 16:39:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:44391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965398AbXATVjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 16:39:10 -0500
Received: (qmail invoked by alias); 20 Jan 2007 21:39:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 20 Jan 2007 22:39:08 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37295>


Now, if you say

	git log --walk-reflogs --relative-date next@{yesterday}

it shows the reflog date as a relative date expression.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 log-tree.c    |    3 ++-
 reflog-walk.c |    6 +++---
 reflog-walk.h |    3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index f043ad3..843a7c5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -225,7 +225,8 @@ void show_log(struct rev_info *opt, const char *sep)
 		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
 		if (opt->reflog_info)
-			show_reflog_message(opt->reflog_info);
+			show_reflog_message(opt->reflog_info,
+					opt->relative_date);
 	}
 
 	/*
diff --git a/reflog-walk.c b/reflog-walk.c
index d58ff9b..6706f45 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -215,7 +215,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
-void show_reflog_message(struct reflog_walk_info* info)
+void show_reflog_message(struct reflog_walk_info* info, int relative_date)
 {
 	if (info && info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = info->last_commit_reflog;
@@ -224,8 +224,8 @@ void show_reflog_message(struct reflog_walk_info* info)
 		printf("Reflog: %s@{", commit_reflog->reflogs->ref);
 		info = &commit_reflog->reflogs->items[commit_reflog->recno + 1];
 		if (commit_reflog->flag)
-			printf("%s", show_rfc2822_date(info->timestamp,
-						info->tz));
+			printf("%s", show_date(info->timestamp, info->tz,
+						relative_date));
 		else
 			printf("%d", commit_reflog->reflogs->nr
 					- 2 - commit_reflog->recno);
diff --git a/reflog-walk.h b/reflog-walk.h
index 787996b..b7a65e7 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -6,6 +6,7 @@ extern void add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
-extern void show_reflog_message(struct reflog_walk_info* info);
+extern void show_reflog_message(struct reflog_walk_info* info,
+		int relative_date);
 
 #endif
-- 
1.5.0.rc1.g956c1-dirty
