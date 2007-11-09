From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Fri, 09 Nov 2007 01:49:42 +0100
Message-ID: <4733AEA6.1040802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIFP-00047A-45
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500AbXKIA7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 19:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757889AbXKIA7w
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 19:59:52 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:52598
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756525AbXKIA7s (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 19:59:48 -0500
Received: from [10.0.1.201] (p57B7C9DB.dip.t-dialin.net [87.183.201.219])
	by neapel230.server4you.de (Postfix) with ESMTP id 32390873BC;
	Fri,  9 Nov 2007 01:50:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64097>

Some of the --pretty=format placeholders expansions are expensive to
calculate.  This is made worse by the current code's use of
interpolate(), which requires _all_ placeholders are to be prepared
up front.

One way to speed this up is to check which placeholders are present
in the format string and to prepare only the expansions that are
needed.  That still leaves the allocation overhead of interpolate().

Another way is to use a callback based approach together with the
strbuf library to keep allocations to a minimum and avoid string
copies.  That's what this patch does.  It introduces a new strbuf
function, strbuf_expand().

The function takes a format string, list of placeholder strings,
a user supplied function 'fn', and an opaque pointer 'context'
to tell 'fn' what thingy to operate on.

The function 'fn' is expected to accept a strbuf, a parsed
placeholder string and the 'context' pointer, and append the
interpolated value for the 'context' thingy, according to the
format specified by the placeholder.

Thanks to Pierre Habouzit for his suggestion to use strchrnul() and
the code surrounding its callsite.  And thanks to Junio for most of
this commit message. :)

Here my measurements of most of Paul Mackerras' test cases that
highlighted the performance problem (best of three runs):
    
(master)
$ time git log --pretty=oneline >/dev/null

real    0m0.390s
user    0m0.340s
sys     0m0.040s

(master)
$ time git log --pretty=raw >/dev/null

real    0m0.434s
user    0m0.408s
sys     0m0.016s

(master)
$ time git log --pretty="format:%H {%P} %ct" >/dev/null

real    0m1.347s
user    0m0.080s
sys     0m1.256s

(interp_find_active -- Dscho)
$ time ./git log --pretty="format:%H {%P} %ct" >/dev/null

real    0m0.694s
user    0m0.020s
sys     0m0.672s

(strbuf_expand -- this patch)
$ time ./git log --pretty="format:%H {%P} %ct" >/dev/null

real    0m0.395s
user    0m0.352s
sys     0m0.028s

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This version fixes a bug in the first one, which would eat
percent signs that were not followed by a placeholder from the
list.  That may be a valid thing to do for a brand-new parser,
but it regressed on what interpolate() did.

 strbuf.c |   24 ++++++
 strbuf.h |    3 +
 pretty.c |  276 ++++++++++++++++++++++++++++++++++----------------------------
 3 files changed, 180 insertions(+), 123 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index f4201e1..536b432 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -129,6 +129,30 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_expand(struct strbuf *sb, const char *format,
+                   const char **placeholders, expand_fn_t fn, void *context)
+{
+	for (;;) {
+		const char *percent, **p;
+
+		percent = strchrnul(format, '%');
+		strbuf_add(sb, format, percent - format);
+		if (!*percent)
+			break;
+		format = percent + 1;
+
+		for (p = placeholders; *p; p++) {
+			if (!prefixcmp(format, *p))
+				break;
+		}
+		if (*p) {
+			fn(sb, *p, context);
+			format += strlen(*p);
+		} else
+			strbuf_addch(sb, '%');
+	}
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
diff --git a/strbuf.h b/strbuf.h
index cd7f295..21d8944 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -102,6 +102,9 @@ static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
 	strbuf_add(sb, sb2->buf, sb2->len);
 }
 
