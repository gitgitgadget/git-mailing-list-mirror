From: Thomas Egerer <thomas.egerer@secunet.com>
Subject: Re: [PATCH] pretty.c: Make user defined format honor color option
Date: Thu, 17 Mar 2011 14:46:32 +0100
Message-ID: <4D8210B8.804@secunet.com>
References: <4D81C741.8060108@secunet.com> <1300354791.3269.19.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:46:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0DX4-0005jQ-F7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 14:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab1CQNqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 09:46:24 -0400
Received: from a.mx.secunet.com ([195.81.216.161]:43835 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab1CQNqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 09:46:23 -0400
Received: from localhost (alg1 [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7320A1A0084;
	Thu, 17 Mar 2011 14:37:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mail-srv1.secumail.de (unknown [10.53.40.200])
	by a.mx.secunet.com (Postfix) with ESMTP id 213601A0082;
	Thu, 17 Mar 2011 14:37:17 +0100 (CET)
Received: from [10.182.7.178] ([10.182.7.178]) by mail-srv1.secumail.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 17 Mar 2011 14:46:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20101227 Icedove/3.0.11
In-Reply-To: <1300354791.3269.19.camel@wpalmer.simply-domain>
X-Enigmail-Version: 1.0.1
X-OriginalArrivalTime: 17 Mar 2011 13:46:21.0042 (UTC) FILETIME=[B2CA9D20:01CBE4A9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169242>


This patch fixes that the pretty-formats tformat and format ignore
git's color option.

Signed-off-by: Thomas Egerer <thomas.egerer@secunet.com>
---
 builtin/log.c      |    2 +-
 builtin/rev-list.c |    1 +
 builtin/shortlog.c |    5 +++--
 commit.h           |    1 +
 log-tree.c         |    1 +
 pretty.c           |   29 +++++++++++++++++------------
 shortlog.h         |    2 +-
 7 files changed, 25 insertions(+), 16 deletions(-)



0001-pretty.c-Make-user-defined-format-honor-color-option.patch

diff --git a/builtin/log.c b/builtin/log.c
index f5ed690..d65d268 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -780,7 +780,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	log.in1 = 2;
 	log.in2 = 4;
 	for (i = 0; i < nr; i++)
-		shortlog_add_commit(&log, list[i]);
+		shortlog_add_commit(rev, &log, list[i]);

 	shortlog_output(&log);

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ba27d39..7dcd659 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -108,6 +108,7 @@ static void show_commit(struct commit *commit, void *data)
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
 		ctx.date_mode = revs->date_mode;
+		ctx.colorize = (DIFF_OPT_TST(&revs->diffopt, COLOR_DIFF) != 0);
 		pretty_print_commit(revs->commit_format, commit, &buf, &ctx);
 		if (revs->graph) {
 			if (buf.len) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1a21e4b..401525e 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -136,7 +136,7 @@ static void read_from_stdin(struct shortlog *log)
 	}
 }

-void shortlog_add_commit(struct shortlog *log, struct commit *commit)
+void shortlog_add_commit(struct rev_info * rev, struct shortlog *log, struct commit *commit)
 {
 	const char *author = NULL, *buffer;
 	struct strbuf buf = STRBUF_INIT;
@@ -166,6 +166,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.subject = "";
 		ctx.after_subject = "";
 		ctx.date_mode = DATE_NORMAL;
+		ctx.colorize = (DIFF_OPT_TST(&rev->diffopt, COLOR_DIFF) != 0);
 		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
@@ -183,7 +184,7 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
 	if (prepare_revision_walk(rev))
 		die("revision walk setup failed");
 	while ((commit = get_revision(rev)) != NULL)
-		shortlog_add_commit(log, commit);
+		shortlog_add_commit(rev, log, commit);
 }

 static int parse_uint(char const **arg, int comma, int defval)
diff --git a/commit.h b/commit.h
index 659c87c..d23bf99 100644
--- a/commit.h
+++ b/commit.h
@@ -78,6 +78,7 @@ struct pretty_print_context
 	int show_notes;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
+	unsigned colorize:1;
 };

 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index b46ed3b..63017d2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -505,6 +505,7 @@ void show_log(struct rev_info *opt)
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.reflog_info = opt->reflog_info;
+	ctx.colorize = (DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF) != 0);
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);

 	if (opt->add_signoff)This patch fixes that the pretty-formats tformat and format ignore
git's color option.

Signed-off-by: Thomas Egerer <thomas.egerer@secunet.com>
---
 builtin/log.c      |    2 +-
 builtin/rev-list.c |    1 +
 builtin/shortlog.c |    5 +++--
 commit.h           |    1 +
 log-tree.c         |    1 +
 pretty.c           |   29 +++++++++++++++++------------
 shortlog.h         |    2 +-
 7 files changed, 25 insertions(+), 16 deletions(-)



0001-pretty.c-Make-user-defined-format-honor-color-option.patch

diff --git a/builtin/log.c b/builtin/log.c
index f5ed690..d65d268 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -780,7 +780,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	log.in1 = 2;
 	log.in2 = 4;
 	for (i = 0; i < nr; i++)
-		shortlog_add_commit(&log, list[i]);
+		shortlog_add_commit(rev, &log, list[i]);

 	shortlog_output(&log);

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ba27d39..7dcd659 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -108,6 +108,7 @@ static void show_commit(struct commit *commit, void *data)
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
 		ctx.date_mode = revs->date_mode;
