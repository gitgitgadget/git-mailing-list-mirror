From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 5/9] refactor pretty.c into "parse" and "format" steps
Date: Tue, 29 Mar 2011 00:17:27 +0100
Message-ID: <1301354251-23380-6-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4LhL-0000rH-K2
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab1C1XSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:18:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35885 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1C1XSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:18:01 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so4410093wwa.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=T6ruRkwaiWEGw++lew1QiEfA589R0gUxV16RYvN5uPw=;
        b=VptXmf/sJFSOjvloXMhPURRfOiDPeObb7sX2h52FHqyjAKs0IVyS84jZ45R1PENj54
         apt+z3udR1eGZL6m9q/cgAY1ns87dNdX5aozCRmjCpMlii9jQ8im+rCU03n2FJjidGmr
         ndzgzbxVb1J9DA9On38gFPKm3esqM3z5KqmXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UlubPIGtgL5HV33d7AWZEH/2Z3bQdnvf6dTYxvXk23zOaxty+ThfhYSxImg3Qx8r8y
         P/VAjgTKQ8Rhpf8/Zr5p7n9O3PWxFhi8JBqkN7/6pZlxlZRTqs3bKBuqx6W4uJ9vXBjf
         ihrtgKiTBGhZTM6SmzyAqt+Jr4G1OPJ7R6RfI=
Received: by 10.216.82.68 with SMTP id n46mr4309397wee.57.1301354280265;
        Mon, 28 Mar 2011 16:18:00 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.17.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:17:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170203>

Previously we parsed-out the user-defined "pretty" formats and outputted
the result in one pass, once for every commit. This was perfectly
reasonable, as the performance penalties for doing so are almost
nonexistant. However, it did make it cumbersome to define more-complex
placeholders.

Here we split the bulk of pretty.c into separate "parse" and "format"
steps, adding the bulk of the back-end for more-complicated formatting
rules in the process.

This also adds test-pretty, for debugging the parser. It prints out a
human-readable dump of the parsed format.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 .gitignore    |    1 +
 Makefile      |    1 +
 commit.h      |   86 ++++++
 pretty.c      |  802 ++++++++++++++++++++++++++++++++++++++++-----------------
 test-pretty.c |  232 +++++++++++++++++
 5 files changed, 889 insertions(+), 233 deletions(-)
 create mode 100644 test-pretty.c

diff --git a/.gitignore b/.gitignore
index 3dd6ef7..c3b32e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -173,6 +173,7 @@
 /test-obj-pool
 /test-parse-options
 /test-path-utils
+/test-pretty
 /test-run-command
 /test-sha1
 /test-sigchain
diff --git a/Makefile b/Makefile
index 5c2b797..9cecf40 100644
--- a/Makefile
+++ b/Makefile
@@ -436,6 +436,7 @@ TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-mktemp
+TEST_PROGRAMS_NEED_X += test-pretty
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/commit.h b/commit.h
index 4198513..fff1225 100644
--- a/commit.h
+++ b/commit.h
@@ -83,17 +83,103 @@ struct userformat_want {
 	unsigned notes:1;
 };
 
+enum format_part_type {
+	FORMAT_PART_UNKNOWN = 0,
+	FORMAT_PART_LITERAL,
+
+	FORMAT_PART_COMMIT_HASH,
+	FORMAT_PART_COMMIT_HASH_ABBREV,
+	FORMAT_PART_PARENT_HASHES,
+	FORMAT_PART_PARENT_HASHES_ABBREV,
+	FORMAT_PART_TREE_HASH,
+	FORMAT_PART_TREE_HASH_ABBREV,
+
+	FORMAT_PART_AUTHOR_NAME,
+	FORMAT_PART_AUTHOR_NAME_MAILMAP,
+	FORMAT_PART_AUTHOR_EMAIL,
+	FORMAT_PART_AUTHOR_EMAIL_MAILMAP,
+	FORMAT_PART_AUTHOR_DATE,
+	FORMAT_PART_COMMITTER_NAME,
+	FORMAT_PART_COMMITTER_NAME_MAILMAP,
+	FORMAT_PART_COMMITTER_EMAIL,
+	FORMAT_PART_COMMITTER_EMAIL_MAILMAP,
+	FORMAT_PART_COMMITTER_DATE,
+
+	FORMAT_PART_DECORATE,
+	FORMAT_PART_ENCODING,
+	FORMAT_PART_SUBJECT,
+	FORMAT_PART_SUBJECT_SANITIZED,
+	FORMAT_PART_BODY,
+	FORMAT_PART_RAW_BODY,
+	FORMAT_PART_NOTES,
+
+	FORMAT_PART_REFLOG_SELECTOR,
+	FORMAT_PART_REFLOG_SELECTOR_SHORT,
+	FORMAT_PART_REFLOG_SUBJECT,
+
+	FORMAT_PART_MARK,
+	FORMAT_PART_WRAP
+};
+
+enum format_part_magic {
+	NO_MAGIC,
+	ADD_LF_BEFORE_NON_EMPTY,
+	DEL_LF_BEFORE_EMPTY,
+	ADD_SP_BEFORE_NON_EMPTY
+};
+
+enum format_arg_type {
+	FORMAT_ARG_UINT,
+	FORMAT_ARG_DATE_MODE
+};
+
+struct format_arg {
+	enum format_arg_type type;
+	union {
+		unsigned long uint;
+		enum date_mode dmode;
+	};
+};
+
+struct format_part;
+struct format_parts {
+	size_t			format_len;
+	struct userformat_want	want;
+	size_t			len;
+	size_t			alloc;
+	struct format_part	*part;
+};
+
+struct format_part {
+	enum format_part_type	type;
+	enum format_part_magic	magic;
+
+	size_t			format_len;
+
+	size_t			literal_len;
+	char			*literal;
+
+	size_t			argc;
+	size_t			args_alloc;
+	struct format_arg	*args;
+};
+
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *logmsg_reencode(const struct commit *commit,
 			     const char *output_encoding);
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
+extern struct format_parts *parse_format(const char *unparsed);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
+extern void format_commit_message_parsed(const struct commit *commit,
+					 const struct format_parts *parsed_format,
+					 struct strbuf *sb,
+					 const struct pretty_print_context *context);
 extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 				struct strbuf *sb,
 				const struct pretty_print_context *context);
