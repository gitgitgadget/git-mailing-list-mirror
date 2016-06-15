From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Build in merge
Date: Mon,  7 Jul 2008 19:24:20 +0200
Message-ID: <1215451460-1681-1-git-send-email-vmiklos@frugalware.org>
References: <7vej67jt1e.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: "To: Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:25:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFuSd-0001yj-2W
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 19:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbYGGRYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 13:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbYGGRYM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 13:24:12 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:53986 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbYGGRYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 13:24:09 -0400
Received: from vmobile.example.net (dsl5401C53A.pool.t-online.hu [84.1.197.58])
	by yugo.frugalware.org (Postfix) with ESMTP id A1C611DDC5B;
	Mon,  7 Jul 2008 19:24:04 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 79CF41A9CEF; Mon,  7 Jul 2008 19:24:20 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
In-Reply-To: <7vej67jt1e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87634>

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Jul 06, 2008 at 01:50:05AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> But more problematic is that a path_list is inherently a dynamic data
> structure (you can add and it reallocs), and this use of relying on
> the
> knowledge that you happen to never add anything (nor subtract
> anything)
> from the list is a mere hack.  If on the other hand you (and more
> importantly other people who touch this implementation later) will
> never
> add or remove items from this "strategies" array, you should make sure
> at
> the interface level that nobody can -- one way to do so is not to
> abuse
> path_list for something like this.
>
> Come to think of it, wasn't the reason why the earlier "Why do you
> need
> such distracting casts all over the place?" issue came up in another
> patch
> because of this kind of (ab)use of path_list, which is an
> inappropriate
> data structure for the job?

Here is an updated version without using path_list at all.

 Makefile                                      |    2 +-
 builtin-merge.c                               | 1153 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-merge.sh => contrib/examples/git-merge.sh |    0
 git.c                                         |    1 +
 t/t7602-merge-octopus-many.sh                 |    2 +-
 6 files changed, 1157 insertions(+), 2 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)

diff --git a/Makefile b/Makefile
index bf77292..fbc53e9 100644
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
@@ -515,6 +514,7 @@ BUILTIN_OBJS += builtin-ls-remote.o
 BUILTIN_OBJS += builtin-ls-tree.o
 BUILTIN_OBJS += builtin-mailinfo.o
 BUILTIN_OBJS += builtin-mailsplit.o
+BUILTIN_OBJS += builtin-merge.o
 BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
