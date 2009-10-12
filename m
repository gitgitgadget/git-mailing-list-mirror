From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 2/5] Introduce new pretty formats %g and %G for reflog information
Date: Mon, 12 Oct 2009 23:06:04 +0200
Message-ID: <e0321a8af8d702d24ace33510daff22d02f4e116.1255380039.git.trast@student.ethz.ch>
References: <cover.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	<git@vger.kernel.org>
To: Jef Driesen <jefdriesen@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDi-0002of-TI
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129AbZJLVHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933103AbZJLVHu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:07:50 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:56482 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933057AbZJLVHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:07:47 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 23:06:43 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 23:06:45 +0200
X-Mailer: git-send-email 1.6.5.64.g01287
In-Reply-To: <cover.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130072>

Add two new pretty escapes: %g expands to the reflog selector (i.e.,
branch@{number} or branch@{date}) and %G expands to the reflog
message.

We use the newly refactored selector formatting function and introduce
another wrapper to get the reflog message.

Unfortunately, we also need to pass down the reflog_walk_info from
show_log(), so this commit touches a lot of (unrelated) callers to
pretty_print_commit() and format_commit_message() to accomodate the
extra argument.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 archive.c             |    2 +-
 builtin-branch.c      |    3 ++-
 builtin-checkout.c    |    2 +-
 builtin-commit.c      |    4 ++--
 builtin-log.c         |    2 +-
 builtin-merge.c       |    2 +-
 builtin-rev-list.c    |    2 +-
 builtin-shortlog.c    |    2 +-
 builtin-show-branch.c |    2 +-
 commit.h              |    7 +++++--
 log-tree.c            |    4 ++--
 pretty.c              |   20 +++++++++++++++++---
 reflog-walk.c         |   16 ++++++++++++++++
 reflog-walk.h         |    7 +++++++
 14 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/archive.c b/archive.c
index 0cc79d2..d325ce3 100644
--- a/archive.c
+++ b/archive.c
@@ -48,7 +48,7 @@ static void format_subst(const struct commit *commit,
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
 		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf, DATE_NORMAL);
+		format_commit_message(commit, fmt.buf, buf, DATE_NORMAL, NULL);
 		len -= c + 1 - src;
 		src  = c + 1;
 	}
diff --git a/builtin-branch.c b/builtin-branch.c
index 9f57992..d90bfaf 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -388,7 +388,8 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		commit = item->commit;
 		if (commit && !parse_commit(commit)) {
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-					    &subject, 0, NULL, NULL, 0, 0);
+					    &subject, 0, NULL, NULL, 0, 0,
+					    NULL);
 			sub = subject.buf;
 		}
 
diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..b6b9c45 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -303,7 +303,7 @@ static void describe_detached_head(char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 	parse_commit(commit);
-	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, NULL, NULL, 0, 0);
+	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, NULL, NULL, 0, 0, NULL);
 	fprintf(stderr, "%s %s... %s\n", msg,
 		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..d63d467 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -685,7 +685,7 @@ static int message_is_empty(struct strbuf *sb)
 	commit = get_revision(&revs);
 	if (commit) {
 		strbuf_release(&buf);
-		format_commit_message(commit, "%an <%ae>", &buf, DATE_NORMAL);
+		format_commit_message(commit, "%an <%ae>", &buf, DATE_NORMAL, NULL);
 		return strbuf_detach(&buf, NULL);
 	}
 	die("No existing author found with '%s'", name);
@@ -943,7 +943,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	if (!log_tree_commit(&rev, commit)) {
 		struct strbuf buf = STRBUF_INIT;
-		format_commit_message(commit, format + 7, &buf, DATE_NORMAL);
+		format_commit_message(commit, format + 7, &buf, DATE_NORMAL, NULL);
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/builtin-log.c b/builtin-log.c
index 25e21ed..57df76e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1305,7 +1305,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		if (verbose) {
 			struct strbuf buf = STRBUF_INIT;
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-			                    &buf, 0, NULL, NULL, 0, 0);
+			                    &buf, 0, NULL, NULL, 0, 0, NULL);
 			printf("%c %s %s\n", sign,
 			       sha1_to_hex(commit->object.sha1), buf.buf);
 			strbuf_release(&buf);
diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..70f1488 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -291,7 +291,7 @@ static void squash_message(void)
 		strbuf_addf(&out, "commit %s\n",
 			sha1_to_hex(commit->object.sha1));
 		pretty_print_commit(rev.commit_format, commit, &out, rev.abbrev,
-			NULL, NULL, rev.date_mode, 0);
+			NULL, NULL, rev.date_mode, 0, NULL);
 	}
 	if (write(fd, out.buf, out.len) < 0)
 		die_errno("Writing SQUASH_MSG");
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4ba1c12..78659c8 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -98,7 +98,7 @@ static void show_commit(struct commit *commit, void *data)
 		struct strbuf buf = STRBUF_INIT;
 		pretty_print_commit(revs->commit_format, commit,
 				    &buf, revs->abbrev, NULL, NULL,
-				    revs->date_mode, 0);
+				    revs->date_mode, 0, NULL);
 		if (revs->graph) {
 			if (buf.len) {
 				if (revs->commit_format != CMIT_FMT_ONELINE)
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 4d4a3c8..128b382 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -160,7 +160,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		struct strbuf buf = STRBUF_INIT;
 
 		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &buf,
-			DEFAULT_ABBREV, "", "", DATE_NORMAL, 0);
+			DEFAULT_ABBREV, "", "", DATE_NORMAL, 0, NULL);
 		insert_one_record(log, author, buf.buf);
 		strbuf_release(&buf);
 		return;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index be95930..73ea7ce 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -294,7 +294,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 
 	if (commit->object.parsed) {
 		pretty_print_commit(CMIT_FMT_ONELINE, commit,
-				    &pretty, 0, NULL, NULL, 0, 0);
+				    &pretty, 0, NULL, NULL, 0, 0, NULL);
 		pretty_str = pretty.buf;
 	}
 	if (!prefixcmp(pretty_str, "[PATCH] "))