diff --git a/pretty.c b/pretty.c
index 8a288f0..cb02879 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,7 +10,7 @@
 #include "color.h"
 #include "reflog-walk.h"
 
-static char *user_format;
+static struct format_parts *user_format;
 static struct cmt_fmt_map {
 	const char *name;
 	enum cmit_fmt format;
@@ -23,10 +23,408 @@ static size_t commit_formats_len;
 static size_t commit_formats_alloc;
 static struct cmt_fmt_map *find_commit_format(const char *sought);
 
+#define WHITESPACE " \t\r\n"
+#define format_parts_alloc() \
+	((struct format_parts*)xcalloc(1, sizeof(struct format_parts)))
+#define format_part_alloc() \
+	((struct format_part*)xcalloc(1, sizeof(struct format_part)))
+static void format_part_free(struct format_part **part);
+static void format_parts_free(struct format_parts **parts)
+{
+	if((*parts)->part)
+		free((*parts)->part);
+	free(*parts);
+	*parts = NULL;
+}
+static void format_part_free(struct format_part **part)
+{
+	if ((*part)->literal)
+		free((*part)->literal);
+	if ((*part)->args)
+		free((*part)->args);
+	free(*part);
+	*part = NULL;
+}
+
+static struct format_part *parts_add(struct format_parts *parts,
+				     enum format_part_type type)
+{
+	ALLOC_GROW(parts->part, parts->len+1, parts->alloc);
+	memset(&parts->part[parts->len], 0,
+	       sizeof(parts->part[parts->len]));
+	parts->part[parts->len].type = type;
+	parts->len++;
+	return &parts->part[parts->len-1];
+}
+
+static struct format_part *parts_add_part(struct format_parts *parts,
+					   struct format_part *part)
+{
+	struct format_part *dst = parts_add(parts, FORMAT_PART_UNKNOWN);
+	memcpy(dst, part, sizeof(*dst));
+	if (part->type == FORMAT_PART_NOTES)
+		parts->want.notes = 1;
+	return dst;
+}
+
+static void parts_add_nliteral(struct format_parts *parts, const char *literal,
+			       size_t len)
+{
+	if (len == 0)
+		return;
+	parts_add(parts, FORMAT_PART_LITERAL);
+	parts->part[parts->len-1].literal = xmemdupz(literal, len);
+	parts->part[parts->len-1].literal_len = len;
+	parts->part[parts->len-1].format_len = len;
+	return;
+}
+
+static void part_add_arg_date_mode(struct format_part *part,
+				   enum date_mode dmode)
+{
+	part->args = xrealloc(part->args,
+			      sizeof(struct format_arg) * (part->argc+1));
+	part->args[part->argc].type = FORMAT_ARG_DATE_MODE;
+	part->args[part->argc].dmode = dmode;
+	part->argc++;
+	return;
+}
+
+/*
+* Parse a single argument of an extended format, up to the next delimiter
+* ie: up to ',' or ')'
+* The return value is the position of the found delimiter within *unparsed,
+* or NULL if the argument was invalid.
+*/
+const char *parse_arg(struct format_part *part, enum format_arg_type type,
+		      const char *unparsed)
+{
+	struct format_arg arg = {0};
+	const char *c = unparsed;
+	char *t;
+
+	if (type != FORMAT_ARG_UINT)
+		return NULL;
+	arg.type = type;
+
+	c += strspn(c, WHITESPACE);
+	if (!isdigit(*c))
+		return NULL;
+	arg.uint = strtoul(c, &t, 10);
+	if (t == c)
+		return NULL;
+	c = t + strspn(t, WHITESPACE);
+	if (*c == ',' || *c == ')'){
+		ALLOC_GROW(part->args, part->argc+1, part->args_alloc);
+		memcpy(&(part->args[part->argc]), &arg,
+		       sizeof(struct format_arg));
+		part->argc++;
+		return c;
+	}
+	return NULL;
+}
+
+static struct format_part *parse_special(const char *unparsed)
+{
+	struct format_part *part = NULL;
+	int h1,h2;
+	char c;
+	const char *s, *e;
+
+	/* these allocate their own part */
+	switch (unparsed[1]) {
+	case '-':
+	case '+':
+	case ' ':
+		if (*unparsed != '%')
+			goto fail;
+
+		part = parse_special(unparsed + 1);
+		if (part) {
+			part->format_len++;
+
+			switch (unparsed[1]) {
+			case '-':
+				part->magic = DEL_LF_BEFORE_EMPTY;
+				break;
+			case '+':
+				part->magic = ADD_LF_BEFORE_NON_EMPTY;
+				break;
+			case ' ':
+				part->magic = ADD_SP_BEFORE_NON_EMPTY;
+				break;
+			}
+		}
+		return part;
+	}
+
+	part = format_part_alloc();
+
+	/* most placeholders are 2 characters long */
+	part->format_len = 2;
+
+	switch (unparsed[1]) {
+	case 'h':
+		part->type = FORMAT_PART_COMMIT_HASH_ABBREV;
+		return part;
+	case 'H':
+		part->type = FORMAT_PART_COMMIT_HASH;
+		return part;
+	case 'p':
+		part->type = FORMAT_PART_PARENT_HASHES_ABBREV;
+		return part;
+	case 'P':
+		part->type = FORMAT_PART_PARENT_HASHES;
+		return part;
+	case 't':
+		part->type = FORMAT_PART_TREE_HASH_ABBREV;
+		return part;
+	case 'T':
+		part->type = FORMAT_PART_TREE_HASH;
+		return part;
+	case 'a':
+		part->format_len++;
+		switch (unparsed[2]) {
+		case 'n':
+			part->type = FORMAT_PART_AUTHOR_NAME;
+			return part;
+		case 'N':
+			part->type = FORMAT_PART_AUTHOR_NAME_MAILMAP;
+			return part;
+		case 'e':
+			part->type = FORMAT_PART_AUTHOR_EMAIL;
+			return part;
+		case 'E':
+			part->type = FORMAT_PART_AUTHOR_EMAIL_MAILMAP;
+			return part;
+		case 'd':
+			part->type = FORMAT_PART_AUTHOR_DATE;
+			return part;
+		case 'D':
+			part->type = FORMAT_PART_AUTHOR_DATE;
+			part_add_arg_date_mode(part, DATE_RFC2822);
+			return part;
+		case 'r':
+			part->type = FORMAT_PART_AUTHOR_DATE;
+			part_add_arg_date_mode(part, DATE_RELATIVE);
+			return part;
+		case 't':
+			part->type = FORMAT_PART_AUTHOR_DATE;
+			part_add_arg_date_mode(part, DATE_UNIX);
+			return part;
+		case 'i':
+			part->type = FORMAT_PART_AUTHOR_DATE;
+			part_add_arg_date_mode(part, DATE_ISO8601);
+			return part;
+		}
+		goto fail;
+	case 'c':
+		part->format_len++;
+		switch (unparsed[2]) {
+		case 'n':
+			part->type = FORMAT_PART_COMMITTER_NAME;
+			return part;
+		case 'N':
+			part->type = FORMAT_PART_COMMITTER_NAME_MAILMAP;
+			return part;
+		case 'e':
+			part->type = FORMAT_PART_COMMITTER_EMAIL;
+			return part;
+		case 'E':
+			part->type = FORMAT_PART_COMMITTER_EMAIL_MAILMAP;
+			return part;
+		case 'd':
+			part->type = FORMAT_PART_COMMITTER_DATE;
+			return part;
+		case 'D':
+			part->type = FORMAT_PART_COMMITTER_DATE;
+			part_add_arg_date_mode(part, DATE_RFC2822);
+			return part;
+		case 'r':
+			part->type = FORMAT_PART_COMMITTER_DATE;
+			part_add_arg_date_mode(part, DATE_RELATIVE);
+			return part;
+		case 't':
+			part->type = FORMAT_PART_COMMITTER_DATE;
+			part_add_arg_date_mode(part, DATE_UNIX);
+			return part;
+		case 'i':
+			part->type = FORMAT_PART_COMMITTER_DATE;
+			part_add_arg_date_mode(part, DATE_ISO8601);
+			return part;
+		}
+		goto fail;
+	case 'd':
+		part->type = FORMAT_PART_DECORATE;
+		return part;
+	case 'e':
+		part->type = FORMAT_PART_ENCODING;
+		return part;
+	case 's':
+		part->type = FORMAT_PART_SUBJECT;
+		return part;
+	case 'f':
+		part->type = FORMAT_PART_SUBJECT_SANITIZED;
+		return part;
+	case 'b':
+		part->type = FORMAT_PART_BODY;
+		return part;
+	case 'B':
+		part->type = FORMAT_PART_RAW_BODY;
+		return part;
+	case 'N':
+		part->type = FORMAT_PART_NOTES;
+		return part;
+	case 'g':
+		part->format_len++;
+		switch (unparsed[2]) {
+		case 'D':
+			part->type = FORMAT_PART_REFLOG_SELECTOR;
+			return part;
+		case 'd':
+			part->type = FORMAT_PART_REFLOG_SELECTOR_SHORT;
+			return part;
+		case 's':
+			part->type = FORMAT_PART_REFLOG_SUBJECT;
+			return part;
+		}
+		goto fail;
+	case 'C':
+		part->type = FORMAT_PART_LITERAL;
+		if (unparsed[2] == '(') {
+			e = strchr(unparsed + 3, ')');
+			part->literal = xcalloc(1, COLOR_MAXLEN);
+			if (!e || !color_parse_len(unparsed + 3,
+						  e - (unparsed + 3),
+						  part->literal))
+				goto fail;
+			part->literal_len = strlen(part->literal);
+			part->format_len = e - unparsed + 1;
+			return part;
+		}
+
+		if (!prefixcmp(&unparsed[2], "red")) {
+			part->literal = GIT_COLOR_RED;
+			part->literal_len = strlen(GIT_COLOR_RED);
+			part->format_len = 5;
+		} else if (!prefixcmp(&unparsed[2], "green")) {
+			part->literal = GIT_COLOR_GREEN;
+			part->literal_len = strlen(GIT_COLOR_GREEN);
+			part->format_len = 7;
+		} else if (!prefixcmp(&unparsed[2], "blue")) {
+			part->literal = GIT_COLOR_BLUE;
+			part->literal_len = strlen(GIT_COLOR_BLUE);
+			part->format_len = 6;
+		} else if (!prefixcmp(&unparsed[2], "reset")) {
+			part->literal = GIT_COLOR_RESET;
+			part->literal_len = strlen(GIT_COLOR_RESET);
+			part->format_len = 7;
+		}
+
+		if (part->literal)
+			return part;
+		goto fail;
+	case 'm':
+		part->type = FORMAT_PART_MARK;
+		return part;
+	case 'w':
+		if (unparsed[2] != '(')
+			goto fail;
+
+		part->type = FORMAT_PART_WRAP;
+
+		s = unparsed + 3;
+		while (part->argc <= 3) {
+			s += strspn(s, WHITESPACE);
+			if (*s == ')'){
+				part->format_len = s - unparsed + 1;
+				return part;
+			}
+			if (part->argc) {
+				if (*s != ',')
+					goto fail;
+				s++;
+			}
+			if (part->argc == 3)
+				goto fail;
+
+			s = parse_arg(part, FORMAT_ARG_UINT, s);
+			if (!s)
+				goto fail;
+		}
+		goto fail;
+	case 'x':
+		/* %x00 == NUL, %x0a == LF, etc. */
+		if (0 <= (h1 = hexval_table[0xff & unparsed[2]]) &&
+		    h1 <= 16 &&
+		    0 <= (h2 = hexval_table[0xff & unparsed[3]]) &&
+		    h2 <= 16) {
+			part->type = FORMAT_PART_LITERAL;
+			part->format_len = 4;
+			c = (h1<<4)|h2;
+			part->literal = xmemdupz(&c, 1);
+			part->literal_len = 1;
+			return part;
+		}
+		goto fail;
+	case 'n':
+		part->type = FORMAT_PART_LITERAL;
+		part->literal = "\n";
+		part->literal_len = 1;
+		return part;
+	case '%':
+		part->type = FORMAT_PART_LITERAL;
+		part->literal = xstrndup(&unparsed[1], 1);
+		part->literal_len = 1;
+		return part;
+	}
+
+fail:
+	if (part)
+		format_part_free(&part);
+	return NULL;
+}
+
+struct format_parts *parse_format(const char *unparsed)
+{
+	struct format_parts *parts = format_parts_alloc();
+	struct format_part *part;
+	const char *c = unparsed;
+	const char *last = NULL;
+
+	while (*c) {
+		if (!last)
+			last = c;
+
+		c += strcspn(c, "%");
+		if (!*c)
+			break;
+
+		part = parse_special(c);
+		if (part) {
+			parts_add_nliteral(parts, last, c - last);
+			last = NULL;
+
+			parts_add_part(parts, part);
+			c += part->format_len;
+			free(part);
+			continue;
+		}
+		c++;
+	}
+
+	if (last)
+		parts_add_nliteral(parts, last, c - last);
+
+	parts->format_len = c - unparsed + 1;
+	return parts;
+}
+
 static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
 {
-	free(user_format);
-	user_format = xstrdup(cp);
+	if (user_format)
+		format_parts_free(&user_format);
+	user_format = parse_format(cp);
 	if (is_tformat)
 		rev->use_terminator = 1;
 	rev->commit_format = CMIT_FMT_USERFORMAT;
@@ -440,11 +838,9 @@ static int mailmap_name(char *email, int email_len, char *name, int name_len)
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
 
-static size_t format_person_part(struct strbuf *sb, char part,
-				 const char *msg, int len, enum date_mode dmode)
+static void format_person_part(struct strbuf *sb, struct format_part *part,
+			       const char *msg, int len, enum date_mode dmode)
 {
-	/* currently all placeholders have same length */
-	const int placeholder_len = 2;
 	int start, end, tz = 0;
 	unsigned long date = 0;
 	char *ep;
@@ -463,7 +859,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	 * below len - 1.
 	 */
 	if (end >= len - 2)
-		goto skip;
+		return;
 
 	/* Seek for both name and email part */
 	name_start = msg;
@@ -472,19 +868,22 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		name_end--;
 	name_len = name_end-name_start;
 	if (name_len >= sizeof(person_name))
-		goto skip;
+		return;
 	mail_start = msg+end+1;
 	mail_end = mail_start;
 	while (mail_end < msg_end && *mail_end != '>')
 		mail_end++;
 	mail_len = mail_end-mail_start;
 	if (mail_len >= sizeof(person_mail))
-		goto skip;
+		return;
 	if (mail_end == msg_end)
-		goto skip;
+		return;
 	end = mail_end-msg;
 
-	if (part == 'N' || part == 'E') { /* mailmap lookup */
+	if (part->type == FORMAT_PART_AUTHOR_NAME_MAILMAP ||
+	    part->type == FORMAT_PART_AUTHOR_EMAIL_MAILMAP ||
+	    part->type == FORMAT_PART_COMMITTER_NAME_MAILMAP ||
+	    part->type == FORMAT_PART_COMMITTER_EMAIL_MAILMAP) {
 		/* copy up to, and including, the end delimiter */
 		strlcpy(person_name, name_start, name_len+1);
 		strlcpy(person_mail, mail_start, mail_len+1);
@@ -494,27 +893,37 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		mail_start = person_mail;
 		mail_len = strlen(person_mail);
 	}
-	if (part == 'n' || part == 'N') {	/* name */
+	if (part->type == FORMAT_PART_AUTHOR_NAME ||
+	    part->type == FORMAT_PART_AUTHOR_NAME_MAILMAP ||
+	    part->type == FORMAT_PART_COMMITTER_NAME ||
+	    part->type == FORMAT_PART_COMMITTER_NAME_MAILMAP) {
 		strbuf_add(sb, name_start, name_len);
-		return placeholder_len;
+		return;
 	}
-	if (part == 'e' || part == 'E') {	/* email */
+	if (part->type == FORMAT_PART_AUTHOR_EMAIL ||
+	    part->type == FORMAT_PART_AUTHOR_EMAIL_MAILMAP ||
+	    part->type == FORMAT_PART_COMMITTER_EMAIL ||
+	    part->type == FORMAT_PART_COMMITTER_EMAIL_MAILMAP) {
 		strbuf_add(sb, mail_start, mail_len);
-		return placeholder_len;
+		return;
 	}
 
 	/* advance 'start' to point to date start delimiter */
 	for (start = end + 1; start < len && isspace(msg[start]); start++)
 		; /* do nothing */
 	if (start >= len)
-		goto skip;
+		return;
 	date = strtoul(msg + start, &ep, 10);
 	if (msg + start == ep)
-		goto skip;
+		return;
 
-	if (part == 't') {	/* date, UNIX timestamp */
+	if (part->type != FORMAT_PART_AUTHOR_DATE &&
+	    part->type != FORMAT_PART_COMMITTER_DATE)
+		return;
+
+	if (part->argc && part->args[0].dmode == DATE_UNIX) {
 		strbuf_add(sb, msg + start, ep - (msg + start));
-		return placeholder_len;
+		return;
 	}
 
 	/* parse tz */
@@ -526,31 +935,11 @@ static size_t format_person_part(struct strbuf *sb, char part,
 			tz = -tz;
 	}
 
-	switch (part) {
-	case 'd':	/* date */
+	if (part->argc)
+		strbuf_addstr(sb, show_date(date, tz, part->args[0].dmode));
+	else
 		strbuf_addstr(sb, show_date(date, tz, dmode));
-		return placeholder_len;
-	case 'D':	/* date, RFC2822 style */
-		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
-		return placeholder_len;
-	case 'r':	/* date, relative */
-		strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
-		return placeholder_len;
-	case 'i':	/* date, ISO 8601 */
-		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
-		return placeholder_len;
-	}
-
-skip:
-	/*
-	 * bogus commit, 'sb' cannot be updated, but we still need to
-	 * compute a valid return value.
-	 */
-	if (part == 'n' || part == 'e' || part == 't' || part == 'd'
-	    || part == 'D' || part == 'r' || part == 'i')
-		return placeholder_len;
-
-	return 0; /* unknown placeholder */
+	return;
 }
 
 struct chunk {
@@ -745,116 +1134,65 @@ static void rewrap_message_tail(struct strbuf *sb,
 	c->indent2 = new_indent2;
 }
 
-static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
-				void *context)
+void format_commit_message_part(struct format_part *part,
+				struct strbuf *sb, void *context)
 {
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
-	const char *msg = c->message;
+	const char *msg = commit->buffer;
 	struct commit_list *p;
-	int h1, h2;
+	unsigned long width = 0, indent1 = 0, indent2 = 0;
 
 	/* these are independent of the commit */
-	switch (placeholder[0]) {
-	case 'C':
-		if (placeholder[1] == '(') {
-			const char *end = strchr(placeholder + 2, ')');
-			char color[COLOR_MAXLEN];
-			if (!end || !color_parse_len(placeholder + 2,
-						     end - (placeholder + 2),
-						     color))
-				return 0;
-			strbuf_addstr(sb, color);
-			return end - placeholder + 1;
-		}
-		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, GIT_COLOR_RED);
-			return 4;
-		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, GIT_COLOR_GREEN);
-			return 6;
-		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, GIT_COLOR_BLUE);
-			return 5;
-		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, GIT_COLOR_RESET);
-			return 6;
-		} else
-			return 0;
-	case 'n':		/* newline */
-		strbuf_addch(sb, '\n');
-		return 1;
-	case 'x':
-		/* %x00 == NUL, %x0a == LF, etc. */
-		if (0 <= (h1 = hexval_table[0xff & placeholder[1]]) &&
-		    h1 <= 16 &&
-		    0 <= (h2 = hexval_table[0xff & placeholder[2]]) &&
-		    h2 <= 16) {
-			strbuf_addch(sb, (h1<<4)|h2);
-			return 3;
-		} else
-			return 0;
-	case 'w':
-		if (placeholder[1] == '(') {
-			unsigned long width = 0, indent1 = 0, indent2 = 0;
-			char *next;
-			const char *start = placeholder + 2;
-			const char *end = strchr(start, ')');
-			if (!end)
-				return 0;
-			if (end > start) {
-				width = strtoul(start, &next, 10);
-				if (*next == ',') {
-					indent1 = strtoul(next + 1, &next, 10);
-					if (*next == ',') {
-						indent2 = strtoul(next + 1,
-								 &next, 10);
-					}
-				}
-				if (*next != ')')
-					return 0;
-			}
-			rewrap_message_tail(sb, c, width, indent1, indent2);
-			return end - placeholder + 1;
-		} else
-			return 0;
+	switch (part->type) {
+	case FORMAT_PART_LITERAL:
+		strbuf_add(sb, part->literal, part->literal_len);
+		return;
+	case FORMAT_PART_WRAP:
+		width = (part->argc > 0) ? part->args[0].uint : 0;
+		indent1 = (part->argc > 1) ? part->args[1].uint : 0;
+		indent2 = (part->argc > 2) ? part->args[2].uint : 0;
+		rewrap_message_tail(sb, c, width, indent1, indent2);
+		return;
+	default:
+		break;
 	}
 
 	/* these depend on the commit */
 	if (!commit->object.parsed)
 		parse_object(commit->object.sha1);
 
-	switch (placeholder[0]) {
-	case 'H':		/* commit hash */
+	switch (part->type) {
+	case FORMAT_PART_COMMIT_HASH:
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
-		return 1;
-	case 'h':		/* abbreviated commit hash */
+		return;
+	case FORMAT_PART_COMMIT_HASH_ABBREV:
 		if (add_again(sb, &c->abbrev_commit_hash))
-			return 1;
+			return;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
-						     c->pretty_ctx->abbrev));
+					     c->pretty_ctx->abbrev));
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
-		return 1;
-	case 'T':		/* tree hash */
+		return;
+	case FORMAT_PART_TREE_HASH:
 		strbuf_addstr(sb, sha1_to_hex(commit->tree->object.sha1));
-		return 1;
-	case 't':		/* abbreviated tree hash */
+		return;
+	case FORMAT_PART_TREE_HASH_ABBREV:
 		if (add_again(sb, &c->abbrev_tree_hash))
-			return 1;
+			return;
 		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
 						     c->pretty_ctx->abbrev));
 		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
