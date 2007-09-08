From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/3] Rework pretty_print_commit to use strbufs instead of custom buffers.
Date: Sat,  8 Sep 2007 13:53:19 +0200
Message-ID: <11892523992038-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11892523992761-git-send-email-madcoder@debian.org>
 <1189252399433-git-send-email-madcoder@debian.org>
 <1189252399316-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 13:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITysV-0006v1-KI
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 13:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXIHLx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 07:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbXIHLx0
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 07:53:26 -0400
Received: from pan.madism.org ([88.191.52.104]:57497 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbXIHLxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 07:53:21 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 062EC1E9D0;
	Sat,  8 Sep 2007 13:53:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3F5BF142999; Sat,  8 Sep 2007 13:53:19 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <1189252399316-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58119>

  Also remove the "len" parameter, as:
  (1) it was used as a max boundary, and every caller used ~0u
  (2) we check for final NUL no matter what, so it doesn't help for speed.

  As a result most of the pp_* function takes 3 arguments less, and we need
a lot less local variables, this makes the code way more readable, and
easier to extend if needed.

  This patch also fixes some spacing and cosmetic issues.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-branch.c      |   15 +--
 builtin-log.c         |   12 +-
 builtin-rev-list.c    |   13 +-
 builtin-show-branch.c |   13 +-
 commit.c              |  330 ++++++++++++++++++-------------------------------
 commit.h              |    6 +-
 log-tree.c            |   56 +++------
 7 files changed, 171 insertions(+), 274 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 5f5c182..68cd5f9 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -268,23 +268,22 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 
 	if (verbose) {
-		char *subject = NULL;
-		unsigned long subject_len = 0;
+		struct strbuf subject;
 		const char *sub = " **** invalid ref ****";
 
+		strbuf_init(&subject);
+
 		commit = lookup_commit(item->sha1);
 		if (commit && !parse_commit(commit)) {
-			pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-					    &subject, &subject_len, 0,
-					    NULL, NULL, 0);
-			sub = subject;
+			pretty_print_commit(CMIT_FMT_ONELINE, commit,
+					    &subject, 0, NULL, NULL, 0);
+			sub = subject.buf;
 		}
 		printf("%c %s%-*s%s %s %s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
 		       branch_get_color(COLOR_BRANCH_RESET),
 		       find_unique_abbrev(item->sha1, abbrev), sub);
-		if (subject)
-			free(subject);
+		strbuf_release(&subject);
 	} else {
 		printf("%c %s%s%s\n", c, branch_get_color(color), item->name,
 		       branch_get_color(COLOR_BRANCH_RESET));
diff --git a/builtin-log.c b/builtin-log.c
index fa81c25..21b35a1 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -763,13 +763,13 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			sign = '-';
 
 		if (verbose) {
-			char *buf = NULL;
-			unsigned long buflen = 0;
-			pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-			                    &buf, &buflen, 0, NULL, NULL, 0);
+			struct strbuf buf;
+			strbuf_init(&buf);
+			pretty_print_commit(CMIT_FMT_ONELINE, commit,
+			                    &buf, 0, NULL, NULL, 0);
 			printf("%c %s %s\n", sign,
-			       sha1_to_hex(commit->object.sha1), buf);
-			free(buf);
+			       sha1_to_hex(commit->object.sha1), buf.buf);
+			strbuf_release(&buf);
 		}
 		else {
 			printf("%c %s\n", sign,
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index ac551d5..7967f86 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -80,13 +80,12 @@ static void show_commit(struct commit *commit)
 		putchar('\n');
 
 	if (revs.verbose_header) {
-		char *buf = NULL;
-		unsigned long buflen = 0;
-		pretty_print_commit(revs.commit_format, commit, ~0,
-				    &buf, &buflen,
-				    revs.abbrev, NULL, NULL, revs.date_mode);
-		printf("%s%c", buf, hdr_termination);
-		free(buf);
+		struct strbuf buf;
+		strbuf_init(&buf);
+		pretty_print_commit(revs.commit_format, commit,
+					&buf, revs.abbrev, NULL, NULL, revs.date_mode);
+		printf("%s%c", buf.buf, hdr_termination);
+		strbuf_release(&buf);
 	}
 	maybe_flush_or_die(stdout, "stdout");
 	if (commit->parents) {
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 4fa87f6..020116f 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -259,16 +259,15 @@ static void join_revs(struct commit_list **list_p,
 
 static void show_one_commit(struct commit *commit, int no_name)
 {
-	char *pretty = NULL;
+	struct strbuf pretty;
 	const char *pretty_str = "(unavailable)";
-	unsigned long pretty_len = 0;
 	struct commit_name *name = commit->util;
 
+	strbuf_init(&pretty);
 	if (commit->object.parsed) {
-		pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-				    &pretty, &pretty_len,
-				    0, NULL, NULL, 0);
-		pretty_str = pretty;
+		pretty_print_commit(CMIT_FMT_ONELINE, commit,
+					&pretty, 0, NULL, NULL, 0);
+		pretty_str = pretty.buf;
 	}
 	if (!prefixcmp(pretty_str, "[PATCH] "))
 		pretty_str += 8;
@@ -289,7 +288,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 			       find_unique_abbrev(commit->object.sha1, 7));
 	}
 	puts(pretty_str);
-	free(pretty);
+	strbuf_release(&pretty);
 }
 
 static char *ref_name[MAX_REVS + 1];
diff --git a/commit.c b/commit.c
index 30db9f4..dafa821 100644
--- a/commit.c
+++ b/commit.c
@@ -458,11 +458,11 @@ void clear_commit_marks(struct commit *commit, unsigned int mark)
 /*
  * Generic support for pretty-printing the header
  */
-static int get_one_line(const char *msg, unsigned long len)
+static int get_one_line(const char *msg)
 {
 	int ret = 0;
 
-	while (len--) {
+	for (;;) {
 		char c = *msg++;
 		if (!c)
 			break;
@@ -485,31 +485,24 @@ static int is_rfc2047_special(char ch)
 	return (non_ascii(ch) || (ch == '=') || (ch == '?') || (ch == '_'));
 }
 
-static int add_rfc2047(char *buf, const char *line, int len,
+static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 		       const char *encoding)
 {
-	char *bp = buf;
-	int i, needquote;
-	char q_encoding[128];
-	const char *q_encoding_fmt = "=?%s?q?";
+	int i, last;
 
-	for (i = needquote = 0; !needquote && i < len; i++) {
+	for (i = 0; i < len; i++) {
 		int ch = line[i];
 		if (non_ascii(ch))
-			needquote++;
-		if ((i + 1 < len) &&
-		    (ch == '=' && line[i+1] == '?'))
-			needquote++;
+			goto needquote;
+		if ((i + 1 < len) && (ch == '=' && line[i+1] == '?'))
+			goto needquote;
 	}
-	if (!needquote)
-		return sprintf(buf, "%.*s", len, line);
-
-	i = snprintf(q_encoding, sizeof(q_encoding), q_encoding_fmt, encoding);
-	if (sizeof(q_encoding) < i)
-		die("Insanely long encoding name %s", encoding);
-	memcpy(bp, q_encoding, i);
-	bp += i;
-	for (i = 0; i < len; i++) {
+	strbuf_add(sb, line, len);
+	return;
+
+needquote:
+	strbuf_addf(sb, "=?%s?q?", encoding);
+	for (i = last = 0; i < len; i++) {
 		unsigned ch = line[i] & 0xFF;
 		/*
 		 * We encode ' ' using '=20' even though rfc2047
@@ -518,15 +511,13 @@ static int add_rfc2047(char *buf, const char *line, int len,
 		 * leave the underscore in place.
 		 */
 		if (is_rfc2047_special(ch) || ch == ' ') {
-			sprintf(bp, "=%02X", ch);
-			bp += 3;
+			strbuf_add(sb, line + last, i - last);
+			strbuf_addf(sb, "=%02X", ch);
+			last = i + 1;
 		}
-		else
-			*bp++ = ch;
 	}
-	memcpy(bp, "?=", 2);
-	bp += 2;
-	return bp - buf;
+	strbuf_add(sb, line + last, len - last);
+	strbuf_addstr(sb, "?=");
 }
 
 static unsigned long bound_rfc2047(unsigned long len, const char *encoding)
@@ -537,21 +528,21 @@ static unsigned long bound_rfc2047(unsigned long len, const char *encoding)
 	return len * 3 + elen + 100;
 }
 
-static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
+static void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 			 const char *line, enum date_mode dmode,
 			 const char *encoding)
 {
 	char *date;
 	int namelen;
 	unsigned long time;
-	int tz, ret;
+	int tz;
 	const char *filler = "    ";
 
 	if (fmt == CMIT_FMT_ONELINE)
-		return 0;
+		return;
 	date = strchr(line, '>');
 	if (!date)
-		return 0;
+		return;
 	namelen = ++date - line;
 	time = strtoul(date, &date, 10);
 	tz = strtol(date, NULL, 10);
@@ -560,42 +551,35 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 		char *name_tail = strchr(line, '<');
 		int display_name_length;
 		if (!name_tail)
-			return 0;
+			return;
 		while (line < name_tail && isspace(name_tail[-1]))
 			name_tail--;
 		display_name_length = name_tail - line;
 		filler = "";
-		strcpy(buf, "From: ");
-		ret = strlen(buf);
-		ret += add_rfc2047(buf + ret, line, display_name_length,
-				   encoding);
-		memcpy(buf + ret, name_tail, namelen - display_name_length);
-		ret += namelen - display_name_length;
-		buf[ret++] = '\n';
+		strbuf_addstr(sb, "From: ");
+		add_rfc2047(sb, line, display_name_length, encoding);
+		strbuf_add(sb, name_tail, namelen - display_name_length);
+		strbuf_addch(sb, '\n');
 	}
 	else {
-		ret = sprintf(buf, "%s: %.*s%.*s\n", what,
+		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
 			      (fmt == CMIT_FMT_FULLER) ? 4 : 0,
 			      filler, namelen, line);
 	}
 	switch (fmt) {
 	case CMIT_FMT_MEDIUM:
-		ret += sprintf(buf + ret, "Date:   %s\n",
-			       show_date(time, tz, dmode));
+		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, dmode));
 		break;
 	case CMIT_FMT_EMAIL:
-		ret += sprintf(buf + ret, "Date: %s\n",
-			       show_date(time, tz, DATE_RFC2822));
+		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
 		break;
 	case CMIT_FMT_FULLER:
-		ret += sprintf(buf + ret, "%sDate: %s\n", what,
-			       show_date(time, tz, dmode));
+		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, dmode));
 		break;
 	default:
 		/* notin' */
 		break;
 	}
