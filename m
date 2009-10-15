From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/5] reflog-walk: refactor the branch@{num} formatting
Date: Fri, 16 Oct 2009 00:41:45 +0200
Message-ID: <6dab88e2a1624ae37dbc0c8fd86e4ea486c809a6.1255645570.git.trast@student.ethz.ch>
References: <cover.1255645570.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 00:46:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyZ4w-0006Yh-88
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 00:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763192AbZJOWoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 18:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763190AbZJOWoj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 18:44:39 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:58969 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763188AbZJOWoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 18:44:39 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:42:44 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:42:23 +0200
X-Mailer: git-send-email 1.6.5.116.gfe4b9
In-Reply-To: <cover.1255645570.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130431>

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
1.6.5.18.g9f87a.dirty