-		return 1;
-	case 'P':		/* parent hashes */
+		return;
+	case FORMAT_PART_PARENT_HASHES:
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, sha1_to_hex(p->item->object.sha1));
 		}
-		return 1;
-	case 'p':		/* abbreviated parent hashes */
+		return;
+	case FORMAT_PART_PARENT_HASHES_ABBREV:
 		if (add_again(sb, &c->abbrev_parent_hashes))
-			return 1;
+			return;
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
@@ -864,159 +1202,138 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		c->abbrev_parent_hashes.len = sb->len -
 		                              c->abbrev_parent_hashes.off;
-		return 1;
-	case 'm':		/* left/right/bottom */
+		return;
+	case FORMAT_PART_MARK:
 		strbuf_addch(sb, (commit->object.flags & BOUNDARY)
 		                 ? '-'
 		                 : (commit->object.flags & SYMMETRIC_LEFT)
 		                 ? '<'
 		                 : '>');
-		return 1;
-	case 'd':
+		return;
+	case FORMAT_PART_DECORATE:
 		format_decoration(sb, commit);
-		return 1;
-	case 'g':		/* reflog info */
-		switch(placeholder[1]) {
-		case 'd':	/* reflog selector */
-		case 'D':
-			if (c->pretty_ctx->reflog_info)
-				get_reflog_selector(sb,
-						    c->pretty_ctx->reflog_info,
-						    c->pretty_ctx->date_mode,
-						    (placeholder[1] == 'd'));
-			return 2;
-		case 's':	/* reflog message */
-			if (c->pretty_ctx->reflog_info)
-				get_reflog_message(sb, c->pretty_ctx->reflog_info);
-			return 2;
+		return;
+	case FORMAT_PART_REFLOG_SELECTOR:
+	case FORMAT_PART_REFLOG_SELECTOR_SHORT:
+		if (c->pretty_ctx->reflog_info) {
+			get_reflog_selector(sb,
+					    c->pretty_ctx->reflog_info,
+					    c->pretty_ctx->date_mode,
+					    (part->type == FORMAT_PART_REFLOG_SELECTOR_SHORT));
 		}
-		return 0;	/* unknown %g placeholder */
-	case 'N':
+		return;
+	case FORMAT_PART_REFLOG_SUBJECT:
+		if (c->pretty_ctx->reflog_info)
+			get_reflog_message(sb, c->pretty_ctx->reflog_info);
+		return;
+	case FORMAT_PART_NOTES:
 		if (c->pretty_ctx->show_notes) {
 			format_display_notes(commit->object.sha1, sb,
 				    get_log_output_encoding(), 0);
-			return 1;
 		}
-		return 0;
+		return;
+	default:
+		break;
 	}
 
 	/* For the rest we have to parse the commit header. */
 	if (!c->commit_header_parsed)
 		parse_commit_header(c);
 
