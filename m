From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Fri, 12 Jan 2007 17:31:35 -0800
Message-ID: <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net>
References: <871wm08kcu.fsf@morpheus.local>
	<7vd55jrj38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 02:31:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5XkL-0007j7-Ak
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 02:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbXAMBbi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 20:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbXAMBbh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 20:31:37 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:48681 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161144AbXAMBbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 20:31:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113013136.JQIF18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 20:31:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ARWk1W00y1kojtg0000000; Fri, 12 Jan 2007 20:30:45 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <7vd55jrj38.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 14:11:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36736>

Junio C Hamano <junkio@cox.net> writes:

> It might make more sense to just set the log_output_encoding to
> be always UTF-8 when generating an e-mail output, in
> git-format-patch.

Actually, I do not want to be an UTF-8 imperialist, so how about
doing this?

-- >8 --
Use log output encoding in --pretty=email headers.

Private functions add_rfc2047() and pretty_print_commit() assumed
they are only emitting UTF-8.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/commit.c b/commit.c
index 496d37a..9b2b842 100644
--- a/commit.c
+++ b/commit.c
@@ -464,20 +464,29 @@ static int get_one_line(const char *msg, unsigned long len)
 	return ret;
 }
 
+/* High bit set, or ISO-2022-INT */
+static int non_ascii(int ch)
+{
+	ch = (ch & 0xff);
+	return ((ch & 0x80) || (ch == 0x1b));
+}
+
 static int is_rfc2047_special(char ch)
 {
-	return ((ch & 0x80) || (ch == '=') || (ch == '?') || (ch == '_'));
+	return (non_ascii(ch) || (ch == '=') || (ch == '?') || (ch == '_'));
 }
 
-static int add_rfc2047(char *buf, const char *line, int len)
+static int add_rfc2047(char *buf, const char *line, int len,
+		       const char *encoding)
 {
 	char *bp = buf;
 	int i, needquote;
-	static const char q_utf8[] = "=?utf-8?q?";
+	char q_encoding[128];
+	const char *q_encoding_fmt = "=?%s?q?";
 
 	for (i = needquote = 0; !needquote && i < len; i++) {
-		unsigned ch = line[i];
-		if (ch & 0x80)
+		int ch = line[i];
+		if (non_ascii(ch))
 			needquote++;
 		if ((i + 1 < len) &&
 		    (ch == '=' && line[i+1] == '?'))
@@ -486,8 +495,11 @@ static int add_rfc2047(char *buf, const char *line, int len)
 	if (!needquote)
 		return sprintf(buf, "%.*s", len, line);
 
-	memcpy(bp, q_utf8, sizeof(q_utf8)-1);
-	bp += sizeof(q_utf8)-1;
+	i = snprintf(q_encoding, sizeof(q_encoding), q_encoding_fmt, encoding);
+	if (sizeof(q_encoding) < i)
+		die("Insanely long encoding name %s", encoding);
+	memcpy(bp, q_encoding, i);
+	bp += i;
 	for (i = 0; i < len; i++) {
 		unsigned ch = line[i] & 0xFF;
 		if (is_rfc2047_special(ch)) {
@@ -505,7 +517,8 @@ static int add_rfc2047(char *buf, const char *line, int len)
 }
 
 static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
-			 const char *line, int relative_date)
+			 const char *line, int relative_date,
+			 const char *encoding)
 {
 	char *date;
 	int namelen;
@@ -533,7 +546,8 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 		filler = "";
 		strcpy(buf, "From: ");
 		ret = strlen(buf);
-		ret += add_rfc2047(buf + ret, line, display_name_length);
+		ret += add_rfc2047(buf + ret, line, display_name_length,
+				   encoding);
 		memcpy(buf + ret, name_tail, namelen - display_name_length);
 		ret += namelen - display_name_length;
 		buf[ret++] = '\n';
@@ -668,21 +682,18 @@ static char *replace_encoding_header(char *buf, char *encoding)
 	return buf;
 }
 
-static char *logmsg_reencode(const struct commit *commit)
+static char *logmsg_reencode(const struct commit *commit,
+			     char *output_encoding)
 {
 	char *encoding;
 	char *out;
-	char *output_encoding = (git_log_output_encoding
-				 ? git_log_output_encoding
-				 : git_commit_encoding);
+	char *utf8 = "utf-8";
 
-	if (!output_encoding)
-		output_encoding = "utf-8";
-	else if (!*output_encoding)
+	if (!*output_encoding)
 		return NULL;
 	encoding = get_header(commit, "encoding");
 	if (!encoding)
-		return NULL;
+		encoding = utf8;
 	if (!strcmp(encoding, output_encoding))
 		out = strdup(commit->buffer);
 	else
@@ -691,7 +702,8 @@ static char *logmsg_reencode(const struct commit *commit)
 	if (out)
 		out = replace_encoding_header(out, output_encoding);
 
-	free(encoding);
+	if (encoding != utf8)
+		free(encoding);
 	if (!out)
 		return NULL;
 	return out;
@@ -711,8 +723,15 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	int parents_shown = 0;
 	const char *msg = commit->buffer;
 	int plain_non_ascii = 0;
-	char *reencoded = logmsg_reencode(commit);
+	char *reencoded;
+	char *encoding;
 
+	encoding = (git_log_output_encoding
+		    ? git_log_output_encoding
+		    : git_commit_encoding);
+	if (!encoding)
+		encoding = "utf-8";
+	reencoded = logmsg_reencode(commit, encoding);
 	if (reencoded)
 		msg = reencoded;
 
@@ -738,7 +757,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				    i + 1 < len && msg[i+1] == '\n')
 					in_body = 1;
 			}
-			else if (ch & 0x80) {
+			else if (non_ascii(ch)) {
 				plain_non_ascii = 1;
 				break;
 			}
@@ -797,13 +816,15 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				offset += add_user_info("Author", fmt,
 							buf + offset,
 							line + 7,
-							relative_date);
+							relative_date,
+							encoding);
 			if (!memcmp(line, "committer ", 10) &&
 			    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER))
 				offset += add_user_info("Commit", fmt,
 							buf + offset,
 							line + 10,
-							relative_date);
+							relative_date,
+							encoding);
 			continue;
 		}
 
@@ -826,7 +847,8 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 			int slen = strlen(subject);
 			memcpy(buf + offset, subject, slen);
 			offset += slen;
-			offset += add_rfc2047(buf + offset, line, linelen);
+			offset += add_rfc2047(buf + offset, line, linelen,
+					      encoding);
 		}
 		else {
 			memset(buf + offset, ' ', indent);
@@ -837,11 +859,17 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 		if (fmt == CMIT_FMT_ONELINE)
 			break;
 		if (subject && plain_non_ascii) {
-			static const char header[] =
-				"Content-Type: text/plain; charset=UTF-8\n"
+			int sz;
+			char header[512];
+			const char *header_fmt =
+				"Content-Type: text/plain; charset=%s\n"
 				"Content-Transfer-Encoding: 8bit\n";
-			memcpy(buf + offset, header, sizeof(header)-1);
-			offset += sizeof(header)-1;
+			sz = snprintf(header, sizeof(header), header_fmt,
+				      encoding);
+			if (sizeof(header) < sz)
+				die("Encoding name %s too long", encoding);
+			memcpy(buf + offset, header, sz);
+			offset += sz;
 		}
 		if (after_subject) {
 			int slen = strlen(after_subject);