diff --git a/commit.h b/commit.h
index f4fc5c5..93efeeb 100644
--- a/commit.h
+++ b/commit.h
@@ -69,14 +69,17 @@ enum cmit_fmt {
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
+struct reflog_walk_info;
 extern void format_commit_message(const struct commit *commit,
 				  const void *format, struct strbuf *sb,
-				  enum date_mode dmode);
+				  enum date_mode dmode,
+				  struct reflog_walk_info *reflog_info);
 extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
                                 struct strbuf *,
                                 int abbrev, const char *subject,
                                 const char *after_subject, enum date_mode,
-				int need_8bit_cte);
+				int need_8bit_cte,
+				struct reflog_walk_info *reflog_info);
 void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		   const char *line, enum date_mode dmode,
 		   const char *encoding);
diff --git a/log-tree.c b/log-tree.c
index 1618f3c..e75f953 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -179,7 +179,7 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 	if (commit) {
 		int max_len = start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
 
-		format_commit_message(commit, "%f", buf, DATE_NORMAL);
+		format_commit_message(commit, "%f", buf, DATE_NORMAL, NULL);
 		if (max_len < buf->len)
 			strbuf_setlen(buf, max_len);
 		strbuf_addstr(buf, suffix);
@@ -408,7 +408,7 @@ void show_log(struct rev_info *opt)
 		need_8bit_cte = has_non_ascii(opt->add_signoff);
 	pretty_print_commit(opt->commit_format, commit, &msgbuf,
 			    abbrev, subject, extra_headers, opt->date_mode,
-			    need_8bit_cte);
+			    need_8bit_cte, opt->reflog_info);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
diff --git a/pretty.c b/pretty.c
index f5983f8..0b67580 100644
--- a/pretty.c
+++ b/pretty.c
@@ -7,6 +7,7 @@
 #include "mailmap.h"
 #include "log-tree.h"
 #include "color.h"
+#include "reflog-walk.h"
 
 static char *user_format;
 
@@ -443,6 +444,7 @@ struct chunk {
 struct format_commit_context {
 	const struct commit *commit;
 	enum date_mode dmode;
+	struct reflog_walk_info *reflog_info;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
 
@@ -701,6 +703,14 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'd':
 		format_decoration(sb, commit);
 		return 1;
+	case 'g':		/* reflog handle */
+		if (c->reflog_info)
+			get_reflog_selector(sb, c->reflog_info, c->dmode);
+		return 1;
+	case 'G':		/* reflog message */
+		if (c->reflog_info)
+			get_reflog_message(sb, c->reflog_info);
+		return 1;
 	}
 
 	/* For the rest we have to parse the commit header. */
@@ -741,13 +751,15 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 
 void format_commit_message(const struct commit *commit,
 			   const void *format, struct strbuf *sb,
-			   enum date_mode dmode)
+			   enum date_mode dmode,
+			   struct reflog_walk_info *reflog_info)
 {
 	struct format_commit_context context;
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.dmode = dmode;
+	context.reflog_info = reflog_info;
 	strbuf_expand(sb, format, format_commit_item, &context);
 }
 
@@ -902,7 +914,8 @@ void pp_remainder(enum cmit_fmt fmt,
 void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 			 struct strbuf *sb, int abbrev,
 			 const char *subject, const char *after_subject,
-			 enum date_mode dmode, int need_8bit_cte)
+			 enum date_mode dmode, int need_8bit_cte,
+			 struct reflog_walk_info *reflog_info)
 {
 	unsigned long beginning_of_body;
 	int indent = 4;
@@ -911,7 +924,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	const char *encoding;
 
 	if (fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, dmode);
+		format_commit_message(commit, user_format, sb, dmode,
+				      reflog_info);
 		return;
 	}
 
diff --git a/reflog-walk.c b/reflog-walk.c
index 9478dbc..929f025 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -265,6 +265,22 @@ void get_reflog_selector(struct strbuf *sb,
 	strbuf_addch(sb, '}');
 }
 
+void get_reflog_message(struct strbuf *sb,
+			struct reflog_walk_info *reflog_info)
+{
+	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
+	struct reflog_info *info;
+
+	if (!commit_reflog)
+		return;
+
+	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+	size_t len = strlen(info->message);
+	if (len > 0)
+		len--;
+	strbuf_add(sb, info->message, len);
+}
+
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 	enum date_mode dmode)
 {
diff --git a/reflog-walk.h b/reflog-walk.h
index 74c9096..986121f 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -3,6 +3,8 @@
 
 #include "cache.h"
 
+struct reflog_walk_info;
+
 extern void init_reflog_walk(struct reflog_walk_info** info);
 extern int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
@@ -10,5 +12,10 @@ extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
 extern void show_reflog_message(struct reflog_walk_info *info, int,
 		enum date_mode);
+extern void get_reflog_message(struct strbuf *sb,
+		struct reflog_walk_info *reflog_info);
+extern void get_reflog_selector(struct strbuf *sb,
+		struct reflog_walk_info *reflog_info,
+		enum date_mode dmode);
 
 #endif
-- 
1.6.5.64.g01287