-	switch (placeholder[0]) {
-	case 'a':	/* author ... */
-		return format_person_part(sb, placeholder[1],
-				   msg + c->author.off, c->author.len,
-				   c->pretty_ctx->date_mode);
-	case 'c':	/* committer ... */
-		return format_person_part(sb, placeholder[1],
-				   msg + c->committer.off, c->committer.len,
-				   c->pretty_ctx->date_mode);
-	case 'e':	/* encoding */
+	switch (part->type) {
+	case FORMAT_PART_AUTHOR_NAME:
+	case FORMAT_PART_AUTHOR_NAME_MAILMAP:
+	case FORMAT_PART_AUTHOR_EMAIL:
+	case FORMAT_PART_AUTHOR_EMAIL_MAILMAP:
+	case FORMAT_PART_AUTHOR_DATE:
+		format_person_part(sb, part, commit->buffer + c->author.off,
+				   c->author.len, c->pretty_ctx->date_mode);
+		return;
+	case FORMAT_PART_COMMITTER_NAME:
+	case FORMAT_PART_COMMITTER_NAME_MAILMAP:
+	case FORMAT_PART_COMMITTER_EMAIL:
+	case FORMAT_PART_COMMITTER_EMAIL_MAILMAP:
+	case FORMAT_PART_COMMITTER_DATE:
+		format_person_part(sb, part, commit->buffer + c->committer.off,
+				   c->committer.len, c->pretty_ctx->date_mode);
+		return;
+	case FORMAT_PART_ENCODING:
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
-		return 1;
-	case 'B':	/* raw body */
+		return;
+	case FORMAT_PART_RAW_BODY:
 		/* message_off is always left at the initial newline */
 		strbuf_addstr(sb, msg + c->message_off + 1);
-		return 1;
+		return;
+	default:
+		break;
 	}
 
 	/* Now we need to parse the commit message. */
 	if (!c->commit_message_parsed)
 		parse_commit_message(c);
 
-	switch (placeholder[0]) {
-	case 's':	/* subject */
+	switch (part->type) {
+	case FORMAT_PART_SUBJECT:
 		format_subject(sb, msg + c->subject_off, " ");
-		return 1;
-	case 'f':	/* sanitized subject */
+		return;
+	case FORMAT_PART_SUBJECT_SANITIZED:
 		format_sanitized_subject(sb, msg + c->subject_off);
-		return 1;
-	case 'b':	/* body */
+		return;
+	case FORMAT_PART_BODY:
 		strbuf_addstr(sb, msg + c->body_off);
-		return 1;
-	}
-	return 0;	/* unknown placeholder */
-}
-
-static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
-				 void *context)
-{
-	int consumed;
-	size_t orig_len;
-	enum {
-		NO_MAGIC,
-		ADD_LF_BEFORE_NON_EMPTY,
-		DEL_LF_BEFORE_EMPTY,
-		ADD_SP_BEFORE_NON_EMPTY
-	} magic = NO_MAGIC;
-
-	switch (placeholder[0]) {
-	case '-':
-		magic = DEL_LF_BEFORE_EMPTY;
-		break;
-	case '+':
-		magic = ADD_LF_BEFORE_NON_EMPTY;
-		break;
-	case ' ':
-		magic = ADD_SP_BEFORE_NON_EMPTY;
-		break;
+		return;
 	default:
 		break;
 	}
-	if (magic != NO_MAGIC)
-		placeholder++;
-
-	orig_len = sb->len;
-	consumed = format_commit_one(sb, placeholder, context);
-	if (magic == NO_MAGIC)
-		return consumed;
-
-	if ((orig_len == sb->len) && magic == DEL_LF_BEFORE_EMPTY) {
-		while (sb->len && sb->buf[sb->len - 1] == '\n')
-			strbuf_setlen(sb, sb->len - 1);
-	} else if (orig_len != sb->len) {
-		if (magic == ADD_LF_BEFORE_NON_EMPTY)
-			strbuf_insert(sb, orig_len, "\n", 1);
-		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
-			strbuf_insert(sb, orig_len, " ", 1);
-	}
-	return consumed + 1;
+	return;
 }
 