+typedef void (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
+extern void strbuf_expand(struct strbuf *sb, const char *format, const char **placeholders, expand_fn_t fn, void *context);
+
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 
diff --git a/pretty.c b/pretty.c
index 490cede..9fbd73f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "commit.h"
-#include "interpolate.h"
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
@@ -283,7 +282,8 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static void fill_person(struct interp *table, const char *msg, int len)
+static void format_person_part(struct strbuf *sb, char part,
+                               const char *msg, int len)
 {
 	int start, end, tz = 0;
 	unsigned long date;
@@ -295,7 +295,10 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	start = end + 1;
 	while (end > 0 && isspace(msg[end - 1]))
 		end--;
-	table[0].value = xmemdupz(msg, end);
+	if (part == 'n') {	/* name */
+		strbuf_add(sb, msg, end);
+		return;
+	}
 
 	if (start >= len)
 		return;
@@ -307,7 +310,10 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	if (end >= len)
 		return;
 
-	table[1].value = xmemdupz(msg + start, end - start);
+	if (part == 'e') {	/* email */
+		strbuf_add(sb, msg + start, end - start);
+		return;
+	}
 
 	/* parse date */
 	for (start = end + 1; start < len && isspace(msg[start]); start++)
@@ -318,7 +324,10 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	if (msg + start == ep)
 		return;
 
-	table[5].value = xmemdupz(msg + start, ep - (msg + start));
+	if (part == 't') {	/* date, UNIX timestamp */
+		strbuf_add(sb, msg + start, ep - (msg + start));
+		return;
+	}
 
 	/* parse tz */
 	for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)
@@ -329,123 +338,107 @@ static void fill_person(struct interp *table, const char *msg, int len)
 			tz = -tz;
 	}
 
-	interp_set_entry(table, 2, show_date(date, tz, DATE_NORMAL));
-	interp_set_entry(table, 3, show_date(date, tz, DATE_RFC2822));
-	interp_set_entry(table, 4, show_date(date, tz, DATE_RELATIVE));
-	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
+	switch (part) {
+	case 'd':	/* date */
+		strbuf_addstr(sb, show_date(date, tz, DATE_NORMAL));
+		return;
+	case 'D':	/* date, RFC2822 style */
+		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
+		return;
+	case 'r':	/* date, relative */
+		strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
+		return;
+	case 'i':	/* date, ISO 8601 */
+		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
+		return;
+	}
 }
 
