From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 10/11] Build in merge
Date: Fri, 20 Jun 2008 01:22:35 +0200
Message-ID: <a750360c92c30e05c686c454c0e5df2223b08f99.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
 <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
 <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org>
 <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org>
 <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org>
 <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org>
 <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org>
 <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org>
 <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TUS-0006Vg-A8
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbYFSXW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbYFSXWz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:22:55 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46950 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbYFSXWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:45 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 8C84D1DDC60
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C749718E0EF; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85572>

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Makefile                                      |    2 +-
 builtin-merge.c                               | 1128 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git.c                                         |    1 +
 5 files changed, 1131 insertions(+), 1 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)

diff --git a/Makefile b/Makefile
index b003e3e..3d8c3d2 100644
--- a/Makefile
+++ b/Makefile
@@ -240,7 +240,6 @@ SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
-SCRIPT_SH += git-merge.sh
 SCRIPT_SH += git-merge-stupid.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-parse-remote.sh
@@ -511,6 +510,7 @@ BUILTIN_OBJS += builtin-ls-remote.o
 BUILTIN_OBJS += builtin-ls-tree.o
 BUILTIN_OBJS += builtin-mailinfo.o
 BUILTIN_OBJS += builtin-mailsplit.o
+BUILTIN_OBJS += builtin-merge.o
 BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
