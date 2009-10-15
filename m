From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/5] Refactor pretty_print_commit arguments into a struct
Date: Fri, 16 Oct 2009 00:41:44 +0200
Message-ID: <9d3d0f0a6126afc86689138adf58ac7a12c43858.1255645570.git.trast@student.ethz.ch>
References: <cover.1255645570.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 00:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyZ4u-0006Yh-00
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 00:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763163AbZJOWnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 18:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763159AbZJOWnu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 18:43:50 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:58969 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761137AbZJOWnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 18:43:49 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:42:44 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:42:23 +0200
X-Mailer: git-send-email 1.6.5.116.gfe4b9
In-Reply-To: <cover.1255645570.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130434>

pretty_print_commit() has a bunch of rarely-used arguments, and
introducing more of them requires yet another update of all the call
sites.  Refactor most of them into a struct to make future extensions
easier.

The ones that stay "plain" arguments were chosen on the grounds that
all callers put real arguments there, whereas some callers have 0/NULL
for all arguments that were factored into the struct.

We declare the struct 'const' to ensure none of the callers are bitten
by the changed (no longer call-by-value) semantics.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin-branch.c      |    3 ++-
 builtin-checkout.c    |    3 ++-
 builtin-log.c         |    3 ++-
 builtin-merge.c       |    7 +++++--
 builtin-rev-list.c    |    7 ++++---
 builtin-shortlog.c    |    9 ++++++---
 builtin-show-branch.c |    4 ++--
 commit.h              |   19 +++++++++++++------
 log-tree.c            |   20 ++++++++++----------
 pretty.c              |   27 ++++++++++++++-------------
 10 files changed, 60 insertions(+), 42 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 9f57992..05e876e 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -387,8 +387,9 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 		commit = item->commit;
 		if (commit && !parse_commit(commit)) {
+			struct pretty_print_context ctx = {0};
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-					    &subject, 0, NULL, NULL, 0, 0);
+					    &subject, &ctx);
 			sub = subject.buf;
 		}
 
diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..075a49f 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -302,8 +302,9 @@ static void show_local_changes(struct object *head)
 static void describe_detached_head(char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
 	parse_commit(commit);
-	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, NULL, NULL, 0, 0);
+	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, &ctx);
 	fprintf(stderr, "%s %s... %s\n", msg,
 		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
diff --git a/builtin-log.c b/builtin-log.c
index 25e21ed..207a361 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1304,8 +1304,9 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 
 		if (verbose) {
 			struct strbuf buf = STRBUF_INIT;
+			struct pretty_print_context ctx = {0};
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-			                    &buf, 0, NULL, NULL, 0, 0);
+					    &buf, &ctx);
 			printf("%c %s %s\n", sign,
 			       sha1_to_hex(commit->object.sha1), buf.buf);
 			strbuf_release(&buf);
diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..c69a305 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -264,6 +264,7 @@ static void squash_message(void)
 	struct strbuf out = STRBUF_INIT;
 	struct commit_list *j;
 	int fd;
+	struct pretty_print_context ctx = {0};
 
 	printf("Squash commit -- not updating HEAD\n");
 	fd = open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
@@ -285,13 +286,15 @@ static void squash_message(void)
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
 
+	ctx.abbrev = rev.abbrev;
+	ctx.date_mode = rev.date_mode;
+
 	strbuf_addstr(&out, "Squashed commit of the following:\n");
 	while ((commit = get_revision(&rev)) != NULL) {
 		strbuf_addch(&out, '\n');
 		strbuf_addf(&out, "commit %s\n",
 			sha1_to_hex(commit->object.sha1));
-		pretty_print_commit(rev.commit_format, commit, &out, rev.abbrev,
-			NULL, NULL, rev.date_mode, 0);
+		pretty_print_commit(rev.commit_format, commit, &out, &ctx);
 	}
 	if (write(fd, out.buf, out.len) < 0)
 		die_errno("Writing SQUASH_MSG");
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4ba1c12..42cc8d8 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -96,9 +96,10 @@ static void show_commit(struct commit *commit, void *data)
 
 	if (revs->verbose_header && commit->buffer) {
 		struct strbuf buf = STRBUF_INIT;
-		pretty_print_commit(revs->commit_format, commit,
-				    &buf, revs->abbrev, NULL, NULL,
-				    revs->date_mode, 0);
+		struct pretty_print_context ctx = {0};
+		ctx.abbrev = revs->abbrev;
+		ctx.date_mode = revs->date_mode;
+		pretty_print_commit(revs->commit_format, commit, &buf, &ctx);
 		if (revs->graph) {
 			if (buf.len) {
 				if (revs->commit_format != CMIT_FMT_ONELINE)
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 4d4a3c8..8aa63c7 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -158,9 +158,12 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		    sha1_to_hex(commit->object.sha1));
 	if (log->user_format) {
 		struct strbuf buf = STRBUF_INIT;
-
-		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &buf,
-			DEFAULT_ABBREV, "", "", DATE_NORMAL, 0);
+		struct pretty_print_context ctx = {0};
+		ctx.abbrev = DEFAULT_ABBREV;
+		ctx.subject = "";
+		ctx.after_subject = "";
+		ctx.date_mode = DATE_NORMAL;
+		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &buf, &ctx);
 		insert_one_record(log, author, buf.buf);
 		strbuf_release(&buf);
 		return;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index be95930..9f13caa 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -293,8 +293,8 @@ static void show_one_commit(struct commit *commit, int no_name)
 	struct commit_name *name = commit->util;
 
 	if (commit->object.parsed) {
-		pretty_print_commit(CMIT_FMT_ONELINE, commit,
-				    &pretty, 0, NULL, NULL, 0, 0);
+		struct pretty_print_context ctx = {0};
+		pretty_print_commit(CMIT_FMT_ONELINE, commit, &pretty, &ctx);
 		pretty_str = pretty.buf;
 	}
 	if (!prefixcmp(pretty_str, "[PATCH] "))
diff --git a/commit.h b/commit.h
index f4fc5c5..011766d 100644
--- a/commit.h
+++ b/commit.h
@@ -63,6 +63,15 @@ enum cmit_fmt {
 	CMIT_FMT_UNSPECIFIED,
 };
 
+struct pretty_print_context
+{
+	int abbrev;
+	const char *subject;
+	const char *after_subject;
+	enum date_mode date_mode;
+	int need_8bit_cte;
+};
+
 extern int non_ascii(int);
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
@@ -71,12 +80,10 @@ enum cmit_fmt {
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern void format_commit_message(const struct commit *commit,
 				  const void *format, struct strbuf *sb,
-				  enum date_mode dmode);
-extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
-                                struct strbuf *,
-                                int abbrev, const char *subject,
-                                const char *after_subject, enum date_mode,
-				int need_8bit_cte);
+				  const struct pretty_print_context *context);
+extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
+				struct strbuf *sb,
+				const struct pretty_print_context *context);
 void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		   const char *line, enum date_mode dmode,
 		   const char *encoding);