-void format_commit_message(const struct commit *commit,
-                           const void *format, struct strbuf *sb)
+static void format_commit_item(struct strbuf *sb, const char *placeholder,
+                               void *context)
 {
-	struct interp table[] = {
-		{ "%H" },	/* commit hash */
-		{ "%h" },	/* abbreviated commit hash */
-		{ "%T" },	/* tree hash */
-		{ "%t" },	/* abbreviated tree hash */
-		{ "%P" },	/* parent hashes */
-		{ "%p" },	/* abbreviated parent hashes */
-		{ "%an" },	/* author name */
-		{ "%ae" },	/* author email */
-		{ "%ad" },	/* author date */
-		{ "%aD" },	/* author date, RFC2822 style */
-		{ "%ar" },	/* author date, relative */
-		{ "%at" },	/* author date, UNIX timestamp */
-		{ "%ai" },	/* author date, ISO 8601 */
-		{ "%cn" },	/* committer name */
-		{ "%ce" },	/* committer email */
-		{ "%cd" },	/* committer date */
-		{ "%cD" },	/* committer date, RFC2822 style */
-		{ "%cr" },	/* committer date, relative */
-		{ "%ct" },	/* committer date, UNIX timestamp */
-		{ "%ci" },	/* committer date, ISO 8601 */
-		{ "%e" },	/* encoding */
-		{ "%s" },	/* subject */
-		{ "%b" },	/* body */
-		{ "%Cred" },	/* red */
-		{ "%Cgreen" },	/* green */
-		{ "%Cblue" },	/* blue */
-		{ "%Creset" },	/* reset color */
-		{ "%n" },	/* newline */
-		{ "%m" },	/* left/right/bottom */
-	};
-	enum interp_index {
-		IHASH = 0, IHASH_ABBREV,
-		ITREE, ITREE_ABBREV,
-		IPARENTS, IPARENTS_ABBREV,
-		IAUTHOR_NAME, IAUTHOR_EMAIL,
-		IAUTHOR_DATE, IAUTHOR_DATE_RFC2822, IAUTHOR_DATE_RELATIVE,
-		IAUTHOR_TIMESTAMP, IAUTHOR_ISO8601,
-		ICOMMITTER_NAME, ICOMMITTER_EMAIL,
-		ICOMMITTER_DATE, ICOMMITTER_DATE_RFC2822,
-		ICOMMITTER_DATE_RELATIVE, ICOMMITTER_TIMESTAMP,
-		ICOMMITTER_ISO8601,
-		IENCODING,
-		ISUBJECT,
-		IBODY,
-		IRED, IGREEN, IBLUE, IRESET_COLOR,
-		INEWLINE,
-		ILEFT_RIGHT,
-	};
+	const struct commit *commit = context;
 	struct commit_list *p;
-	char parents[1024];
-	unsigned long len;
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
 	const char *msg = commit->buffer;
 
-	if (ILEFT_RIGHT + 1 != ARRAY_SIZE(table))
-		die("invalid interp table!");
-
 	/* these are independent of the commit */
-	interp_set_entry(table, IRED, "\033[31m");
-	interp_set_entry(table, IGREEN, "\033[32m");
-	interp_set_entry(table, IBLUE, "\033[34m");
-	interp_set_entry(table, IRESET_COLOR, "\033[m");
-	interp_set_entry(table, INEWLINE, "\n");
+	switch (placeholder[0]) {
+	case 'C':
+		switch (placeholder[3]) {
+		case 'd':	/* red */
+			strbuf_addstr(sb, "\033[31m");
+			return;
+		case 'e':	/* green */
+			strbuf_addstr(sb, "\033[32m");
+			return;
+		case 'u':	/* blue */
+			strbuf_addstr(sb, "\033[34m");
+			return;
+		case 's':	/* reset color */
+			strbuf_addstr(sb, "\033[m");
+			return;
+		}
+	case 'n':		/* newline */
+		strbuf_addch(sb, '\n');
+		return;
+	}
 
 	/* these depend on the commit */
 	if (!commit->object.parsed)
 		parse_object(commit->object.sha1);
-	interp_set_entry(table, IHASH, sha1_to_hex(commit->object.sha1));
-	interp_set_entry(table, IHASH_ABBREV,
-			find_unique_abbrev(commit->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, ITREE, sha1_to_hex(commit->tree->object.sha1));
-	interp_set_entry(table, ITREE_ABBREV,
-			find_unique_abbrev(commit->tree->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, ILEFT_RIGHT,
-			 (commit->object.flags & BOUNDARY)
-			 ? "-"
-			 : (commit->object.flags & SYMMETRIC_LEFT)
-			 ? "<"
-			 : ">");
-
-	parents[1] = 0;
-	for (i = 0, p = commit->parents;
-			p && i < sizeof(parents) - 1;
-			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			sha1_to_hex(p->item->object.sha1));
-	interp_set_entry(table, IPARENTS, parents + 1);
-
-	parents[1] = 0;
-	for (i = 0, p = commit->parents;
-			p && i < sizeof(parents) - 1;
-			p = p->next)
-		i += snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			find_unique_abbrev(p->item->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
 
+	switch (placeholder[0]) {
+	case 'H':		/* commit hash */
+		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
+		return;
+	case 'h':		/* abbreviated commit hash */
+		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
+		                                     DEFAULT_ABBREV));
+		return;
+	case 'T':		/* tree hash */
+		strbuf_addstr(sb, sha1_to_hex(commit->tree->object.sha1));
+		return;
+	case 't':		/* abbreviated tree hash */
+		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
+		                                     DEFAULT_ABBREV));
+		return;
+	case 'P':		/* parent hashes */
+		for (p = commit->parents; p; p = p->next) {
+			if (p != commit->parents)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, sha1_to_hex(p->item->object.sha1));
+		}
+		return;
+	case 'p':		/* abbreviated parent hashes */
+		for (p = commit->parents; p; p = p->next) {
+			if (p != commit->parents)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, find_unique_abbrev(
+					p->item->object.sha1, DEFAULT_ABBREV));
+		}
+		return;
+	case 'm':		/* left/right/bottom */
+		strbuf_addch(sb, (commit->object.flags & BOUNDARY)
+		                 ? '-'
+		                 : (commit->object.flags & SYMMETRIC_LEFT)
+		                 ? '<'
+		                 : '>');
+		return;
+	}
+
+	/* For the rest we have to parse the commit header. */
 	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
 		int eol;
 		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
 			; /* do nothing */
 
 		if (state == SUBJECT) {
-			table[ISUBJECT].value = xmemdupz(msg + i, eol - i);
+			if (placeholder[0] == 's') {
+				strbuf_add(sb, msg + i, eol - i);
+				return;
+			}
 			i = eol;
 		}
 		if (i == eol) {
@@ -453,29 +446,66 @@ void format_commit_message(const struct commit *commit,
 			/* strip empty lines */
 			while (msg[eol + 1] == '\n')
 				eol++;
-		} else if (!prefixcmp(msg + i, "author "))
-			fill_person(table + IAUTHOR_NAME,
-					msg + i + 7, eol - i - 7);
-		else if (!prefixcmp(msg + i, "committer "))
-			fill_person(table + ICOMMITTER_NAME,
-					msg + i + 10, eol - i - 10);
-		else if (!prefixcmp(msg + i, "encoding "))
-			table[IENCODING].value =
-				xmemdupz(msg + i + 9, eol - i - 9);
+		} else if (!prefixcmp(msg + i, "author ")) {
+			if (placeholder[0] == 'a') {
+				format_person_part(sb, placeholder[1],
+				                   msg + i + 7, eol - i - 7);
+				return;
+			}
+		} else if (!prefixcmp(msg + i, "committer ")) {
+			if (placeholder[0] == 'c') {
+				format_person_part(sb, placeholder[1],
+				                   msg + i + 10, eol - i - 10);
+				return;
+			}
+		} else if (!prefixcmp(msg + i, "encoding ")) {
+			if (placeholder[0] == 'e') {
+				strbuf_add(sb, msg + i + 9, eol - i - 9);
+				return;
+			}
+		}
 		i = eol;
 	}