diff --git a/builtin-merge.c b/builtin-merge.c
new file mode 100644
index 0000000..7312997
--- /dev/null
+++ b/builtin-merge.c
@@ -0,0 +1,1153 @@
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
+#include "color.h"
+
+#define DEFAULT_TWOHEAD (1<<0)
+#define DEFAULT_OCTOPUS (1<<1)
+#define NO_FAST_FORWARD (1<<2)
+#define NO_TRIVIAL      (1<<3)
+
+struct strategy {
+	const char *name;
+	unsigned attr;
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
+static unsigned char head[20], stash[20];
+static struct strategy *use_strategies;
+static size_t use_strategies_nr, use_strategies_alloc;
+static const char *branch;
+
+static struct strategy all_strategy[] = {
+	{ "recur",      NO_TRIVIAL },
+	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
+	{ "octopus",    DEFAULT_OCTOPUS },
+	{ "resolve",    0 },
+	{ "stupid",     0 },
+	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
+	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
+};
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
+		strbuf_addf(buf, "%s\n\n", arg);
+		have_message = 1;
+	}
+	return 0;
+}
+
+static int strategy_lookup(const char *path)
+{
+	int i;
+
+	if (!path)
+		return -1;
+
+	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
+		if (!strcmp(path, all_strategy[i].name))
+			return all_strategy[i].attr;
+	return -1;
+}
+
+static inline void append_strategy(const char *name, unsigned attr)
+{
+	ALLOC_GROW(use_strategies, use_strategies_nr + 1, use_strategies_alloc);
+	use_strategies[use_strategies_nr].name = name;
+	use_strategies[use_strategies_nr++].attr = attr;
+}
+
+static int option_parse_strategy(const struct option *opt,
+	const char *arg, int unset)
+{
+	int i, attr;
+
+	if (unset)
+		return 0;
+
+	attr = strategy_lookup(arg);
+
+	if (attr >= 0)
+		append_strategy(arg, attr);
+	else {
+		struct strbuf err;
+		strbuf_init(&err, 0);
+		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
+			strbuf_addf(&err, " %s", all_strategy[i].name);
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
+		"perform a commit if the merge succeeds (default)"),
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
+static void drop_save(void)
+{
+	unlink(git_path("MERGE_HEAD"));
+	unlink(git_path("MERGE_MSG"));
+}
+
+static void save_state(void)
+{
+	int len;
+	struct child_process cp;
+	struct strbuf buffer = STRBUF_INIT;
+	const char *argv[] = {"stash", "create", NULL};
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.out = -1;
+	cp.git_cmd = 1;
+
+	if (start_command(&cp))
+		die("could not run stash.");
+	len = strbuf_read(&buffer, cp.out, 1024);
+	close(cp.out);
+
+	if (finish_command(&cp) || len < 0)
+		die("stash failed");
+	else if (!len)
+		return;
+	strbuf_setlen(&buffer, buffer.len-1);
+	if (get_sha1(buffer.buf, stash))
+		die("not a valid object: %s", buffer.buf);
+}
+
+static void reset_hard(unsigned const char *sha1, int verbose)
+{
+	int i = 0;
+	const char *args[6];
+
+	args[i++] = "read-tree";
+	if (verbose)
+		args[i++] = "-v";
+	args[i++] = "--reset";
+	args[i++] = "-u";
+	args[i++] = sha1_to_hex(sha1);
+	args[i] = NULL;
+
+	if (run_command_v_opt(args, RUN_GIT_CMD))
+		die("read-tree failed");
+}
+
+static void restore_state(void)
+{
+	struct strbuf sb;
+	const char *args[] = { "stash", "apply", NULL, NULL };
+
+	if (is_null_sha1(stash))
+		return;
+
+	reset_hard(head, 1);
+
+	strbuf_init(&sb, 0);
+	args[2] = sha1_to_hex(stash);
+
+	/*
+	 * It is OK to ignore error here, for example when there was
+	 * nothing to restore.
+	 */
+	run_command_v_opt(args, RUN_GIT_CMD);
+
+	strbuf_release(&sb);
+	refresh_cache(REFRESH_QUIET);
+}
+
+/* This is called when no merge was necessary. */
+static void finish_up_to_date(const char *msg)
+{
+	printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
+	drop_save();
+}
+
+static void squash_message(void)
+{
+	struct rev_info rev;
+	struct commit *commit;
+	struct strbuf out;
+	struct commit_list *j;
+	int fd;
+
+	printf("Squash commit -- not updating HEAD\n");
+	fd = open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die("Could not write to %s", git_path("SQUASH_MSG"));
+
+	init_revisions(&rev, NULL);
+	rev.ignore_merges = 1;
+	rev.commit_format = CMIT_FMT_MEDIUM;
+
+	commit = lookup_commit(head);
+	commit->object.flags |= UNINTERESTING;
+	add_pending_object(&rev, &commit->object, NULL);
+
+	for (j = remoteheads; j; j = j->next)
+		add_pending_object(&rev, &j->item->object, NULL);
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
+	write(fd, out.buf, out.len);
+	close(fd);
+	strbuf_release(&out);
+}
+
+static int run_hook(const char *name)
+{
+	struct child_process hook;
+	const char *argv[3], *env[2];
+	char index[PATH_MAX];
+
+	argv[0] = git_path("hooks/%s", name);
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", get_index_file());
+	env[0] = index;
+	env[1] = NULL;
+
+	if (squash)
+		argv[1] = "1";
+	else
+		argv[1] = "0";
+	argv[2] = NULL;
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
+		squash_message();
+	} else {
+		if (!merge_msg.len)
+			printf("No merge message -- not updating HEAD\n");
+		else {
+			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
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
+		struct diff_options opts;
+		diff_setup(&opts);
+		opts.output_format |=
+			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+		opts.detect_rename = DIFF_DETECT_RENAME;
+		if (diff_use_color_default > 0)
+			DIFF_OPT_SET(&opts, COLOR_DIFF);
+		if (diff_setup_done(&opts) < 0)
+			die("diff_setup_done failed");
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
+	const char *ptr;
+	int len, early;
+
+	memset(branch_head, 0, sizeof(branch_head));
+	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
+	if (!remote_head)
+		die("'%s' does not point to a commit", remote);
+
+	strbuf_init(&buf, 0);
+	strbuf_addstr(&buf, "refs/heads/");
+	strbuf_addstr(&buf, remote);
+	resolve_ref(buf.buf, branch_head, 0, 0);
+
+	if (!hashcmp(remote_head->sha1, branch_head)) {
+		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
+			sha1_to_hex(branch_head), remote);
+		return;
+	}
+
+	/* See if remote matches <name>^^^.. or <name>~<number> */
+	for (len = 0, ptr = remote + strlen(remote);
+	     remote < ptr && ptr[-1] == '^';
+	     ptr--)
+		len++;
+	if (len)
+		early = 1;
+	else {
+		early = 0;
+		ptr = strrchr(remote, '~');
+		if (ptr) {
+			int seen_nonzero = 0;
+
+			len++; /* count ~ */
+			while (*++ptr && isdigit(*ptr)) {
+				seen_nonzero |= (*ptr != '0');
+				len++;
+			}
+			if (*ptr)
+				len = 0; /* not ...~<number> */
+			else if (seen_nonzero)
+				early = 1;
+			else if (len == 1)
+				early = 1; /* "name~" is "name~1"! */
+		}
+	}
+	if (len) {
+		struct strbuf truname = STRBUF_INIT;
+		strbuf_addstr(&truname, "refs/heads/");
+		strbuf_addstr(&truname, remote);
+		strbuf_setlen(&truname, len+11);
+		if (resolve_ref(truname.buf, buf_sha, 0, 0)) {
+			strbuf_addf(msg,
+				    "%s\t\tbranch '%s'%s of .\n",
+				    sha1_to_hex(remote_head->sha1),
+				    truname.buf,
+				    (early ? " (early part)" : ""));
+			return;
+		}
+	}
+
+	if (!strcmp(remote, "FETCH_HEAD") &&
+			!access(git_path("FETCH_HEAD"), R_OK)) {
+		FILE *fp;
+		struct strbuf line;
+		char *ptr;
+
+		strbuf_init(&line, 0);
+		fp = fopen(git_path("FETCH_HEAD"), "r");
+		if (!fp)
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
+		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
+		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
+		argc++;
+		parse_options(argc, argv, builtin_merge_options,
+			      builtin_merge_usage, 0);
+		free(buf);
+	}
+
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+		show_diffstat = git_config_bool(k, v);
+	else if (!strcmp(k, "pull.twohead"))
+		return git_config_string(&pull_twohead, k, v);
+	else if (!strcmp(k, "pull.octopus"))
+		return git_config_string(&pull_octopus, k, v);
+	return git_diff_ui_config(k, v, cb);
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
+	opts.head_idx = 2;
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
+	for (i = 0; i < nr_trees; i++) {
+		parse_tree(trees[i]);
+		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+	}
+	if (unpack_trees(nr_trees, t, &opts))
+		return -1;
+	return 0;
+}
+
+static void write_tree_trivial(unsigned char *sha1)
+{
+	if (write_cache_as_tree(sha1, 0, NULL))
+		die("git write-tree failed to write a tree");
+}
+
+static int try_merge_strategy(const char *strategy, struct commit_list *common,
+	const char *head_arg)
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
+	args[i++] = head_arg;
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
+static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
+{
+	struct tree *trees[MAX_UNPACK_TREES];
+	struct unpack_trees_options opts;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	int i, fd, nr_trees = 0;
+	struct dir_struct dir;
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+
+	if (read_cache_unmerged())
+		die("you need to resolve your current index first");
+
+	fd = hold_locked_index(lock_file, 1);
+
+	memset(&trees, 0, sizeof(trees));
+	memset(&opts, 0, sizeof(opts));
+	memset(&t, 0, sizeof(t));
+	dir.show_ignored = 1;
+	dir.exclude_per_dir = ".gitignore";
+	opts.dir = &dir;
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
+		commit_locked_index(lock_file))
+		die("unable to write new index file");
+	return 0;
+}
+
+static void split_merge_strategies(const char *string, struct strategy **list,
+		int *nr, int *alloc)
+{
+	char *p, *q, *buf;
+
+	if (!string)
+		return;
+
+	buf = xstrdup(string);
+	q = buf;
+	for (;;) {
+		p = strchr(q, ' ');
+		if (!p) {
+			ALLOC_GROW(*list, *nr + 1, *alloc);
+			(*list)[(*nr)++].name = xstrdup(q);
+			free(buf);
+			return;
+		} else {
+			*p = '\0';
+			ALLOC_GROW(*list, *nr + 1, *alloc);
+			(*list)[(*nr)++].name = xstrdup(q);
+			q = ++p;
+		}
+	}
+}
+
+static void add_strategies(const char *string, unsigned attr)
+{
+	struct strategy *list = NULL;
+	int list_alloc = 0, list_nr = 0, i;
+
+	memset(&list, 0, sizeof(list));
+	split_merge_strategies(string, &list, &list_nr, &list_alloc);
+	if (list != NULL) {
+		for (i = 0; i < list_nr; i++) {
+			int attr;
+
+			attr = strategy_lookup(list[i].name);
+			if (attr >= 0)
+				append_strategy(list[i].name, attr);
+		}
+		return;
+	}
+	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
+		if (all_strategy[i].attr & attr)
+			append_strategy(all_strategy[i].name,
+				all_strategy[i].attr);
+}
+
+static int merge_trivial(void)
+{
+	unsigned char result_tree[20], result_commit[20];
+	struct commit_list parent;
+
+	write_tree_trivial(result_tree);
+	printf("Wonderful.\n");
+	parent.item = remoteheads->item;
+	parent.next = NULL;
+	commit_tree(merge_msg.buf, result_tree, &parent, result_commit);
+	finish(result_commit, "In-index merge");
+	drop_save();
+	return 0;
+}
+
+static int finish_automerge(struct commit_list *common,
+	unsigned char *result_tree,
+	const char *wt_strategy)
+{
+	struct commit_list *parents = NULL, *j;
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char result_commit[20];
+
+	free_commit_list(common);
+	if (allow_fast_forward) {
+		parents = remoteheads;
+		commit_list_insert(lookup_commit(head), &parents);
+		parents = reduce_heads(parents);
+	} else {
+		struct commit_list **pptr = &parents;
+
+		pptr = &commit_list_insert(lookup_commit(head),
+				pptr)->next;
+		for (j = remoteheads; j; j = j->next)
+			pptr = &commit_list_insert(j->item, pptr)->next;
+	}
+	free_commit_list(remoteheads);
+	strbuf_addch(&merge_msg, '\n');
+	commit_tree(merge_msg.buf, result_tree, parents, result_commit);
+	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
+	finish(result_commit, buf.buf);
+	strbuf_release(&buf);
+	drop_save();
+	return 0;
+}
+
+static int suggest_conflicts(void)
+{
+	FILE *fp;
+	int pos;
+
+	fp = fopen(git_path("MERGE_MSG"), "a");
+	if (!fp)
+		die("Could open %s for writing", git_path("MERGE_MSG"));
+	fprintf(fp, "\nConflicts:\n");
+	for (pos = 0; pos < active_nr; pos++) {
+		struct cache_entry *ce = active_cache[pos];
+
+		if (ce_stage(ce)) {
+			fprintf(fp, "\t%s\n", ce->name);
+			while (pos + 1 < active_nr &&
+					!strcmp(ce->name,
+						active_cache[pos + 1]->name))
+				pos++;
+		}
+	}
+	fclose(fp);
+	rerere();
+	printf("Automatic merge failed; "
+			"fix conflicts and then commit the result.\n");
+	return 1;
+}
+
+static struct commit *is_old_style_invocation(int argc, const char **argv)
+{
+	struct commit *second_token = NULL;
+	if (argc > 1) {
+		unsigned char second_sha1[20];
+
+		if (get_sha1(argv[1], second_sha1))
+			return NULL;
+		second_token = lookup_commit_reference_gently(second_sha1, 0);
+		if (!second_token)
+			die("'%s' is not a commit", argv[1]);
+		if (hashcmp(second_token->object.sha1, head))
+			return NULL;
+	}
+	return second_token;
+}
+
+static int evaluate_result(void)
+{
+	int cnt = 0;
+	struct rev_info rev;
+
+	if (read_cache() < 0)
+		die("failed to read the cache");
+
+	/* Check how many files differ. */
+	init_revisions(&rev, "");
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.diffopt.output_format |=
+		DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = count_diff_files;
+	rev.diffopt.format_callback_data = &cnt;
+	run_diff_files(&rev, 0);
+
+	/*
+	 * Check how many unmerged entries are
+	 * there.
+	 */
+	cnt += count_unmerged_entries();
+
+	return cnt;
+}
+
+int cmd_merge(int argc, const char **argv, const char *prefix)
+{
+	unsigned char result_tree[20];
+	struct strbuf buf;
+	const char *head_arg;
+	int flag, head_invalid = 0, i;
+	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
+	struct commit_list *common = NULL;
+	const char *best_strategy = NULL, *wt_strategy = NULL;
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
+	branch = resolve_ref("HEAD", head, 0, &flag);
+	if (branch && !prefixcmp(branch, "refs/heads/"))
+		branch += 11;
+	if (is_null_sha1(head))
+		head_invalid = 1;
+
+	git_config(git_merge_config, NULL);
+
+	/* for color.ui */
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
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
+	if (!argc)
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
+
+	if (!have_message && is_old_style_invocation(argc, argv)) {
+		strbuf_addstr(&merge_msg, argv[0]);
+		head_arg = argv[1];
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
+		struct strbuf msg;
+
+		/* We are invoked directly as the first-class UI. */
+		head_arg = "HEAD";
+
+		/*
+		 * All the rest are the commits being merged;
+		 * prepare the standard merge summary message to
+		 * be appended to the given message.  If remote
+		 * is invalid we will die later in the common
+		 * codepath so we discard the error in this
+		 * loop.
+		 */
+		strbuf_init(&msg, 0);
+		for (i = 0; i < argc; i++)
+			merge_name(argv[i], &msg);
+		fmt_merge_msg(option_log, &msg, &merge_msg);
+		if (merge_msg.len)
+			strbuf_setlen(&merge_msg, merge_msg.len-1);
+	}
+
+	if (head_invalid || !argc)
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
+	if (!use_strategies) {
+		if (!remoteheads->next)
+			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
+		else
+			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
+	}
+
+	for (i = 0; i < use_strategies_nr; i++) {
+		if (use_strategies[i].attr & NO_FAST_FORWARD)
+			allow_fast_forward = 0;
+		if (use_strategies[i].attr & NO_TRIVIAL)
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
+		free(list);
+	}
+
+	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head, NULL, 0,
+		DIE_ON_ERR);
+
+	if (!common)
+		; /* No common ancestors found. We need a real merge. */
+	else if (!remoteheads->next && !common->next &&
+			common->item == remoteheads->item) {
+		/*
+		 * If head can reach all the merge then we are up to date.
+		 * but first the most common case of merging one remote.
+		 */
+		finish_up_to_date("Already up-to-date.");
+		return 0;
+	} else if (allow_fast_forward && !remoteheads->next &&
+			!common->next &&
+			!hashcmp(common->item->object.sha1, head)) {
+		/* Again the most common case of merging one remote. */
+		struct strbuf msg;
+		struct object *o;
+		char hex[41];
+
+		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
+
+		printf("Updating %s..%s\n",
+			hex,
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
+			return 1;
+
+		if (checkout_fast_forward(head, remoteheads->item->object.sha1))
+			return 1;
+
+		finish(o->sha1, msg.buf);
+		drop_save();
+		return 0;
+	} else if (!remoteheads->next && common->next)
+		;
+		/*
+		 * We are not doing octopus and not fast forward.  Need
+		 * a real merge.
+		 */
+	else if (!remoteheads->next && !common->next && option_commit) {
+		/*
+		 * We are not doing octopus, not fast forward, and have
+		 * only one common.
+		 */
+		refresh_cache(REFRESH_QUIET);
+		if (allow_trivial) {
+			/* See if it is really trivial. */
+			git_committer_info(IDENT_ERROR_ON_NO_NAME);
+			printf("Trying really trivial in-index merge...\n");
+			if (!read_tree_trivial(common->item->object.sha1,
+					head, remoteheads->item->object.sha1))
+				return merge_trivial();
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
+			/*
+			 * Here we *have* to calculate the individual
+			 * merge_bases again, otherwise "git merge HEAD^
+			 * HEAD^^" would be missed.
+			 */
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
+	if (use_strategies_nr != 1) {
+		/*
+		 * Stash away the local changes so that we can try more
+		 * than one.
+		 */
+		save_state();
+	} else {
+		memcpy(stash, null_sha1, 20);
+	}
+
+	for (i = 0; i < use_strategies_nr; i++) {
+		int ret;
+		if (i) {
+			printf("Rewinding the tree to pristine...\n");
+			restore_state();
+		}
+		if (use_strategies_nr != 1)
+			printf("Trying merge strategy %s...\n",
+				use_strategies[i].name);
+		/*
+		 * Remember which strategy left the state in the working
+		 * tree.
+		 */
+		wt_strategy = use_strategies[i].name;
+
+		ret = try_merge_strategy(use_strategies[i].name,
+			common, head_arg);
+		if (!option_commit && !ret) {
+			merge_was_ok = 1;
+			/*
+			 * This is necessary here just to avoid writing
+			 * the tree, but later we will *not* exit with
+			 * status code 1 because merge_was_ok is set.
+			 */
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
+				int cnt = evaluate_result();
+
+				if (best_cnt <= 0 || cnt <= best_cnt) {
+					best_strategy = use_strategies[i].name;
+					best_cnt = cnt;
+				}
+			}
+			if (merge_was_ok)
+				break;
+			else
+				continue;
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
+	if (automerge_was_ok)
+		return finish_automerge(common, result_tree, wt_strategy);
+
+	/*
+	 * Pick the result from the best strategy and have the user fix
+	 * it up.
+	 */
+	if (!best_strategy) {
+		restore_state();
+		if (use_strategies_nr > 1)
+			fprintf(stderr,
+				"No merge strategy handled the merge.\n");
+		else
+			fprintf(stderr, "Merge with strategy %s failed.\n",
+				use_strategies[0].name);
+		return 2;
+	} else if (best_strategy == wt_strategy)
+		; /* We already have its result in the working tree. */
+	else {
+		printf("Rewinding the tree to pristine...\n");
+		restore_state();
+		printf("Using the %s to prepare resolving by hand.\n",
+			best_strategy);
+		try_merge_strategy(best_strategy, common, head_arg);
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
+	} else
+		return suggest_conflicts();
+}
diff --git a/builtin.h b/builtin.h
index 05ee56f..0e605d4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -64,6 +64,7 @@ extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
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
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index f3a4bb2..fcb8285 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -23,7 +23,7 @@ test_expect_success 'setup' '
 	done
 '
 
-test_expect_failure 'merge c1 with c2, c3, c4, ... c29' '
+test_expect_success 'merge c1 with c2, c3, c4, ... c29' '
 	git reset --hard c1 &&
 	i=2 &&
 	refs="" &&
-- 
1.5.6.1.322.ge904b.dirty
