From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make git-fmt-merge-msg a builtin
Date: Mon, 3 Jul 2006 15:31:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607031530380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jul 03 15:31:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxOWl-0004tl-Kg
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 15:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWGCNbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 09:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWGCNbg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 09:31:36 -0400
Received: from mail.gmx.de ([213.165.64.21]:34451 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751158AbWGCNbe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 09:31:34 -0400
Received: (qmail invoked by alias); 03 Jul 2006 13:31:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 03 Jul 2006 15:31:33 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23174>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This does not (yet) remove the Perl version.

 Makefile                |    2 
 builtin-fmt-merge-msg.c |  357 +++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h               |    1 
 git.c                   |    3 
 4 files changed, 361 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c142bdd..c75b8a9 100644
--- a/Makefile
+++ b/Makefile
@@ -245,7 +245,7 @@ BUILTIN_OBJS = \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
-	builtin-update-ref.o
+	builtin-update-ref.o builtin-fmt-merge-msg.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
new file mode 100644
index 0000000..a73b322
--- /dev/null
+++ b/builtin-fmt-merge-msg.c
@@ -0,0 +1,357 @@
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "tag.h"
+
+static const char *fmt_merge_msg_usage =
+	"git-fmt-merge-msg [--summary] [--no-summary] [--file <file>]";
+
+static int merge_summary = 0;
+
+static int fmt_merge_msg_config(const char *key, const char *value)
+{
+	if (!strcmp("merge.summary", key))
+		merge_summary = git_config_bool(key, value);
+	return 0;
+}
+
+struct list {
+	char **list;
+	void **payload;
+	unsigned nr, alloc;
+};
+
+static void append_to_list(struct list *list, char *value)
+{
+	if (list->nr == list->alloc) {
+		list->alloc += 32;
+		list->list = realloc(list->list, sizeof(char *) * list->alloc);
+		list->payload = realloc(list->payload,
+				sizeof(char *) * list->alloc);
+	}
+	list->payload[list->nr] = NULL;
+	list->list[list->nr++] = value;
+}
+
+static int find_in_list(struct list *list, char *value)
+{
+	int i;
+
+	for (i = 0; i < list->nr; i++)
+		if (!strcmp(list->list[i], value))
+			return i;
+
+	return -1;
+}
+
+static void free_list(struct list *list)
+{
+	int i;
+
+	if (list->alloc == 0)
+		return;
+
+	for (i = 0; i < list->nr; i++) {
+		free(list->list[i]);
+		if (list->payload[i])
+			free(list->payload[i]);
+	}
+	free(list->list);
+	free(list->payload);
+	list->nr = list->alloc = 0;
+}
+
+struct src_data {
+	struct list branch, tag, r_branch, generic;
+	int head_status;
+};
+
+static struct list srcs = { NULL, NULL, 0, 0};
+static struct list origins = { NULL, NULL, 0, 0};
+
+static int handle_line(char *line)
+{
+	int i, len = strlen(line);
+	unsigned char *sha1;
+	char *src, *origin;
+	struct src_data *src_data;
+
+	if (len < 43 || line[40] != '\t')
+		return 1;
+
+	if (!strncmp(line + 41, "not-for-merge", 13))
+		return 0;
+
+	if (line[41] != '\t')
+		return 2;
+
+	line[40] = 0;
+	sha1 = xmalloc(20);
+	i = get_sha1(line, sha1);
+	line[40] = '\t';
+	if (i)
+		return 3;
+
+	if (line[len - 1] == '\n')
+		line[len - 1] = 0;
+	line += 42;
+
+	src = strstr(line, " of ");
+	if (src) {
+		*src = 0;
+		src += 4;
+	} else
+		src = "HEAD";
+
+	i = find_in_list(&srcs, src);
+	if (i < 0) {
+		i = srcs.nr;
+		append_to_list(&srcs, strdup(src));
+		srcs.payload[i] = xcalloc(1, sizeof(struct src_data));
+	}
+	src_data = srcs.payload[i];
+
+	if (!strncmp(line, "branch ", 7)) {
+		origin = strdup(line + 7);
+		append_to_list(&(src_data->branch), origin);
+		src_data->head_status |= 2;
+	} else if (!strncmp(line, "tag ", 4)) {
+		origin = line;
+		append_to_list(&(src_data->tag), strdup(origin + 4));
+		src_data->head_status |= 2;
+	} else if (!strncmp(line, "remote branch ", 14)) {
+		origin = strdup(line + 14);
+		append_to_list(&(src_data->r_branch), origin);
+		src_data->head_status |= 2;
+	} else if (!strcmp(line, "HEAD")) {
+		origin = strdup(src);
+		src_data->head_status |= 1;
+	} else {
+		origin = strdup(src);
+		append_to_list(&(src_data->generic), strdup(line));
+		src_data->head_status |= 2;
+	}
+
+	if (!strcmp(".", src) || !strcmp(src, origin)) {
+		int len = strlen(origin);
+		if (origin[0] == '\'' && origin[len - 1] == '\'') {
+			char *new_origin = malloc(len - 1);
+			memcpy(new_origin, origin + 1, len - 2);
+			new_origin[len - 1] = 0;
+			origin = new_origin;
+		} else
+			origin = strdup(origin);
+	} else {
+		char *new_origin = malloc(strlen(origin) + strlen(src) + 5);
+		sprintf(new_origin, "%s of %s", origin, src);
+		origin = new_origin;
+	}
+	append_to_list(&origins, origin);
+	origins.payload[origins.nr - 1] = sha1;
+	return 0;
+}
+
+static void print_joined(const char *singular, const char *plural,
+		struct list *list)
+{
+	if (list->nr == 0)
+		return;
+	if (list->nr == 1) {
+		printf("%s%s", singular, list->list[0]);
+	} else {
+		int i;
+		printf("%s", plural);
+		for (i = 0; i < list->nr - 1; i++)
+			printf("%s%s", i > 0 ? ", " : "", list->list[i]);
+		printf(" and %s", list->list[list->nr - 1]);
+	}
+}
+
+static void shortlog(const char *name, unsigned char *sha1,
+		struct commit *head, struct rev_info *rev, int limit)
+{
+	int i, count = 0;
+	struct commit *commit;
+	struct object *branch;
+	struct list subjects = { NULL, NULL, 0, 0 };
+	int flags = UNINTERESTING | TREECHANGE | SEEN | SHOWN | ADDED;
+
+	branch = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
+	if (!branch || branch->type != TYPE_COMMIT)
+		return;
+
+	setup_revisions(0, NULL, rev, NULL);
+	rev->ignore_merges = 1;
+	add_pending_object(rev, branch, name);
+	add_pending_object(rev, &(head->object), "^HEAD");
+	head->object.flags |= UNINTERESTING;
+        prepare_revision_walk(rev);
+	while ((commit = get_revision(rev)) != NULL) {
+		char *oneline, *bol, *eol;
+
+		/* ignore merges */
+		if (commit->parents && commit->parents->next)
+			continue;
+
+		count++;
+		if (subjects.nr > limit)
+			continue;
+
+		bol = strstr(commit->buffer, "\n\n");
+		if (!bol) {
+			append_to_list(&subjects, strdup(sha1_to_hex(
+							commit->object.sha1)));
+			continue;
+		}
+
+		bol += 2;
+		eol = strchr(bol, '\n');
+		
+		if (eol) {
+			int len = eol - bol;
+			oneline = malloc(len + 1);
+			memcpy(oneline, bol, len);
+			oneline[len] = 0;
+		} else
+			oneline = strdup(bol);
+		append_to_list(&subjects, oneline);
+	}
+
+	if (count > limit)
+		printf("\n* %s: (%d commits)\n", name, count);
+	else
+		printf("\n* %s:\n", name);
+
+	for (i = 0; i < subjects.nr; i++)
+		if (i >= limit)
+			printf("  ...\n");
+		else
+			printf("  %s\n", subjects.list[i]);
+
+	clear_commit_marks((struct commit *)branch, flags);
+	clear_commit_marks(head, flags);
+	free_commit_list(rev->commits);
+	rev->commits = NULL;
+	rev->pending.nr = 0;
+
+	free_list(&subjects);
+	
+}
+
+int cmd_fmt_merge_msg(int argc, char **argv, char **envp)
+{
+	int limit = 20, i = 0;
+	char line[1024];
+	FILE *in = stdin;
+	const char *sep = "";
+	unsigned char head_sha1[20];
+	const char *head, *current_branch;
+
+	git_config(fmt_merge_msg_config);
+
+	while (argc > 1) {
+		if (!strcmp(argv[1], "--summary"))
+			merge_summary = 1;
+		else if (!strcmp(argv[1], "--no-summary"))
+			merge_summary = 0;
+		else if (!strcmp(argv[1], "-F") || !strcmp(argv[1], "--file")) {
+			if (argc < 2)
+				die ("Which file?");
+			if (!strcmp(argv[2], "-"))
+				in = stdin;
+			else {
+				fclose(in);
+				in = fopen(argv[2], "r");
+			}
+			argc--; argv++;
+		} else
+			break;
+		argc--; argv++;
+	}
+
+	if (argc > 1)
+		usage(fmt_merge_msg_usage);
+
+	/* get current branch */
+	head = strdup(git_path("HEAD"));
+	current_branch = resolve_ref(head, head_sha1, 1);
+	current_branch += strlen(head) - 4;
+	free((char *)head);
+	if (!strncmp(current_branch, "refs/heads/", 11))
+		current_branch += 11;
+
+	while (fgets(line, sizeof(line), in)) {
+		i++;
+		if (line[0] == 0)
+			continue;
+		if (handle_line(line))
+			die ("Error in line %d: %s", i, line);
+	}
+
+	printf("Merge ");
+	for (i = 0; i < srcs.nr; i++) {
+		struct src_data *src_data = srcs.payload[i];
+		const char *subsep = "";
+
+		printf(sep);
+		sep = "; ";
+
+		if (src_data->head_status == 1) {
+			printf(srcs.list[i]);
+			continue;
+		}
+		if (src_data->head_status == 3) {
+			subsep = ", ";
+			printf("HEAD");
+		}
+		if (src_data->branch.nr) {
+			printf(subsep);
+			subsep = ", ";
+			print_joined("branch ", "branches ",
+					&(src_data->branch));
+		}
+		if (src_data->r_branch.nr) {
+			printf(subsep);
+			subsep = ", ";
+			print_joined("remote branch ", "remote branches ",
+					&(src_data->r_branch));
+		}
+		if (src_data->tag.nr) {
+			printf(subsep);
+			subsep = ", ";
+			print_joined("tag ", "tags ", &(src_data->tag));
+		}
+		if (src_data->generic.nr) {
+			printf(subsep);
+			print_joined("commit ", "commits ",
+					&(src_data->generic));
+		}
+		if (strcmp(".", srcs.list[i]))
+			printf(" of %s", srcs.list[i]);
+	}
+
+	printf(" into %s\n", current_branch);
+
+	if (merge_summary) {
+		struct commit *head;
+		struct rev_info rev;
+
+		head = lookup_commit(head_sha1);
+parse_object(head->object.sha1);
+head = head->parents->item;
+		init_revisions(&rev);
+		rev.commit_format = CMIT_FMT_ONELINE;
+		rev.ignore_merges = 1;
+		rev.limited = 1;
+
+		for (i = 0; i < origins.nr; i++)
+			shortlog(origins.list[i], origins.payload[i],
+					head, &rev, limit);
+	}
+
+	/* No cleanup yet; is standalone anyway */
+
+	return 0;
+}
+
diff --git a/builtin.h b/builtin.h
old mode 100644
new mode 100755
index f12d5e6..d9e5483
--- a/builtin.h
+++ b/builtin.h
@@ -49,6 +49,7 @@ extern int cmd_cat_file(int argc, const 
 extern int cmd_rev_parse(int argc, const char **argv, char **envp);
 extern int cmd_update_index(int argc, const char **argv, char **envp);
 extern int cmd_update_ref(int argc, const char **argv, char **envp);
+extern int cmd_fmt_merge_msg(int argc, const char **argv, char **envp);
 
 extern int cmd_write_tree(int argc, const char **argv, char **envp);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
diff --git a/git.c b/git.c
index 512fa63..7cc826b 100644
--- a/git.c
+++ b/git.c
@@ -200,7 +200,8 @@ static void handle_internal_command(int 
 		{ "mailinfo", cmd_mailinfo },
 		{ "stripspace", cmd_stripspace },
 		{ "update-index", cmd_update_index },
-		{ "update-ref", cmd_update_ref }
+		{ "update-ref", cmd_update_ref },
+		{ "fmt-merge-msg", cmd_fmt_merge_msg }
 	};
 	int i;
 
-- 
1.4.1.ga246