-	if (msg[i])
-		table[IBODY].value = xstrdup(msg + i);
-
-	len = interpolate(sb->buf + sb->len, strbuf_avail(sb),
-				format, table, ARRAY_SIZE(table));
-	if (len > strbuf_avail(sb)) {
-		strbuf_grow(sb, len);
-		interpolate(sb->buf + sb->len, strbuf_avail(sb) + 1,
-					format, table, ARRAY_SIZE(table));
-	}
-	strbuf_setlen(sb, sb->len + len);
-	interp_clear_table(table, ARRAY_SIZE(table));
+	if (msg[i] && placeholder[0] == 'b')	/* body */
+		strbuf_addstr(sb, msg + i);
+}
+
+void format_commit_message(const struct commit *commit,
+                           const void *format, struct strbuf *sb)
+{
+	const char *placeholders[] = {
+		"H",		/* commit hash */
+		"h",		/* abbreviated commit hash */
+		"T",		/* tree hash */
+		"t",		/* abbreviated tree hash */
+		"P",		/* parent hashes */
+		"p",		/* abbreviated parent hashes */
+		"an",		/* author name */
+		"ae",		/* author email */
+		"ad",		/* author date */
+		"aD",		/* author date, RFC2822 style */
+		"ar",		/* author date, relative */
+		"at",		/* author date, UNIX timestamp */
+		"ai",		/* author date, ISO 8601 */
+		"cn",		/* committer name */
+		"ce",		/* committer email */
+		"cd",		/* committer date */
+		"cD",		/* committer date, RFC2822 style */
+		"cr",		/* committer date, relative */
+		"ct",		/* committer date, UNIX timestamp */
+		"ci",		/* committer date, ISO 8601 */
+		"e",		/* encoding */
+		"s",		/* subject */
+		"b",		/* body */
+		"Cred",		/* red */
+		"Cgreen",	/* green */
+		"Cblue",	/* blue */
+		"Creset",	/* reset color */
+		"n",		/* newline */
+		"m",		/* left/right/bottom */
+		NULL
+	};
+	strbuf_expand(sb, format, placeholders, format_commit_item, (void *)commit);
 }
 
 static void pp_header(enum cmit_fmt fmt,
 
