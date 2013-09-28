From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 34/44] shortlog: split builtin from common code
Date: Sat, 28 Sep 2013 17:03:59 -0500
Message-ID: <1380405849-13000-35-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jv-000423-8S
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab3I1WLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:44 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:47334 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355Ab3I1WLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:42 -0400
Received: by mail-oa0-f43.google.com with SMTP id f4so3018519oah.2
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HuP67jiYz1MLVEBOv9R4ph29VuKbnxkwPb/jya4EVSQ=;
        b=oHz1Cj5XHYMErSK8aQVoDw/Jlhv2fvhZJxjiORRA3W47A5XIT3jxiq70ev/pEMAqPy
         60C/8Gr0Sguky+IJZmKMEp7c4mYzCiZULflmIY/+4kFgoRd6pJdsNC/x124uKbe0vRCp
         //qMvIRBVvzje8mU8S1lTTKTkJel/Z3A1EYieINO6B4prEpBSo8IyL2QiY7yz2nAnYnn
         47idEBBbKDAyZMs3SpoSajwJ+CiOZFDESSqHFBp8z/pGoUy8K6DguOB/3FVZCbHSFX1v
         ciwINXpBsNHmr1QfnwzLrS7dGgjVwr7txSdhZ4azAiCJIPJ/Ph50pDrQlOU5IS9PUP4G
         NILQ==
X-Received: by 10.60.118.70 with SMTP id kk6mr12445439oeb.22.1380406301839;
        Sat, 28 Sep 2013 15:11:41 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm19538918obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235556>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    Somebody forgot to do this.

 Makefile           |   1 +
 builtin/shortlog.c | 184 +----------------------------------------------------
 shortlog.c         | 181 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 shortlog.h         |   6 ++
 4 files changed, 189 insertions(+), 183 deletions(-)
 create mode 100644 shortlog.c

diff --git a/Makefile b/Makefile
index 44b4cd5..709c087 100644
--- a/Makefile
+++ b/Makefile
@@ -880,6 +880,7 @@ LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1_file.o
 LIB_OBJS += sha1_name.o
 LIB_OBJS += shallow.o
+LIB_OBJS += shortlog.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
 LIB_OBJS += strbuf.o
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1434f8f..f84c6f8 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,11 +1,8 @@
 #include "builtin.h"
 #include "cache.h"
 #include "commit.h"
-#include "diff.h"
 #include "string-list.h"
 #include "revision.h"
-#include "utf8.h"
-#include "mailmap.h"
 #include "shortlog.h"
 #include "parse-options.h"
 
@@ -14,81 +11,6 @@ static char const * const shortlog_usage[] = {
 	NULL
 };
 
-static int compare_by_number(const void *a1, const void *a2)
-{
-	const struct string_list_item *i1 = a1, *i2 = a2;
-	const struct string_list *l1 = i1->util, *l2 = i2->util;
-
-	if (l1->nr < l2->nr)
-		return 1;
-	else if (l1->nr == l2->nr)
-		return 0;
-	else
-		return -1;
-}
-
-static void insert_one_record(struct shortlog *log,
-			      const char *author,
-			      const char *oneline)
-{
-	const char *dot3 = log->common_repo_prefix;
-	char *buffer, *p;
-	struct string_list_item *item;
-	const char *mailbuf, *namebuf;
-	size_t namelen, maillen;
-	const char *eol;
-	struct strbuf subject = STRBUF_INIT;
-	struct strbuf namemailbuf = STRBUF_INIT;
-	struct ident_split ident;
-
-	if (split_ident_line(&ident, author, strlen(author)))
-		return;
-
-	namebuf = ident.name_begin;
-	mailbuf = ident.mail_begin;
-	namelen = ident.name_end - ident.name_begin;
-	maillen = ident.mail_end - ident.mail_begin;
-
-	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
-	strbuf_add(&namemailbuf, namebuf, namelen);
-
-	if (log->email)
-		strbuf_addf(&namemailbuf, " <%.*s>", (int)maillen, mailbuf);
-
-	item = string_list_insert(&log->list, namemailbuf.buf);
-	if (item->util == NULL)
-		item->util = xcalloc(1, sizeof(struct string_list));
-
-	/* Skip any leading whitespace, including any blank lines. */
-	while (*oneline && isspace(*oneline))
-		oneline++;
-	eol = strchr(oneline, '\n');
-	if (!eol)
-		eol = oneline + strlen(oneline);
-	if (!prefixcmp(oneline, "[PATCH")) {
-		char *eob = strchr(oneline, ']');
-		if (eob && (!eol || eob < eol))
-			oneline = eob + 1;
-	}
-	while (*oneline && isspace(*oneline) && *oneline != '\n')
-		oneline++;
-	format_subject(&subject, oneline, " ");
-	buffer = strbuf_detach(&subject, NULL);
-
-	if (dot3) {
-		int dot3len = strlen(dot3);
-		if (dot3len > 5) {
-			while ((p = strstr(buffer, dot3)) != NULL) {
-				int taillen = strlen(p) - dot3len;
-				memcpy(p, "/.../", 5);
-				memmove(p + 5, p + dot3len, taillen + 1);
-			}
-		}
-	}
-
-	string_list_append(item->util, buffer);
-}
-
 static void read_from_stdin(struct shortlog *log)
 {
 	char author[1024], oneline[1024];
@@ -103,51 +25,10 @@ static void read_from_stdin(struct shortlog *log)
 		while (fgets(oneline, sizeof(oneline), stdin) &&
 		       oneline[0] == '\n')
 			; /* discard blanks */
-		insert_one_record(log, author + 8, oneline);
+		shortlog_insert_one_record(log, author + 8, oneline);
 	}
 }
 
