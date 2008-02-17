From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Improve message-id generation flow control for
 format-patch
Date: Sun, 17 Feb 2008 13:35:44 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171335240.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:36:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoNA-00050Y-Mn
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbYBQSfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbYBQSfq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:35:46 -0500
Received: from iabervon.org ([66.92.72.58]:49982 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbYBQSfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:35:45 -0500
Received: (qmail 6729 invoked by uid 1000); 17 Feb 2008 18:35:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 18:35:44 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74157>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-log.c |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 99d69f0..867cc13 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -575,16 +575,19 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 	o2->flags = flags2;
 }
 
-static void gen_message_id(char *dest, unsigned int length, char *base)
+static void gen_message_id(struct rev_info *info, char *base)
 {
 	const char *committer = git_committer_info(IDENT_WARN_ON_NO_NAME);
 	const char *email_start = strrchr(committer, '<');
 	const char *email_end = strrchr(committer, '>');
-	if(!email_start || !email_end || email_start > email_end - 1)
+	struct strbuf buf;
+	if (!email_start || !email_end || email_start > email_end - 1)
 		die("Could not extract email from committer identity.");
-	snprintf(dest, length, "%s.%lu.git.%.*s", base,
-		 (unsigned long) time(NULL),
-		 (int)(email_end - email_start - 1), email_start + 1);
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
+		    (unsigned long) time(NULL),
+		    (int)(email_end - email_start - 1), email_start + 1);
+	info->message_id = strbuf_detach(&buf, NULL);
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -625,8 +628,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
-	char message_id[1024];
-	char ref_message_id[1024];
 
 	git_config(git_format_config);
 	init_revisions(&rev, prefix);
@@ -809,15 +810,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.nr = total - nr + (start_number - 1);
 		/* Make the second and subsequent mails replies to the first */
 		if (thread) {
-			if (nr == (total - 2)) {
-				strncpy(ref_message_id, message_id,
-					sizeof(ref_message_id));
-				ref_message_id[sizeof(ref_message_id)-1]='\0';
-				rev.ref_message_id = ref_message_id;
+			if (rev.message_id) {
+				if (rev.ref_message_id)
+					free((char *) rev.message_id);
+				else
+					rev.ref_message_id = rev.message_id;
 			}
-			gen_message_id(message_id, sizeof(message_id),
-				       sha1_to_hex(commit->object.sha1));
-			rev.message_id = message_id;
+			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
 		if (!use_stdout)
 			if (reopen_stdout(commit, rev.nr, keep_subject,
-- 
1.5.4.1.1350.g2b9ee
