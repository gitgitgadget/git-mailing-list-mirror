From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 9/9] Build in checkout
Date: Mon, 4 Feb 2008 13:36:07 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802041336060.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:37:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM6BX-0006Qr-8F
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbYBDSgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbYBDSgM
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:36:12 -0500
Received: from iabervon.org ([66.92.72.58]:51160 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676AbYBDSgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:36:10 -0500
Received: (qmail 8490 invoked by uid 1000); 4 Feb 2008 18:36:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Feb 2008 18:36:07 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72549>

The only differences in behavior should be:

 - git checkout -m with non-trivial merging won't print out
   merge-recursive messages (see the change in t7201-co.sh)

 - git checkout -- paths... will give a sensible error message if
   HEAD is invalid as a commit.

 - some intermediate states which were written to disk in the shell
   version (in particular, index states) are only kept in memory in
   this version, and therefore these can no longer be revealed by
   later write operations becoming impossible.

I'm not 100% sure I got the merge recursive setup exactly right; the
base for a non-trivial merge in the shell code doesn't seem
theoretically justified to me, but I tried to match it anyway, and the
tests all pass this way.

Other than these items, the results should be identical to the shell
version, so far as I can tell.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                                           |    3 +-
 builtin-checkout.c                                 |  478 ++++++++++++++++++++
 builtin.h                                          |    1 +
 .../examples/git-checkout.sh                       |    0 
 git.c                                              |    1 +
 t/t7201-co.sh                                      |    7 -
 6 files changed, 482 insertions(+), 8 deletions(-)
 create mode 100644 builtin-checkout.c
 rename git-checkout.sh => contrib/examples/git-checkout.sh (100%)

diff --git a/Makefile b/Makefile
index 85ec1c6..1bfcbdc 100644
--- a/Makefile
+++ b/Makefile
@@ -219,7 +219,7 @@ BASIC_CFLAGS =
 BASIC_LDFLAGS =
 
 SCRIPT_SH = \
-	git-bisect.sh git-checkout.sh \
+	git-bisect.sh \
 	git-clone.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
@@ -331,6 +331,7 @@ BUILTIN_OBJS = \
 	builtin-bundle.o \
 	builtin-cat-file.o \
 	builtin-check-attr.o \
+	builtin-checkout.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
 	builtin-clean.o \
diff --git a/builtin-checkout.c b/builtin-checkout.c
new file mode 100644
index 0000000..2950d5c
--- /dev/null
+++ b/builtin-checkout.c
@@ -0,0 +1,478 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "commit.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+#include "dir.h"
+#include "run-command.h"
+#include "merge-recursive.h"
+#include "diff.h"
+#include "revision.h"
+
+static const char * const checkout_usage[] = {
+	"git checkout [options] <branch>",
+	"git checkout [options] [<branch>] -- <file>...",
+	NULL,
+};
+
+static int post_checkout_hook(struct commit *old, struct commit *new,
+			      int changed)
+{
+	struct child_process proc;
+	const char *name = git_path("hooks/post-checkout");
+	const char *argv[5];
+
+	if (access(name, X_OK) < 0)
+		return 0;
+
+	memset(&proc, 0, sizeof(proc));
+	argv[0] = name;
+	argv[1] = xstrdup(sha1_to_hex(old->object.sha1));
+	argv[2] = xstrdup(sha1_to_hex(new->object.sha1));
+	argv[3] = changed ? "1" : "0";
+	argv[4] = NULL;
+	proc.argv = argv;
+	proc.no_stdin = 1;
+	proc.stdout_to_stderr = 1;
+	return run_command(&proc);
+}
+
+static int cache_unmerged(void)
+{
+	int i;
+	for (i = 0; i < active_nr; i++) {
+		if (ce_stage(active_cache[i]))
+			return 1;
+	}
+	return 0;
+}
+
+static int update_some(const unsigned char *sha1, const char *base, int baselen,
+		       const char *pathname, unsigned mode, int stage)
+{
+	if (S_ISGITLINK(mode)) {
+		return 0;
+	} else if (S_ISDIR(mode)) {
+		return READ_TREE_RECURSIVE;
+	}
+	int len = baselen + strlen(pathname);
+	struct cache_entry *ce = xcalloc(1, cache_entry_size(len));
+	hashcpy(ce->sha1, sha1);
+	memcpy(ce->name, base, baselen);
+	memcpy(ce->name + baselen, pathname, len - baselen);
+	ce->ce_flags = create_ce_flags(len, 0);
+	ce->ce_mode = create_ce_mode(mode);
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+	return 0;
+}
+
+static int read_tree_some(struct tree *tree, const char **pathspec)
+{
+	int newfd;
+	struct lock_file lock_file;
+	newfd = hold_locked_index(&lock_file, 1);
+	read_cache();
+
+	read_tree_recursive(tree, "", 0, 0, pathspec, update_some);
+
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_locked_index(&lock_file))
+		die("unable to write new index file");
+
+	/* update the index with the given tree's info
+	 * for all args, expanding wildcards, and exit
+	 * with any non-zero return code.
+	 */
+	return 0;
+}
+
+static int checkout_paths(const char **pathspec)
+{
+	int pos;
+	struct checkout state;
+	static char *ps_matched;
+	unsigned char rev[20];
+	int flag;
+	struct commit *head;
+
+	for (pos = 0; pathspec[pos]; pos++)
+		;
+	ps_matched = xcalloc(1, pos);
+
+	for (pos = 0; pos < active_nr; pos++) {
+		struct cache_entry *ce = active_cache[pos];
+		pathspec_match(pathspec, ps_matched, ce->name, 0);
+	}
+
+	if (report_path_error(ps_matched, pathspec, 0))
+		return 1;
+
+	memset(&state, 0, sizeof(state));
+	state.force = 1;
+	state.refresh_cache = 1;
+	for (pos = 0; pos < active_nr; pos++) {
+		struct cache_entry *ce = active_cache[pos];
+		if (pathspec_match(pathspec, NULL, ce->name, 0)) {
+			checkout_entry(ce, &state, NULL);
+		}
+	}
+
+	resolve_ref("HEAD", rev, 0, &flag);
+	head = lookup_commit_reference_gently(rev, 1);
+
+	return post_checkout_hook(head, head, 0);
+}
+
+static int remove_merge_head(void)
+{
+	unlink(git_path("MERGE_HEAD"));
+	return 0;
+}
+
+static void show_local_changes(struct object *head)
+{
+	struct rev_info rev;
+	// I think we want full paths, even if we're in a subdirectory.
+	init_revisions(&rev, NULL);
+	rev.abbrev = 0;
+	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
+	add_pending_object(&rev, head, NULL);
+	run_diff_index(&rev, 0);
+}
+
+static void describe_detached_head(char *msg, struct commit *commit)
+{
+	struct strbuf sb;
+	strbuf_init(&sb, 0);
+	parse_commit(commit);
+	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, "", "", 0, 0);
+	fprintf(stderr, "%s %s... %s\n", msg,
+		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
+	strbuf_release(&sb);
+}
+
+static int reset_to_new(struct tree *tree, int quiet)
+{
+	struct unpack_trees_options opts;
+	struct tree_desc tree_desc;
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = -1;
+	opts.update = 1;
+	opts.reset = 1;
+	opts.merge = 1;
+	opts.fn = oneway_merge;
+	opts.verbose_update = !quiet;
+	parse_tree(tree);
+	init_tree_desc(&tree_desc, tree->buffer, tree->size);
+	if (unpack_trees(1, &tree_desc, &opts))
+		return 128;
+	return 0;
+}
+
+static void reset_clean_to_new(struct tree *tree, int quiet)
+{
+	struct unpack_trees_options opts;
+	struct tree_desc tree_desc;
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = -1;
+	opts.skip_unmerged = 1;
+	opts.reset = 1;
+	opts.merge = 1;
+	opts.fn = oneway_merge;
+	opts.verbose_update = !quiet;
+	parse_tree(tree);
+	init_tree_desc(&tree_desc, tree->buffer, tree->size);
+	unpack_trees(1, &tree_desc, &opts);
+}
+
+struct checkout_opts {
+	int quiet;
+	int merge;
+	int force;
+
+	char *new_branch;
+	int new_branch_log;
+	int track;
+	int no_track;
+};
+
+struct branch_info {
+	const char *name; /* The short name used */
+	const char *path; /* The full name of a real branch */
+	struct commit *commit; /* The named commit */
+};
+
+static void setup_branch_path(struct branch_info *branch)
+{
+	char *path = xmalloc(strlen(branch->name) +
+			     strlen("refs/heads/") + 1);
+	sprintf(path, "refs/heads/%s", branch->name);
+	branch->path = path;
+}
+
+static int merge_working_tree(struct checkout_opts *opts,
+			      struct branch_info *old, struct branch_info *new,
+			      const char *prefix)
+{
+	int ret;
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	int newfd = hold_locked_index(lock_file, 1);
+	read_cache();
+
+	if (opts->force) {
+		ret = reset_to_new(new->commit->tree, opts->quiet);
+		if (ret)
+			return ret;
+	} else {
+		struct tree_desc trees[2];
+		struct tree *tree;
+		struct unpack_trees_options topts;
+		memset(&topts, 0, sizeof(topts));
+		topts.head_idx = -1;
+
+		refresh_cache(REFRESH_QUIET);
+
+		if (cache_unmerged()) {
+			ret = opts->merge ? -1 :
+				error("you need to resolve your current index first");
+		} else {
+			topts.update = 1;
+			topts.merge = 1;
+			topts.gently = opts->merge;
+			topts.fn = twoway_merge;
+			topts.dir = xcalloc(1, sizeof(*topts.dir));
+			topts.dir->show_ignored = 1;
+			topts.dir->exclude_per_dir = ".gitignore";
+			topts.prefix = prefix;
+			tree = parse_tree_indirect(old->commit->object.sha1);
+			init_tree_desc(&trees[0], tree->buffer, tree->size);
+			tree = parse_tree_indirect(new->commit->object.sha1);
+			init_tree_desc(&trees[1], tree->buffer, tree->size);
+			ret = unpack_trees(2, trees, &topts);
+		}
+		if (ret) {
+			/*
+			 * Unpack couldn't do a trivial merge; either
+			 * give up or do a real merge, depending on
+			 * whether the merge flag was used.
+			 */
+			struct tree *result;
+			struct tree *work;
+			if (!opts->merge)
+				return 1;
+			parse_commit(old->commit);
+
+			/* Do more real merge */
+
+			/*
+			 * We update the index fully, then write the
+			 * tree from the index, then merge the new
+			 * branch with the current tree, with the old
+			 * branch as the base. Then we reset the index
+			 * (but not the working tree) to the new
+			 * branch, leaving the working tree as the
+			 * merged version, but skipping unmerged
+			 * entries in the index.
+			 */
+
+			add_files_to_cache(0, NULL, NULL);
+			work = write_tree_from_memory();
+
+			ret = reset_to_new(new->commit->tree, opts->quiet);
+			if (ret)
+				return ret;
+			merge_trees(new->commit->tree, work, old->commit->tree,
+				    new->name, "local", &result);
+			reset_clean_to_new(new->commit->tree, opts->quiet);
+		}
+	}
+
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_locked_index(lock_file))
+		die("unable to write new index file");
+
+	if (!opts->force)
+		show_local_changes(&new->commit->object);
+
+	return 0;
+}
+
+static void update_refs_for_switch(struct checkout_opts *opts,
+				   struct branch_info *old,
+				   struct branch_info *new)
+{
+	char *msg;
+	const char *old_desc;
+	if (opts->new_branch) {
+		create_branch(opts->new_branch, new->name, 0,
+			      opts->new_branch_log, opts->track);
+		new->name = opts->new_branch;
+		setup_branch_path(new);
+	}
+
+	msg = malloc(1024);
+	old_desc = old->name;
+	if (!old_desc)
+		old_desc = sha1_to_hex(old->commit->object.sha1);
+	snprintf(msg, 1024, "checkout: moving from %s to %s",
+		 old_desc, new->name);
+
+	if (new->path) {
+		create_symref("HEAD", new->path, msg);
+		if (!opts->quiet) {
+			if (old->path && !strcmp(new->path, old->path))
+				fprintf(stderr, "Already on \"%s\"\n",
+					new->name);
+			else
+				fprintf(stderr, "Switched to%s branch \"%s\"\n",
+					opts->new_branch ? " a new" : "",
+					new->name);
+		}
+	} else if (strcmp(new->name, "HEAD")) {
+		update_ref(msg, "HEAD", new->commit->object.sha1, NULL,
+			   REF_NODEREF, DIE_ON_ERR);
+		if (!opts->quiet) {
+			if (old->path)
+				fprintf(stderr, "Note: moving to \"%s\" which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
+			describe_detached_head("HEAD is now at", new->commit);
+		}
+	}
+	remove_merge_head();
+}
+
+static int switch_branches(struct checkout_opts *opts,
+			   struct branch_info *new, const char *prefix)
+{
+	int ret = 0;
+	struct branch_info old;
+	unsigned char rev[20];
+	int flag;
+	memset(&old, 0, sizeof(old));
+	old.path = resolve_ref("HEAD", rev, 0, &flag);
+	old.commit = lookup_commit_reference_gently(rev, 1);
+	if (!(flag & REF_ISSYMREF))
+		old.path = NULL;
+
+	if (old.path && !prefixcmp(old.path, "refs/heads/"))
+		old.name = old.path + strlen("refs/heads/");
+
+	if (!new->name) {
+		new->name = "HEAD";
+		new->commit = old.commit;
+		if (!new->commit)
+			die("You are on a branch yet to be born");
+		parse_commit(new->commit);
+	}
+
+	/*
+	 * If the new thing isn't a branch and isn't HEAD and we're
+	 * not starting a new branch, and we want messages, and we
+	 * weren't on a branch, and we're moving to a new commit,
+	 * describe the old commit.
+	 */
+	if (!new->path && strcmp(new->name, "HEAD") && !opts->new_branch &&
+	    !opts->quiet && !old.path && new->commit != old.commit)
+		describe_detached_head("Previous HEAD position was", old.commit);
+
+	if (!old.commit) {
+		if (!opts->quiet) {
+			fprintf(stderr, "warning: You appear to be on a branch yet to be born.\n");
+			fprintf(stderr, "warning: Forcing checkout of %s.\n", new->name);
+		}
+		opts->force = 1;
+	}
+
+	ret = merge_working_tree(opts, &old, new, prefix);
+	if (ret)
+		return ret;
+
+	update_refs_for_switch(opts, &old, new);
+
+	return post_checkout_hook(old.commit, new->commit, 1);
+}
+
+int cmd_checkout(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	unsigned char rev[20];
+	const char *arg;
+	struct branch_info new;
+	struct tree *source_tree = NULL;
+
+	memset(&opts, 0, sizeof(opts));
+
+	memset(&new, 0, sizeof(new));
+
+	struct option options[] = {
+		OPT__QUIET(&opts.quiet),
+		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
+		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
+		OPT_BOOLEAN( 0 , "no-track", &opts.no_track, "don't track"),
+		OPT_BOOLEAN( 0 , "track", &opts.track, "track"),
+		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
+		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
+	};
+
+	git_config(git_default_config);
+
+	argc = parse_options(argc, argv, options, checkout_usage, 0);
+	if (argc) {
+		arg = argv[0];
+		if (get_sha1(arg, rev))
+			;
+		else if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
+			new.name = arg;
+			setup_branch_path(&new);
+			if (resolve_ref(new.path, rev, 1, NULL))
+				new.commit = lookup_commit_reference(rev);
+			else
+				new.path = NULL;
+			parse_commit(new.commit);
+			source_tree = new.commit->tree;
+			argv++;
+			argc--;
+		} else if ((source_tree = parse_tree_indirect(rev))) {
+			argv++;
+			argc--;
+		}
+	}
+
+	if (argc && !strcmp(argv[0], "--")) {
+		argv++;
+		argc--;
+	}
+
+	if (!opts.new_branch && (opts.track || opts.no_track)) {
+		die("git checkout: --track and --no-track require -b");
+	}
+	if (opts.force && opts.merge) {
+		die("git checkout: -f and -m are incompatible");
+	}
+
+	if (argc) {
+		const char **pathspec = get_pathspec(prefix, argv);
+		/* Checkout paths */
+		if (opts.new_branch || opts.force || opts.merge) {
+			if (argc == 1) {
+				die("git checkout: updating paths is incompatible with switching branches/forcing\nDid you intend to checkout '%s' which can not be resolved as commit?", argv[0]);
+			} else {
+				die("git checkout: updating paths is incompatible with switching branches/forcing");
+			}
+		}
+
+		if (source_tree)
+			read_tree_some(source_tree, pathspec);
+		else
+			read_cache();
+		return checkout_paths(pathspec);
+	}
+
+	if (new.name && !new.commit) {
+		die("Cannot switch branch to a non-commit.");
+	}
+
+	return switch_branches(&opts, &new, prefix);
+}
diff --git a/builtin.h b/builtin.h
index 428160d..25d91bb 100644
--- a/builtin.h
+++ b/builtin.h
@@ -19,6 +19,7 @@ extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
+extern int cmd_checkout(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
diff --git a/git-checkout.sh b/contrib/examples/git-checkout.sh
similarity index 100%
rename from git-checkout.sh
rename to contrib/examples/git-checkout.sh
diff --git a/git.c b/git.c
index 57c9712..e06a866 100644
--- a/git.c
+++ b/git.c
@@ -296,6 +296,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
+		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
 			RUN_SETUP | NEED_WORK_TREE},
 		{ "check-ref-format", cmd_check_ref_format },
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index c6f93a9..92c9ba9 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -103,13 +103,6 @@ test_expect_success "checkout -m with dirty tree" '
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
 	(cat >expect.messages <<EOF
-Merging side with local
-Merging:
-ab76817 Side M one, D two, A three
-virtual local
-found 1 common ancestor(s):
-7329388 Initial A one, A two
-Auto-merged one
 M	one
 EOF
 ) &&
-- 
1.5.4