diff --git a/builtin-merge.c b/builtin-merge.c
new file mode 100644
index 0000000..cc6b88b
--- /dev/null
+++ b/builtin-merge.c
@@ -0,0 +1,1128 @@
+/*
+ * Builtin "git merge"
+ *
+ * Copyright (c) 2008 Miklos Vajna <vmiklos@frugalware.org>
+ *
+ * Based on git-merge.sh by Junio C Hamano.
+ */
+
+#include "cache.h"
+#include "parse-options.h"
+#include "builtin.h"
+#include "run-command.h"
+#include "path-list.h"
+#include "diff.h"
+#include "refs.h"
+#include "commit.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "unpack-trees.h"
+#include "cache-tree.h"
+#include "dir.h"
+#include "utf8.h"
+#include "log-tree.h"
+
+enum strategy {
+	DEFAULT_TWOHEAD = 1,
+	DEFAULT_OCTOPUS = 2,
+	NO_FAST_FORWARD = 4,
+	NO_TRIVIAL = 8
+};
+
+static const char * const builtin_merge_usage[] = {
+	"git-merge [options] <remote>...",
+	"git-merge [options] <msg> HEAD <remote>",
+	NULL
+};
+
+static int show_diffstat = 1, option_log, squash;
+static int option_commit = 1, allow_fast_forward = 1;
+static int allow_trivial = 1, have_message;
+static struct strbuf merge_msg;
+static struct commit_list *remoteheads;
+static unsigned char head[20];
+static struct path_list use_strategies;
+static const char *branch;
+
+static struct path_list_item strategy_items[] = {
+	{ "recur",      (void *)NO_TRIVIAL },
+	{ "recursive",  (void *)(DEFAULT_TWOHEAD | NO_TRIVIAL) },
+	{ "octopus",    (void *)DEFAULT_OCTOPUS },
+	{ "resolve",    (void *)0 },
+	{ "stupid",     (void *)0 },
+	{ "ours",       (void *)(NO_FAST_FORWARD | NO_TRIVIAL) },
+	{ "subtree",    (void *)(NO_FAST_FORWARD | NO_TRIVIAL) },
+};
+static struct path_list strategies = { strategy_items,
+	ARRAY_SIZE(strategy_items), 0, 0 };
+
+static const char *pull_twohead, *pull_octopus;
+
+static int option_parse_message(const struct option *opt,
+	const char *arg, int unset)
+{
+	struct strbuf *buf = opt->value;
+
+	if (unset)
+		strbuf_setlen(buf, 0);
+	else {
+		strbuf_addstr(buf, arg);
+		have_message = 1;
+	}
+	return 0;
+}
+
+static struct path_list_item *unsorted_path_list_lookup(const char *path,
+	struct path_list *list)
+{
+	int i;
+
+	if (!path)
+		return NULL;
+
+	for (i = 0; i < list->nr; i++)
+		if (!strcmp(path, list->items[i].path))
+			return &list->items[i];
+	return NULL;
+}
+
+static inline void path_list_append_strategy(const char *path, void *util,
+	struct path_list *list)
+{
+	path_list_append(path, list)->util = util;
+}
+
+static int option_parse_strategy(const struct option *opt,
+	const char *arg, int unset)
+{
+	int i;
+	struct path_list *list = opt->value;
+	struct path_list_item *item =
+		unsorted_path_list_lookup(arg, &strategies);
+
+	if (unset)
+		return 0;
+
+	if (item)
+		path_list_append_strategy(arg, item->util, list);
+	else {
+		struct strbuf err;
+		strbuf_init(&err, 0);
+		for (i = 0; i < strategies.nr; i++)
+			strbuf_addf(&err, " %s", strategies.items[i].path);
+		fprintf(stderr, "Could not find merge strategy '%s'.\n", arg);
+		fprintf(stderr, "Available strategies are:%s.\n", err.buf);
+		exit(1);
+	}
+	return 0;
+}
+
+static int option_parse_n(const struct option *opt,
+		const char *arg, int unset)
+{
+	show_diffstat = unset;
+	return 0;
+}
+
+static struct option builtin_merge_options[] = {
+	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
+		"do not show a diffstat at the end of the merge",
+		PARSE_OPT_NOARG, option_parse_n },
+	OPT_BOOLEAN(0, "stat", &show_diffstat,
+		"show a diffstat at the end of the merge"),
+	OPT_BOOLEAN(0, "summary", &show_diffstat, "(synonym to --stat)"),
+	OPT_BOOLEAN(0, "log", &option_log,
+		"add list of one-line log to merge commit message"),
+	OPT_BOOLEAN(0, "squash", &squash,
+		"create a single commit instead of doing a merge"),
+	OPT_BOOLEAN(0, "commit", &option_commit,
+		"perform a commit if the merge sucesses (default)"),
+	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
+		"allow fast forward (default)"),
+	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
+		"merge strategy to use", option_parse_strategy),
+	OPT_CALLBACK('m', "message", &merge_msg, "message",
+		"message to be used for the merge commit (if any)",
+		option_parse_message),
+	OPT_END()
+};
+
+/* Cleans up metadata that is uninteresting after a succeeded merge. */
+static void dropsave()
+{
+	unlink(git_path("MERGE_HEAD"));
+	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("MERGE_STASH"));
+}
+
+static void save_state()
+{
+	int fd;
+	struct child_process stash;
+	const char *argv[] = {"stash", "create", NULL};
+
+	fd = open(git_path("MERGE_STASH"), O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die("Could not write to %s", git_path("MERGE_STASH"));
+	memset(&stash, 0, sizeof(stash));
+	stash.argv = argv;
+	stash.out = fd;
+	stash.git_cmd = 1;
+	run_command(&stash);
+}
+
+static void reset_hard(unsigned const char *sha1, int verbose)
+{
+	struct tree *tree;
+	struct unpack_trees_options opts;
+	struct tree_desc t;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = -1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.update = 1;
+	opts.reset = 1;
+	if (verbose)
+		opts.verbose_update = 1;
+
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
+		die("failed to unpack %s tree object", sha1_to_hex(sha1));
+	parse_tree(tree);
+	init_tree_desc(&t, tree->buffer, tree->size);
+	if (unpack_trees(1, &t, &opts))
+		exit(128); /* We've already reported the error, finish dying */
+}
+
+static void restore_state()
+{
+	struct strbuf sb;
+	const char *args[] = { "stash", "apply", NULL, NULL };
+
+	if (access(git_path("MERGE_STASH"), R_OK) < 0)
+		return;
+
+	reset_hard(head, 1);
+
+	strbuf_init(&sb, 0);
+	if (strbuf_read_file(&sb, git_path("MERGE_STASH"), 0) < 0)
+		die("could not read MERGE_STASH: %s", strerror(errno));
+	args[2] = sb.buf;
+
+	/*
+	 * It is OK to ignore error here, for example when there was
+	 * nothing to restore.
+	 */
+	run_command_v_opt(args, RUN_GIT_CMD);
+
+	refresh_cache(REFRESH_QUIET);
+}
+
+/* This is called when no merge was necessary. */
+static void finish_up_to_date(const char *msg)
+{
+	if (squash)
+		printf("%s (nothing to squash)\n", msg);
+	else
+		printf("%s\n", msg);
+	dropsave();
+}
+
+static void squash_message(int out_fd)
+{
+	struct rev_info rev;
+	struct commit *commit;
+	struct strbuf out;
+	struct commit_list *j;
+
+	init_revisions(&rev, NULL);
+	rev.ignore_merges = 1;
+	rev.commit_format = CMIT_FMT_MEDIUM;
+
+	commit = lookup_commit(head);
+	commit->object.flags |= UNINTERESTING;
+	add_pending_object(&rev, &commit->object, NULL);
+
+	for (j = remoteheads; j; j = j->next) {
+		j->item->object.flags &= ~UNINTERESTING;
+		add_pending_object(&rev, &j->item->object, NULL);
+	}
+
+	setup_revisions(0, NULL, &rev, NULL);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+
+	strbuf_init(&out, 0);
+	strbuf_addstr(&out, "Squashed commit of the following:\n");
+	while ((commit = get_revision(&rev)) != NULL) {
+		strbuf_addch(&out, '\n');
+		strbuf_addf(&out, "commit %s\n",
+			sha1_to_hex(commit->object.sha1));
+		pretty_print_commit(rev.commit_format, commit, &out, rev.abbrev,
+			NULL, NULL, rev.date_mode, 0);
+	}
+	write(out_fd, out.buf, out.len);
+	strbuf_release(&out);
+}
+
+static int run_hook(const char *name)
+{
+	struct child_process hook;
+	const char *argv[3], *env[2];
+	char index[PATH_MAX];
+
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", get_index_file());
+	env[0] = index;
+	env[1] = NULL;
+
+	argv[0] = git_path("hooks/%s", name);
+	if (squash)
+		argv[1] = "1";
+	else
+		argv[1] = "0";
+	argv[2] = NULL;
+
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv = argv;
+	hook.no_stdin = 1;
+	hook.stdout_to_stderr = 1;
+	hook.env = env;
+
+	return run_command(&hook);
+}
+
+static void finish(const unsigned char *new_head, const char *msg)
+{
+	struct strbuf reflog_message;
+	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
+	struct diff_options opts;
+
+	strbuf_init(&reflog_message, 0);
+	if (!msg)
+		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
+	else {
+		printf("%s\n", msg);
+		strbuf_addf(&reflog_message, "%s: %s",
+			getenv("GIT_REFLOG_ACTION"), msg);
+	}
+	if (squash) {
+		int fd;
+		printf("Squash commit -- not updating HEAD\n");
+		fd = open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
+		if (fd < 0)
+			die("Could not write to %s", git_path("SQUASH_MSG"));
+		squash_message(fd);
+		close(fd);
+	} else {
+		if (!merge_msg.len)
+			printf("No merge message -- not updating HEAD\n");
+		else {
+			update_ref(reflog_message.buf, "HEAD",
+				new_head, head, 0,
+				DIE_ON_ERR);
+			/*
+			 * We ignore errors in 'gc --auto', since the
+			 * user should see them.
+			 */
+			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+		}
+	}
+	if (new_head && show_diffstat) {
+		diff_setup(&opts);
+		opts.output_format |=
+			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+		opts.detect_rename = DIFF_DETECT_RENAME;
+		diff_tree_sha1(head, new_head, "", &opts);
+		diffcore_std(&opts);
+		diff_flush(&opts);
+	}
+
+	/* Run a post-merge hook */
+	run_hook("post-merge");
+
+	strbuf_release(&reflog_message);
+}
+
+/* Get the name for the merge commit's message. */
+static void merge_name(const char *remote, struct strbuf *msg)
+{
+	struct object *remote_head;
+	unsigned char branch_head[20], buf_sha[20];
+	struct strbuf buf;
+	char *ptr;
+	int match = 0;
+
+	memset(branch_head, 0, sizeof(branch_head));
+	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
+	if (!remote_head)
+		return;
+
+	strbuf_init(&buf, 0);
+	strbuf_addstr(&buf, "refs/heads/");
+	strbuf_addstr(&buf, remote);
+	get_sha1(buf.buf, branch_head);
+
+	if (!hashcmp(remote_head->sha1, branch_head)) {
+		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
+			sha1_to_hex(branch_head), remote);
+		return;
+	}
+	/* See if remote matches <name>~<number>, or <name>^ */
+	ptr = strrchr(remote, '^');
+	if (ptr && *(ptr+1) == '\0')
+		match = 1;
+	else {
+		ptr = strrchr(remote, '~');
+		if (ptr && *(ptr+1) != '0' && isdigit(*(ptr+1))) {
+			ptr++;
+			match = 1;
+			while (*(++ptr))
+				if (!isdigit(*ptr)) {
+					match = 0;
+					break;
+				}
+		}
+	}
+	if (match) {
+		struct strbuf truname;
+		strbuf_addstr(&truname, remote);
+		strbuf_setlen(&truname, strrchr(truname.buf, '~')-truname.buf);
+		if (!get_sha1(truname.buf, buf_sha)) {
+			strbuf_addf(msg,
+				"%s\t\tbranch '%s' (early part) of .\n",
+				sha1_to_hex(remote_head->sha1), truname.buf);
+			return;
+		}
+	}
+
+	if (!strcmp(remote, "FETCH_HEAD") &&
+		!access(git_path("FETCH_HEAD"), R_OK)) {
+		FILE *fp;
+		struct strbuf line;
+		char *ptr;
+
+		strbuf_init(&line, 0);
+		fp = fopen(git_path("FETCH_HEAD"), "r");
+		if (fp == NULL)
+			die("could not open %s for reading: %s",
+				git_path("FETCH_HEAD"), strerror(errno));
+		strbuf_getline(&line, fp, '\n');
+		fclose(fp);
+		ptr = strstr(line.buf, "\tnot-for-merge\t");
+		if (ptr)
+			strbuf_remove(&line, ptr-line.buf+1, 13);
+		strbuf_addbuf(msg, &line);
+		strbuf_release(&line);
+		return;
+	}
+	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
+		sha1_to_hex(remote_head->sha1), remote);
+}
+
+int git_merge_config(const char *k, const char *v, void *cb)
+{
+	if (branch && !prefixcmp(k, "branch.") &&
+		!prefixcmp(k + 7, branch) &&
+		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+		const char **argv;
+		int argc;
+		char *buf;
+
+		buf = xstrdup(v);
+		argc = split_cmdline(buf, &argv);
+		parse_options(argc, argv, builtin_merge_options,
+				builtin_merge_usage,
+				PARSE_OPT_ARGV0_IS_AN_OPTION);
+		free(buf);
+	}
+
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+		show_diffstat = git_config_bool(k, v);
+	else if (!strcmp(k, "pull.twohead"))
+		return git_config_string(&pull_twohead, k, v);
+	else if (!strcmp(k, "pull.octopus"))
+		return git_config_string(&pull_octopus, k, v);
+	return 0;
+}
+
+static int read_tree_trivial(unsigned char *common, unsigned char *head,
+	unsigned char *one)
+{
+	int i, nr_trees = 0;
+	struct tree *trees[MAX_UNPACK_TREES];
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct unpack_trees_options opts;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = -1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.update = 1;
+	opts.verbose_update = 1;
+	opts.trivial_merges_only = 1;
+	opts.merge = 1;
+	trees[nr_trees] = parse_tree_indirect(common);
+	if (!trees[nr_trees++])
+		return -1;
+	trees[nr_trees] = parse_tree_indirect(head);
+	if (!trees[nr_trees++])
+		return -1;
+	trees[nr_trees] = parse_tree_indirect(one);
+	if (!trees[nr_trees++])
+		return -1;
+	opts.fn = threeway_merge;
+	cache_tree_free(&active_cache_tree);
+	opts.head_idx = 2;
+	for (i = 0; i < nr_trees; i++) {
+		parse_tree(trees[i]);
+		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+	}
+	if (unpack_trees(nr_trees, t, &opts))
+		return -1;
+	return 0;
+}
+
+static int commit_tree_trivial(const char *msg, unsigned const char *tree,
+		struct commit_list *parents, unsigned char *ret)
+{
+	struct commit_list *i;
+	struct strbuf buf;
+	int encoding_is_utf8;
+
+	/* Not having i18n.commitencoding is the same as having utf-8 */
+	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+
+	strbuf_init(&buf, 8192); /* should avoid reallocs for the headers */
+	strbuf_addf(&buf, "tree %s\n", sha1_to_hex(tree));
+
+	for (i = parents; i; i = i->next)
+		strbuf_addf(&buf, "parent %s\n",
+			sha1_to_hex(i->item->object.sha1));
+
+	/* Person/date information */
+	strbuf_addf(&buf, "author %s\n",
+		git_author_info(IDENT_ERROR_ON_NO_NAME));
+	strbuf_addf(&buf, "committer %s\n",
+		git_committer_info(IDENT_ERROR_ON_NO_NAME));
+	if (!encoding_is_utf8)
+		strbuf_addf(&buf, "encoding %s\n", git_commit_encoding);
+	strbuf_addch(&buf, '\n');
+
+	/* And add the comment */
+	strbuf_addstr(&buf, msg);
+
+	write_sha1_file(buf.buf, buf.len, commit_type, ret);
+	strbuf_release(&buf);
+	return *ret;
+}
+
+static void write_tree_trivial(unsigned char *sha1)
+{
+	if (write_cache_as_tree(sha1, 0, NULL))
+		die("git write-tree failed to write a tree");
+}
+
+static int try_merge_strategy(char *strategy, struct commit_list *common,
+	struct strbuf *head_arg)
+{
+	const char **args;
+	int i = 0, ret;
+	struct commit_list *j;
+	struct strbuf buf;
+
+	args = xmalloc((4 + commit_list_count(common) +
+			commit_list_count(remoteheads)) * sizeof(char *));
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "merge-%s", strategy);
+	args[i++] = buf.buf;
+	for (j = common; j; j = j->next)
+		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+	args[i++] = "--";
+	args[i++] = head_arg->buf;
+	for (j = remoteheads; j; j = j->next)
+		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+	args[i] = NULL;
+	ret = run_command_v_opt(args, RUN_GIT_CMD);
+	strbuf_release(&buf);
+	i = 1;
+	for (j = common; j; j = j->next)
+		free((void *)args[i++]);
+	i += 2;
+	for (j = remoteheads; j; j = j->next)
+		free((void *)args[i++]);
+	free(args);
+	return -ret;
+}
+
+static void count_diff_files(struct diff_queue_struct *q,
+		struct diff_options *opt, void *data)
+{
+	int *count = data;
+
+	(*count) += q->nr;
+}
+
+static int count_unmerged_entries(void)
+{
+	const struct index_state *state = &the_index;
+	int i, ret = 0;
+
+	for (i = 0; i < state->cache_nr; i++)
+		if (ce_stage(state->cache[i]))
+			ret++;
+
+	return ret;
+}
+
+static int merge_one_remote(unsigned char *head, unsigned char *remote)
+{
+	struct tree *trees[MAX_UNPACK_TREES];
+	struct unpack_trees_options opts;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	int i, fd, nr_trees = 0;
+	struct dir_struct *dir;
+	struct lock_file lock_file;
+
+	memset(&lock_file, 0, sizeof(lock_file));
+	if (read_cache_unmerged())
+		die("you need to resolve your current index first");
+
+	fd = hold_locked_index(&lock_file, 1);
+
+	memset(&trees, 0, sizeof(trees));
+	memset(&opts, 0, sizeof(opts));
+	memset(&t, 0, sizeof(t));
+	dir = xcalloc(1, sizeof(*opts.dir));
+	dir->show_ignored = 1;
+	dir->exclude_per_dir = ".gitignore";
+	opts.dir = dir;
+
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.update = 1;
+	opts.verbose_update = 1;
+	opts.merge = 1;
+	opts.fn = twoway_merge;
+
+	trees[nr_trees] = parse_tree_indirect(head);
+	if (!trees[nr_trees++])
+		return -1;
+	trees[nr_trees] = parse_tree_indirect(remote);
+	if (!trees[nr_trees++])
+		return -1;
+	for (i = 0; i < nr_trees; i++) {
+		parse_tree(trees[i]);
+		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+	}
+	if (unpack_trees(nr_trees, t, &opts))
+		return -1;
+	if (write_cache(fd, active_cache, active_nr) ||
+		commit_locked_index(&lock_file))
+		die("unable to write new index file");
+	return 0;
+}
+
+static void split_merge_strategies(const char *string, struct path_list *list)
+{
+	char *p, *q, *buf;
+
+	if (!string)
+		return;
+
+	list->strdup_paths = 1;
+	buf = xstrdup(string);
+	q = buf;
+	while (1) {
+		p = strchr(q, ' ');
+		if (!p) {
+			path_list_append(q, list);
+			free(buf);
+			return;
+		} else {
+			*p = '\0';
+			path_list_append(q, list);
+			q = ++p;
+		}
+	}
+}
+
+static void add_strategies(const char *string, enum strategy strategy)
+{
+	struct path_list list;
+	int i;
+
+	memset(&list, 0, sizeof(list));
+	split_merge_strategies(string, &list);
+	if (list.nr) {
+		for (i = 0; i < list.nr; i++) {
+			struct path_list_item *item;
+
+			item = unsorted_path_list_lookup(list.items[i].path,
+				&strategies);
+			if (item)
+				path_list_append_strategy(list.items[i].path,
+					item->util, &use_strategies);
+		}
+		return;
+	}
+	for (i = 0; i < strategies.nr; i++)
+		if ((enum strategy)strategies.items[i].util & strategy)
+			path_list_append_strategy(strategies.items[i].path,
+				strategies.items[i].util,
+				&use_strategies);
+}
+
+int cmd_merge(int argc, const char **argv, const char *prefix)
+{
+	unsigned char sha1[20], result_tree[20];
+	struct object *second_token = NULL;
+	struct strbuf buf, head_arg;
+	int flag, head_invalid, i, single_strategy;
+	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
+	struct commit_list *common = NULL;
+	struct path_list_item *best_strategy = NULL, *wt_strategy = NULL;
+	struct commit_list **remotes = &remoteheads;
+
+	setup_work_tree();
+	if (unmerged_cache())
+		die("You are in the middle of a conflicted merge.");
+
+	/*
+	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
+	 * current branch.
+	 */
+	branch = resolve_ref("HEAD", sha1, 0, &flag);
+	if (branch && flag & REF_ISSYMREF) {
+		const char *ptr = skip_prefix(branch, "refs/heads/");
+		if (ptr)
+			branch = ptr;
+	}
+
+	git_config(git_merge_config, NULL);
+
+	argc = parse_options(argc, argv, builtin_merge_options,
+			builtin_merge_usage, 0);
+
+	if (squash) {
+		if (!allow_fast_forward)
+			die("You cannot combine --squash with --no-ff.");
+		option_commit = 0;
+	}
+
+	if (argc == 0)
+		usage_with_options(builtin_merge_usage,
+			builtin_merge_options);
+
+	/*
+	 * This could be traditional "merge <msg> HEAD <commit>..."  and
+	 * the way we can tell it is to see if the second token is HEAD,
+	 * but some people might have misused the interface and used a
+	 * committish that is the same as HEAD there instead.
+	 * Traditional format never would have "-m" so it is an
+	 * additional safety measure to check for it.
+	 */
+	strbuf_init(&buf, 0);
+	strbuf_init(&head_arg, 0);
+	if (argc > 1)
+		second_token = peel_to_type(argv[1], 0, NULL, OBJ_COMMIT);
+	head_invalid = get_sha1("HEAD", head);
+
+	if (!have_message && second_token &&
+		!hashcmp(second_token->sha1, head)) {
+		strbuf_addstr(&merge_msg, argv[0]);
+		strbuf_addstr(&head_arg, argv[1]);
+		argv += 2;
+		argc -= 2;
+	} else if (head_invalid) {
+		struct object *remote_head;
+		/*
+		 * If the merged head is a valid one there is no reason
+		 * to forbid "git merge" into a branch yet to be born.
+		 * We do the same for "git pull".
+		 */
+		if (argc != 1)
+			die("Can merge only exactly one commit into "
+				"empty head");
+		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
+		if (!remote_head)
+			die("%s - not something we can merge", argv[0]);
+		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
+				DIE_ON_ERR);
+		reset_hard(remote_head->sha1, 0);
+		return 0;
+	} else {
+		/* We are invoked directly as the first-class UI. */
+		strbuf_addstr(&head_arg, "HEAD");
+		if (!merge_msg.len) {
+			/*
+			 * All the rest are the commits being merged;
+			 * prepare the standard merge summary message to
+			 * be appended to the given message.  If remote
+			 * is invalid we will die later in the common
+			 * codepath so we discard the error in this
+			 * loop.
+			 */
+			struct strbuf msg;
+
+			strbuf_init(&msg, 0);
+			for (i = 0; i < argc; i++)
+				merge_name(argv[i], &msg);
+			fmt_merge_msg(option_log, &msg, &merge_msg);
+			if (merge_msg.len)
+				strbuf_setlen(&merge_msg, merge_msg.len-1);
+		}
+	}
+
+	if (head_invalid || argc == 0)
+		usage_with_options(builtin_merge_usage,
+			builtin_merge_options);
+
+	strbuf_addstr(&buf, "merge");
+	for (i = 0; i < argc; i++)
+		strbuf_addf(&buf, " %s", argv[i]);
+	setenv("GIT_REFLOG_ACTION", buf.buf, 0);
+	strbuf_reset(&buf);
+
+	for (i = 0; i < argc; i++) {
+		struct object *o;
+
+		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
+		if (!o)
+			die("%s - not something we can merge", argv[i]);
+		remotes = &commit_list_insert(lookup_commit(o->sha1),
+			remotes)->next;
+
+		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
+		setenv(buf.buf, argv[i], 1);
+		strbuf_reset(&buf);
+	}
+
+	if (!use_strategies.nr) {
+		if (!remoteheads->next)
+			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
+		else
+			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
+	}
+
+	for (i = 0; i < use_strategies.nr; i++) {
+		if ((unsigned int)use_strategies.items[i].util &
+			NO_FAST_FORWARD)
+			allow_fast_forward = 0;
+		if ((unsigned int)use_strategies.items[i].util & NO_TRIVIAL)
+			allow_trivial = 0;
+	}
+
+	if (!remoteheads->next)
+		common = get_merge_bases(lookup_commit(head),
+				remoteheads->item, 1);
+	else {
+		struct commit_list *list = remoteheads;
+		commit_list_insert(lookup_commit(head), &list);
+		common = get_octopus_merge_bases(list);
+	}
+
+	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head, NULL, 0,
+		DIE_ON_ERR);
+
+	if (!common)
+		; /* No common ancestors found. We need a real merge. */
+	else if (!remoteheads->next &&
+		!hashcmp(common->item->object.sha1,
+		remoteheads->item->object.sha1)) {
+		/*
+		 * If head can reach all the merge then we are up to
+		 * date.
+		 */
+		finish_up_to_date("Already up-to-date.");
+		return 0;
+	} else if (allow_fast_forward && !remoteheads->next &&
+		!hashcmp(common->item->object.sha1, head)) {
+		/* Again the most common case of merging one remote. */
+		struct strbuf msg;
+		struct object *o;
+
+		printf("Updating %s..%s\n",
+			find_unique_abbrev(head, DEFAULT_ABBREV),
+			find_unique_abbrev(remoteheads->item->object.sha1,
+			DEFAULT_ABBREV));
+		refresh_cache(REFRESH_QUIET);
+		strbuf_init(&msg, 0);
+		strbuf_addstr(&msg, "Fast forward");
+		if (have_message)
+			strbuf_addstr(&msg,
+				" (no commit created; -m option ignored)");
+		o = peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
+			0, NULL, OBJ_COMMIT);
+		if (!o)
+			return 0;
+
+		if (merge_one_remote(head, remoteheads->item->object.sha1))
+			return 0;
+
+		finish(o->sha1, msg.buf);
+		dropsave();
+		return 0;
+	} else if (!remoteheads->next && common->next)
+		;
+		/*
+		 * We are not doing octopus and not fast forward.  Need
+		 * a real merge.
+		 */
+	else if (!remoteheads->next && option_commit) {
+		/*
+		 * We are not doing octopus and not fast forward.  Need
+		 * a real merge.
+		 */
+		refresh_cache(REFRESH_QUIET);
+		if (allow_trivial) {
+			/* See if it is really trivial. */
+			git_committer_info(IDENT_ERROR_ON_NO_NAME);
+			printf("Trying really trivial in-index merge...\n");
+			if (!read_tree_trivial(common->item->object.sha1,
+					head, remoteheads->item->object.sha1)) {
+				unsigned char result_tree[20],
+					result_commit[20];
+				struct commit_list parent;
+
+				write_tree_trivial(result_tree);
+				printf("Wonderful.\n");
+				parent.item = remoteheads->item;
+				parent.next = NULL;
+				commit_tree_trivial(merge_msg.buf,
+					result_tree, &parent,
+					result_commit);
+				finish(result_commit, "In-index merge");
+				dropsave();
+				return 0;
+			}
+			printf("Nope.\n");
+		}
+	} else {
+		/*
+		 * An octopus.  If we can reach all the remote we are up
+		 * to date.
+		 */
+		int up_to_date = 1;
+		struct commit_list *j;
+
+		for (j = remoteheads; j; j = j->next) {
+			struct commit_list *common_one;
+
+			common_one = get_merge_bases(lookup_commit(head),
+				j->item, 1);
+			if (hashcmp(common_one->item->object.sha1,
+				j->item->object.sha1)) {
+				up_to_date = 0;
+				break;
+			}
+		}
+		if (up_to_date) {
+			finish_up_to_date("Already up-to-date. Yeeah!");
+			return 0;
+		}
+	}
+
+	/* We are going to make a new commit. */
+	git_committer_info(IDENT_ERROR_ON_NO_NAME);
+
+	/*
+	 * At this point, we need a real merge.  No matter what strategy
+	 * we use, it would operate on the index, possibly affecting the
+	 * working tree, and when resolved cleanly, have the desired
+	 * tree in the index -- this means that the index must be in
+	 * sync with the head commit.  The strategies are responsible
+	 * to ensure this.
+	 */
+	if (use_strategies.nr != 1) {
+		/*
+		 * Stash away the local changes so that we can try more
+		 * than one.
+		 */
+		save_state();
+		single_strategy = 0;
+	} else {
+		unlink(git_path("MERGE_STASH"));
+		single_strategy = 1;
+	}
+
+	for (i = 0; i < use_strategies.nr; i++) {
+		int ret;
+		if (i) {
+			printf("Rewinding the tree to pristine...\n");
+			restore_state();
+		}
+		if (!single_strategy)
+			printf("Trying merge strategy %s...\n",
+				use_strategies.items[i].path);
+		/*
+		 * Remember which strategy left the state in the working
+		 * tree.
+		 */
+		wt_strategy = &use_strategies.items[i];
+
+		ret = try_merge_strategy(use_strategies.items[i].path,
+			common, &head_arg);
+		if (!option_commit && !ret) {
+			merge_was_ok = 1;
+			ret = 1;
+		}
+
+		if (ret) {
+			/*
+			 * The backend exits with 1 when conflicts are
+			 * left to be resolved, with 2 when it does not
+			 * handle the given merge at all.
+			 */
+			if (ret == 1) {
+				int cnt = 0;
+				struct rev_info rev;
+
+				if (read_cache() < 0)
+					die("failed to read the cache");
+
+				/* Check how many files differ. */
+				init_revisions(&rev, "");
+				setup_revisions(0, NULL, &rev, NULL);
+				rev.diffopt.output_format |=
+					DIFF_FORMAT_CALLBACK;
+				rev.diffopt.format_callback = count_diff_files;
+				rev.diffopt.format_callback_data = &cnt;
+				run_diff_files(&rev, 0);
+
+				/*
+				 * Check how many unmerged entries are
+				 * there.
+				 */
+				cnt += count_unmerged_entries();
+
+				if (best_cnt <= 0 || cnt <= best_cnt) {
+					best_strategy =
+						&use_strategies.items[i];
+					best_cnt = cnt;
+				}
+			}
+			continue;
+		}
+
+		/* Automerge succeeded. */
+		write_tree_trivial(result_tree);
+		automerge_was_ok = 1;
+		break;
+	}
+
+	/*
+	 * If we have a resulting tree, that means the strategy module
+	 * auto resolved the merge cleanly.
+	 */
+	if (automerge_was_ok) {
+		struct commit_list *parents = NULL, *j;
+		unsigned char result_commit[20];
+
+		free_commit_list(common);
+		if (allow_fast_forward)
+			parents = filter_independent(head, remoteheads);
+		else {
+			struct commit_list **pptr = &parents;
+
+			pptr = &commit_list_insert(lookup_commit(head),
+				pptr)->next;
+			for (j = remoteheads; j; j = j->next)
+				pptr = &commit_list_insert(j->item, pptr)->next;
+		}
+		free_commit_list(remoteheads);
+		strbuf_addch(&merge_msg, '\n');
+		commit_tree_trivial(merge_msg.buf, result_tree, parents,
+			result_commit);
+		free_commit_list(parents);
+		strbuf_addf(&buf, "Merge made by %s.", wt_strategy->path);
+		finish(result_commit, buf.buf);
+		strbuf_release(&buf);
+		dropsave();
+		return 0;
+	}
+
+	/*
+	 * Pick the result from the best strategy and have the user fix
+	 * it up.
+	 */
+	if (!best_strategy) {
+		restore_state();
+		if (use_strategies.nr > 1)
+			fprintf(stderr,
+				"No merge strategy handled the merge.\n");
+		else
+			fprintf(stderr, "Merge with strategy %s failed.\n",
+				use_strategies.items[0].path);
+		return 2;
+	} else if (best_strategy == wt_strategy)
+		; /* We already have its result in the working tree. */
+	else {
+		printf("Rewinding the tree to pristine...\n");
+		restore_state();
+		printf("Using the %s to prepare resolving by hand.\n",
+			best_strategy->path);
+		try_merge_strategy(best_strategy->path, common, &head_arg);
+	}
+
+	if (squash)
+		finish(NULL, NULL);
+	else {
+		int fd;
+		struct commit_list *j;
+
+		for (j = remoteheads; j; j = j->next)
+			strbuf_addf(&buf, "%s\n",
+				sha1_to_hex(j->item->object.sha1));
+		fd = open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
+		if (fd < 0)
+			die("Could open %s for writing",
+				git_path("MERGE_HEAD"));
+		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+			die("Could not write to %s", git_path("MERGE_HEAD"));
+		close(fd);
+		strbuf_addch(&merge_msg, '\n');
+		fd = open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
+		if (fd < 0)
+			die("Could open %s for writing", git_path("MERGE_MSG"));
+		if (write_in_full(fd, merge_msg.buf, merge_msg.len) !=
+			merge_msg.len)
+			die("Could not write to %s", git_path("MERGE_MSG"));
+		close(fd);
+	}
+
+	if (merge_was_ok) {
+		fprintf(stderr, "Automatic merge went well; "
+			"stopped before committing as requested\n");
+		return 0;
+	} else {
+		FILE *fp;
+		int pos;
+		const char *argv_rerere[] = { "rerere", NULL };
+
+		fp = fopen(git_path("MERGE_MSG"), "a");
+		if (!fp)
+			die("Could open %s for writing", git_path("MERGE_MSG"));
+		fprintf(fp, "\nConflicts:\n");
+		for (pos = 0; pos < active_nr; pos++) {
+			struct cache_entry *ce = active_cache[pos];
+
+			if (ce_stage(ce)) {
+				fprintf(fp, "\t%s\n", ce->name);
+				while (pos + 1 < active_nr &&
+					!strcmp(ce->name,
+					active_cache[pos + 1]->name))
+					pos++;
+			}
+		}
+		fclose(fp);
+		run_command_v_opt(argv_rerere, RUN_GIT_CMD);
+		printf("Automatic merge failed; "
+			"fix conflicts and then commit the result.\n");
+		return 1;
+	}
+}
diff --git a/builtin.h b/builtin.h
index 2b01fea..8bf5280 100644
--- a/builtin.h
+++ b/builtin.h
@@ -60,6 +60,7 @@ extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
+extern int cmd_merge(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
diff --git a/git-merge.sh b/contrib/examples/git-merge.sh
similarity index 100%
rename from git-merge.sh
rename to contrib/examples/git-merge.sh
diff --git a/git.c b/git.c
index 2fbe96b..770aadd 100644
--- a/git.c
+++ b/git.c
@@ -271,6 +271,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "ls-remote", cmd_ls_remote },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
+		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
-- 
1.5.6
