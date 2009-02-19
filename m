From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/4] format-patch: track several references
Date: Thu, 19 Feb 2009 22:26:31 +0100
Message-ID: <5a41305e9103c870e8cae95dcf58655c275aba9b.1235078708.git.trast@student.ethz.ch>
References: <200902170027.09406.trast@student.ethz.ch> <cover.1235078708.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 22:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaGRK-0002DO-Na
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253AbZBSV0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbZBSV0u
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:26:50 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21625 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755954AbZBSV0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 16:26:48 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 22:26:43 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 22:26:42 +0100
X-Mailer: git-send-email 1.6.2.rc1.295.g1e29
In-Reply-To: <cover.1235078708.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 21:26:42.0764 (UTC) FILETIME=[C253E8C0:01C992D8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110755>

Currently, format-patch can only track a single reference (the
In-Reply-To:) for each mail.  To ensure proper threading, we should
list all known references for every mail.

Change the rev_info.ref_message_id field to a string_list, so that we
can append references at will, and change the output formatting
routines to print all of them in the References: header.  The last
entry in the list is implicitly assumed to be the In-Reply-To:, which
gives output consistent with RFC 2822:

   The "References:" field will contain the contents of the parent's
   "References:" field (if any) followed by the contents of the
   parent's "Message-ID:" field (if any).

Note that this is just preparatory work; nothing uses it yet, so all
"References:" fields in the output are still only one deep.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin-log.c |   14 ++++++++++----
 log-tree.c    |   11 ++++++++---
 revision.h    |    2 +-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..b188575 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -17,6 +17,7 @@
 #include "run-command.h"
 #include "shortlog.h"
 #include "remote.h"
+#include "string-list.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -1011,8 +1012,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
-	if (in_reply_to)
-		rev.ref_message_id = clean_message_id(in_reply_to);
+	if (in_reply_to || thread || cover_letter)
+		rev.ref_message_id = xcalloc(1, sizeof(struct string_list));
+	if (in_reply_to) {
+		const char *msgid = clean_message_id(in_reply_to);
+		string_list_append(msgid, rev.ref_message_id);
+	}
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
@@ -1036,10 +1041,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				 * otherwise, make everything a reply
 				 * to that.
 				 */
-				if (rev.ref_message_id)
+				if (rev.ref_message_id->nr > 0)
 					free(rev.message_id);
 				else
-					rev.ref_message_id = rev.message_id;
+					string_list_append(rev.message_id,
+							   rev.ref_message_id);
 			}
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
diff --git a/log-tree.c b/log-tree.c
index 84a74e5..72d97b8 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -6,6 +6,7 @@
 #include "log-tree.h"
 #include "reflog-walk.h"
 #include "refs.h"
+#include "string-list.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -211,9 +212,13 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 		printf("Message-Id: <%s>\n", opt->message_id);
 		graph_show_oneline(opt->graph);
 	}
-	if (opt->ref_message_id) {
-		printf("In-Reply-To: <%s>\nReferences: <%s>\n",
-		       opt->ref_message_id, opt->ref_message_id);
+	if (opt->ref_message_id && opt->ref_message_id->nr > 0) {
+		int i, n;
+		n = opt->ref_message_id->nr;
+		printf("In-Reply-To: <%s>\n", opt->ref_message_id->items[n-1].string);
+		for (i = 0; i < n; i++)
+			printf("%s<%s>\n", (i > 0 ? "\t" : "References: "),
+			       opt->ref_message_id->items[i].string);
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary) {
diff --git a/revision.h b/revision.h
index 7cf8487..01dc74e 100644
--- a/revision.h
+++ b/revision.h
@@ -89,7 +89,7 @@ struct rev_info {
 	int		nr, total;
 	const char	*mime_boundary;
 	char		*message_id;
-	const char	*ref_message_id;
+	struct string_list *ref_message_id;
 	const char	*add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
-- 
1.6.2.rc1.295.g1e29
