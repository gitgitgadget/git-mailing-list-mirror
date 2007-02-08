From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] log --reflog: honour --relative-date
Date: Thu, 8 Feb 2007 21:58:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082156370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Feb 08 21:58:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGLp-0001Pq-2g
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423333AbXBHU6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 15:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423337AbXBHU6i
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:58:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:34656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423333AbXBHU6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 15:58:37 -0500
Received: (qmail invoked by alias); 08 Feb 2007 20:58:35 -0000
X-Provags-ID: V01U2FsdGVkX19/yeRlVpN/zUCYQ1bAHaep8BNhFxFrPKAWYqmpjl
	DZXw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39091>


If you say "git log -g --relative-date", it is very likely that
you want to see the reflog names in terms of a relative date.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 log-tree.c    |    3 ++-
 reflog-walk.c |   12 +++++++-----
 reflog-walk.h |    2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 85acd66..4e3c7fd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -226,7 +226,8 @@ void show_log(struct rev_info *opt, const char *sep)
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
 		if (opt->reflog_info) {
 			show_reflog_message(opt->reflog_info,
-				    opt->commit_format == CMIT_FMT_ONELINE);;
+				    opt->commit_format == CMIT_FMT_ONELINE,
+				    opt->relative_date);
 			if (opt->commit_format == CMIT_FMT_ONELINE) {
 				printf("%s", sep);
 				return;
diff --git a/reflog-walk.c b/reflog-walk.c
index 653ec95..afe1577 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -227,7 +227,8 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
-void show_reflog_message(struct reflog_walk_info* info, int oneline)
+void show_reflog_message(struct reflog_walk_info* info, int oneline,
+	int relative_date)
 {
 	if (info && info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = info->last_commit_reflog;
@@ -236,7 +237,7 @@ void show_reflog_message(struct reflog_walk_info* info, int oneline)
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		if (oneline) {
 			printf("%s@{", commit_reflog->reflogs->ref);
-			if (commit_reflog->flag)
+			if (commit_reflog->flag || relative_date)
 				printf("%s", show_date(info->timestamp, 0, 1));
 			else
 				printf("%d", commit_reflog->reflogs->nr
@@ -245,9 +246,10 @@ void show_reflog_message(struct reflog_walk_info* info, int oneline)
 		}
 		else {
 			printf("Reflog: %s@{", commit_reflog->reflogs->ref);
-			if (commit_reflog->flag)
-				printf("%s", show_rfc2822_date(info->timestamp,
-							       info->tz));
+			if (commit_reflog->flag || relative_date)
+				printf("%s", show_date(info->timestamp,
+							info->tz,
+							relative_date));
 			else
 				printf("%d", commit_reflog->reflogs->nr
 				       - 2 - commit_reflog->recno);
diff --git a/reflog-walk.h b/reflog-walk.h
index e63d867..a4f7015 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -6,6 +6,6 @@ extern void add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
-extern void show_reflog_message(struct reflog_walk_info *info, int);
+extern void show_reflog_message(struct reflog_walk_info *info, int, int);
 
 #endif
