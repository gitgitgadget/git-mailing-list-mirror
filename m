From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 5/5] Build in merge
Date: Sat, 24 May 2008 02:01:08 +0200
Message-ID: <b9c1abcb326eafb12ac12138ae064f08eddbca50.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
 <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
 <28874c24faf45e6e4499c9692cc1de1e93cd4dcf.1211586801.git.vmiklos@frugalware.org>
 <dace39a3a72957bec9a7f4b8528b08fc7fbe3341.1211586801.git.vmiklos@frugalware.org>
 <b2314d0b07976d106e9ac9a9eebceb465f0ec46b.1211586801.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 02:02:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhDb-00019s-AL
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758951AbYEXABV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759080AbYEXABU
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:01:20 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36664 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758951AbYEXABM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:01:12 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 105CF1DDC5B
	for <git@vger.kernel.org>; Sat, 24 May 2008 02:01:10 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D7D53185E1D; Sat, 24 May 2008 02:01:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.357.g1af8b.dirty
In-Reply-To: <b2314d0b07976d106e9ac9a9eebceb465f0ec46b.1211586801.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82779>

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Makefile                                      |    2 +-
 builtin-merge.c                               | 1117 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git.c                                         |    1 +
 5 files changed, 1120 insertions(+), 1 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)

diff --git a/Makefile b/Makefile
index 91d938a..9820932 100644
--- a/Makefile
+++ b/Makefile
@@ -241,7 +241,6 @@ SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
-SCRIPT_SH += git-merge.sh
 SCRIPT_SH += git-merge-stupid.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-parse-remote.sh
@@ -509,6 +508,7 @@ BUILTIN_OBJS += builtin-ls-remote.o
 BUILTIN_OBJS += builtin-ls-tree.o
 BUILTIN_OBJS += builtin-mailinfo.o
 BUILTIN_OBJS += builtin-mailsplit.o
+BUILTIN_OBJS += builtin-merge.o
 BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