+		ctx.colorize = (DIFF_OPT_TST(&revs->diffopt, COLOR_DIFF) != 0);
 		pretty_print_commit(revs->commit_format, commit, &buf, &ctx);
 		if (revs->graph) {
 			if (buf.len) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1a21e4b..401525e 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -136,7 +136,7 @@ static void read_from_stdin(struct shortlog *log)
 	}
 }

-void shortlog_add_commit(struct shortlog *log, struct commit *commit)
+void shortlog_add_commit(struct rev_info * rev, struct shortlog *log, struct commit *commit)
 {
 	const char *author = NULL, *buffer;
 	struct strbuf buf = STRBUF_INIT;
@@ -166,6 +166,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.subject = "";
 		ctx.after_subject = "";
 		ctx.date_mode = DATE_NORMAL;
+		ctx.colorize = (DIFF_OPT_TST(&rev->diffopt, COLOR_DIFF) != 0);
 		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
@@ -183,7 +184,7 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
 	if (prepare_revision_walk(rev))
 		die("revision walk setup failed");
 	while ((commit = get_revision(rev)) != NULL)
-		shortlog_add_commit(log, commit);
+		shortlog_add_commit(rev, log, commit);
 }

 static int parse_uint(char const **arg, int comma, int defval)
diff --git a/commit.h b/commit.h
index 659c87c..d23bf99 100644
--- a/commit.h
+++ b/commit.h
@@ -78,6 +78,7 @@ struct pretty_print_context
 	int show_notes;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
+	unsigned colorize:1;
 };

 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index b46ed3b..63017d2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -505,6 +505,7 @@ void show_log(struct rev_info *opt)
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.reflog_info = opt->reflog_info;
+	ctx.colorize = (DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF) != 0);
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);

 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 8549934..3c3467f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -743,7 +743,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
+	char cbuf[COLOR_MAXLEN];
 	struct commit_list *p;
+	size_t consumed = 0;
+	char *color = NULL;
 	int h1, h2;

 	/* these are independent of the commit */
@@ -751,29 +754,31 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	case 'C':
 		if (placeholder[1] == '(') {
 			const char *end = strchr(placeholder + 2, ')');
-			char color[COLOR_MAXLEN];
 			if (!end)
 				return 0;
 			color_parse_mem(placeholder + 2,
 					end - (placeholder + 2),
-					"--pretty format", color);
-			strbuf_addstr(sb, color);
-			return end - placeholder + 1;
+					"--pretty format", cbuf);
+			consumed = end - placeholder + 1;
+			color = cbuf;
 		}
 		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, GIT_COLOR_RED);
-			return 4;
+			color = GIT_COLOR_RED;
+			consumed = 4;
 		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, GIT_COLOR_GREEN);
-			return 6;
+			color = GIT_COLOR_GREEN;
+			consumed = 6;
 		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, GIT_COLOR_BLUE);
-			return 5;
+			color = GIT_COLOR_BLUE;
+			consumed = 5;
 		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, GIT_COLOR_RESET);
-			return 6;
+			color = GIT_COLOR_RESET;
+			consumed = 6;
 		} else
 			return 0;
+		if (color && (c->pretty_ctx->colorize == 1))
+			strbuf_addstr(sb, color);
+		return consumed;
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
diff --git a/shortlog.h b/shortlog.h
index de4f86f..0da5f97 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -21,7 +21,7 @@ struct shortlog {

 void shortlog_init(struct shortlog *log);

-void shortlog_add_commit(struct shortlog *log, struct commit *commit);
+void shortlog_add_commit(struct rev_info *rev, struct shortlog *log, struct commit *commit);

 void shortlog_output(struct shortlog *log);


diff --git a/pretty.c b/pretty.c
index 8549934..3c3467f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -743,7 +743,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
+	char cbuf[COLOR_MAXLEN];
 	struct commit_list *p;
+	size_t consumed = 0;
+	char *color = NULL;
 	int h1, h2;

 	/* these are independent of the commit */
@@ -751,29 +754,31 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	case 'C':
 		if (placeholder[1] == '(') {
 			const char *end = strchr(placeholder + 2, ')');
-			char color[COLOR_MAXLEN];
 			if (!end)
 				return 0;
 			color_parse_mem(placeholder + 2,
 					end - (placeholder + 2),
-					"--pretty format", color);
-			strbuf_addstr(sb, color);
-			return end - placeholder + 1;
+					"--pretty format", cbuf);
+			consumed = end - placeholder + 1;
+			color = cbuf;
 		}
 		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, GIT_COLOR_RED);
-			return 4;
+			color = GIT_COLOR_RED;
+			consumed = 4;
 		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, GIT_COLOR_GREEN);
-			return 6;
+			color = GIT_COLOR_GREEN;
+			consumed = 6;
 		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, GIT_COLOR_BLUE);
-			return 5;
+			color = GIT_COLOR_BLUE;
+			consumed = 5;
 		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, GIT_COLOR_RESET);
-			return 6;
+			color = GIT_COLOR_RESET;
+			consumed = 6;
 		} else
 			return 0;
+		if (color && (c->pretty_ctx->colorize == 1))
+			strbuf_addstr(sb, color);
+		return consumed;
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
diff --git a/shortlog.h b/shortlog.h
index de4f86f..0da5f97 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -21,7 +21,7 @@ struct shortlog {

 void shortlog_init(struct shortlog *log);

-void shortlog_add_commit(struct shortlog *log, struct commit *commit);
+void shortlog_add_commit(struct rev_info *rev, struct shortlog *log, struct commit *commit);

 void shortlog_output(struct shortlog *log);
