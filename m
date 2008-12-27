From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sat, 27 Dec 2008 01:49:21 +0100
Message-ID: <1230338961.8363.101.camel@ubuntu.ubuntu-domain>
References: <1230337969.8363.84.camel@ubuntu.ubuntu-domain>
	 <1230338375.8363.91.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 01:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGNO9-0006gq-Pp
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbYL0AtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYL0AtY
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:49:24 -0500
Received: from india601.server4you.de ([85.25.151.105]:35804 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYL0AtX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 19:49:23 -0500
Received: from [10.0.1.101] (p57B7F73B.dip.t-dialin.net [87.183.247.59])
	by india601.server4you.de (Postfix) with ESMTPSA id 31A602F8003;
	Sat, 27 Dec 2008 01:49:22 +0100 (CET)
In-Reply-To: <1230338375.8363.91.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103976>

git log --pretty=format:%s (and tformat:) used to display the first
line of the subject, unlike the other --pretty options, which would
construct a subject line from all lines of the first paragraph of
the commit message.

For consistency and increased code reuse, change format: to do the
same as the other options.

Before:
	$ git log --pretty=oneline v1.6.1 | md5sum
	7c0896d2a94fc3315a0372b9b3373a8f  -
	$ git log --pretty=tformat:"%H %s" v1.6.1 | md5sum
	298903b1c065002e15daa5329213c51f  -

After:
	$ git log --pretty=tformat:"%H %s" v1.6.1 | md5sum
	7c0896d2a94fc3315a0372b9b3373a8f  -
	$ git log --pretty=oneline v1.6.1 | md5sum
	7c0896d2a94fc3315a0372b9b3373a8f  -

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c |   53 ++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/pretty.c b/pretty.c
index 632abc5..343dca5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -424,13 +424,15 @@ struct chunk {
 struct format_commit_context {
 	const struct commit *commit;
 	enum date_mode dmode;
+	unsigned commit_header_parsed:1;
+	unsigned commit_message_parsed:1;
 
 	/* These offsets are relative to the start of the commit message. */
-	int commit_header_parsed;
-	struct chunk subject;
 	struct chunk author;
 	struct chunk committer;
 	struct chunk encoding;
+	size_t message_off;
+	size_t subject_off;
 	size_t body_off;
 
 	/* The following ones are relative to the result struct strbuf. */
@@ -460,23 +462,14 @@ static void parse_commit_header(struct format_commit_context *context)
 {
 	const char *msg = context->commit->buffer;
 	int i;
-	enum { HEADER, SUBJECT, BODY } state;
 
-	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
+	for (i = 0; msg[i]; i++) {
 		int eol;
 		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
 			; /* do nothing */
 
-		if (state == SUBJECT) {
-			context->subject.off = i;
-			context->subject.len = eol - i;
-			i = eol;
-		}
 		if (i == eol) {
-			state++;
-			/* strip empty lines */
-			while (msg[eol] == '\n' && msg[eol + 1] == '\n')
-				eol++;
+			break;
 		} else if (!prefixcmp(msg + i, "author ")) {
 			context->author.off = i + 7;
 			context->author.len = eol - i - 7;
@@ -488,10 +481,8 @@ static void parse_commit_header(struct format_commit_context *context)
 			context->encoding.len = eol - i - 9;
 		}
 		i = eol;
-		if (!msg[i])
-			break;
 	}
-	context->body_off = i;
+	context->message_off = i;
 	context->commit_header_parsed = 1;
 }
 
@@ -508,6 +499,8 @@ static const char *format_subject(struct strbuf *sb, const char *msg,
 		if (!linelen || is_empty_line(line, &linelen))
 			break;
 
+		if (!sb)
+			continue;
 		strbuf_grow(sb, linelen + 2);
 		if (!first)
 			strbuf_addstr(sb, line_separator);
@@ -517,6 +510,21 @@ static const char *format_subject(struct strbuf *sb, const char *msg,
 	return msg;
 }
 
+static void parse_commit_message(struct format_commit_context *c)
+{
+	const char *msg = c->commit->buffer + c->message_off;
+	const char *start = c->commit->buffer;
+
+	msg = skip_empty_lines(msg);
+	c->subject_off = msg - start;
+
+	msg = format_subject(NULL, msg, NULL);
+	msg = skip_empty_lines(msg);
+	c->body_off = msg - start;
+
+	c->commit_message_parsed = 1;
+}
+
 static void format_decoration(struct strbuf *sb, const struct commit *commit)
 {
 	struct name_decoration *d;
@@ -636,9 +644,6 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		parse_commit_header(c);
 
 	switch (placeholder[0]) {
-	case 's':	/* subject */
-		strbuf_add(sb, msg + c->subject.off, c->subject.len);
-		return 1;
 	case 'a':	/* author ... */
 		return format_person_part(sb, placeholder[1],
 				   msg + c->author.off, c->author.len,
@@ -650,6 +655,16 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'e':	/* encoding */
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
 		return 1;
+	}
+
+	/* Now we need to parse the commit message. */
+	if (!c->commit_message_parsed)
+		parse_commit_message(c);
+
+	switch (placeholder[0]) {
+	case 's':	/* subject */
+		format_subject(sb, msg + c->subject_off, " ");
+		return 1;
 	case 'b':	/* body */
 		strbuf_addstr(sb, msg + c->body_off);
 		return 1;
-- 
1.6.1
