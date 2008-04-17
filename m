From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 8/8] Build in clone
Date: Thu, 17 Apr 2008 19:32:43 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804171932080.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-365792352-1208475129=:19665"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 01:33:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmdbl-0003ZA-Tf
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 01:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbYDQXcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbYDQXcx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 19:32:53 -0400
Received: from iabervon.org ([66.92.72.58]:42470 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292AbYDQXcu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 19:32:50 -0400
Received: (qmail 6333 invoked by uid 1000); 17 Apr 2008 23:32:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2008 23:32:43 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0804171932420.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79851>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-365792352-1208475129=:19665
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0804171932421.19665@iabervon.org>

This version is still a mess, but it passes all of the tests. I'm
somewhat unconvinced by the test coverage for clone, however; the
last failure I found was actually for which heads get created in a
bare repository, and it was only failing when there was an extra one
in a non-bare clone in a test for something entirely different.

Thanks to Johannes Schindelin for various comments and improvements,
including supporting cloning full bundles.
---
 Makefile                      |    2 +-
 builtin-clone.c               |  546 +++++++++++++++++++++++++++++++++++++++++
 builtin.h                     |    1 +
 contrib/examples/git-clone.sh |  522 +++++++++++++++++++++++++++++++++++++++
 git-clone.sh                  |  522 ---------------------------------------
 git.c                         |    1 +
 6 files changed, 1071 insertions(+), 523 deletions(-)
 create mode 100644 builtin-clone.c
 create mode 100755 contrib/examples/git-clone.sh
 delete mode 100755 git-clone.sh

diff --git a/Makefile b/Makefile
index 78b7738..be9113f 100644
--- a/Makefile
+++ b/Makefile
@@ -235,7 +235,6 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
-SCRIPT_SH += git-clone.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -479,6 +478,7 @@ BUILTIN_OBJS += builtin-check-ref-format.o
 BUILTIN_OBJS += builtin-checkout-index.o
 BUILTIN_OBJS += builtin-checkout.o
 BUILTIN_OBJS += builtin-clean.o
+BUILTIN_OBJS += builtin-clone.o
 BUILTIN_OBJS += builtin-commit-tree.o
 BUILTIN_OBJS += builtin-commit.o
 BUILTIN_OBJS += builtin-config.o
diff --git a/builtin-clone.c b/builtin-clone.c
new file mode 100644
index 0000000..17d10b1
--- /dev/null
+++ b/builtin-clone.c
@@ -0,0 +1,546 @@
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
+static char *get_repo_path(const char *repo, int *is_bundle)
+{
+	static char *suffix[] = { "/.git", ".git", "" };
+	static char *bundle_suffix[] = { ".bundle", "" };
+	struct stat st;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
+		const char *path;
+		path = mkpath("%s%s", repo, suffix[i]);
+		if (!stat(path, &st) && S_ISDIR(st.st_mode)) {
+			*is_bundle = 0;
+			return xstrdup(make_absolute_path(path));
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(bundle_suffix); i++) {
+		const char *path;
+		path = mkpath("%s%s", repo, bundle_suffix[i]);
+		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
+			*is_bundle = 1;
+			return xstrdup(make_absolute_path(path));
+		}
+	}
+
+	return NULL;
+}
+
+static char *guess_dir_name(const char *repo, int is_bundle)
+{
+	const char *p, *start, *end, *limit;
+	int after_slash_or_colon;
+
+	/* Guess dir name from repository: strip trailing '/',
+	 * strip trailing '[:/]*.{git,bundle}', strip leading '.*[/:]'. */
+
+	after_slash_or_colon = 1;
+	limit = repo + strlen(repo);
+	start = repo;
+	end = limit;
+	for (p = repo; p < limit; p++) {
+		const char *prefix = is_bundle ? ".bundle" : ".git";
+		if (!prefixcmp(p, prefix)) {
+			if (!after_slash_or_colon)
+				end = p;
+			p += strlen(prefix) - 1;
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
+static int is_directory(const char *path)
+{
+	struct stat buf;
+
+	return !stat(path, &buf) && S_ISDIR(buf.st_mode);
+}
+
+static void setup_reference(const char *repo)
+{
+	const char *ref_git;
+	char *ref_git_copy;
+
+	struct remote *remote;
+	struct transport *transport;
+	const struct ref *extra;
+
+	ref_git = make_absolute_path(option_reference);
+
+	if (is_directory(mkpath("%s/.git/objects", ref_git)))
+		ref_git = mkpath("%s/.git", ref_git);
+	else if (!is_directory(mkpath("%s/objects", ref_git)))
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
+static void copy_or_link_directory(char *src, char *dest)
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
+			warning ("failed to stat %s\n", src);
+			continue;
+		}
+		if (S_ISDIR(buf.st_mode)) {
+			if (de->d_name[0] != '.')
+				copy_or_link_directory(src, dest);
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
+static const struct ref * clone_local(const char *src_repo,
+		const char *dest_repo)
+{
+	const struct ref *ret;
+	char src[PATH_MAX];
+	char dest[PATH_MAX];
+	struct remote *remote;
+	struct transport *transport;
+
+	if (option_shared)
+		add_to_alternates_file(src_repo);
+	else {
+		snprintf(src, PATH_MAX, "%s/objects", src_repo);
+		snprintf(dest, PATH_MAX, "%s/objects", dest_repo);
+		copy_or_link_directory(src, dest);
+	}
+
+	remote = remote_get(src_repo);
+	transport = transport_get(remote, src_repo);
+	ret = transport_get_remote_refs(transport);
+	transport_disconnect(transport);
+	return ret;
+}
+
+static const char *junk_work_tree;
+static const char *junk_git_dir;
+pid_t junk_pid;
+
+static void remove_junk(void)
+{
+	struct strbuf sb;
+	if (getpid() != junk_pid)
+		return;
+	strbuf_init(&sb, 0);
+	if (junk_git_dir) {
+		strbuf_addstr(&sb, junk_git_dir);
+		remove_dir_recursively(&sb, 0);
+		strbuf_reset(&sb);
+	}
+	if (junk_work_tree) {
+		strbuf_addstr(&sb, junk_work_tree);
+		remove_dir_recursively(&sb, 0);
+		strbuf_reset(&sb);
+	}
+}
+
+static void remove_junk_on_signal(int signo)
+{
+	remove_junk();
+	signal(SIGINT, SIG_DFL);
+	raise(signo);
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
+static struct ref *write_remote_refs(const struct ref *refs,
+		struct refspec *refspec, const char *reflog)
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
+	int is_bundle = 0;
+	struct stat buf;
+	const char *repo_name, *repo, *work_tree, *git_dir;
+	char *path, *dir;
+	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
+	char branch_top[256], key[256], value[256];
+	struct strbuf reflog_msg;
+
+	struct refspec refspec;
+
+	junk_pid = getpid();
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
+	path = get_repo_path(repo_name, &is_bundle);
+	if (path)
+		repo = path;
+	else if (!strchr(repo_name, ':'))
+		repo = xstrdup(make_absolute_path(repo_name));
+	else
+		repo = repo_name;
+
+	if (argc == 2)
+		dir = xstrdup(argv[1]);
+	else
+		dir = guess_dir_name(repo_name, is_bundle);
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
+	junk_git_dir = git_dir;
+	atexit(remove_junk);
+	signal(SIGINT, remove_junk_on_signal);
+
+	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
+
+	set_git_dir(make_absolute_path(git_dir));
+
+	fprintf(stderr, "Initialize %s\n", git_dir);
+	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
+
+	if (option_reference)
+		setup_reference(git_dir);
+
+	git_config(git_default_config);
+
+	if (option_bare) {
+		strcpy(branch_top, "refs/heads/");
+
+		git_config_set("core.bare", "true");
+	} else {
+		snprintf(branch_top, sizeof(branch_top),
+			 "refs/remotes/%s/", option_origin);
+
+		/* Configure the remote */
+		snprintf(key, sizeof(key), "remote.%s.url", option_origin);
+		git_config_set(key, repo);
+
+		snprintf(key, sizeof(key), "remote.%s.fetch", option_origin);
+		snprintf(value, sizeof(value),
+				"+refs/heads/*:%s*", branch_top);
+		git_config_set_multivar(key, value, "^$", 0);
+	}
+
+	refspec.force = 0;
+	refspec.pattern = 1;
+	refspec.src = "refs/heads/";
+	refspec.dst = branch_top;
+
+	if (path && !is_bundle)
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
+		refs = transport_get_remote_refs(transport);
+		transport_fetch_refs(transport, refs);
+	}
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
+			snprintf(key, sizeof(key), "branch.%s.remote", head);
+			git_config_set(key, option_origin);
+			snprintf(key, sizeof(key), "branch.%s.merge", head);
+			git_config_set(key, head_points_at->name);
+		}
+	} else if (remote_head) {
+		/* Source had detached HEAD pointing somewhere. */
+		if (option_bare)
+			option_no_checkout = 1;
+		else
+			update_ref(reflog_msg.buf, "HEAD",
+				   remote_head->old_sha1,
+				   NULL, REF_NODEREF, DIE_ON_ERR);
+	} else {
+		/* Nothing to checkout out */
+		if (!option_no_checkout)
+			warning ("remote HEAD refers to nonexistent ref, "
+				"unable to checkout.\n");
+		option_no_checkout = 1;
+	}
+
+	if (!option_no_checkout) {
+		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+		struct unpack_trees_options opts;
+		struct tree *tree;
+		struct tree_desc t;
+		int fd;
+
+		/* We need to be in the new work tree for the checkout */
+		setup_work_tree();
+
+		fd = hold_locked_index(lock_file, 1);
+
+		memset(&opts, 0, sizeof opts);
+		opts.update = 1;
+		opts.verbose_update = !option_quiet;
+		opts.dst_index = &the_index;
+
+		tree = parse_tree_indirect(remote_head->old_sha1);
+		parse_tree(tree);
+		init_tree_desc(&t, tree->buffer, tree->size);
+		unpack_trees(1, &t, &opts);
+
+		if (write_cache(fd, active_cache, active_nr) ||
+		    commit_locked_index(lock_file))
+			die("unable to write new index file");
+	}
+
+	strbuf_release(&reflog_msg);
+	junk_pid = 0;
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
diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
new file mode 100755
index 0000000..2636159
--- /dev/null
+++ b/contrib/examples/git-clone.sh
@@ -0,0 +1,522 @@
+#!/bin/sh
+#
+# Copyright (c) 2005, Linus Torvalds
+# Copyright (c) 2005, Junio C Hamano
+#
+# Clone a repository into a different directory that does not yet exist.
+
+# See git-sh-setup why.
+unset CDPATH
+
+OPTIONS_SPEC="\
+git-clone [options] [--] <repo> [<dir>]
+--
+n,no-checkout        don't create a checkout
+bare                 create a bare repository
+naked                create a bare repository
+l,local              to clone from a local repository
+no-hardlinks         don't use local hardlinks, always copy
+s,shared             setup as a shared repository
+template=            path to the template directory
+q,quiet              be quiet
+reference=           reference repository
+o,origin=            use <name> instead of 'origin' to track upstream
+u,upload-pack=       path to git-upload-pack on the remote
+depth=               create a shallow clone of that depth
+
+use-separate-remote  compatibility, do not use
+no-separate-remote   compatibility, do not use"
+
+die() {
+	echo >&2 "$@"
+	exit 1
+}
+
+usage() {
+	exec "$0" -h
+}
+
+eval "$(echo "$OPTIONS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
+
+get_repo_base() {
+	(
+		cd "`/bin/pwd`" &&
+		cd "$1" || cd "$1.git" &&
+		{
+			cd .git
+			pwd
+		}
+	) 2>/dev/null
+}
+
+if [ -n "$GIT_SSL_NO_VERIFY" -o \
+	"`git config --bool http.sslVerify`" = false ]; then
+    curl_extra_args="-k"
+fi
+
+http_fetch () {
+	# $1 = Remote, $2 = Local
+	curl -nsfL $curl_extra_args "$1" >"$2"
+	curl_exit_status=$?
+	case $curl_exit_status in
+	126|127) exit ;;
+	*)	 return $curl_exit_status ;;
+	esac
+}
+
+clone_dumb_http () {
+	# $1 - remote, $2 - local
+	cd "$2" &&
+	clone_tmp="$GIT_DIR/clone-tmp" &&
+	mkdir -p "$clone_tmp" || exit 1
+	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
+		"`git config --bool http.noEPSV`" = true ]; then
+		curl_extra_args="${curl_extra_args} --disable-epsv"
+	fi
+	http_fetch "$1/info/refs" "$clone_tmp/refs" ||
+		die "Cannot get remote repository information.
+Perhaps git-update-server-info needs to be run there?"
+	test "z$quiet" = z && v=-v || v=
+	while read sha1 refname
+	do
+		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
+		case "$name" in
+		*^*)	continue;;
+		esac
+		case "$bare,$name" in
+		yes,* | ,heads/* | ,tags/*) ;;
+		*)	continue ;;
+		esac
+		if test -n "$use_separate_remote" &&
+		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
+		then
+			tname="remotes/$origin/$branch_name"
+		else
+			tname=$name
+		fi
+		git-http-fetch $v -a -w "$tname" "$sha1" "$1" || exit 1
+	done <"$clone_tmp/refs"
+	rm -fr "$clone_tmp"
+	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
+	rm -f "$GIT_DIR/REMOTE_HEAD"
+	if test -f "$GIT_DIR/REMOTE_HEAD"; then
+		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+		case "$head_sha1" in
+		'ref: refs/'*)
+			;;
+		*)
+			git-http-fetch $v -a "$head_sha1" "$1" ||
+			rm -f "$GIT_DIR/REMOTE_HEAD"
+			;;
+		esac
+	fi
+}
+
+quiet=
+local=no
+use_local_hardlink=yes
+local_shared=no
+unset template
+no_checkout=
+upload_pack=
+bare=
+reference=
+origin=
+origin_override=
+use_separate_remote=t
+depth=
+no_progress=
+local_explicitly_asked_for=
+test -t 1 || no_progress=--no-progress
+
+while test $# != 0
+do
+	case "$1" in
+	-n|--no-checkout)
+		no_checkout=yes ;;
+	--naked|--bare)
+		bare=yes ;;
+	-l|--local)
+		local_explicitly_asked_for=yes
+		use_local_hardlink=yes
+		;;
+	--no-hardlinks)
+		use_local_hardlink=no ;;
+	-s|--shared)
+		local_shared=yes ;;
+	--template)
+		shift; template="--template=$1" ;;
+	-q|--quiet)
+		quiet=-q ;;
+	--use-separate-remote|--no-separate-remote)
+		die "clones are always made with separate-remote layout" ;;
+	--reference)
+		shift; reference="$1" ;;
+	-o|--origin)
+		shift;
+		case "$1" in
+		'')
+		    usage ;;
+		*/*)
+		    die "'$1' is not suitable for an origin name"
+		esac
+		git check-ref-format "heads/$1" ||
+		    die "'$1' is not suitable for a branch name"
+		test -z "$origin_override" ||
+		    die "Do not give more than one --origin options."
+		origin_override=yes
+		origin="$1"
+		;;
+	-u|--upload-pack)
+		shift
+		upload_pack="--upload-pack=$1" ;;
+	--depth)
+		shift
+		depth="--depth=$1" ;;
+	--)
+		shift
+		break ;;
+	*)
+		usage ;;
+	esac
+	shift
+done
+
+repo="$1"
+test -n "$repo" ||
+    die 'you must specify a repository to clone.'
+
+# --bare implies --no-checkout and --no-separate-remote
+if test yes = "$bare"
+then
+	if test yes = "$origin_override"
+	then
+		die '--bare and --origin $origin options are incompatible.'
+	fi
+	no_checkout=yes
+	use_separate_remote=
+fi
+
+if test -z "$origin"
+then
+	origin=origin
+fi
+
+# Turn the source into an absolute path if
+# it is local
+if base=$(get_repo_base "$repo"); then
+	repo="$base"
+	if test -z "$depth"
+	then
+		local=yes
+	fi
+elif test -f "$repo"
+then
+	case "$repo" in /*) ;; *) repo="$PWD/$repo" ;; esac
+fi
+
+# Decide the directory name of the new repository
+if test -n "$2"
+then
+	dir="$2"
+else
+	# Derive one from the repository name
+	# Try using "humanish" part of source repo if user didn't specify one
+	if test -f "$repo"
+	then
+		# Cloning from a bundle
+		dir=$(echo "$repo" | sed -e 's|/*\.bundle$||' -e 's|.*/||g')
+	else
+		dir=$(echo "$repo" |
+			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
+	fi
+fi
+
+[ -e "$dir" ] && die "destination directory '$dir' already exists."
+[ yes = "$bare" ] && unset GIT_WORK_TREE
+[ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&
+die "working tree '$GIT_WORK_TREE' already exists."
+D=
+W=
+cleanup() {
+	err=$?
+	test -z "$D" && rm -rf "$dir"
+	test -z "$W" && test -n "$GIT_WORK_TREE" && rm -rf "$GIT_WORK_TREE"
+	cd ..
+	test -n "$D" && rm -rf "$D"
+	test -n "$W" && rm -rf "$W"
+	exit $err
+}
+trap cleanup 0
+mkdir -p "$dir" && D=$(cd "$dir" && pwd) || usage
+test -n "$GIT_WORK_TREE" && mkdir -p "$GIT_WORK_TREE" &&
+W=$(cd "$GIT_WORK_TREE" && pwd) && GIT_WORK_TREE="$W" && export GIT_WORK_TREE
+if test yes = "$bare" || test -n "$GIT_WORK_TREE"; then
+	GIT_DIR="$D"
+else
+	GIT_DIR="$D/.git"
+fi &&
+export GIT_DIR &&
+GIT_CONFIG="$GIT_DIR/config" git-init $quiet ${template+"$template"} || usage
+
+if test -n "$bare"
+then
+	GIT_CONFIG="$GIT_DIR/config" git config core.bare true
+fi
+
+if test -n "$reference"
+then
+	ref_git=
+	if test -d "$reference"
+	then
+		if test -d "$reference/.git/objects"
+		then
+			ref_git="$reference/.git"
+		elif test -d "$reference/objects"
+		then
+			ref_git="$reference"
+		fi
+	fi
+	if test -n "$ref_git"
+	then
+		ref_git=$(cd "$ref_git" && pwd)
+		echo "$ref_git/objects" >"$GIT_DIR/objects/info/alternates"
+		(
+			GIT_DIR="$ref_git" git for-each-ref \
+				--format='%(objectname) %(*objectname)'
+		) |
+		while read a b
+		do
+			test -z "$a" ||
+			git update-ref "refs/reference-tmp/$a" "$a"
+			test -z "$b" ||
+			git update-ref "refs/reference-tmp/$b" "$b"
+		done
+	else
+		die "reference repository '$reference' is not a local directory."
+	fi
+fi
+
+rm -f "$GIT_DIR/CLONE_HEAD"
+
+# We do local magic only when the user tells us to.
+case "$local" in
+yes)
+	( cd "$repo/objects" ) ||
+		die "cannot chdir to local '$repo/objects'."
+
+	if test "$local_shared" = yes
+	then
+		mkdir -p "$GIT_DIR/objects/info"
+		echo "$repo/objects" >>"$GIT_DIR/objects/info/alternates"
+	else
+		cpio_quiet_flag=""
+		cpio --help 2>&1 | grep -- --quiet >/dev/null && \
+			cpio_quiet_flag=--quiet
+		l= &&
+		if test "$use_local_hardlink" = yes
+		then
+			# See if we can hardlink and drop "l" if not.
+			sample_file=$(cd "$repo" && \
+				      find objects -type f -print | sed -e 1q)
+			# objects directory should not be empty because
+			# we are cloning!
+			test -f "$repo/$sample_file" ||
+				die "fatal: cannot clone empty repository"
+			if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
+			then
+				rm -f "$GIT_DIR/objects/sample"
+				l=l
+			elif test -n "$local_explicitly_asked_for"
+			then
+				echo >&2 "Warning: -l asked but cannot hardlink to $repo"
+			fi
+		fi &&
+		cd "$repo" &&
+		find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
+			exit 1
+	fi
+	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
+	;;
+*)
+	case "$repo" in
+	rsync://*)
+		case "$depth" in
+		"") ;;
+		*) die "shallow over rsync not supported" ;;
+		esac
+		rsync $quiet -av --ignore-existing  \
+			--exclude info "$repo/objects/" "$GIT_DIR/objects/" ||
+		exit
+		# Look at objects/info/alternates for rsync -- http will
+		# support it natively and git native ones will do it on the
+		# remote end.  Not having that file is not a crime.
+		rsync -q "$repo/objects/info/alternates" \
+			"$GIT_DIR/TMP_ALT" 2>/dev/null ||
+			rm -f "$GIT_DIR/TMP_ALT"
+		if test -f "$GIT_DIR/TMP_ALT"
+		then
+		    ( cd "$D" &&
+		      . git-parse-remote &&
+		      resolve_alternates "$repo" <"$GIT_DIR/TMP_ALT" ) |
+		    while read alt
+		    do
+			case "$alt" in 'bad alternate: '*) die "$alt";; esac
+			case "$quiet" in
+			'')	echo >&2 "Getting alternate: $alt" ;;
+			esac
+			rsync $quiet -av --ignore-existing  \
+			    --exclude info "$alt" "$GIT_DIR/objects" || exit
+		    done
+		    rm -f "$GIT_DIR/TMP_ALT"
+		fi
+		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
+		;;
+	https://*|http://*|ftp://*)
+		case "$depth" in
+		"") ;;
+		*) die "shallow over http or ftp not supported" ;;
+		esac
+		if test -z "@@NO_CURL@@"
+		then
+			clone_dumb_http "$repo" "$D"
+		else
+			die "http transport not supported, rebuild Git with curl support"
+		fi
+		;;
+	*)
+		if [ -f "$repo" ] ; then
+			git bundle unbundle "$repo" > "$GIT_DIR/CLONE_HEAD" ||
+			die "unbundle from '$repo' failed."
+		else
+			case "$upload_pack" in
+			'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
+			*) git-fetch-pack --all -k \
+				$quiet "$upload_pack" $depth $no_progress "$repo" ;;
+			esac >"$GIT_DIR/CLONE_HEAD" ||
+			die "fetch-pack from '$repo' failed."
+		fi
+		;;
+	esac
+	;;
+esac
+test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GIT_DIR/refs/reference-tmp"
+
+if test -f "$GIT_DIR/CLONE_HEAD"
+then
+	# Read git-fetch-pack -k output and store the remote branches.
+	if [ -n "$use_separate_remote" ]
+	then
+		branch_top="remotes/$origin"
+	else
+		branch_top="heads"
+	fi
+	tag_top="tags"
+	while read sha1 name
+	do
+		case "$name" in
+		*'^{}')
+			continue ;;
+		HEAD)
+			destname="REMOTE_HEAD" ;;
+		refs/heads/*)
+			destname="refs/$branch_top/${name#refs/heads/}" ;;
+		refs/tags/*)
+			destname="refs/$tag_top/${name#refs/tags/}" ;;
+		*)
+			continue ;;
+		esac
+		git update-ref -m "clone: from $repo" "$destname" "$sha1" ""
+	done < "$GIT_DIR/CLONE_HEAD"
+fi
+
+if test -n "$W"; then
+	cd "$W" || exit
+else
+	cd "$D" || exit
+fi
+
+if test -z "$bare"
+then
+	# a non-bare repository is always in separate-remote layout
+	remote_top="refs/remotes/$origin"
+	head_sha1=
+	test ! -r "$GIT_DIR/REMOTE_HEAD" || head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+	case "$head_sha1" in
+	'ref: refs/'*)
+		# Uh-oh, the remote told us (http transport done against
+		# new style repository with a symref HEAD).
+		# Ideally we should skip the guesswork but for now
+		# opt for minimum change.
+		head_sha1=`expr "z$head_sha1" : 'zref: refs/heads/\(.*\)'`
+		head_sha1=`cat "$GIT_DIR/$remote_top/$head_sha1"`
+		;;
+	esac
+
+	# The name under $remote_top the remote HEAD seems to point at.
+	head_points_at=$(
+		(
+			test -f "$GIT_DIR/$remote_top/master" && echo "master"
+			cd "$GIT_DIR/$remote_top" &&
+			find . -type f -print | sed -e 's/^\.\///'
+		) | (
+		done=f
+		while read name
+		do
+			test t = $done && continue
+			branch_tip=`cat "$GIT_DIR/$remote_top/$name"`
+			if test "$head_sha1" = "$branch_tip"
+			then
+				echo "$name"
+				done=t
+			fi
+		done
+		)
+	)
+
+	# Upstream URL
+	git config remote."$origin".url "$repo" &&
+
+	# Set up the mappings to track the remote branches.
+	git config remote."$origin".fetch \
+		"+refs/heads/*:$remote_top/*" '^$' &&
+
+	# Write out remote.$origin config, and update our "$head_points_at".
+	case "$head_points_at" in
+	?*)
+		# Local default branch
+		git symbolic-ref HEAD "refs/heads/$head_points_at" &&
+
+		# Tracking branch for the primary branch at the remote.
+		git update-ref HEAD "$head_sha1" &&
+
+		rm -f "refs/remotes/$origin/HEAD"
+		git symbolic-ref "refs/remotes/$origin/HEAD" \
+			"refs/remotes/$origin/$head_points_at" &&
+
+		git config branch."$head_points_at".remote "$origin" &&
+		git config branch."$head_points_at".merge "refs/heads/$head_points_at"
+		;;
+	'')
+		if test -z "$head_sha1"
+		then
+			# Source had nonexistent ref in HEAD
+			echo >&2 "Warning: Remote HEAD refers to nonexistent ref, unable to checkout."
+			no_checkout=t
+		else
+			# Source had detached HEAD pointing nowhere
+			git update-ref --no-deref HEAD "$head_sha1" &&
+			rm -f "refs/remotes/$origin/HEAD"
+		fi
+		;;
+	esac
+
+	case "$no_checkout" in
+	'')
+		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
+		git read-tree -m -u $v HEAD HEAD
+	esac
+fi
+rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
+
+trap - 0
diff --git a/git-clone.sh b/git-clone.sh
deleted file mode 100755
index 2636159..0000000
--- a/git-clone.sh
+++ /dev/null
@@ -1,522 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005, Linus Torvalds
-# Copyright (c) 2005, Junio C Hamano
-#
-# Clone a repository into a different directory that does not yet exist.
-
-# See git-sh-setup why.
-unset CDPATH
-
-OPTIONS_SPEC="\
-git-clone [options] [--] <repo> [<dir>]
---
-n,no-checkout        don't create a checkout
-bare                 create a bare repository
-naked                create a bare repository
-l,local              to clone from a local repository
-no-hardlinks         don't use local hardlinks, always copy
-s,shared             setup as a shared repository
-template=            path to the template directory
-q,quiet              be quiet
-reference=           reference repository
-o,origin=            use <name> instead of 'origin' to track upstream
-u,upload-pack=       path to git-upload-pack on the remote
-depth=               create a shallow clone of that depth
-
-use-separate-remote  compatibility, do not use
-no-separate-remote   compatibility, do not use"
-
-die() {
-	echo >&2 "$@"
-	exit 1
-}
-
-usage() {
-	exec "$0" -h
-}
-
-eval "$(echo "$OPTIONS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
-
-get_repo_base() {
-	(
-		cd "`/bin/pwd`" &&
-		cd "$1" || cd "$1.git" &&
-		{
-			cd .git
-			pwd
-		}
-	) 2>/dev/null
-}
-
-if [ -n "$GIT_SSL_NO_VERIFY" -o \
-	"`git config --bool http.sslVerify`" = false ]; then
-    curl_extra_args="-k"
-fi
-
-http_fetch () {
-	# $1 = Remote, $2 = Local
-	curl -nsfL $curl_extra_args "$1" >"$2"
-	curl_exit_status=$?
-	case $curl_exit_status in
-	126|127) exit ;;
-	*)	 return $curl_exit_status ;;
-	esac
-}
-
-clone_dumb_http () {
-	# $1 - remote, $2 - local
-	cd "$2" &&
-	clone_tmp="$GIT_DIR/clone-tmp" &&
-	mkdir -p "$clone_tmp" || exit 1
-	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
-		"`git config --bool http.noEPSV`" = true ]; then
-		curl_extra_args="${curl_extra_args} --disable-epsv"
-	fi
-	http_fetch "$1/info/refs" "$clone_tmp/refs" ||
-		die "Cannot get remote repository information.
-Perhaps git-update-server-info needs to be run there?"
-	test "z$quiet" = z && v=-v || v=
-	while read sha1 refname
-	do
-		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
-		case "$name" in
-		*^*)	continue;;
-		esac
-		case "$bare,$name" in
-		yes,* | ,heads/* | ,tags/*) ;;
-		*)	continue ;;
-		esac
-		if test -n "$use_separate_remote" &&
-		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
-		then
-			tname="remotes/$origin/$branch_name"
-		else
-			tname=$name
-		fi
-		git-http-fetch $v -a -w "$tname" "$sha1" "$1" || exit 1
-	done <"$clone_tmp/refs"
-	rm -fr "$clone_tmp"
-	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
-	rm -f "$GIT_DIR/REMOTE_HEAD"
-	if test -f "$GIT_DIR/REMOTE_HEAD"; then
-		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
-		case "$head_sha1" in
-		'ref: refs/'*)
-			;;
-		*)
-			git-http-fetch $v -a "$head_sha1" "$1" ||
-			rm -f "$GIT_DIR/REMOTE_HEAD"
-			;;
-		esac
-	fi
-}
-
-quiet=
-local=no
-use_local_hardlink=yes
-local_shared=no
-unset template
-no_checkout=
-upload_pack=
-bare=
-reference=
-origin=
-origin_override=
-use_separate_remote=t
-depth=
-no_progress=
-local_explicitly_asked_for=
-test -t 1 || no_progress=--no-progress
-
-while test $# != 0
-do
-	case "$1" in
-	-n|--no-checkout)
-		no_checkout=yes ;;
-	--naked|--bare)
-		bare=yes ;;
-	-l|--local)
-		local_explicitly_asked_for=yes
-		use_local_hardlink=yes
-		;;
-	--no-hardlinks)
-		use_local_hardlink=no ;;
-	-s|--shared)
-		local_shared=yes ;;
-	--template)
-		shift; template="--template=$1" ;;
-	-q|--quiet)
-		quiet=-q ;;
-	--use-separate-remote|--no-separate-remote)
-		die "clones are always made with separate-remote layout" ;;
-	--reference)
-		shift; reference="$1" ;;
-	-o|--origin)
-		shift;
-		case "$1" in
-		'')
-		    usage ;;
-		*/*)
-		    die "'$1' is not suitable for an origin name"
-		esac
-		git check-ref-format "heads/$1" ||
-		    die "'$1' is not suitable for a branch name"
-		test -z "$origin_override" ||
-		    die "Do not give more than one --origin options."
-		origin_override=yes
-		origin="$1"
-		;;
-	-u|--upload-pack)
-		shift
-		upload_pack="--upload-pack=$1" ;;
-	--depth)
-		shift
-		depth="--depth=$1" ;;
-	--)
-		shift
-		break ;;
-	*)
-		usage ;;
-	esac
-	shift
-done
-
-repo="$1"
-test -n "$repo" ||
-    die 'you must specify a repository to clone.'
-
-# --bare implies --no-checkout and --no-separate-remote
-if test yes = "$bare"
-then
-	if test yes = "$origin_override"
-	then
-		die '--bare and --origin $origin options are incompatible.'
-	fi
-	no_checkout=yes
-	use_separate_remote=
-fi
-
-if test -z "$origin"
-then
-	origin=origin
-fi
-
-# Turn the source into an absolute path if
-# it is local
-if base=$(get_repo_base "$repo"); then
-	repo="$base"
-	if test -z "$depth"
-	then
-		local=yes
-	fi
-elif test -f "$repo"
-then
-	case "$repo" in /*) ;; *) repo="$PWD/$repo" ;; esac
-fi
-
-# Decide the directory name of the new repository
-if test -n "$2"
-then
-	dir="$2"
-else
-	# Derive one from the repository name
-	# Try using "humanish" part of source repo if user didn't specify one
-	if test -f "$repo"
-	then
-		# Cloning from a bundle
-		dir=$(echo "$repo" | sed -e 's|/*\.bundle$||' -e 's|.*/||g')
-	else
-		dir=$(echo "$repo" |
-			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
-	fi
-fi
-
-[ -e "$dir" ] && die "destination directory '$dir' already exists."
-[ yes = "$bare" ] && unset GIT_WORK_TREE
-[ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&
-die "working tree '$GIT_WORK_TREE' already exists."
-D=
-W=
-cleanup() {
-	err=$?
-	test -z "$D" && rm -rf "$dir"
-	test -z "$W" && test -n "$GIT_WORK_TREE" && rm -rf "$GIT_WORK_TREE"
-	cd ..
-	test -n "$D" && rm -rf "$D"
-	test -n "$W" && rm -rf "$W"
-	exit $err
-}
-trap cleanup 0
-mkdir -p "$dir" && D=$(cd "$dir" && pwd) || usage
-test -n "$GIT_WORK_TREE" && mkdir -p "$GIT_WORK_TREE" &&
-W=$(cd "$GIT_WORK_TREE" && pwd) && GIT_WORK_TREE="$W" && export GIT_WORK_TREE
-if test yes = "$bare" || test -n "$GIT_WORK_TREE"; then
-	GIT_DIR="$D"
-else
-	GIT_DIR="$D/.git"
-fi &&
-export GIT_DIR &&
-GIT_CONFIG="$GIT_DIR/config" git-init $quiet ${template+"$template"} || usage
-
-if test -n "$bare"
-then
-	GIT_CONFIG="$GIT_DIR/config" git config core.bare true
-fi
-
-if test -n "$reference"
-then
-	ref_git=
-	if test -d "$reference"
-	then
-		if test -d "$reference/.git/objects"
-		then
-			ref_git="$reference/.git"
-		elif test -d "$reference/objects"
-		then
-			ref_git="$reference"
-		fi
-	fi
-	if test -n "$ref_git"
-	then
-		ref_git=$(cd "$ref_git" && pwd)
-		echo "$ref_git/objects" >"$GIT_DIR/objects/info/alternates"
-		(
-			GIT_DIR="$ref_git" git for-each-ref \
-				--format='%(objectname) %(*objectname)'
-		) |
-		while read a b
-		do
-			test -z "$a" ||
-			git update-ref "refs/reference-tmp/$a" "$a"
-			test -z "$b" ||
-			git update-ref "refs/reference-tmp/$b" "$b"
-		done
-	else
-		die "reference repository '$reference' is not a local directory."
-	fi
-fi
-
-rm -f "$GIT_DIR/CLONE_HEAD"
-
-# We do local magic only when the user tells us to.
-case "$local" in
-yes)
-	( cd "$repo/objects" ) ||
-		die "cannot chdir to local '$repo/objects'."
-
-	if test "$local_shared" = yes
-	then
-		mkdir -p "$GIT_DIR/objects/info"
-		echo "$repo/objects" >>"$GIT_DIR/objects/info/alternates"
-	else
-		cpio_quiet_flag=""
-		cpio --help 2>&1 | grep -- --quiet >/dev/null && \
-			cpio_quiet_flag=--quiet
-		l= &&
-		if test "$use_local_hardlink" = yes
-		then
-			# See if we can hardlink and drop "l" if not.
-			sample_file=$(cd "$repo" && \
-				      find objects -type f -print | sed -e 1q)
-			# objects directory should not be empty because
-			# we are cloning!
-			test -f "$repo/$sample_file" ||
-				die "fatal: cannot clone empty repository"
-			if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
-			then
-				rm -f "$GIT_DIR/objects/sample"
-				l=l
-			elif test -n "$local_explicitly_asked_for"
-			then
-				echo >&2 "Warning: -l asked but cannot hardlink to $repo"
-			fi
-		fi &&
-		cd "$repo" &&
-		find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
-			exit 1
-	fi
-	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
-	;;
-*)
-	case "$repo" in
-	rsync://*)
-		case "$depth" in
-		"") ;;
-		*) die "shallow over rsync not supported" ;;
-		esac
-		rsync $quiet -av --ignore-existing  \
-			--exclude info "$repo/objects/" "$GIT_DIR/objects/" ||
-		exit
-		# Look at objects/info/alternates for rsync -- http will
-		# support it natively and git native ones will do it on the
-		# remote end.  Not having that file is not a crime.
-		rsync -q "$repo/objects/info/alternates" \
-			"$GIT_DIR/TMP_ALT" 2>/dev/null ||
-			rm -f "$GIT_DIR/TMP_ALT"
-		if test -f "$GIT_DIR/TMP_ALT"
-		then
-		    ( cd "$D" &&
-		      . git-parse-remote &&
-		      resolve_alternates "$repo" <"$GIT_DIR/TMP_ALT" ) |
-		    while read alt
-		    do
-			case "$alt" in 'bad alternate: '*) die "$alt";; esac
-			case "$quiet" in
-			'')	echo >&2 "Getting alternate: $alt" ;;
-			esac
-			rsync $quiet -av --ignore-existing  \
-			    --exclude info "$alt" "$GIT_DIR/objects" || exit
-		    done
-		    rm -f "$GIT_DIR/TMP_ALT"
-		fi
-		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
-		;;
-	https://*|http://*|ftp://*)
-		case "$depth" in
-		"") ;;
-		*) die "shallow over http or ftp not supported" ;;
-		esac
-		if test -z "@@NO_CURL@@"
-		then
-			clone_dumb_http "$repo" "$D"
-		else
-			die "http transport not supported, rebuild Git with curl support"
-		fi
-		;;
-	*)
-		if [ -f "$repo" ] ; then
-			git bundle unbundle "$repo" > "$GIT_DIR/CLONE_HEAD" ||
-			die "unbundle from '$repo' failed."
-		else
-			case "$upload_pack" in
-			'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
-			*) git-fetch-pack --all -k \
-				$quiet "$upload_pack" $depth $no_progress "$repo" ;;
-			esac >"$GIT_DIR/CLONE_HEAD" ||
-			die "fetch-pack from '$repo' failed."
-		fi
-		;;
-	esac
-	;;
-esac
-test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GIT_DIR/refs/reference-tmp"
-
-if test -f "$GIT_DIR/CLONE_HEAD"
-then
-	# Read git-fetch-pack -k output and store the remote branches.
-	if [ -n "$use_separate_remote" ]
-	then
-		branch_top="remotes/$origin"
-	else
-		branch_top="heads"
-	fi
-	tag_top="tags"
-	while read sha1 name
-	do
-		case "$name" in
-		*'^{}')
-			continue ;;
-		HEAD)
-			destname="REMOTE_HEAD" ;;
-		refs/heads/*)
-			destname="refs/$branch_top/${name#refs/heads/}" ;;
-		refs/tags/*)
-			destname="refs/$tag_top/${name#refs/tags/}" ;;
-		*)
-			continue ;;
-		esac
-		git update-ref -m "clone: from $repo" "$destname" "$sha1" ""
-	done < "$GIT_DIR/CLONE_HEAD"
-fi
-
-if test -n "$W"; then
-	cd "$W" || exit
-else
-	cd "$D" || exit
-fi
-
-if test -z "$bare"
-then
-	# a non-bare repository is always in separate-remote layout
-	remote_top="refs/remotes/$origin"
-	head_sha1=
-	test ! -r "$GIT_DIR/REMOTE_HEAD" || head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
-	case "$head_sha1" in
-	'ref: refs/'*)
-		# Uh-oh, the remote told us (http transport done against
-		# new style repository with a symref HEAD).
-		# Ideally we should skip the guesswork but for now
-		# opt for minimum change.
-		head_sha1=`expr "z$head_sha1" : 'zref: refs/heads/\(.*\)'`
-		head_sha1=`cat "$GIT_DIR/$remote_top/$head_sha1"`
-		;;
-	esac
-
-	# The name under $remote_top the remote HEAD seems to point at.
-	head_points_at=$(
-		(
-			test -f "$GIT_DIR/$remote_top/master" && echo "master"
-			cd "$GIT_DIR/$remote_top" &&
-			find . -type f -print | sed -e 's/^\.\///'
-		) | (
-		done=f
-		while read name
-		do
-			test t = $done && continue
-			branch_tip=`cat "$GIT_DIR/$remote_top/$name"`
-			if test "$head_sha1" = "$branch_tip"
-			then
-				echo "$name"
-				done=t
-			fi
-		done
-		)
-	)
-
-	# Upstream URL
-	git config remote."$origin".url "$repo" &&
-
-	# Set up the mappings to track the remote branches.
-	git config remote."$origin".fetch \
-		"+refs/heads/*:$remote_top/*" '^$' &&
-
-	# Write out remote.$origin config, and update our "$head_points_at".
-	case "$head_points_at" in
-	?*)
-		# Local default branch
-		git symbolic-ref HEAD "refs/heads/$head_points_at" &&
-
-		# Tracking branch for the primary branch at the remote.
-		git update-ref HEAD "$head_sha1" &&
-
-		rm -f "refs/remotes/$origin/HEAD"
-		git symbolic-ref "refs/remotes/$origin/HEAD" \
-			"refs/remotes/$origin/$head_points_at" &&
-
-		git config branch."$head_points_at".remote "$origin" &&
-		git config branch."$head_points_at".merge "refs/heads/$head_points_at"
-		;;
-	'')
-		if test -z "$head_sha1"
-		then
-			# Source had nonexistent ref in HEAD
-			echo >&2 "Warning: Remote HEAD refers to nonexistent ref, unable to checkout."
-			no_checkout=t
-		else
-			# Source had detached HEAD pointing nowhere
-			git update-ref --no-deref HEAD "$head_sha1" &&
-			rm -f "refs/remotes/$origin/HEAD"
-		fi
-		;;
-	esac
-
-	case "$no_checkout" in
-	'')
-		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
-		git read-tree -m -u $v HEAD HEAD
-	esac
-fi
-rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
-
-trap - 0
diff --git a/git.c b/git.c
index c4e4644..4e7845a 100644
--- a/git.c
+++ b/git.c
@@ -286,6 +286,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-- 
1.5.4.3.610.gea6cd
--1547844168-365792352-1208475129=:19665--