diff --git a/log-tree.c b/log-tree.c
index f7d54f2..f57487f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -277,10 +277,9 @@ void show_log(struct rev_info *opt)
 	struct strbuf msgbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
-	int abbrev = opt->diffopt.abbrev;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
-	const char *subject = NULL, *extra_headers = opt->extra_headers;
-	int need_8bit_cte = 0;
+	const char *extra_headers = opt->extra_headers;
+	struct pretty_print_context ctx = {0};
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
@@ -347,8 +346,8 @@ void show_log(struct rev_info *opt)
 	 */
 
 	if (opt->commit_format == CMIT_FMT_EMAIL) {
-		log_write_email_headers(opt, commit, &subject, &extra_headers,
-					&need_8bit_cte);
+		log_write_email_headers(opt, commit, &ctx.subject, &extra_headers,
+					&ctx.need_8bit_cte);
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
@@ -405,11 +404,12 @@ void show_log(struct rev_info *opt)
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	if (need_8bit_cte >= 0)
-		need_8bit_cte = has_non_ascii(opt->add_signoff);
-	pretty_print_commit(opt->commit_format, commit, &msgbuf,
-			    abbrev, subject, extra_headers, opt->date_mode,
-			    need_8bit_cte);
+	if (ctx.need_8bit_cte >= 0)
+		ctx.need_8bit_cte = has_non_ascii(opt->add_signoff);
+	ctx.date_mode = opt->date_mode;
+	ctx.abbrev = opt->diffopt.abbrev;
+	ctx.after_subject = extra_headers;
+	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
diff --git a/pretty.c b/pretty.c
index f5983f8..d6d57eb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -442,7 +442,7 @@ struct chunk {
 
 struct format_commit_context {
 	const struct commit *commit;
-	enum date_mode dmode;
+	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
 
@@ -711,11 +711,11 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'a':	/* author ... */
 		return format_person_part(sb, placeholder[1],
 				   msg + c->author.off, c->author.len,
-				   c->dmode);
+				   c->pretty_ctx->date_mode);
 	case 'c':	/* committer ... */
 		return format_person_part(sb, placeholder[1],
 				   msg + c->committer.off, c->committer.len,
-				   c->dmode);
+				   c->pretty_ctx->date_mode);
 	case 'e':	/* encoding */
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
 		return 1;
@@ -741,13 +741,13 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 
 void format_commit_message(const struct commit *commit,
 			   const void *format, struct strbuf *sb,
-			   enum date_mode dmode)
+			   const struct pretty_print_context *pretty_ctx)
 {
 	struct format_commit_context context;
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
-	context.dmode = dmode;
+	context.pretty_ctx = pretty_ctx;
 	strbuf_expand(sb, format, format_commit_item, &context);
 }
 
@@ -900,18 +900,18 @@ void pp_remainder(enum cmit_fmt fmt,
 }
 
 void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
-			 struct strbuf *sb, int abbrev,
-			 const char *subject, const char *after_subject,
-			 enum date_mode dmode, int need_8bit_cte)
+			 struct strbuf *sb,
+			 const struct pretty_print_context *context)
 {
 	unsigned long beginning_of_body;
 	int indent = 4;
 	const char *msg = commit->buffer;
 	char *reencoded;
 	const char *encoding;
+	int need_8bit_cte = context->need_8bit_cte;
 
 	if (fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, dmode);
+		format_commit_message(commit, user_format, sb, context);
 		return;
 	}
 
@@ -946,8 +946,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		}
 	}
 
-	pp_header(fmt, abbrev, dmode, encoding, commit, &msg, sb);
-	if (fmt != CMIT_FMT_ONELINE && !subject) {
+	pp_header(fmt, context->abbrev, context->date_mode, encoding,
+		  commit, &msg, sb);
+	if (fmt != CMIT_FMT_ONELINE && !context->subject) {
 		strbuf_addch(sb, '\n');
 	}
 
@@ -956,8 +957,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 
 	/* These formats treat the title line specially. */
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
-		pp_title_line(fmt, &msg, sb, subject,
-			      after_subject, encoding, need_8bit_cte);
+		pp_title_line(fmt, &msg, sb, context->subject,
+			      context->after_subject, encoding, need_8bit_cte);
 
 	beginning_of_body = sb->len;
 	if (fmt != CMIT_FMT_ONELINE)
-- 
1.6.5.18.g9f87a.dirty