diff --git a/builtin-merge.c b/builtin-merge.c
new file mode 100644
index 0000000..ffe6a67
--- /dev/null
+++ b/builtin-merge.c
@@ -0,0 +1,1117 @@
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
+#include "strbuf.h"
+#include "run-command.h"
+#include "path-list.h"
+#include "diff.h"
+#include "refs.h"
+#include "reset.h"
+#include "commit.h"
+#include "diffcore.h"
+#include "revision.h"
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
+static int show_diffstat = 1, hide_diffstat, option_log, squash;
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
+static struct option builtin_merge_options[] = {
+	OPT_BOOLEAN('n', NULL, &hide_diffstat,
+		"don't show a diffstat at the end of the merge"),
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
+/*
+ * TODO: This is the same as builtin-remote's skip_prefix, but it seems
+ * we can't move it simply to git-compat-util.h as parse-options.c has
+ * an other skip_prefix() function as well.
+ */
+static inline const char *skip_prefix(const char *name, const char *prefix)
+{
+	return !name ? "" :
+		prefixcmp(name, prefix) ?  name : name + strlen(prefix);
+}
+
+static const unsigned char *hex_to_sha1(char *hex)
+{
+	static unsigned char sha1[20];
+
+	if (get_sha1(hex, sha1))
+		die("bad revision '%s'", hex);
+	return sha1;
+}
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
+static void restore_state()
+{
+	struct strbuf sb;
+	const char *args[] = { "stash", "apply", NULL, NULL };
+
+	if (access(git_path("MERGE_STASH"), R_OK) < 0)
+		return;
+
+	reset_index_file(head, 1, 1);
+
+	strbuf_init(&sb, 0);
+	if (strbuf_read_file(&sb, git_path("MERGE_STASH"), 0) < 0)
+		die("could not read MERGE_STASH: %s", strerror(errno));
+	args[2] = sb.buf;
+	if (run_command_v_opt(args, RUN_GIT_CMD))
+		die("Could not apply stash '%s'", sb.buf);
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
+	const char **args;
+	int i = 0;
+	/* TODO: it should be possible to avoid exec here() */
+	struct child_process log;
+	struct strbuf head_buf;
+	struct commit_list *j;
+	const char squash_header[] = "Squashed commit of the following:\n\n";
+
+	write(out_fd, squash_header, sizeof(squash_header) - 1);
+
+	strbuf_init(&head_buf, 0);
+	strbuf_addch(&head_buf, '^');
+	strbuf_addstr(&head_buf, sha1_to_hex(head));
+
+	args = xmalloc((5 + commit_list_count(remoteheads)) * sizeof(char *));
+	args[i++] = "log";
+	args[i++] = "--no-merges";
+	args[i++] = "--pretty=medium";
+	args[i++] = head_buf.buf;
+	for (j = remoteheads; j; j = j->next)
+		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+	args[i] = NULL;
+	memset(&log, 0, sizeof(log));
+	log.argv = args;
+	log.out = out_fd;
+	log.git_cmd = 1;
+	run_command(&log);
+	strbuf_release(&head_buf);
+	for (i = 4; args[i]; i++)
+		free((char *)args[i]);
+	free(args);
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
+}
+
+/* Get the name for the merge commit's message. */
+static void merge_name(const char *remote, struct strbuf *msg)
+{
+	struct object *remote_head;
+	unsigned char branch_head[20], buf_sha[20];
+	struct strbuf buf;
+	char *ref;
+	regex_t reg;
+
+	memset(branch_head, 0, sizeof(branch_head));
+	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
+	if (!remote_head)
+		return;
+
+	/* TODO: maybe here we could just use get_sha1()? */
+	strbuf_init(&buf, 0);
+	strbuf_addstr(&buf, "refs/heads/");
+	strbuf_addstr(&buf, remote);
+	dwim_ref(buf.buf, buf.len, branch_head, &ref);
+
+	if (!hashcmp(remote_head->sha1, branch_head)) {
+		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
+			sha1_to_hex(branch_head), remote);
+		return;
+	}
+	/*
+	 * TODO: This probably wants to match not only <name>~<number>,
+	 * but also <name>^
+	 */
+	/* TODO: using regcomp() is not sensible, we could do it by hand
+	 * just by using strchr(). */
+	regcomp(&reg, "~[1-9][0-9]*$", 0);
+	if (!regexec(&reg, remote, 0, 0, 0)) {
+		struct strbuf truname;
+		strbuf_addstr(&truname, remote);
+		strbuf_setlen(&truname, strrchr(truname.buf, '~')-truname.buf);
+		if (dwim_ref(truname.buf, truname.len, buf_sha, &ref)) {
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
+int git_merge_config(const char *k, const char *v)
+{
+	if (branch && !prefixcmp(k, "branch.") &&
+		!prefixcmp(k + 7, branch) &&
+		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+		const char **argv;
+		int argc;
+		struct strbuf cmdline;
+
+		/* TODO this is indeed a hack, maybe modify
+		 * split_cmdline() and add an option to tell
+		 * where should it start feeding options,
+		 * default to 0, but here to 1? */
+		strbuf_init(&cmdline, 0);
+		strbuf_addf(&cmdline, "merge %s", v);
+		argc = split_cmdline((char *)cmdline.buf, &argv);
+		parse_options(argc, argv, builtin_merge_options,
+				builtin_merge_usage, 0);
+		/* TODO: hack and code duplication */
+		if (hide_diffstat)
+			show_diffstat = hide_diffstat = 0;
+		strbuf_release(&cmdline);
+	}
+
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+		show_diffstat = git_config_bool(k, v);
+	/* FIXME: This may or may not be a list */
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
+	const char *args[] = {
+		"read-tree", "--trivial", "-m", "-u", "-v",
+		NULL, NULL, NULL, NULL };
+
+	args[5] = sha1_to_hex(common);
+	args[6] = sha1_to_hex(head);
+	args[7] = sha1_to_hex(one);
+
+	return run_command_v_opt(args, RUN_GIT_CMD);
+}
+
+static char *commit_tree_trivial(const char *msg, const char *tree,
+		struct commit_list *parents)
+{
+	int i = 0, len;
+	/* TODO: it should be possible to avoid exec here() */
+	struct child_process ct;
+	struct strbuf result_commit;
+	const char **args;
+	struct commit_list *j;
+
+	memset(&ct, 0, sizeof(ct));
+	strbuf_init(&result_commit, 0);
+	args = xmalloc((3 + 2 * commit_list_count(parents)) * sizeof(char *));
+	args[i++] = "commit-tree";
+	args[i++] = tree;
+	for (j = parents; j; j = j->next) {
+		args[i++] = "-p";
+		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+	}
+	args[i++] = NULL;
+	ct.argv = args;
+	ct.in = -1;
+	ct.out = -1;
+	ct.git_cmd = 1;
+	if (start_command(&ct))
+		die("could not run git commit-tree");
+	if (write_in_full(ct.in, msg, strlen(msg)) != strlen(msg))
+		die("git commit-tree did not accept the commit message");
+	close(ct.in);
+	len = strbuf_read(&result_commit, ct.out, 1024);
+	close(ct.out);
+	if (finish_command(&ct) || !len || len < 0)
+		die("git commit-tree failed to commit the tree");
+	if (result_commit.len)
+		strbuf_setlen(&result_commit, result_commit.len-1);
+	return result_commit.buf;
+}
+
+static void write_tree_trivial(struct strbuf *result_tree)
+{
+	const char *argv_write_tree[] = { "write-tree", NULL };
+	/* TODO: it should be possible to avoid exec here() */
+	struct child_process wt;
+	int len;
+
+	memset(&wt, 0, sizeof(wt));
+	strbuf_init(result_tree, 0);
+	wt.argv = argv_write_tree;
+	wt.out = -1;
+	wt.git_cmd = 1;
+	if (start_command(&wt))
+		die("could not run git write-tree");
+	len = strbuf_read(result_tree, wt.out, 1024);
+	close(wt.out);
+	if (finish_command(&wt) || !len || len < 0)
+		die("git write-tree failed to write a tree");
+	strbuf_setlen(result_tree, result_tree->len-1);
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
+struct commit_list *commit_list_append(struct commit *item,
+	struct commit_list **list_p)
+{
+	struct commit_list *i, *prev = NULL, *list = *list_p;
+	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
+
+	new_list->item = item;
+	new_list->next = NULL;
+
+	if (!list)
+		*list_p = new_list;
+	else {
+		for (i = list; i; i = i->next)
+			prev = i;
+		prev->next = new_list;
+	}
+	return list;
+}
+
+static void run_show_branch(char *opt, unsigned char *head,
+	struct commit_list **common)
+{
+	struct child_process show;
+	struct strbuf common_buf;
+	const char **args;
+	const char *ptr;
+	int i, len;
+	struct commit_list *j;
+	unsigned char sha1[20];
+
+	memset(&show, 0, sizeof(show));
+	strbuf_init(&common_buf, 0);
+	args = xmalloc((4 + commit_list_count(remoteheads)) * sizeof(char *));
+	i = 0;
+	args[i++] = "show-branch";
+	args[i++] = opt;
+	args[i++] = xstrdup(sha1_to_hex(head));
+	for (j = remoteheads; j; j = j->next)
+		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+	args[i] = NULL;
+	show.argv = args;
+	show.out = -1;
+	show.git_cmd = 1;
+	if (start_command(&show))
+		die("could not run git show-branch");
+	len = strbuf_read(&common_buf, show.out, 1024);
+	close(show.out);
+	if (finish_command(&show) || !len || len < 0)
+		die("git show-branch failed to produce the list of merge bases");
+	for (i = 2; args[i]; i++)
+		free((char *)args[i]);
+	free(args);
+	ptr = common_buf.buf;
+	while ((ptr = strchr(ptr, '\n'))) {
+		char hex[41];
+		memset(hex, 0, sizeof(hex));
+		memcpy(hex, ptr-40, 40);
+		if (get_sha1(hex, sha1))
+			die("bad revision returned by show-branch: '%s'", hex);
+		commit_list_append(lookup_commit(sha1), common);
+		ptr++;
+	}
+}
+
+int cmd_merge(int argc, const char **argv, const char *prefix)
+{
+	unsigned char sha1[20], result_tree[20] = "";
+	struct object *second_token = NULL;
+	struct strbuf buf, head_arg;
+	int flag, head_invalid, i, single_strategy;
+	int best_cnt = -1, merge_was_ok = 0;
+	struct commit_list *common = NULL;
+	struct path_list_item *best_strategy = NULL, *wt_strategy;
+
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
+	if (branch && flag & REF_ISSYMREF)
+		branch = skip_prefix(branch, "refs/heads/");
+
+	git_config(git_merge_config);
+
+	argc = parse_options(argc, argv, builtin_merge_options,
+			builtin_merge_usage, 0);
+	/* TODO: hack */
+	if (hide_diffstat)
+		show_diffstat = hide_diffstat = 0;
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
+			die("Can merge only exactly one commit into empty head");
+		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
+		if (!remote_head)
+			die("%s - not something we can merge", argv[0]);
+		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
+				DIE_ON_ERR);
+		return reset_index_file(hex_to_sha1("HEAD"), 1, 0);
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
+			int i, len;
+			struct strbuf msg;
+			struct child_process fmt;
+			const char *args[3];
+
+			strbuf_init(&msg, 0);
+			for (i = 0; i < argc; i++)
+				merge_name(argv[i], &msg);
+			memset(&fmt, 0, sizeof(fmt));
+			args[0] = "fmt-merge-msg";
+			if (option_log)
+				args[1] = "--log";
+			else
+				args[1] = "--no-log";
+			args[2] = NULL;
+			fmt.argv = args;
+			fmt.in = -1;
+			fmt.out = -1;
+			fmt.git_cmd = 1;
+			if (start_command(&fmt))
+				die("could not run git fmt-merge-msg");
+			if (write_in_full(fmt.in, msg.buf, msg.len) != msg.len)
+				die("git fmt-merge-msg did not accept the tag data");
+			close(fmt.in);
+			len = strbuf_read(&merge_msg, fmt.out, 1024);
+			close(fmt.out);
+			if (finish_command(&fmt) || !len || len < 0)
+				die("git fmt-merge-msg failed to produce a merge commit message");
+			if(merge_msg.len)
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
+		commit_list_append(lookup_commit(o->sha1), &remoteheads);
+
+		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
+		setenv(buf.buf, argv[i], 1);
+		strbuf_reset(&buf);
+	}
+
+	if (!use_strategies.nr) {
+		struct path_list_item *item;
+		/*
+		 * TODO: there is some code duplication here, it would
+		 * be nice to kill it.
+		 */
+		if (!remoteheads->next) {
+			item = unsorted_path_list_lookup(pull_twohead,
+				&strategies);
+			if (pull_twohead && item) {
+				path_list_append_strategy(pull_twohead,
+					item->util, &use_strategies);
+			} else {
+				for (i = 0; i < strategies.nr; i++)
+					if ((enum strategy)strategies.items[i].util & DEFAULT_TWOHEAD)
+						path_list_append_strategy(strategies.items[i].path,
+							strategies.items[i].util,
+							&use_strategies);
+			}
+		} else {
+			item = unsorted_path_list_lookup(pull_octopus,
+				&strategies);
+			if (pull_octopus && item)
+				path_list_append_strategy(pull_octopus,
+					item->util, &use_strategies);
+			else {
+				for (i = 0; i < strategies.nr; i++)
+					if ((enum strategy)strategies.items[i].util & DEFAULT_OCTOPUS)
+						path_list_append_strategy(strategies.items[i].path,
+							strategies.items[i].util,
+							&use_strategies);
+			}
+		}
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
+		/*
+		 * TODO: move functionality to commit.c and avoid fork()
+		 * here.
+		 */
+		run_show_branch("--merge-base", head, &common);
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
+		const char *args[7];
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
+		i = 0;
+		args[i++] = "read-tree";
+		args[i++] = "-v";
+		args[i++] = "-m";
+		args[i++] = "-u";
+		args[i++] = "--exclude-per-directory=.gitignore";
+		args[i++] = sha1_to_hex(head);
+		args[i++] = sha1_to_hex(remoteheads->item->object.sha1);
+		args[i] = NULL;
+		if (run_command_v_opt(args, RUN_GIT_CMD))
+			return 0;
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
+				struct strbuf result_tree;
+				char *result_commit;
+				struct commit_list parent;
+
+				write_tree_trivial(&result_tree);
+				printf("Wonderful.\n");
+				parent.item = remoteheads->item;
+				parent.next = NULL;
+				result_commit =
+					commit_tree_trivial(merge_msg.buf,
+					result_tree.buf, &parent);
+				finish(hex_to_sha1(result_commit),
+						"In-index merge");
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
+				/* TODO maybe somehow document that
+				 * these two blocks does the same as
+				 * diff-files and ls-files? */
+				init_revisions(&rev, "");
+				setup_revisions(0, NULL, &rev, NULL);
+				rev.diffopt.output_format |=
+					DIFF_FORMAT_CALLBACK;
+				rev.diffopt.format_callback = count_diff_files;
+				rev.diffopt.format_callback_data = &cnt;
+				run_diff_files(&rev, 0);
+
+				cnt += count_unmerged_entries();
+
+				if (best_cnt <= 0 || cnt <= best_cnt) {
+					best_strategy = &use_strategies.items[i];
+					best_cnt = cnt;
+				}
+			}
+			continue;
+		}
+
+		/* Automerge succeeded. */
+		write_tree_trivial(&buf);
+		if (get_sha1(buf.buf, result_tree))
+			die("bad tree '%s'", buf.buf);
+		strbuf_reset(&buf);
+		break;
+	}
+
+	/*
+	 * If we have a resulting tree, that means the strategy module
+	 * auto resolved the merge cleanly.
+	 */
+	/* TODO: is there a better check? somehow need to determine if
+	 * we wrote something to result_tree since its declaration */
+	if (result_tree[0] != '\0') {
+		struct commit_list *parents = NULL, *j;
+		char *result_commit;
+
+		if (allow_fast_forward)
+			run_show_branch("--independent", head, &parents);
+		else {
+			commit_list_append(lookup_commit(head), &parents);
+			for (j = remoteheads; j; j = j->next)
+				commit_list_append(j->item, &parents);
+		}
+		strbuf_addch(&merge_msg, '\n');
+		result_commit = commit_tree_trivial(merge_msg.buf,
+			sha1_to_hex(result_tree), parents);
+		strbuf_addf(&buf, "Merge made by %s.", wt_strategy->path);
+		finish(hex_to_sha1(result_commit), buf.buf);
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
index 95126fd..7c26d75 100644
--- a/builtin.h
+++ b/builtin.h
@@ -54,6 +54,7 @@ extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
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
index b8df19e..fced435 100644
--- a/git.c
+++ b/git.c
@@ -267,6 +267,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "ls-remote", cmd_ls_remote },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
+		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
-- 
1.5.5.1.357.g1af8b.dirty