-	return ret;
 }
 
 static int is_empty_line(const char *line, int *len_p)
@@ -607,16 +591,16 @@ static int is_empty_line(const char *line, int *len_p)
 	return !len;
 }
 
-static int add_merge_info(enum cmit_fmt fmt, char *buf, const struct commit *commit, int abbrev)
+static void add_merge_info(enum cmit_fmt fmt, struct strbuf *sb,
+			const struct commit *commit, int abbrev)
 {
 	struct commit_list *parent = commit->parents;
-	int offset;
 
 	if ((fmt == CMIT_FMT_ONELINE) || (fmt == CMIT_FMT_EMAIL) ||
 	    !parent || !parent->next)
-		return 0;
+		return;
 
-	offset = sprintf(buf, "Merge:");
+	strbuf_addstr(sb, "Merge:");
 
 	while (parent) {
 		struct commit *p = parent->item;
@@ -629,10 +613,9 @@ static int add_merge_info(enum cmit_fmt fmt, char *buf, const struct commit *com
 		dots = (abbrev && strlen(hex) != 40) ?  "..." : "";
 		parent = parent->next;
 
-		offset += sprintf(buf + offset, " %s%s", hex, dots);
+		strbuf_addf(sb, " %s%s", hex, dots);
 	}
-	buf[offset++] = '\n';
-	return offset;
+	strbuf_addch(sb, '\n');
 }
 
 static char *get_header(const struct commit *commit, const char *key)
@@ -787,8 +770,8 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
 }
 
