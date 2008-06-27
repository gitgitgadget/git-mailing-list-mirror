From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 06/15] git-fmt-merge-msg: make it usable from other builtins
Date: Fri, 27 Jun 2008 18:21:59 +0200
Message-ID: <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk5-0004E3-A3
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759744AbYF0QW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756321AbYF0QW2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:28 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45346 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760570AbYF0QWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:12 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id B131B1DDC65;
	Fri, 27 Jun 2008 18:22:06 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 4C2C218E82A; Fri, 27 Jun 2008 18:22:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86580>

Move all functionality (except config and option parsing) from
cmd_fmt_merge_msg() to fmt_merge_msg(), so that other builtins can use
it without a child process.

All functions have been changed to use strbufs, and now only
cmd_fmt_merge_msg() reads directly from a file / writes anything to
stdout.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-fmt-merge-msg.c |  155 +++++++++++++++++++++++++++--------------------
 builtin.h               |    3 +
 2 files changed, 92 insertions(+), 66 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index b892621..dbd7d2d 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -159,23 +159,24 @@ static int handle_line(char *line)
 }
 
 static void print_joined(const char *singular, const char *plural,
-		struct list *list)
+		struct list *list, struct strbuf *out)
 {
 	if (list->nr == 0)
 		return;
 	if (list->nr == 1) {
-		printf("%s%s", singular, list->list[0]);
+		strbuf_addf(out, "%s%s", singular, list->list[0]);
 	} else {
 		int i;
-		printf("%s", plural);
+		strbuf_addstr(out, plural);
 		for (i = 0; i < list->nr - 1; i++)
-			printf("%s%s", i > 0 ? ", " : "", list->list[i]);
-		printf(" and %s", list->list[list->nr - 1]);
+			strbuf_addf(out, "%s%s", i > 0 ? ", " : "", list->list[i]);
+		strbuf_addf(out, " and %s", list->list[list->nr - 1]);
 	}
 }
 
 static void shortlog(const char *name, unsigned char *sha1,
-		struct commit *head, struct rev_info *rev, int limit)
+		struct commit *head, struct rev_info *rev, int limit,
+		struct strbuf *out)
 {
 	int i, count = 0;
 	struct commit *commit;
@@ -232,15 +233,15 @@ static void shortlog(const char *name, unsigned char *sha1,
 	}
 
 	if (count > limit)
-		printf("\n* %s: (%d commits)\n", name, count);
+		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
 	else
-		printf("\n* %s:\n", name);
+		strbuf_addf(out, "\n* %s:\n", name);
 
 	for (i = 0; i < subjects.nr; i++)
 		if (i >= limit)
-			printf("  ...\n");
+			strbuf_addf(out, "  ...\n");
 		else
-			printf("  %s\n", subjects.list[i]);
+			strbuf_addf(out, "  %s\n", subjects.list[i]);
 
 	clear_commit_marks((struct commit *)branch, flags);
 	clear_commit_marks(head, flags);
@@ -251,43 +252,13 @@ static void shortlog(const char *name, unsigned char *sha1,
 	free_list(&subjects);
 }
 
-int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
-{
-	int limit = 20, i = 0;
+int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
+	int limit = 20, i = 0, pos = 0;
 	char line[1024];
-	FILE *in = stdin;
-	const char *sep = "";
+	char *p = line, *sep = "";
 	unsigned char head_sha1[20];
 	const char *current_branch;
 
-	git_config(fmt_merge_msg_config, NULL);
-
-	while (argc > 1) {
-		if (!strcmp(argv[1], "--log") || !strcmp(argv[1], "--summary"))
-			merge_summary = 1;
-		else if (!strcmp(argv[1], "--no-log")
-				|| !strcmp(argv[1], "--no-summary"))
-			merge_summary = 0;
-		else if (!strcmp(argv[1], "-F") || !strcmp(argv[1], "--file")) {
-			if (argc < 3)
-				die ("Which file?");
-			if (!strcmp(argv[2], "-"))
-				in = stdin;
-			else {
-				fclose(in);
-				in = fopen(argv[2], "r");
-				if (!in)
-					die("cannot open %s", argv[2]);
-			}
-			argc--; argv++;
-		} else
-			break;
-		argc--; argv++;
-	}
-
-	if (argc > 1)
-		usage(fmt_merge_msg_usage);
-
 	/* get current branch */
 	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
@@ -295,75 +266,127 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	if (!prefixcmp(current_branch, "refs/heads/"))
 		current_branch += 11;
 
-	while (fgets(line, sizeof(line), in)) {
+	/* get a line */
+	while (pos < in->len) {
+		int len;
+		char *newline;
+
+		p = in->buf + pos;
+		newline = strchr(p, '\n');
+		len = newline ? newline - p : strlen(p);
+		pos += len + !!newline;
 		i++;
-		if (line[0] == 0)
-			continue;
-		if (handle_line(line))
-			die ("Error in line %d: %s", i, line);
+		p[len] = 0;
+		if (handle_line(p))
+			die ("Error in line %d: %.*s", i, len, p);
 	}
 
-	printf("Merge ");
+	strbuf_addstr(out, "Merge ");
 	for (i = 0; i < srcs.nr; i++) {
 		struct src_data *src_data = srcs.payload[i];
 		const char *subsep = "";
 
-		printf(sep);
+		strbuf_addstr(out, sep);
 		sep = "; ";
 
 		if (src_data->head_status == 1) {
-			printf(srcs.list[i]);
+			strbuf_addstr(out, srcs.list[i]);
 			continue;
 		}
 		if (src_data->head_status == 3) {
 			subsep = ", ";
-			printf("HEAD");
+			strbuf_addstr(out, "HEAD");
 		}
 		if (src_data->branch.nr) {
-			printf(subsep);
+			strbuf_addstr(out, subsep);
 			subsep = ", ";
-			print_joined("branch ", "branches ", &src_data->branch);
+			print_joined("branch ", "branches ", &src_data->branch,
+					out);
 		}
 		if (src_data->r_branch.nr) {
-			printf(subsep);
+			strbuf_addstr(out, subsep);
 			subsep = ", ";
 			print_joined("remote branch ", "remote branches ",
-					&src_data->r_branch);
+					&src_data->r_branch, out);
 		}
 		if (src_data->tag.nr) {
-			printf(subsep);
+			strbuf_addstr(out, subsep);
 			subsep = ", ";
-			print_joined("tag ", "tags ", &src_data->tag);
+			print_joined("tag ", "tags ", &src_data->tag, out);
 		}
 		if (src_data->generic.nr) {
-			printf(subsep);
-			print_joined("commit ", "commits ", &src_data->generic);
+			strbuf_addstr(out, subsep);
+			print_joined("commit ", "commits ", &src_data->generic,
+					out);
 		}
 		if (strcmp(".", srcs.list[i]))
-			printf(" of %s", srcs.list[i]);
+			strbuf_addf(out, " of %s", srcs.list[i]);
 	}
 
 	if (!strcmp("master", current_branch))
-		putchar('\n');
+		strbuf_addch(out, '\n');
 	else
-		printf(" into %s\n", current_branch);
+		strbuf_addf(out, " into %s\n", current_branch);
 
 	if (merge_summary) {
 		struct commit *head;
 		struct rev_info rev;
 
 		head = lookup_commit(head_sha1);
-		init_revisions(&rev, prefix);
+		init_revisions(&rev, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
 		rev.limited = 1;
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.list[i], origins.payload[i],
-					head, &rev, limit);
+					head, &rev, limit, out);
 	}
+	return 0;
+}
+
+int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
+{
+	FILE *in = stdin;
+	struct strbuf input, output;
+	int ret;
+
+	git_config(fmt_merge_msg_config, NULL);
+
+	while (argc > 1) {
+		if (!strcmp(argv[1], "--log") || !strcmp(argv[1], "--summary"))
+			merge_summary = 1;
+		else if (!strcmp(argv[1], "--no-log")
+				|| !strcmp(argv[1], "--no-summary"))
+			merge_summary = 0;
+		else if (!strcmp(argv[1], "-F") || !strcmp(argv[1], "--file")) {
+			if (argc < 3)
+				die ("Which file?");
+			if (!strcmp(argv[2], "-"))
+				in = stdin;
+			else {
+				fclose(in);
+				in = fopen(argv[2], "r");
+				if (!in)
+					die("cannot open %s", argv[2]);
+			}
+			argc--; argv++;
+		} else
+			break;
+		argc--; argv++;
+	}
+
+	if (argc > 1)
+		usage(fmt_merge_msg_usage);
 
-	/* No cleanup yet; is standalone anyway */
+	strbuf_init(&input, 0);
+	if (strbuf_read(&input, fileno(in), 0) < 0)
+		die("could not read input file %s", strerror(errno));
+	strbuf_init(&output, 0);
 
+	ret = fmt_merge_msg(merge_summary, &input, &output);
+	if (ret)
+		return ret;
+	printf("%s", output.buf);
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index b460b2d..2b01fea 100644
--- a/builtin.h
+++ b/builtin.h
@@ -2,6 +2,7 @@
 #define BUILTIN_H
 
 #include "git-compat-util.h"
+#include "strbuf.h"
 
 extern const char git_version_string[];
 extern const char git_usage_string[];
@@ -11,6 +12,8 @@ extern void list_common_cmds_help(void);
 extern void help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
 extern int read_line_with_nul(char *buf, int size, FILE *file);
+extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
+	struct strbuf *out);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
-- 
1.5.6
