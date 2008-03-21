From: Anton Gladkov <agladkov@parallels.com>
Subject: [PATCH] [RFC] add Message-ID field to log on git-am operation
Date: Sat, 22 Mar 2008 01:00:05 +0300
Message-ID: <1206136805-20115-1-git-send-email-agladkov@parallels.com>
Cc: Anton Gladkov <agladkov@parallels.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 22:53:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcpBO-0007B8-97
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 22:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbYCUVxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756678AbYCUVxI
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 17:53:08 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:22872 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622AbYCUVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 17:53:06 -0400
Received: from localhost.localdomain ([10.30.3.212])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id m2LLr0qF015625;
	Sat, 22 Mar 2008 00:53:01 +0300 (MSK)
X-Mailer: git-send-email 1.5.5.rc0.22.ga384d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77774>

o For what?
 E.g. you have tuned your post-script
 to send a notification on patches committed to
 the main branch. It is usefull when such
 notification sended as a reply on original message
 to follow already committed patches.
o How to use?
 Just 'git-am' your message.
 To whatch a message ID in logs use '%M' in pretty format or
 'full' format.
---
 builtin-commit-tree.c |    2 ++
 builtin-mailinfo.c    |    5 ++++-
 git-am.sh             |    3 ++-
 pretty.c              |   12 ++++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 6610d18..b396ec4 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -100,6 +100,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	/* Person/date information */
 	strbuf_addf(&buffer, "author %s\n", git_author_info(IDENT_ERROR_ON_NO_NAME));
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
+	if (getenv("GIT_MESSAGE_ID") != NULL)
+		strbuf_addf(&buffer, "message %s\n", getenv("GIT_MESSAGE_ID"));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 	strbuf_addch(&buffer, '\n');
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 11f154b..f800d86 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -289,7 +289,7 @@ static void cleanup_space(char *buf)
 
 static void decode_header(char *it, unsigned itsize);
 static const char *header[MAX_HDR_PARSED] = {
-	"From","Subject","Date",
+	"From","Subject","Date","Message-ID"
 };
 
 static int check_header(char *line, unsigned linesize, char **hdr_data, int overwrite)
@@ -905,6 +905,9 @@ static void handle_info(void)
 			handle_from(hdr);
 			fprintf(fout, "Author: %s\n", name);
 			fprintf(fout, "Email: %s\n", email);
+		} else if (!memcmp(header[i], "Message-ID", 10)) {
+			cleanup_space(hdr);
+			fprintf(fout, "%s: %s\n", header[i], hdr);
 		} else {
 			cleanup_space(hdr);
 			fprintf(fout, "%s: %s\n", header[i], hdr);
diff --git a/git-am.sh b/git-am.sh
index ac5c388..ba22bf8 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -338,6 +338,7 @@ do
 	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
 	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
 	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
+	GIT_MESSAGE_ID="$(sed -n '/^Message-ID/ s/Message-ID: //p' "$dotest/info")"
 
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
@@ -345,7 +346,7 @@ do
 		stop_here $this
 	fi
 
-	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE GIT_MESSAGE_ID
 
 	SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
 	case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
diff --git a/pretty.c b/pretty.c
index 16bfb86..076718c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -385,6 +385,7 @@ struct format_commit_context {
 	struct chunk subject;
 	struct chunk author;
 	struct chunk committer;
+	struct chunk message;
 	struct chunk encoding;
 	size_t body_off;
 
@@ -438,6 +439,9 @@ static void parse_commit_header(struct format_commit_context *context)
 		} else if (!prefixcmp(msg + i, "committer ")) {
 			context->committer.off = i + 10;
 			context->committer.len = eol - i - 10;
+		} else if (!prefixcmp(msg + i, "message ")) {
+			context->message.off = i + 8;
+			context->message.len = eol - i - 8;
 		} else if (!prefixcmp(msg + i, "encoding ")) {
 			context->encoding.off = i + 9;
 			context->encoding.len = eol - i - 9;
@@ -547,6 +551,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'c':	/* committer ... */
 		return format_person_part(sb, placeholder[1],
 		                   msg + c->committer.off, c->committer.len);
+	case 'M':	/* message */
+		strbuf_add(sb, msg + c->message.off, c->message.len);
+		return 1;
 	case 'e':	/* encoding */
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
 		return 1;
@@ -627,6 +634,11 @@ static void pp_header(enum cmit_fmt fmt,
 			strbuf_grow(sb, linelen + 80);
 			pp_user_info("Commit", fmt, sb, line + 10, dmode, encoding);
 		}
+		if (!memcmp(line, "message ", 8) &&
+		    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER)) {
+			strbuf_grow(sb, linelen + 80);
+			pp_user_info("Message-ID", fmt, sb, line + 8, dmode, encoding);
+		}
 	}
 }
 
-- 
1.5.5.rc0.22.ga384d.dirty
