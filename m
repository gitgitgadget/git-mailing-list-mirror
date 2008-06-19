From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 07/11] git-fmt-merge-msg: make it usable from other builtins
Date: Fri, 20 Jun 2008 01:22:32 +0200
Message-ID: <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
 <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
 <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org>
 <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org>
 <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org>
 <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TUV-0006Vg-Bq
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbYFSXXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYFSXXD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:23:03 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46954 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbYFSXWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:54 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id E1E5D1DDC5D
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:51 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B36F318E0EC; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85571>

Move all functionality (except config and option parsing) from
cmd_fmt_merge_msg() to fmt_merge_msg(), so that other builtins can use
it without a child process.

All functions have been changed to use strbufs, and now only
cmd_fmt_merge_msg() reads directly from a file / writes anything to
stdout.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-fmt-merge-msg.c |  157 +++++++++++++++++++++++++++--------------------
 builtin.h               |    3 +
 2 files changed, 94 insertions(+), 66 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index b892621..91f08e9 100644
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
@@ -295,75 +266,129 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	if (!prefixcmp(current_branch, "refs/heads/"))
 		current_branch += 11;
 
-	while (fgets(line, sizeof(line), in)) {
+	/* get a line */
+	for (;;) {
+		int len;
+		char *newline;
+
+		if (pos >= in->len)
+			break;
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