-static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
-				   void *context)
+void format_commit_message_parts(const struct format_parts *parsed,
+				 struct strbuf *sb, void *context)
 {
-	struct userformat_want *w = context;
+	size_t i, orig_len;
+	enum format_part_magic magic;
 
-	if (*placeholder == '+' || *placeholder == '-' || *placeholder == ' ')
-		placeholder++;
+	for (i = 0; i < parsed->len; i++) {
+		orig_len = sb->len;
+		magic = parsed->part[i].magic;
+		format_commit_message_part(&parsed->part[i], sb, context);
 
-	switch (*placeholder) {
-	case 'N':
-		w->notes = 1;
-		break;
+		if (magic == NO_MAGIC)
+			continue;
+
+		if ((orig_len == sb->len) && magic == DEL_LF_BEFORE_EMPTY) {
+			while (sb->len && sb->buf[sb->len - 1] == '\n')
+				strbuf_setlen(sb, sb->len - 1);
+		} else if (orig_len != sb->len) {
+			if (magic == ADD_LF_BEFORE_NON_EMPTY)
+				strbuf_insert(sb, orig_len, "\n", 1);
+			else if (magic == ADD_SP_BEFORE_NON_EMPTY)
+				strbuf_insert(sb, orig_len, " ", 1);
+		}
 	}
-	return 0;
 }
 
 void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 {
-	struct strbuf dummy = STRBUF_INIT;
+	struct format_parts *dummy;
 
 	if (!fmt) {
 		if (!user_format)
 			return;
-		fmt = user_format;
+		memcpy(w, &user_format->want, sizeof(*w));
+		return;
 	}
-	strbuf_expand(&dummy, user_format, userformat_want_item, w);
-	strbuf_release(&dummy);
+
+	dummy = parse_format(fmt);
+	memcpy(w, &dummy->want, sizeof(*w));
+	format_parts_free(&dummy);
 }
 
-void format_commit_message(const struct commit *commit,
-			   const char *format, struct strbuf *sb,
-			   const struct pretty_print_context *pretty_ctx)
+void format_commit_message_parsed(const struct commit *commit,
+				  const struct format_parts *parsed_format,
+				  struct strbuf *sb,
+				  const struct pretty_print_context *pretty_ctx)
 {
 	struct format_commit_context context;
 	static const char utf8[] = "UTF-8";
@@ -1035,13 +1352,32 @@ void format_commit_message(const struct commit *commit,
 			context.message = logmsg_reencode(commit, output_enc);
 	}
 
-	strbuf_expand(sb, format, format_commit_item, &context);
+	format_commit_message_parts(parsed_format, sb, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
 	if (context.message != commit->buffer)
 		free(context.message);
 }
 
+void format_commit_message(const struct commit *commit,
+			   const char *format, struct strbuf *sb,
+			   const struct pretty_print_context *pretty_ctx)
+{
+	static char *last = NULL;
+	static struct format_parts *parsed = NULL;
+
+	if( !parsed || strcmp(last, format) ){
+		if (parsed){
+			format_parts_free(&parsed);
+			free(last);
+		}
+		parsed = parse_format(format);
+		last = xstrdup(format);
+	}
+
+	format_commit_message_parsed(commit, parsed, sb, pretty_ctx);
+}
+
 static void pp_header(enum cmit_fmt fmt,
 		      int abbrev,
 		      enum date_mode dmode,
@@ -1198,7 +1534,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	int need_8bit_cte = context->need_8bit_cte;
 
 	if (fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, context);
+		format_commit_message_parsed(commit, user_format, sb, context);
 		return;
 	}
 
diff --git a/test-pretty.c b/test-pretty.c
new file mode 100644
index 0000000..57c1c65
--- /dev/null
+++ b/test-pretty.c
@@ -0,0 +1,232 @@
+#include <ctype.h>
+#include "cache.h"
+#include "utf8.h"
+#include "commit.h"
+
+static const char *usage_msg = "\n"
+"  test-pretty <format>\n"
+"  test-pretty -a\n"
+"  test-pretty -- <format>\n";
+
+static const char *all = "a"
+"%-h%+h% h"
+"%h%H%p%P%t%T"
+"%an%aN%ae%aE%ad%aD%ar%at%ai"
+"%cn%cN%ce%cE%cd%cD%cr%ct%ci"
+"%d%e%s%f%b%B%N"
+"%gD%gd%gs"
+"%Cred%Cgreen%Cblue%Creset%C(reset)"
+"%m%w()%w(1)%w(1,2)%w(1,2,3)"
+"%x0a%n%%%@";
+
+static struct strbuf *parts_debug(struct format_parts *parts,
+				  const char *unparsed)
+{
+	struct format_part *part;
+	struct strbuf *buf = xcalloc(1, sizeof(*buf));
+	size_t indent = 0;
+	struct {enum format_part_type type; char *label;} labels[] = {
+		{FORMAT_PART_LITERAL, "LITERAL"},
+		{FORMAT_PART_COMMIT_HASH, "COMMIT_HASH"},
+		{FORMAT_PART_COMMIT_HASH_ABBREV, "COMMIT_HASH_ABBREV"},
+		{FORMAT_PART_PARENT_HASHES, "PARENT_HASHES"},
+		{FORMAT_PART_PARENT_HASHES_ABBREV, "PARENT_HASHES_ABBREV"},
+		{FORMAT_PART_TREE_HASH, "TREE_HASH"},
+		{FORMAT_PART_TREE_HASH_ABBREV, "TREE_HASH_ABBREV"},
+		{FORMAT_PART_AUTHOR_NAME, "AUTHOR_NAME"},
+		{FORMAT_PART_AUTHOR_NAME_MAILMAP, "AUTHOR_NAME_MAILMAP"},
+		{FORMAT_PART_AUTHOR_EMAIL, "AUTHOR_EMAIL"},
+		{FORMAT_PART_AUTHOR_EMAIL_MAILMAP, "AUTHOR_EMAIL_MAILMAP"},
+		{FORMAT_PART_AUTHOR_DATE, "AUTHOR_DATE"},
+		{FORMAT_PART_COMMITTER_NAME, "COMMITTER_NAME"},
+		{FORMAT_PART_COMMITTER_NAME_MAILMAP, "COMMITTER_NAME_MAILMAP"},
+		{FORMAT_PART_COMMITTER_EMAIL, "COMMITTER_EMAIL"},
+		{FORMAT_PART_COMMITTER_EMAIL_MAILMAP, "COMMITTER_EMAIL_MAILMAP"},
+		{FORMAT_PART_COMMITTER_DATE, "COMMITTER_DATE"},
+
+		{FORMAT_PART_DECORATE, "DECORATE"},
+		{FORMAT_PART_ENCODING, "ENCODING"},
+		{FORMAT_PART_SUBJECT, "SUBJECT"},
+		{FORMAT_PART_SUBJECT_SANITIZED, "SUBJECT_SANITIZED"},
+		{FORMAT_PART_BODY, "BODY"},
+		{FORMAT_PART_RAW_BODY, "RAW_BODY"},
+		{FORMAT_PART_NOTES, "NOTES"},
+
+		{FORMAT_PART_REFLOG_SELECTOR, "REFLOG_SELECTOR"},
+		{FORMAT_PART_REFLOG_SELECTOR_SHORT, "REFLOG_SELECTOR_SHORT"},
+		{FORMAT_PART_REFLOG_SUBJECT, "REFLOG_SUBJECT"},
+
+		{FORMAT_PART_MARK, "MARK"},
+		{FORMAT_PART_WRAP, "WRAP"}
+	};
+	char *label;
+	size_t i,j,t = 0;
+	strbuf_init(buf, 0);
+
+	strbuf_add_wrapped_text(buf, "{[PARTS:", indent++, 0, 0);
+	strbuf_addf(buf, "%li]\n", parts->len);
+	strbuf_add_wrapped_text(buf, "[FORMAT:", indent, 0, 0);
+	strbuf_addf(buf, "%s]\n", unparsed);
+	strbuf_add_wrapped_text(buf, "(REMADE:", indent, 0, 0);
+	for (i = 0; i < parts->len; i++) {
+		strbuf_add(buf, unparsed + t, parts->part[i].format_len);
+		t += parts->part[i].format_len;
+	}
+	strbuf_addstr(buf, ")\n");
+
+	for (i = 0; i < parts->len; i++) {
+		part = &parts->part[i];
+		label = "UNKNOWN";
+		for (j = 0; j < ARRAY_SIZE(labels); j++) {
+			if (labels[j].type == part->type) {
+				label = labels[j].label;
+			}
+		}
+
+		strbuf_add_wrapped_text(buf, "{[", indent, 0, 0);
+		strbuf_add(buf, unparsed, part->format_len);
+		unparsed += part->format_len;
+		strbuf_add(buf, "] ", 2);
+		strbuf_addstr(buf, label);
+
+		switch(part->magic){
+		case NO_MAGIC:
+			break;
+		case ADD_LF_BEFORE_NON_EMPTY:
+			strbuf_addstr(buf, " (ADD_LF_BEFORE_NON_EMPTY)");
+			break;
+		case DEL_LF_BEFORE_EMPTY:
+			strbuf_addstr(buf, " (DEL_LF_BEFORE_EMPTY)");
+			break;
+		case ADD_SP_BEFORE_NON_EMPTY:
+			strbuf_addstr(buf, " (ADD_SP_BEFORE_NON_EMPTY)");
+			break;
+		}
+
+		if (part->literal) {
+			strbuf_addstr(buf, " \"");
+			t = 0;
+			while (t < part->literal_len) {
+				switch (part->literal[t]) {
+				case '\n':
+					strbuf_addstr(buf, "\\n");
+					break;
+				case '\r':
+					strbuf_addstr(buf, "\\r");
+					break;
+				case '\t':
+					strbuf_addstr(buf, "\\t");
+					break;
+				case '\\':
+					strbuf_addstr(buf, "\\\\");
+					break;
+				default:
+					if (isprint(part->literal[t]))
+						strbuf_add(buf, &part->literal[t],
+							   1);
+					else
+						strbuf_addf(buf, "\\x%02x",
+							    part->literal[t]);
+					break;
+				}
+				t++;
+			}
+			strbuf_addstr(buf, "\"");
+		}
+
+		if (part->argc) {
+			strbuf_addstr(buf, "\n");
+			strbuf_add_wrapped_text(buf, "ARGS: [", indent+1, 0, 0);
+			for (j = 0; j < part->argc; j++) {
+				switch(part->args[j].type){
+				case FORMAT_ARG_UINT:
+					strbuf_addstr(buf, "UINT:");
+					strbuf_addf(buf, "%lu", part->args[j].uint);
+					break;
+				case FORMAT_ARG_DATE_MODE:
+					strbuf_addstr(buf, "DATE_MODE:");
+					switch(part->args[j].dmode){
+					case DATE_NORMAL:
+						strbuf_addstr(buf, "DATE_NORMAL");
+						break;
+					case DATE_RELATIVE:
+						strbuf_addstr(buf, "DATE_RELATIVE");
+						break;
+					case DATE_SHORT:
+						strbuf_addstr(buf, "DATE_SHORT");
+						break;
+					case DATE_LOCAL:
+						strbuf_addstr(buf, "DATE_LOCAL");
+						break;
+					case DATE_ISO8601:
+						strbuf_addstr(buf, "DATE_ISO8601");
+						break;
+					case DATE_RFC2822:
+						strbuf_addstr(buf, "DATE_RFC2822");
+						break;
+					case DATE_RAW:
+						strbuf_addstr(buf, "DATE_RAW");
+						break;
+					case DATE_UNIX:
+						strbuf_addstr(buf, "DATE_UNIX");
+						break;
+					default:
+						strbuf_addf(buf, "(UNKNOWN:%u)",
+							    part->args[j].dmode);
+						break;
+					}
+					break;
+				default:
+					strbuf_addstr(buf, "(UNKNOWN)");
+					break;
+				}
+
+				if (j < part->argc - 1)
+					strbuf_addstr(buf, ", ");
+			}
+			strbuf_addstr(buf, "]\n");
+		}
+
+		if (part->argc)
+			strbuf_add_wrapped_text(buf, "}\n", indent, 0, 0);
+		else
+			strbuf_addstr(buf, "}\n");
+	}
+	strbuf_add_wrapped_text(buf, "}\n", --indent, 0, 0);
+
+	if (!indent) {
+		printf("%s", buf->buf);
+		strbuf_release(buf);
+		free(buf);
+		return NULL;
+	}
+	return buf;
+}
+
+int main(int argc, char **argv)
+{
+	const char *unparsed = NULL;
+	struct format_parts *parsed;
+
+	if (argc < 2) {
+		usage(usage_msg);
+		return 1;
+	}
+
+	if (*argv[1] == '-') {
+		if (argv[1][1] == 'a' && argc == 2)
+			unparsed = all;
+		if (argv[1][1] == '-' && !argv[1][2] && argc == 3)
+			unparsed = argv[2];
+	} else
+		unparsed = argv[1];
+
+	if (!unparsed) {
+		usage(usage_msg);
+		return 1;
+	}
+
+	parsed = parse_format(unparsed);
+	parts_debug(parsed, unparsed);
+	return 0;
+}
-- 
1.7.4.2
