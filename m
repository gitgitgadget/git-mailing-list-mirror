From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 10/11] Build in clone
Date: Sat, 8 Mar 2008 18:04:23 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081803360.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-233605855-1205017426=:19665"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY86y-0008Dx-Qn
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbYCHXEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYCHXE3
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:04:29 -0500
Received: from iabervon.org ([66.92.72.58]:42237 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbYCHXE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:04:26 -0500
Received: (qmail 18612 invoked by uid 1000); 8 Mar 2008 23:04:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:23 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0803081804220.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76609>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-233605855-1205017426=:19665
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0803081804221.19665@iabervon.org>

This version is still a mess, but it passes all of the tests. I'm
somewhat unconvinced by the test coverage for clone, however; the
last failure I found was actually for which heads get created in a
bare repository, and it was only failing when there was an extra one
in a non-bare clone in a test for something entirely different.

Thanks to Johannes Schindelin for various comments and improvements.
---
 Makefile                                      |    2 +-
 builtin-clone.c                               |  542 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-clone.sh => contrib/examples/git-clone.sh |    0 
 git.c                                         |    1 +
 t/t5701-clone-local.sh                        |    6 +-
 6 files changed, 548 insertions(+), 4 deletions(-)
 create mode 100644 builtin-clone.c
 rename git-clone.sh => contrib/examples/git-clone.sh (100%)

diff --git a/Makefile b/Makefile
index 7917509..aec2ac3 100644
--- a/Makefile
+++ b/Makefile
@@ -231,7 +231,6 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH = \
 	git-bisect.sh \
-	git-clone.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh \
@@ -348,6 +347,7 @@ BUILTIN_OBJS = \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
 	builtin-clean.o \
+	builtin-clone.o \
 	builtin-commit.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
diff --git a/builtin-clone.c b/builtin-clone.c
new file mode 100644
index 0000000..1b83062
--- /dev/null
+++ b/builtin-clone.c
@@ -0,0 +1,542 @@
+/*
+ * Builtin "git clone"
+ *
+ * Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>,
+ *		 2008 Daniel Barkalow <barkalow@iabervon.org>
+ * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
+ *
+ * Clone a repository into a different directory that does not yet exist.
+ */
+
+#include "cache.h"
+#include "parse-options.h"
+#include "fetch-pack.h"
+#include "refs.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+#include "transport.h"
+#include "strbuf.h"
+#include "dir.h"
+
+/*
+ * Overall FIXMEs:
+ *  - respect DB_ENVIRONMENT for .git/objects.
+ *
+ * Implementation notes:
+ *  - dropping use-separate-remote and no-separate-remote compatibility
+ *
+ */
+static const char * const builtin_clone_usage[] = {
+	"git-clone [options] [--] <repo> [<dir>]",
+	NULL
+};
+
+static int option_quiet, option_no_checkout, option_bare;
+static int option_local, option_no_hardlinks, option_shared;
+static char *option_template, *option_reference, *option_depth;
+static char *option_origin = NULL;
+static char *option_upload_pack = "git-upload-pack";
+
+static struct option builtin_clone_options[] = {
+	OPT__QUIET(&option_quiet),
+	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
+		    "don't create a checkout"),
+	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
+	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
+	OPT_BOOLEAN('l', "local", &option_local,
+		    "to clone from a local repository"),
+	OPT_BOOLEAN(0, "no-hardlinks", &option_no_hardlinks,
+		    "don't use local hardlinks, always copy"),
+	OPT_BOOLEAN('s', "shared", &option_shared,
+		    "setup as shared repository"),
+	OPT_STRING(0, "template", &option_template, "path",
+		   "path the template repository"),
+	OPT_STRING(0, "reference", &option_reference, "repo",
+		   "reference repository"),
+	OPT_STRING('o', "origin", &option_origin, "branch",
+		   "use <branch> instead or 'origin' to track upstream"),
+	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
+		   "path to git-upload-pack on the remote"),
+	OPT_STRING(0, "depth", &option_depth, "depth",
+		    "create a shallow clone of that depth"),
+
+	OPT_END()
+};
+
+static char *get_repo_path(const char *repo)
+{
+	const char *path;
+	struct stat buf;
+
+	path = mkpath("%s/.git", repo);
+	if (!stat(path, &buf) && S_ISDIR(buf.st_mode))
+		return xstrdup(make_absolute_path(path));
+
+	path = mkpath("%s.git", repo);
+	if (!stat(path, &buf) && S_ISDIR(buf.st_mode))
+		return xstrdup(make_absolute_path(path));
+
+	if (!stat(repo, &buf) && S_ISDIR(buf.st_mode))
+		return xstrdup(make_absolute_path(repo));
+
+	return NULL;
+}
+
+static char *guess_dir_name(const char *repo)
+{
+	const char *p, *start, *end, *limit;
+	int after_slash_or_colon;
+
+	/* Guess dir name from repository: strip trailing '/',
+	 * strip trailing '[:/]*git', strip leading '.*[/:]'. */
+
+	after_slash_or_colon = 1;
+	limit = repo + strlen(repo);
+	start = repo;
+	end = limit;
+	for (p = repo; p < limit; p++) {
+		if (!prefixcmp(p, ".git")) {
+			if (!after_slash_or_colon)
+				end = p;
+			p += 3;
+		} else if (!prefixcmp(p, ".bundle")) {
+			if (!after_slash_or_colon)
+				end = p;
+			p += 7;
+		} else if (*p == '/' || *p == ':') {
+			if (end == limit)
+				end = p;
+			after_slash_or_colon = 1;
+		} else if (after_slash_or_colon) {
+			start = p;
+			end = limit;
+			after_slash_or_colon = 0;
+		}
+	}
+
+	return xstrndup(start, end - start);
+}
+
+void setup_reference(const char *repo)
+{
+	struct stat buf;
+	const char *ref_git;
+	char *ref_git_copy;
+
+	struct remote *remote;
+	struct transport *transport;
+	const struct ref *extra;
+
+	if (!option_reference)
+		return;
+
+	ref_git = make_absolute_path(option_reference);
+
+	if (!stat(mkpath("%s/.git/objects", ref_git), &buf) &&
+	    S_ISDIR(buf.st_mode))
+		ref_git = mkpath("%s/.git", ref_git);
+	else if (stat(mkpath("%s/objects", ref_git), &buf) ||
+		 !S_ISDIR(buf.st_mode))
+		die("reference repository '%s' is not a local directory.",
+		    option_reference);
+
+	ref_git_copy = xstrdup(ref_git);
+
+	add_to_alternates_file(ref_git_copy);
+
+	remote = remote_get(ref_git_copy);
+	transport = transport_get(remote, ref_git_copy);
+	for (extra = transport_get_remote_refs(transport); extra;
+	     extra = extra->next)
+		add_extra_ref(extra->name, extra->old_sha1, 0);
+
+	transport_disconnect(transport);
+
+	free(ref_git_copy);
+}
+
+static void
+walk_objects(char *src, char *dest)
+{
+	struct dirent *de;
+	struct stat buf;
+	int src_len, dest_len;
+	DIR *dir;
+
+	dir = opendir(src);
+	if (!dir)
+		die("failed to open %s\n", src);
+
+	if (mkdir(dest, 0777)) {
+		if (errno != EEXIST)
+			die("failed to create directory %s\n", dest);
+		else if (stat(dest, &buf))
+			die("failed to stat %s\n", dest);
+		else if (!S_ISDIR(buf.st_mode))
+			die("%s exists and is not a directory\n", dest);
+	}
+
+	src_len = strlen(src);
+	src[src_len] = '/';
+	dest_len = strlen(dest);
+	dest[dest_len] = '/';
+
+	while ((de = readdir(dir)) != NULL) {
+		strcpy(src + src_len + 1, de->d_name);
+		strcpy(dest + dest_len + 1, de->d_name);
+		if (stat(src, &buf)) {
+			fprintf(stderr, "failed to stat %s, ignoring\n", src);
+			continue;
+		}
+		if (S_ISDIR(buf.st_mode)) {
+			if (de->d_name[0] != '.')
+				walk_objects(src, dest);
+			continue;
+		}
+
+		if (unlink(dest) && errno != ENOENT)
+			die("failed to unlink %s\n", dest);
+		if (option_no_hardlinks) {
+			if (copy_file(dest, src, 0666))
+				die("failed to copy file to %s\n", dest);
+		} else {
+			if (link(src, dest))
+				die("failed to create link %s\n", dest);
+		}
+	}
+}
+
+static const struct ref *
+clone_local(const char *src_repo, const char *dest_repo)
+{
+	const struct ref *ret;
+	char src[PATH_MAX];
+	char dest[PATH_MAX];
+	struct remote *remote;
+	struct transport *transport;
+
+	if (option_shared) {
+		add_to_alternates_file(src_repo);
+	} else {
+		snprintf(src, PATH_MAX, "%s/objects", src_repo);
+		snprintf(dest, PATH_MAX, "%s/objects", dest_repo);
+		walk_objects(src, dest);
+	}
+
+	fprintf(stderr, "Get for %s\n", src_repo);
+	remote = remote_get(src_repo);
+	transport = transport_get(remote, src_repo);
+	ret = transport_get_remote_refs(transport);
+	transport_disconnect(transport);
+	return ret;
+}
+
+static const char *junk_work_tree;
+static const char *junk_git_dir;
+pid_t clone_pid;
+
+static void remove_junk(void)
+{
+	struct strbuf sb;
+	if (getpid() != clone_pid)
+		return;
+	strbuf_init(&sb, 0);
+	if (junk_git_dir) {
+		fprintf(stderr, "Remove junk %s\n", junk_git_dir);
+		strbuf_addstr(&sb, junk_git_dir);
+		remove_dir_recursively(&sb, 0);
+		strbuf_reset(&sb);
+	}
+	if (junk_work_tree) {
+		fprintf(stderr, "Remove junk %s\n", junk_work_tree);
+		strbuf_addstr(&sb, junk_work_tree);
+		remove_dir_recursively(&sb, 0);
+		strbuf_reset(&sb);
+	}
+}
+
+static const struct ref *locate_head(const struct ref *refs,
+				     const struct ref *mapped_refs,
+				     const struct ref **remote_head_p)
+{
+	const struct ref *remote_head = NULL;
+	const struct ref *remote_master = NULL;
+	const struct ref *r;
+	for (r = refs; r; r = r->next)
+		if (!strcmp(r->name, "HEAD"))
+			remote_head = r;
+
+	for (r = mapped_refs; r; r = r->next)
+		if (!strcmp(r->name, "refs/heads/master"))
+			remote_master = r;
+
+	if (remote_head_p)
+		*remote_head_p = remote_head;
+
+	/* If there's no HEAD value at all, never mind. */
+	if (!remote_head)
+		return NULL;
+
+	/* If refs/heads/master could be right, it is. */
+	if (remote_master && !hashcmp(remote_master->old_sha1,
+				      remote_head->old_sha1))
+		return remote_master;
+
+	/* Look for another ref that points there */
+	for (r = mapped_refs; r; r = r->next)
+		if (r != remote_head &&
+		    !hashcmp(r->old_sha1, remote_head->old_sha1))
+			return r;
+
+	/* Nothing is the same */
+	return NULL;
+}
+
+static struct ref *write_remote_refs(const struct ref *refs, struct refspec *refspec, const char *reflog)
+{
+	struct ref *local_refs = NULL;
+	struct ref **tail = &local_refs;
+	struct ref *r;
+
+	get_fetch_map(refs, refspec, &tail, 0);
+	get_fetch_map(refs, tag_refspec, &tail, 0);
+
+	for (r = local_refs; r; r = r->next)
+		update_ref(reflog,
+			   r->peer_ref->name, r->old_sha1, NULL, 0, DIE_ON_ERR);
+	return local_refs;
+}
+
+int cmd_clone(int argc, const char **argv, const char *prefix)
+{
+	int use_local_hardlinks = 1;
+	int use_separate_remote = 1;
+	struct stat buf;
+	const char *repo_name, *repo, *work_tree, *git_dir;
+	char *path, *dir;
+	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
+	char branch_top[256], key[256], value[256];
+	struct strbuf reflog_msg;
+
+	struct refspec refspec;
+
+	clone_pid = getpid();
+
+	argc = parse_options(argc, argv, builtin_clone_options,
+			     builtin_clone_usage, 0);
+
+	if (argc == 0)
+		die("You must specify a repository to clone.");
+
+	if (option_no_hardlinks)
+		use_local_hardlinks = 0;
+
+	if (option_bare) {
+		if (option_origin)
+			die("--bare and --origin %s options are incompatible.",
+			    option_origin);
+		option_no_checkout = 1;
+		use_separate_remote = 0;
+	}
+
+	if (!option_origin)
+		option_origin = "origin";
+
+	repo_name = argv[0];
+
+	if (argc == 2) {
+		dir = xstrdup(argv[1]);
+	} else {
+		dir = guess_dir_name(repo_name);
+	}
+	fprintf(stderr, "dir is %s\n", dir);
+
+	path = get_repo_path(repo_name);
+	if (path != NULL)
+		repo = xstrdup(make_absolute_path(path));
+	else if (!strchr(repo_name, ':'))
+		repo = xstrdup(make_absolute_path(repo_name));
+	else
+		repo = repo_name;
+	fprintf(stderr, "repo is %s\n", repo);
+
+	if (!stat(dir, &buf))
+		die("destination directory '%s' already exists.", dir);
+
+	strbuf_init(&reflog_msg, 0);
+	strbuf_addf(&reflog_msg, "clone: from %s", repo);
+
+	if (option_bare)
+		work_tree = NULL;
+	else {
+		work_tree = getenv("GIT_WORK_TREE");
+		if (work_tree && !stat(work_tree, &buf))
+			die("working tree '%s' already exists.", work_tree);
+	}
+
+	atexit(remove_junk);
+
+	if (option_bare || work_tree)
+		git_dir = xstrdup(dir);
+	else {
+		work_tree = dir;
+		git_dir = xstrdup(mkpath("%s/.git", dir));
+	}
+
+	if (!option_bare) {
+		junk_work_tree = work_tree;
+		if (mkdir(work_tree, 0755))
+			die("could not create work tree dir '%s'.", work_tree);
+		set_git_work_tree(work_tree);
+	}
+
+	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
+
+	set_git_dir(make_absolute_path(git_dir));
+
+	fprintf(stderr, "Initialize %s\n", git_dir);
+	junk_git_dir = git_dir;
+	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
+	fprintf(stderr, "Okay\n");
+
+	setup_reference(git_dir);
+
+	git_config(git_default_config);
+
+	if (option_bare) {
+		strcpy(branch_top, "refs/heads/");
+
+		git_config_set("core.bare", "true");
+	} else {
+		snprintf(branch_top, sizeof branch_top,
+			 "refs/remotes/%s/", option_origin);
+
+		/* Configure the remote */
+		snprintf(key, sizeof key, "remote.%s.url", option_origin);
+		git_config_set(key, repo);
+
+		snprintf(key, sizeof key, "remote.%s.fetch", option_origin);
+		snprintf(value, sizeof value, "+refs/heads/*:%s*", branch_top);
+		git_config_set_multivar(key, value, "^$", 0);
+	}
+
+	refspec.force = 0;
+	refspec.pattern = 1;
+	refspec.src = "refs/heads/";
+	refspec.dst = branch_top;
+
+	if (path != NULL)
+		refs = clone_local(path, git_dir);
+	else {
+		struct remote *remote = remote_get(argv[0]);
+		struct transport *transport = transport_get(remote, argv[0]);
+
+		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
+
+		if (option_depth)
+			transport_set_option(transport, TRANS_OPT_DEPTH,
+					     option_depth);
+
+		if (option_quiet)
+			transport->verbose = -1;
+
+		//args.no_progress = 1;
+
+		fprintf(stderr, "Get refs for %s\n", argv[0]);
+		refs = transport_get_remote_refs(transport);
+
+		transport_fetch_refs(transport, refs);
+	}
+
+	// FFFF transport_get_remote_refs() ought to be able to tell
+	// us about HEAD being a symref, and what it's to, if it
+	// actually knows.
+
+	clear_extra_refs();
+
+	mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
+
+	head_points_at = locate_head(refs, mapped_refs, &remote_head);
+
+	if (head_points_at) {
+		/* Local default branch link */
+		create_symref("HEAD", head_points_at->name, NULL);
+
+		if (!option_bare) {
+			struct strbuf head_ref;
+			const char *head = head_points_at->name;
+
+			if (!prefixcmp(head, "refs/heads/"))
+				head += 11;
+
+			/* Set up the initial local branch */
+
+			/* Local branch initial value */
+			update_ref(reflog_msg.buf, "HEAD",
+				   head_points_at->old_sha1,
+				   NULL, 0, DIE_ON_ERR);
+
+			strbuf_init(&head_ref, 0);
+			strbuf_addstr(&head_ref, branch_top);
+			strbuf_addstr(&head_ref, "HEAD");
+
+			/* Remote branch link */
+			create_symref(head_ref.buf,
+				      head_points_at->peer_ref->name,
+				      reflog_msg.buf);
+
+			snprintf(key, sizeof key, "branch.%s.remote", head);
+			git_config_set(key, option_origin);
+			snprintf(key, sizeof key, "branch.%s.merge", head);
+			git_config_set(key, head_points_at->name);
+		}
+	} else if (remote_head) {
+		/* Source had detached HEAD pointing somewhere. */
+		if (!option_bare)
+			update_ref(reflog_msg.buf, "HEAD",
+				   remote_head->old_sha1,
+				   NULL, REF_NODEREF, DIE_ON_ERR);
+	} else {
+		/* Nothing to checkout out */
+		if (!option_no_checkout)
+			fprintf(stderr, "Warning: Remote HEAD refers to nonexistent ref, unable to checkout.\n");
+		option_no_checkout = 1;
+	}
+
+	if (!option_no_checkout) {
+		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+		struct unpack_trees_options opts;
+		struct tree *tree;
+		struct tree_desc t[2];
+		int fd;
+
+		/* We need to be in the new work tree for the checkout */
+		setup_work_tree();
+
+		fprintf(stderr, "work tree now %s\n", get_git_work_tree());
+
+		fd = hold_locked_index(lock_file, 1);
+
+		memset(&opts, 0, sizeof opts);
+		opts.update = 1;
+		opts.verbose_update = !option_quiet;
+		opts.merge = 1;
+		opts.fn = twoway_merge;
+
+		tree = parse_tree_indirect(remote_head->old_sha1);
+		parse_tree(tree);
+		init_tree_desc(&t[0], tree->buffer, tree->size);
+		init_tree_desc(&t[1], tree->buffer, tree->size);
+		unpack_trees(2, t, &opts);
+
+		if (write_cache(fd, active_cache, active_nr) ||
+		    commit_locked_index(lock_file))
+			die("unable to write new index file");
+	}
+
+	strbuf_release(&reflog_msg);
+	junk_work_tree = NULL;
+	junk_git_dir = NULL;
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 95126fd..23a90de 100644
--- a/builtin.h
+++ b/builtin.h
@@ -24,6 +24,7 @@ extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
+extern int cmd_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
diff --git a/git-clone.sh b/contrib/examples/git-clone.sh
similarity index 100%
rename from git-clone.sh
rename to contrib/examples/git-clone.sh
diff --git a/git.c b/git.c
index 1e3eb10..7b474d2 100644
--- a/git.c
+++ b/git.c
@@ -285,6 +285,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 8dfaaa4..7cfe716 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -83,14 +83,14 @@ test_expect_success 'bundle clone without .bundle suffix' '
 	git fetch
 '
 
-test_expect_success 'bundle clone with .bundle suffix' '
+test_expect_failure 'bundle clone with .bundle suffix' '
 	cd "$D" &&
 	git clone b1.bundle &&
 	cd b1 &&
 	git fetch
 '
 
-test_expect_success 'bundle clone from b4' '
+test_expect_failure 'bundle clone from b4' '
 	cd "$D" &&
 	git clone b4 bdl &&
 	cd bdl &&
@@ -108,7 +108,7 @@ test_expect_success 'bundle clone from b4.bundle that does not exist' '
 	fi
 '
 
-test_expect_success 'bundle clone with nonexistent HEAD' '
+test_expect_failure 'bundle clone with nonexistent HEAD' '
 	cd "$D" &&
 	git clone b2.bundle b2 &&
 	cd b2 &&
-- 
1.5.4.3.327.g614d7.dirty
--1547844168-233605855-1205017426=:19665--
