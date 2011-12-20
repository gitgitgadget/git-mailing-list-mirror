From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH] Specify a precision for the length of a subject string
Date: Tue, 20 Dec 2011 16:07:54 -0600
Message-ID: <20111220220754.GC21353@llunet.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 23:08:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd7qr-0008UF-Rx
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 23:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab1LTWH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 17:07:58 -0500
Received: from llunet.cs.wisc.edu ([128.105.175.76]:43268 "EHLO
	llunet.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab1LTWH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 17:07:56 -0500
Received: from llunet.cs.wisc.edu (localhost [127.0.0.1])
	by llunet.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id pBKM7sp4013001;
	Tue, 20 Dec 2011 16:07:54 -0600
Received: (from nwp@localhost)
	by llunet.cs.wisc.edu (8.14.1/8.14.1/Submit) id pBKM7sJw013000;
	Tue, 20 Dec 2011 16:07:54 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187532>

We can specify the precision of a subject string, so that length the subjects
viewed by the user do not grow beyond a bound set by the user, in a pretty
formatted string

This makes it possible to do, e.g., 

$ git log --pretty='%h %s' d165204 -1
d165204 git-p4: fix skipSubmitEdit regression

With this patch, the user can do

$ git log --pretty='%h %30s' d165204 -1
d165204 git-p4: fix skipSubmitEdit reg

This is useful when one is working on a system where the pager is lousy.
---
Since my colleagues tend to write long subject lines, I like to truncate them
so they do not overwhelm my terminal.

 builtin/shortlog.c |    2 +-
 commit.h           |    2 +-
 pretty.c           |   35 +++++++++++++++++++++++++++--------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 37f3193..a5a07a3 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -98,7 +98,7 @@ static void insert_one_record(struct shortlog *log,
 	}
 	while (*oneline && isspace(*oneline) && *oneline != '\n')
 		oneline++;
-	format_subject(&subject, oneline, " ");
+	format_subject(&subject, oneline, " ", 0);
 	buffer = strbuf_detach(&subject, NULL);
 
 	if (dot3) {
diff --git a/commit.h b/commit.h
index 3745f12..a95f4ff 100644
--- a/commit.h
+++ b/commit.h
@@ -100,7 +100,7 @@ extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
-				  const char *line_separator);
+				  const char *line_separator, int max_len);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
diff --git a/pretty.c b/pretty.c
index 230fe1c..3af7a95 100644
--- a/pretty.c
+++ b/pretty.c
@@ -738,24 +738,33 @@ static void format_sanitized_subject(struct strbuf *sb, const char *msg)
 }
 
 const char *format_subject(struct strbuf *sb, const char *msg,
-			   const char *line_separator)
+			   const char *line_separator, int max_len)
 {
 	int first = 1;
-
+	int swritten = 0;
 	for (;;) {
 		const char *line = msg;
 		int linelen = get_one_line(line);
-
 		msg += linelen;
 		if (!linelen || is_empty_line(line, &linelen))
 			break;
 
 		if (!sb)
 			continue;
+		if (0 < max_len && max_len < swritten + linelen) {
+			linelen = max_len - swritten;	
+			if(linelen <= 0) {
+				linelen = 0;
+				continue;
+			}
+		}
 		strbuf_grow(sb, linelen + 2);
-		if (!first)
+		if (!first) {
 			strbuf_addstr(sb, line_separator);
+			swritten += strlen(line_separator);
+		}
 		strbuf_add(sb, line, linelen);
+		swritten += linelen;
 		first = 0;
 	}
 	return msg;
@@ -769,7 +778,7 @@ static void parse_commit_message(struct format_commit_context *c)
 	msg = skip_empty_lines(msg);
 	c->subject_off = msg - start;
 
-	msg = format_subject(NULL, msg, NULL);
+	msg = format_subject(NULL, msg, NULL, 0);
 	msg = skip_empty_lines(msg);
 	c->body_off = msg - start;
 
@@ -830,7 +839,17 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	const char *msg = c->message;
 	struct commit_list *p;
 	int h1, h2;
+	int subject_max_len = 0,offset=0;
 
+	while(isdigit(*placeholder)) {
+		subject_max_len *= 10;
+		subject_max_len += *placeholder - '0';
+		++placeholder;
+		++offset;
+	}
+	if(offset > 0 && *placeholder != 's')
+		die("invalid --pretty format: "
+		    "'%%(digits)' can only be followed by an s");
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
@@ -1002,8 +1021,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 
 	switch (placeholder[0]) {
 	case 's':	/* subject */
-		format_subject(sb, msg + c->subject_off, " ");
-		return 1;
+		format_subject(sb, msg + c->subject_off, " ",subject_max_len);
+		return offset + 1;
 	case 'f':	/* sanitized subject */
 		format_sanitized_subject(sb, msg + c->subject_off);
 		return 1;
@@ -1189,7 +1208,7 @@ void pp_title_line(const struct pretty_print_context *pp,
 
 	strbuf_init(&title, 80);
 	*msg_p = format_subject(&title, *msg_p,
-				pp->preserve_subject ? "\n" : " ");
+				pp->preserve_subject ? "\n" : " ",0);
 
 	strbuf_grow(sb, title.len + 1024);
 	if (pp->subject) {
-- 
1.7.8.352.g876a6f.dirty