-static long format_commit_message(const struct commit *commit,
-		const char *msg, char **buf_p, unsigned long *space_p)
+static void format_commit_message(const struct commit *commit,
+		const char *msg, struct strbuf *sb)
 {
 	struct interp table[] = {
 		{ "%H" },	/* commit hash */
@@ -841,6 +824,7 @@ static long format_commit_message(const struct commit *commit,
 	};
 	struct commit_list *p;
 	char parents[1024];
+	unsigned long len;
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
 
@@ -920,20 +904,15 @@ static long format_commit_message(const struct commit *commit,
 		if (!table[i].value)
 			interp_set_entry(table, i, "<unknown>");
 
-	do {
-		char *buf = *buf_p;
-		unsigned long len;
-
-		len = interpolate(buf, *space_p, user_format,
-				    table, ARRAY_SIZE(table));
-		if (len < *space_p)
-			break;
-		ALLOC_GROW(buf, len + 1, *space_p);
-		*buf_p = buf;
-	} while (1);
+	len = interpolate(sb->buf + sb->len, strbuf_avail(sb),
+				user_format, table, ARRAY_SIZE(table));
+	if (len > strbuf_avail(sb)) {
+		strbuf_grow(sb, len);
+		interpolate(sb->buf + sb->len, strbuf_avail(sb) + 1,
+					user_format, table, ARRAY_SIZE(table));
+	}
+	strbuf_setlen(sb, sb->len + len);
 	interp_clear_table(table, ARRAY_SIZE(table));
-
-	return strlen(*buf_p);
 }
 
 static void pp_header(enum cmit_fmt fmt,
@@ -942,34 +921,24 @@ static void pp_header(enum cmit_fmt fmt,
 		      const char *encoding,
 		      const struct commit *commit,
 		      const char **msg_p,
-		      unsigned long *len_p,
-		      unsigned long *ofs_p,
-		      char **buf_p,
-		      unsigned long *space_p)
+		      struct strbuf *sb)
 {
 	int parents_shown = 0;
 
 	for (;;) {
 		const char *line = *msg_p;
-		char *dst;
-		int linelen = get_one_line(*msg_p, *len_p);
-		unsigned long len;
+		int linelen = get_one_line(*msg_p);
 
 		if (!linelen)
 			return;
 		*msg_p += linelen;
-		*len_p -= linelen;
 
 		if (linelen == 1)
 			/* End of header */
 			return;
 
-		ALLOC_GROW(*buf_p, linelen + *ofs_p + 20, *space_p);
-		dst = *buf_p + *ofs_p;
-
 		if (fmt == CMIT_FMT_RAW) {
-			memcpy(dst, line, linelen);
-			*ofs_p += linelen;
+			strbuf_add(sb, line, linelen);
 			continue;
 		}
 
@@ -987,10 +956,8 @@ static void pp_header(enum cmit_fmt fmt,
 			     parent = parent->next, num++)
 				;
 			/* with enough slop */
-			num = *ofs_p + num * 50 + 20;
-			ALLOC_GROW(*buf_p, num, *space_p);
-			dst = *buf_p + *ofs_p;
-			*ofs_p += add_merge_info(fmt, dst, commit, abbrev);
+			strbuf_grow(sb, num * 50 + 20);
+			add_merge_info(fmt, sb, commit, abbrev);
 			parents_shown = 1;
 		}
 
@@ -1000,129 +967,100 @@ static void pp_header(enum cmit_fmt fmt,
 		 * FULLER shows both authors and dates.
 		 */
 		if (!memcmp(line, "author ", 7)) {
-			len = linelen;
+			unsigned long len = linelen;
 			if (fmt == CMIT_FMT_EMAIL)
 				len = bound_rfc2047(linelen, encoding);
-			ALLOC_GROW(*buf_p, *ofs_p + len + 80, *space_p);
-			dst = *buf_p + *ofs_p;
-			*ofs_p += add_user_info("Author", fmt, dst,
-						line + 7, dmode, encoding);
+			strbuf_grow(sb, len + 80);
+			add_user_info("Author", fmt, sb, line + 7, dmode, encoding);
 		}
 
 		if (!memcmp(line, "committer ", 10) &&
 		    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER)) {
-			len = linelen;
+			unsigned long len = linelen;
 			if (fmt == CMIT_FMT_EMAIL)
 				len = bound_rfc2047(linelen, encoding);
-			ALLOC_GROW(*buf_p, *ofs_p + len + 80, *space_p);
-			dst = *buf_p + *ofs_p;
-			*ofs_p += add_user_info("Commit", fmt, dst,
-						line + 10, dmode, encoding);
+			strbuf_grow(sb, len + 80);
+			add_user_info("Commit", fmt, sb, line + 10, dmode, encoding);
 		}
 	}
 }
 
 static void pp_title_line(enum cmit_fmt fmt,
 			  const char **msg_p,
-			  unsigned long *len_p,
-			  unsigned long *ofs_p,
-			  char **buf_p,
-			  unsigned long *space_p,
-			  int indent,
+			  struct strbuf *sb,
 			  const char *subject,
 			  const char *after_subject,
 			  const char *encoding,
 			  int plain_non_ascii)
 {
-	char *title;
-	unsigned long title_alloc, title_len;
+	struct strbuf title;
 	unsigned long len;
 
-	title_len = 0;
-	title_alloc = 80;
-	title = xmalloc(title_alloc);
+	strbuf_init(&title);
+	strbuf_grow(&title, 80);
+
 	for (;;) {
 		const char *line = *msg_p;
-		int linelen = get_one_line(line, *len_p);
-		*msg_p += linelen;
-		*len_p -= linelen;
+		int linelen = get_one_line(line);
 
+		*msg_p += linelen;
 		if (!linelen || is_empty_line(line, &linelen))
 			break;
 
-		if (title_alloc <= title_len + linelen + 2) {
-			title_alloc = title_len + linelen + 80;
-			title = xrealloc(title, title_alloc);
-		}
-		len = 0;
-		if (title_len) {
+		strbuf_grow(&title, linelen + 2);
+		if (title.len) {
 			if (fmt == CMIT_FMT_EMAIL) {
-				len++;
-				title[title_len++] = '\n';
+				strbuf_addch(&title, '\n');
 			}
-			len++;
-			title[title_len++] = ' ';
+			strbuf_addch(&title, ' ');
 		}
-		memcpy(title + title_len, line, linelen);
-		title_len += linelen;
+		strbuf_add(&title, line, linelen);
 	}
 
 	/* Enough slop for the MIME header and rfc2047 */
-	len = bound_rfc2047(title_len, encoding)+ 1000;
+	len = bound_rfc2047(title.len, encoding) + 1000;
 	if (subject)
 		len += strlen(subject);
 	if (after_subject)
 		len += strlen(after_subject);
 	if (encoding)
 		len += strlen(encoding);
-	ALLOC_GROW(*buf_p, title_len + *ofs_p + len, *space_p);
 
+	strbuf_grow(sb, title.len + len);
 	if (subject) {
-		len = strlen(subject);
-		memcpy(*buf_p + *ofs_p, subject, len);
-		*ofs_p += len;
-		*ofs_p += add_rfc2047(*buf_p + *ofs_p,
-				      title, title_len, encoding);
+		strbuf_addstr(sb, subject);
+		add_rfc2047(sb, title.buf, title.len, encoding);
 	} else {
-		memcpy(*buf_p + *ofs_p, title, title_len);
-		*ofs_p += title_len;
+		strbuf_addbuf(sb, &title);
 	}
-	(*buf_p)[(*ofs_p)++] = '\n';
+	strbuf_addch(sb, '\n');
+
 	if (plain_non_ascii) {
 		const char *header_fmt =
 			"MIME-Version: 1.0\n"
 			"Content-Type: text/plain; charset=%s\n"
 			"Content-Transfer-Encoding: 8bit\n";
-		*ofs_p += snprintf(*buf_p + *ofs_p,
-				   *space_p - *ofs_p,
-				   header_fmt, encoding);
+		strbuf_addf(sb, header_fmt, encoding);
 	}
 	if (after_subject) {
-		len = strlen(after_subject);
-		memcpy(*buf_p + *ofs_p, after_subject, len);
-		*ofs_p += len;
+		strbuf_addstr(sb, after_subject);
 	}
-	free(title);
 	if (fmt == CMIT_FMT_EMAIL) {
-		ALLOC_GROW(*buf_p, *ofs_p + 20, *space_p);
-		(*buf_p)[(*ofs_p)++] = '\n';
+		strbuf_addch(sb, '\n');
 	}
+	strbuf_release(&title);
 }
 
 static void pp_remainder(enum cmit_fmt fmt,
 			 const char **msg_p,
-			 unsigned long *len_p,
-			 unsigned long *ofs_p,
-			 char **buf_p,
-			 unsigned long *space_p,
+			 struct strbuf *sb,
 			 int indent)
 {
 	int first = 1;
 	for (;;) {
 		const char *line = *msg_p;
-		int linelen = get_one_line(line, *len_p);
+		int linelen = get_one_line(line);
 		*msg_p += linelen;
-		*len_p -= linelen;
 
 		if (!linelen)
 			break;
@@ -1135,36 +1073,30 @@ static void pp_remainder(enum cmit_fmt fmt,
 		}
 		first = 0;
 
-		ALLOC_GROW(*buf_p, *ofs_p + linelen + indent + 20, *space_p);
+		strbuf_grow(sb, linelen + indent + 20);
 		if (indent) {
-			memset(*buf_p + *ofs_p, ' ', indent);
-			*ofs_p += indent;
+			memset(sb->buf + sb->len, ' ', indent);
+			strbuf_setlen(sb, sb->len + indent);
 		}
-		memcpy(*buf_p + *ofs_p, line, linelen);
-		*ofs_p += linelen;
-		(*buf_p)[(*ofs_p)++] = '\n';
+		strbuf_add(sb, line, linelen);
+		strbuf_addch(sb, '\n');
 	}
 }
 
-unsigned long pretty_print_commit(enum cmit_fmt fmt,
-				  const struct commit *commit,
-				  unsigned long len,
-				  char **buf_p, unsigned long *space_p,
-				  int abbrev, const char *subject,
-				  const char *after_subject,
+void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
+				  struct strbuf *sb, int abbrev,
+				  const char *subject, const char *after_subject,
 				  enum date_mode dmode)
 {
-	unsigned long offset = 0;
 	unsigned long beginning_of_body;
 	int indent = 4;
 	const char *msg = commit->buffer;
 	int plain_non_ascii = 0;
 	char *reencoded;
 	const char *encoding;
-	char *buf;
 
 	if (fmt == CMIT_FMT_USERFORMAT)
-		return format_commit_message(commit, msg, buf_p, space_p);
+		return format_commit_message(commit, msg, sb);
 
 	encoding = (git_log_output_encoding
 		    ? git_log_output_encoding
@@ -1174,7 +1106,6 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	reencoded = logmsg_reencode(commit, encoding);
 	if (reencoded) {
 		msg = reencoded;
-		len = strlen(reencoded);
 	}
 
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
@@ -1189,14 +1120,13 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	if (fmt == CMIT_FMT_EMAIL && !after_subject) {
 		int i, ch, in_body;
 
-		for (in_body = i = 0; (ch = msg[i]) && i < len; i++) {
+		for (in_body = i = 0; (ch = msg[i]); i++) {
 			if (!in_body) {
 				/* author could be non 7-bit ASCII but
 				 * the log may be so; skip over the
 				 * header part first.
 				 */
-				if (ch == '\n' &&
-				    i + 1 < len && msg[i+1] == '\n')
+				if (ch == '\n' && msg[i+1] == '\n')
 					in_body = 1;
 			}
 			else if (non_ascii(ch)) {
@@ -1206,59 +1136,44 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 		}
 	}
 
-	pp_header(fmt, abbrev, dmode, encoding,
-		  commit, &msg, &len,
-		  &offset, buf_p, space_p);
+	pp_header(fmt, abbrev, dmode, encoding, commit, &msg, sb);
 	if (fmt != CMIT_FMT_ONELINE && !subject) {
-		ALLOC_GROW(*buf_p, offset + 20, *space_p);
-		(*buf_p)[offset++] = '\n';
+		strbuf_addch(sb, '\n');
 	}
 
 	/* Skip excess blank lines at the beginning of body, if any... */
 	for (;;) {
-		int linelen = get_one_line(msg, len);
+		int linelen = get_one_line(msg);
 		int ll = linelen;
 		if (!linelen)
 			break;
 		if (!is_empty_line(msg, &ll))
 			break;
 		msg += linelen;
-		len -= linelen;
 	}
 
 	/* These formats treat the title line specially. */
-	if (fmt == CMIT_FMT_ONELINE
-	    || fmt == CMIT_FMT_EMAIL)
-		pp_title_line(fmt, &msg, &len, &offset,
-			      buf_p, space_p, indent,
-			      subject, after_subject, encoding,
-			      plain_non_ascii);
-
-	beginning_of_body = offset;
-	if (fmt != CMIT_FMT_ONELINE)
-		pp_remainder(fmt, &msg, &len, &offset,
-			     buf_p, space_p, indent);
-
-	while (offset && isspace((*buf_p)[offset-1]))
-		offset--;
+	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
+		pp_title_line(fmt, &msg, sb, subject,
+			      after_subject, encoding, plain_non_ascii);
 
-	ALLOC_GROW(*buf_p, offset + 20, *space_p);
-	buf = *buf_p;
+	beginning_of_body = sb->len;
+	if (fmt != CMIT_FMT_ONELINE)
+		pp_remainder(fmt, &msg, sb, indent);
+	strbuf_rtrim(sb);
 
 	/* Make sure there is an EOLN for the non-oneline case */
 	if (fmt != CMIT_FMT_ONELINE)
-		buf[offset++] = '\n';
+		strbuf_addch(sb, '\n');
 
 	/*
 	 * The caller may append additional body text in e-mail
 	 * format.  Make sure we did not strip the blank line
 	 * between the header and the body.
 	 */
-	if (fmt == CMIT_FMT_EMAIL && offset <= beginning_of_body)
-		buf[offset++] = '\n';
-	buf[offset] = '\0';
+	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
+		strbuf_addch(sb, '\n');
 	free(reencoded);
-	return offset;
 }
 
 struct commit *pop_commit(struct commit_list **stack)
@@ -1337,12 +1252,12 @@ void sort_in_topological_order_fn(struct commit_list ** list, int lifo,
 		next=next->next;
 	}
 	/*
-         * find the tips
-         *
-         * tips are nodes not reachable from any other node in the list
-         *
-         * the tips serve as a starting set for the work queue.
-         */
+	 * find the tips
+	 *
+	 * tips are nodes not reachable from any other node in the list
+	 *
+	 * the tips serve as a starting set for the work queue.
+	 */
 	next=*list;
 	insert = &work;
 	while (next) {
@@ -1369,9 +1284,9 @@ void sort_in_topological_order_fn(struct commit_list ** list, int lifo,
 			if (pn) {
 				/*
 				 * parents are only enqueued for emission
-                                 * when all their children have been emitted thereby
-                                 * guaranteeing topological order.
-                                 */
+				 * when all their children have been emitted thereby
+				 * guaranteeing topological order.
+				 */
 				pn->indegree--;
 				if (!pn->indegree) {
 					if (!lifo)
@@ -1383,9 +1298,9 @@ void sort_in_topological_order_fn(struct commit_list ** list, int lifo,
 			parents=parents->next;
 		}
 		/*
-                 * work_item is a commit all of whose children
-                 * have already been emitted. we can emit it now.
-                 */
+		 * work_item is a commit all of whose children
+		 * have already been emitted. we can emit it now.
+		 */
 		*pptr = work_node->list_item;
 		pptr = &(*pptr)->next;
 		*pptr = NULL;
@@ -1481,8 +1396,7 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 }
 
 struct commit_list *get_merge_bases(struct commit *one,
-				    struct commit *two,
-                                    int cleanup)
+					struct commit *two, int cleanup)
 {
 	struct commit_list *list;
 	struct commit **rslt;
diff --git a/commit.h b/commit.h
index 467872e..745f538 100644
--- a/commit.h
+++ b/commit.h
@@ -3,6 +3,7 @@
 
 #include "object.h"
 #include "tree.h"
+#include "strbuf.h"
 #include "decorate.h"
 
 struct commit_list {
@@ -61,7 +62,10 @@ enum cmit_fmt {
 };
 
 extern enum cmit_fmt get_commit_format(const char *arg);
-extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char **buf_p, unsigned long *space_p, int abbrev, const char *subject, const char *after_subject, enum date_mode dmode);
+extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
+                                struct strbuf *,
+                                int abbrev, const char *subject,
+                                const char *after_subject, enum date_mode);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/log-tree.c b/log-tree.c
index a642371..5186939 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -79,25 +79,14 @@ static int detect_any_signoff(char *letter, int size)
 	return seen_head && seen_name;
 }
 
-static unsigned long append_signoff(char **buf_p, unsigned long *buf_sz_p,
-				    unsigned long at, const char *signoff)
+static void append_signoff(struct strbuf *sb, const char *signoff)
 {
 	static const char signed_off_by[] = "Signed-off-by: ";
 	size_t signoff_len = strlen(signoff);
 	int has_signoff = 0;
 	char *cp;
-	char *buf;
-	unsigned long buf_sz;
-
-	buf = *buf_p;
-	buf_sz = *buf_sz_p;
-	if (buf_sz <= at + strlen(signed_off_by) + signoff_len + 3) {
-		buf_sz += strlen(signed_off_by) + signoff_len + 3;
-		buf = xrealloc(buf, buf_sz);
-		*buf_p = buf;
-		*buf_sz_p = buf_sz;
-	}
-	cp = buf;
+
+	cp = sb->buf;
 
 	/* First see if we already have the sign-off by the signer */
 	while ((cp = strstr(cp, signed_off_by))) {
@@ -105,29 +94,25 @@ static unsigned long append_signoff(char **buf_p, unsigned long *buf_sz_p,
 		has_signoff = 1;
 
 		cp += strlen(signed_off_by);
-		if (cp + signoff_len >= buf + at)
+		if (cp + signoff_len >= sb->buf + sb->len)
 			break;
 		if (strncmp(cp, signoff, signoff_len))
 			continue;
 		if (!isspace(cp[signoff_len]))
 			continue;
 		/* we already have him */
-		return at;
+		return;
 	}
 
 	if (!has_signoff)
-		has_signoff = detect_any_signoff(buf, at);
+		has_signoff = detect_any_signoff(sb->buf, sb->len);
 
 	if (!has_signoff)
-		buf[at++] = '\n';
-
-	strcpy(buf + at, signed_off_by);
-	at += strlen(signed_off_by);
-	strcpy(buf + at, signoff);
-	at += signoff_len;
-	buf[at++] = '\n';
-	buf[at] = 0;
-	return at;
+		strbuf_addch(sb, '\n');
+
+	strbuf_addstr(sb, signed_off_by);
+	strbuf_add(sb, signoff, signoff_len);
+	strbuf_addch(sb, '\n');
 }
 
 static unsigned int digits_in_number(unsigned int number)
@@ -142,14 +127,12 @@ static unsigned int digits_in_number(unsigned int number)
 
 void show_log(struct rev_info *opt, const char *sep)
 {
-	char *msgbuf = NULL;
-	unsigned long msgbuf_len = 0;
+	struct strbuf msgbuf;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev = opt->diffopt.abbrev;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra;
-	int len;
 	const char *subject = NULL, *extra_headers = opt->extra_headers;
 
 	opt->loginfo = NULL;
@@ -288,18 +271,17 @@ void show_log(struct rev_info *opt, const char *sep)
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	len = pretty_print_commit(opt->commit_format, commit, ~0u,
-				  &msgbuf, &msgbuf_len, abbrev, subject,
-				  extra_headers, opt->date_mode);
+	strbuf_init(&msgbuf);
+	pretty_print_commit(opt->commit_format, commit, &msgbuf,
+				  abbrev, subject, extra_headers, opt->date_mode);
 
 	if (opt->add_signoff)
-		len = append_signoff(&msgbuf, &msgbuf_len, len,
-				     opt->add_signoff);
+		append_signoff(&msgbuf, opt->add_signoff);
 	if (opt->show_log_size)
-		printf("log size %i\n", len);
+		printf("log size %i\n", (int)msgbuf.len);
 
-	printf("%s%s%s", msgbuf, extra, sep);
-	free(msgbuf);
+	printf("%s%s%s", msgbuf.buf, extra, sep);
+	strbuf_release(&msgbuf);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
-- 
1.5.3.1