-void shortlog_add_commit(struct shortlog *log, struct commit *commit)
-{
-	const char *author = NULL, *buffer;
-	struct strbuf buf = STRBUF_INIT;
-	struct strbuf ufbuf = STRBUF_INIT;
-
-	pp_commit_easy(CMIT_FMT_RAW, commit, &buf);
-	buffer = buf.buf;
-	while (*buffer && *buffer != '\n') {
-		const char *eol = strchr(buffer, '\n');
-
-		if (eol == NULL)
-			eol = buffer + strlen(buffer);
-		else
-			eol++;
-
-		if (!prefixcmp(buffer, "author "))
-			author = buffer + 7;
-		buffer = eol;
-	}
-	if (!author)
-		die(_("Missing author: %s"),
-		    sha1_to_hex(commit->object.sha1));
-	if (log->user_format) {
-		struct pretty_print_context ctx = {0};
-		ctx.fmt = CMIT_FMT_USERFORMAT;
-		ctx.abbrev = log->abbrev;
-		ctx.subject = "";
-		ctx.after_subject = "";
-		ctx.date_mode = DATE_NORMAL;
-		ctx.output_encoding = get_log_output_encoding();
-		pretty_print_commit(&ctx, commit, &ufbuf);
-		buffer = ufbuf.buf;
-	} else if (*buffer) {
-		buffer++;
-	}
-	insert_one_record(log, author, !*buffer ? "<none>" : buffer);
-	strbuf_release(&ufbuf);
-	strbuf_release(&buf);
-}
-
 static void get_from_rev(struct rev_info *rev, struct shortlog *log)
 {
 	struct commit *commit;
@@ -175,9 +56,6 @@ static int parse_uint(char const **arg, int comma, int defval)
 }
 
 static const char wrap_arg_usage[] = "-w[<width>[,<indent1>[,<indent2>]]]";
-#define DEFAULT_WRAPLEN 76
-#define DEFAULT_INDENT1 6
-#define DEFAULT_INDENT2 9
 
 static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
 {
@@ -205,18 +83,6 @@ static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-void shortlog_init(struct shortlog *log)
-{
-	memset(log, 0, sizeof(*log));
-
-	read_mailmap(&log->mailmap, &log->common_repo_prefix);
-
-	log->list.strdup_strings = 1;
-	log->wrap = DEFAULT_WRAPLEN;
-	log->in1 = DEFAULT_INDENT1;
-	log->in2 = DEFAULT_INDENT2;
-}
-
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
 	static struct shortlog log;
@@ -277,51 +143,3 @@ parse_done:
 	shortlog_output(&log);
 	return 0;
 }
