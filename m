From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/5] reflog-walk: refactor the branch@{num} formatting
Date: Fri, 16 Oct 2009 16:20:34 +0200
Message-ID: <6dab88e2a1624ae37dbc0c8fd86e4ea486c809a6.1255701207.git.trast@student.ethz.ch>
References: <cover.1255701207.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynkO-0008Gh-GK
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760118AbZJPOWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760111AbZJPOWf
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:22:35 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:34132 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760109AbZJPOWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:22:35 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 16:21:31 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 16:21:10 +0200
X-Mailer: git-send-email 1.6.5.116.g4aaa3
In-Reply-To: <cover.1255701207.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130492>

We'll use the same output in an upcoming commit, so refactor its
formatting (which was duplicated anyway) into a separate function.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 reflog-walk.c |   54 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 5623ea6..596bafe 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -241,36 +241,46 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
-void show_reflog_message(struct reflog_walk_info *info, int oneline,
+void get_reflog_selector(struct strbuf *sb,
+			 struct reflog_walk_info *reflog_info,
+			 enum date_mode dmode)
+{
+	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
+	struct reflog_info *info;
+
+	if (!commit_reflog)
+		return;
+
+	strbuf_addf(sb, "%s@{", commit_reflog->reflogs->ref);
+	if (commit_reflog->flag || dmode) {
+		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
+	} else {
+		strbuf_addf(sb, "%d", commit_reflog->reflogs->nr
+			    - 2 - commit_reflog->recno);
+	}
+
+	strbuf_addch(sb, '}');
+}
+
+void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 	enum date_mode dmode)
 {
-	if (info && info->last_commit_reflog) {
-		struct commit_reflog *commit_reflog = info->last_commit_reflog;
+	if (reflog_info && reflog_info->last_commit_reflog) {
+		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
 		struct reflog_info *info;
+		struct strbuf selector = STRBUF_INIT;
 
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+		get_reflog_selector(&selector, reflog_info, dmode);
 		if (oneline) {
-			printf("%s@{", commit_reflog->reflogs->ref);
-			if (commit_reflog->flag || dmode)
-				printf("%s", show_date(info->timestamp,
-						       info->tz,
-						       dmode));
-			else
-				printf("%d", commit_reflog->reflogs->nr
-				       - 2 - commit_reflog->recno);
-			printf("}: %s", info->message);
+			printf("%s: %s", selector.buf, info->message);
 		}
 		else {
-			printf("Reflog: %s@{", commit_reflog->reflogs->ref);
-			if (commit_reflog->flag || dmode)
-				printf("%s", show_date(info->timestamp,
-							info->tz,
-							dmode));
-			else
-				printf("%d", commit_reflog->reflogs->nr
-				       - 2 - commit_reflog->recno);
-			printf("} (%s)\nReflog message: %s",
-			       info->email, info->message);
+			printf("Reflog: %s (%s)\nReflog message: %s",
+			       selector.buf, info->email, info->message);
 		}
+
+		strbuf_release(&selector);
 	}
 }
-- 
1.6.5.116.gfe4b9
