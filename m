From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/5] Improve message-id generation flow control for
 format-patch
Date: Mon, 18 Feb 2008 22:56:06 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802182254110.5816@iabervon.org>
References: <cover.1203392527.git.barkalow@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 04:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRJbS-0002Fp-I3
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 04:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYBSD43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 22:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbYBSD40
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 22:56:26 -0500
Received: from iabervon.org ([66.92.72.58]:54150 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbYBSD4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 22:56:07 -0500
Received: (qmail 22298 invoked by uid 1000); 19 Feb 2008 03:56:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 03:56:06 -0000
In-Reply-To: <cover.1203392527.git.barkalow@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74367>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-log.c |   29 ++++++++++++++---------------
 revision.h    |    2 +-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 99d69f0..4f08ca4 100644
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
+					free(rev.message_id);
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
diff --git a/revision.h b/revision.h
index 8572315..e3559d0 100644
--- a/revision.h
+++ b/revision.h
@@ -74,7 +74,7 @@ struct rev_info {
 	struct log_info *loginfo;
 	int		nr, total;
 	const char	*mime_boundary;
-	const char	*message_id;
+	char		*message_id;
 	const char	*ref_message_id;
 	const char	*add_signoff;
 	const char	*extra_headers;
-- 
1.5.4.1.191.gfbf10