-
-static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
-				     const struct shortlog *log)
-{
-	strbuf_add_wrapped_text(sb, s, log->in1, log->in2, log->wrap);
-	strbuf_addch(sb, '\n');
-}
-
-void shortlog_output(struct shortlog *log)
-{
-	int i, j;
-	struct strbuf sb = STRBUF_INIT;
-
-	if (log->sort_by_number)
-		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
-			compare_by_number);
-	for (i = 0; i < log->list.nr; i++) {
-		struct string_list *onelines = log->list.items[i].util;
-
-		if (log->summary) {
-			printf("%6d\t%s\n", onelines->nr, log->list.items[i].string);
-		} else {
-			printf("%s (%d):\n", log->list.items[i].string, onelines->nr);
-			for (j = onelines->nr - 1; j >= 0; j--) {
-				const char *msg = onelines->items[j].string;
-
-				if (log->wrap_lines) {
-					strbuf_reset(&sb);
-					add_wrapped_shortlog_msg(&sb, msg, log);
-					fwrite(sb.buf, sb.len, 1, stdout);
-				}
-				else
-					printf("      %s\n", msg);
-			}
-			putchar('\n');
-		}
-
-		onelines->strdup_strings = 1;
-		string_list_clear(onelines, 0);
-		free(onelines);
-		log->list.items[i].util = NULL;
-	}
-
-	strbuf_release(&sb);
-	log->list.strdup_strings = 1;
-	string_list_clear(&log->list, 1);
-	clear_mailmap(&log->mailmap);
-}
diff --git a/shortlog.c b/shortlog.c
new file mode 100644
index 0000000..89a839f
--- /dev/null
+++ b/shortlog.c
@@ -0,0 +1,181 @@
+#include "cache.h"
+#include "shortlog.h"
+#include "commit.h"
+#include "mailmap.h"
+#include "utf8.h"
+
+void shortlog_init(struct shortlog *log)
+{
+	memset(log, 0, sizeof(*log));
+
+	read_mailmap(&log->mailmap, &log->common_repo_prefix);
+
+	log->list.strdup_strings = 1;
+	log->wrap = DEFAULT_WRAPLEN;
+	log->in1 = DEFAULT_INDENT1;
+	log->in2 = DEFAULT_INDENT2;
+}
+
+void shortlog_insert_one_record(struct shortlog *log,
+		const char *author,
+		const char *oneline)
+{
+	const char *dot3 = log->common_repo_prefix;
+	char *buffer, *p;
+	struct string_list_item *item;
+	const char *mailbuf, *namebuf;
+	size_t namelen, maillen;
+	const char *eol;
+	struct strbuf subject = STRBUF_INIT;
+	struct strbuf namemailbuf = STRBUF_INIT;
+	struct ident_split ident;
+
+	if (split_ident_line(&ident, author, strlen(author)))
+		return;
+
+	namebuf = ident.name_begin;
+	mailbuf = ident.mail_begin;
+	namelen = ident.name_end - ident.name_begin;
+	maillen = ident.mail_end - ident.mail_begin;
+
+	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
+	strbuf_add(&namemailbuf, namebuf, namelen);
+
+	if (log->email)
+		strbuf_addf(&namemailbuf, " <%.*s>", (int)maillen, mailbuf);
+
+	item = string_list_insert(&log->list, namemailbuf.buf);
+	if (item->util == NULL)
+		item->util = xcalloc(1, sizeof(struct string_list));
+
+	/* Skip any leading whitespace, including any blank lines. */
+	while (*oneline && isspace(*oneline))
+		oneline++;
+	eol = strchr(oneline, '\n');
+	if (!eol)
+		eol = oneline + strlen(oneline);
+	if (!prefixcmp(oneline, "[PATCH")) {
+		char *eob = strchr(oneline, ']');
+		if (eob && (!eol || eob < eol))
+			oneline = eob + 1;
+	}
+	while (*oneline && isspace(*oneline) && *oneline != '\n')
+		oneline++;
+	format_subject(&subject, oneline, " ");
+	buffer = strbuf_detach(&subject, NULL);
+
+	if (dot3) {
+		int dot3len = strlen(dot3);
+		if (dot3len > 5) {
+			while ((p = strstr(buffer, dot3)) != NULL) {
+				int taillen = strlen(p) - dot3len;
+				memcpy(p, "/.../", 5);
+				memmove(p + 5, p + dot3len, taillen + 1);
+			}
+		}
+	}
+
+	string_list_append(item->util, buffer);
+}
+
+void shortlog_add_commit(struct shortlog *log, struct commit *commit)
+{
+	const char *author = NULL, *buffer;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf ufbuf = STRBUF_INIT;
+
+	pp_commit_easy(CMIT_FMT_RAW, commit, &buf);
+	buffer = buf.buf;
+	while (*buffer && *buffer != '\n') {
+		const char *eol = strchr(buffer, '\n');
+
+		if (eol == NULL)
+			eol = buffer + strlen(buffer);
+		else
+			eol++;
+
+		if (!prefixcmp(buffer, "author "))
+			author = buffer + 7;
+		buffer = eol;
+	}
+	if (!author)
+		die(_("Missing author: %s"),
+		    sha1_to_hex(commit->object.sha1));
+	if (log->user_format) {
+		struct pretty_print_context ctx = {0};
+		ctx.fmt = CMIT_FMT_USERFORMAT;
+		ctx.abbrev = log->abbrev;
+		ctx.subject = "";
+		ctx.after_subject = "";
+		ctx.date_mode = DATE_NORMAL;
+		ctx.output_encoding = get_log_output_encoding();
+		pretty_print_commit(&ctx, commit, &ufbuf);
+		buffer = ufbuf.buf;
+	} else if (*buffer) {
+		buffer++;
+	}
+	shortlog_insert_one_record(log, author, !*buffer ? "<none>" : buffer);
+	strbuf_release(&ufbuf);
+	strbuf_release(&buf);
+}
+
+static int compare_by_number(const void *a1, const void *a2)
+{
+	const struct string_list_item *i1 = a1, *i2 = a2;
+	const struct string_list *l1 = i1->util, *l2 = i2->util;
+
+	if (l1->nr < l2->nr)
+		return 1;
+	else if (l1->nr == l2->nr)
+		return 0;
+	else
+		return -1;
+}
+
+static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
+				     const struct shortlog *log)
+{
+	strbuf_add_wrapped_text(sb, s, log->in1, log->in2, log->wrap);
+	strbuf_addch(sb, '\n');
+}
+
+void shortlog_output(struct shortlog *log)
+{
+	int i, j;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (log->sort_by_number)
+		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
+			compare_by_number);
+	for (i = 0; i < log->list.nr; i++) {
+		struct string_list *onelines = log->list.items[i].util;
+
+		if (log->summary) {
+			printf("%6d\t%s\n", onelines->nr, log->list.items[i].string);
+		} else {
+			printf("%s (%d):\n", log->list.items[i].string, onelines->nr);
+			for (j = onelines->nr - 1; j >= 0; j--) {
+				const char *msg = onelines->items[j].string;
+
+				if (log->wrap_lines) {
+					strbuf_reset(&sb);
+					add_wrapped_shortlog_msg(&sb, msg, log);
+					fwrite(sb.buf, sb.len, 1, stdout);
+				}
+				else
+					printf("      %s\n", msg);
+			}
+			putchar('\n');
+		}
+
+		onelines->strdup_strings = 1;
+		string_list_clear(onelines, 0);
+		free(onelines);
+		log->list.items[i].util = NULL;
+	}
+
+	strbuf_release(&sb);
+	log->list.strdup_strings = 1;
+	string_list_clear(&log->list, 1);
+	clear_mailmap(&log->mailmap);
+}
diff --git a/shortlog.h b/shortlog.h
index 54bc07c..cf14d8b 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -3,6 +3,10 @@
 
 #include "string-list.h"
 
+#define DEFAULT_WRAPLEN 76
+#define DEFAULT_INDENT1 6
+#define DEFAULT_INDENT2 9
+
 struct shortlog {
 	struct string_list list;
 	int summary;
@@ -25,6 +29,8 @@ void shortlog_init(struct shortlog *log);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
 
+void shortlog_insert_one_record(struct shortlog *log, const char *author, const char *oneline);
+
 void shortlog_output(struct shortlog *log);
 
 #endif
-- 
1.8.4-fc
