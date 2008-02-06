From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Improve message-id generation flow control for
 format-patch
Date: Wed, 6 Feb 2008 11:43:18 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802061140360.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:44:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnOA-00049s-Uz
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbYBFQn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 11:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbYBFQn3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:43:29 -0500
Received: from iabervon.org ([66.92.72.58]:58413 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbYBFQn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 11:43:28 -0500
Received: (qmail 27668 invoked by uid 1000); 6 Feb 2008 16:43:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 16:43:18 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72815>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-log.c |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index dcc9f81..1f74d66 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -576,16 +576,19 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
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
+	info->message_id = buf.buf;
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -626,8 +629,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
-	char message_id[1024];
-	char ref_message_id[1024];
 
 	git_config(git_format_config);
 	init_revisions(&rev, prefix);
@@ -810,15 +811,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
1.5.4.27.gf6864
