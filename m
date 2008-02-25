From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Build in clone
Date: Mon, 25 Feb 2008 16:12:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1321927415-1203973849=:19024"
Cc: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTkdW-0008Ot-6H
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYBYVMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbYBYVMp
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:12:45 -0500
Received: from iabervon.org ([66.92.72.58]:51737 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbYBYVMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:12:43 -0500
Received: (qmail 13495 invoked by uid 1000); 25 Feb 2008 21:12:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 21:12:40 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0802251611000.19024@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75070>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1321927415-1203973849=:19024
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0802251611001.19024@iabervon.org>

This version is still a mess, but it passes all of the tests. I'm
somewhat unconvinced by the test ccoverage for clone, however; the
last failure I found was actually for which heads get created in a
bare repository, and it was only failing when there was an extra one
in a non-bare clone in a test for something entirely different.

This is largely based on Kristian Høgsberg's version from December, but 
the introduced warnings and two whitespace errors I haven't located are 
mine.

I'm still working on getting it cleaned up, but I thought it would be good 
to get it some exposure and testing, since people have been talking about 
builtin-clone today.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                                      |    2 +-
 builtin-clone.c                               |  598 +++++++++++++++++++++++++
 builtin-init-db.c                             |  163 ++++---
 builtin.h                                     |    1 +
 cache.h                                       |    5 +
 git-clone.sh => contrib/examples/git-clone.sh |    0 
 environment.c                                 |    6 +
 git.c                                         |    1 +
 8 files changed, 704 insertions(+), 72 deletions(-)
 create mode 100644 builtin-clone.c
 rename git-clone.sh => contrib/examples/git-clone.sh (100%)

diff --git a/Makefile b/Makefile
index 149343c..c56d9da 100644
--- a/Makefile
+++ b/Makefile
@@ -227,7 +227,6 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH = \
 	git-bisect.sh \
-	git-clone.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh \
@@ -344,6 +343,7 @@ BUILTIN_OBJS = \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
 	builtin-clean.o \
+	builtin-clone.o \
 	builtin-commit.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
diff --git a/builtin-clone.c b/builtin-clone.c
new file mode 100644
index 0000000..da278f9
--- /dev/null
+++ b/builtin-clone.c
@@ -0,0 +1,598 @@
+/*
+ * Builtin "git clone"
+ *
+ * Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
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
+ *  - error path cleanup of dirs+files.
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
+static void
+write_alternates_file(const char *repo, const char *reference)
+{
+	char *file;
+	char *alternates;
+	int fd;
+
+	file = mkpath("%s/objects/info/alternates", repo);
+	fd = open(file, O_CREAT | O_WRONLY | O_APPEND, 0666);
+	if (fd < 0)
+		die("failed to create %s", file);
+	alternates = mkpath("%s/objects\n", reference);
+	write_or_die(fd, alternates, strlen(alternates));
+	if (close(fd))
+		die("could not close %s", file);
+	fprintf(stderr, "Wrote %s to %s\n", alternates, file);
+}
+
+static int
+setup_tmp_ref(const char *refname,
+	      const unsigned char *sha1, int flags, void *cb_data)
+{
+	const char *ref_temp = cb_data;
+	char *path;
+	struct lock_file lk;
+	struct ref_lock *rl;
+
+	/*
+
+	echo "$ref_git/objects" >"$GIT_DIR/objects/info/alternates"
+	(
+		GIT_DIR="$ref_git" git for-each-ref \
+			--format='%(objectname) %(*objectname)'
+	) |
+	while read a b
+	do
+		test -z "$a" ||
+		git update-ref "refs/reference-tmp/$a" "$a"
+		test -z "$b" ||
+		git update-ref "refs/reference-tmp/$b" "$b"
+	done
+
+	*/
+
+	/* We go a bit out of way to use write_ref_sha1() here.  We
+	 * could just write the ref file directly, since neither
+	 * locking or reflog really matters here.  However, let's use
+	 * the standard interface for writing refs as much as is
+	 * possible given that get_git_dir() != the repo we're writing
+	 * the refs in. */
+
+	printf("%s -> %s/%s\n",
+	       sha1_to_hex(sha1), ref_temp, sha1_to_hex(sha1));
+
+	path = mkpath("%s/%s", ref_temp, sha1_to_hex(sha1));
+	rl = xmalloc(sizeof *rl);
+	rl->force_write = 1;
+	rl->lk = &lk;
+	rl->ref_name = xstrdup(sha1_to_hex(sha1));
+	rl->orig_ref_name = xstrdup(rl->ref_name);
+	rl->lock_fd = hold_lock_file_for_update(rl->lk, path, 1);
+	if (write_ref_sha1(rl, sha1, NULL) < 0)
+		die("failed to write temporary ref %s", lk.filename);
+
+	return 0;
+}
+
+static char *
+setup_reference(const char *repo)
+{
+	struct stat buf;
+	const char *ref_git;
+	char *ref_temp;
+
+	if (!option_reference)
+		return NULL;
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
+	set_git_dir(ref_git);
+
+	write_alternates_file(repo, ref_git);
+
+	ref_temp = xstrdup(mkpath("%s/refs/reference-tmp", repo));
+	if (mkdir(ref_temp, 0777))
+		die("could not create directory %s", ref_temp);
+	for_each_ref(setup_tmp_ref, (void *) ref_temp);
+
+	return ref_temp;
+}
+
+static void
+cleanup_reference(char *ref_temp)
+{
+	struct dirent *de;
+	DIR *dir;
+
+	if (!ref_temp)
+		return;
+	dir = opendir(ref_temp);
+	if (!dir) {
+		if (errno == ENOENT)
+			return;
+		die("failed to open directory %s", ref_temp);
+	}
+
+	while ((de = readdir(dir)) != NULL) {
+		if (de->d_name[0] == '.')
+			continue;
+		unlink(mkpath("%s/%s", ref_temp, de->d_name));
+	}
+
+	unlink(ref_temp);
+	free(ref_temp);
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
+		write_alternates_file(dest_repo, src_repo);
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
+int cmd_clone(int argc, const char **argv, const char *prefix)
+{
+	int use_local_hardlinks = 1;
+	int use_separate_remote = 1;
+	struct stat buf;
+	const char *repo, *work_tree, *git_dir;
+	char *path, *dir, *head, *ref_temp;
+	struct ref *refs, *r, *remote_head, *head_points_at, *remote_master;
+	char branch_top[256], key[256], refname[256], value[256];
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
+	repo = argv[0];
+	path = get_repo_path(repo);
+
+	if (argc == 2) {
+		dir = xstrdup(argv[1]);
+	} else {
+		dir = guess_dir_name(repo);
+	}
+
+	if (!stat(dir, &buf))
+		die("destination directory '%s' already exists.", dir);
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
+		if (mkdir(work_tree, 0755))
+			die("could not create work tree dir '%s'.", work_tree);
+		set_git_work_tree(work_tree);
+		junk_work_tree = work_tree;
+	}
+
+	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
+
+	//set_git_dir(make_absolute_path(git_dir));
+
+	fprintf(stderr, "Initialize %s\n", git_dir);
+	init_db(git_dir, option_template, work_tree,
+		option_quiet ? INIT_DB_QUIET : 0);
+	junk_git_dir = git_dir;
+	fprintf(stderr, "Okay\n");
+
+	/* This calls set_git_dir for the reference repo so we can get
+	 * the refs there.  Thus, call this before calling
+	 * set_git_dir() on the repo we're setting up. */
+	ref_temp = setup_reference(git_dir);
+
+	set_git_dir(make_absolute_path(git_dir));
+
+	if (option_bare)
+		git_config_set("core.bare", "true");
+
+	if (path != NULL) {
+		refs = clone_local(path, git_dir);
+		repo = make_absolute_path(path);
+	} else {
+		struct remote *remote = remote_get(argv[0]);
+		struct transport *transport = transport_get(remote, argv[0]);
+		const struct ref *show;
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
+	cleanup_reference(ref_temp);
+
+	if (option_bare)
+		strcpy(branch_top, "refs/heads");
+	else
+		snprintf(branch_top, sizeof branch_top,
+			 "refs/remotes/%s", option_origin);
+
+	printf("%p\n", refs);
+	remote_head = NULL;
+	remote_master = NULL;
+	for (r = refs; r; r = r->next) {
+		fprintf(stderr, "%s\n",	r->name);
+		if (strlen(r->name) >= 3 &&
+		    !strcmp(r->name + strlen(r->name) - 3, "^{}"))
+			continue;
+		if (!strcmp(r->name, "HEAD")) {
+			remote_head = r;
+			if (option_bare)
+				continue;
+			snprintf(refname, sizeof refname,
+				 "%s/HEAD", branch_top);
+		} else {
+			if (!strcmp(r->name, "refs/heads/master"))
+				remote_master = r;
+
+			if (!prefixcmp(r->name, "refs/heads/"))
+				snprintf(refname, sizeof refname,
+					 "%s/%s", branch_top, r->name + 11);
+			else if (!prefixcmp(r->name, "refs/tags/"))
+				snprintf(refname, sizeof refname,
+					 "refs/tags/%s", r->name + 10);
+			else
+				continue;
+		}
+
+		update_ref("clone from $repo",
+			   refname, r->old_sha1, NULL, 0, DIE_ON_ERR);
+	}
+
+	head_points_at = NULL;
+	if (!remote_head) {
+		/* If there isn't one, oh well. */
+	} else if (remote_master && !hashcmp(remote_master->old_sha1,
+				      remote_head->old_sha1)) {
+		/* If refs/heads/master could be right, it is. */
+		head_points_at = remote_master;
+	} else
+		for (r = refs; r; r = r->next) {
+			if (r != remote_head &&
+			    !hashcmp(r->old_sha1, remote_head->old_sha1)) {
+				head_points_at = r;
+				printf("head points at %s\n", r->name);
+				break;
+			}
+		}
+
+	/* FIXME: What about the "Uh-oh, the remote told us..." case? */
+	if (!option_bare) {
+		snprintf(key, sizeof key, "remote.%s.url", option_origin);
+		git_config_set(key, repo);
+		snprintf(key, sizeof key, "remote.%s.fetch", option_origin);
+		snprintf(value, sizeof value, "+refs/heads/*:%s/*", branch_top);
+
+		git_config_set_multivar(key, value, "^$", 0);
+	}
+
+	if (option_bare) {
+		if (head_points_at) {
+			/* Local default branch */
+			create_symref("HEAD", head_points_at->name, NULL);
+		}
+		junk_work_tree = NULL;
+		junk_git_dir = NULL;
+		return 0;
+	}
+
+	if (head_points_at) {
+		if (strrchr(head_points_at->name, '/'))
+			head = strrchr(head_points_at->name, '/') + 1;
+		else
+			head = head_points_at->name;
+
+		/* Local default branch */
+		create_symref("HEAD", head_points_at->name, NULL);
+
+		/* Tracking branch for the primary branch at the remote. */
+		update_ref(NULL, "HEAD", head_points_at->old_sha1,
+			   NULL, 0, DIE_ON_ERR);
+	/*
+		rm -f "refs/remotes/$origin/HEAD"
+		git symbolic-ref "refs/remotes/$origin/HEAD" \
+			"refs/remotes/$origin/$head_points_at" &&
+	*/
+
+		snprintf(key, sizeof key, "branch.%s.remote", head);
+		git_config_set(key, option_origin);
+		snprintf(key, sizeof key, "branch.%s.merge", head);
+		git_config_set(key, head_points_at->name);
+	} else if (remote_head) {
+		/* Source had detached HEAD pointing somewhere. */
+		update_ref("clone from $repo", "HEAD", remote_head->old_sha1,
+			   NULL, REF_NODEREF, DIE_ON_ERR);
+	} else {
+		/* Nothing to checkout out */
+		if (!option_no_checkout)
+			fprintf(stderr, "Warning: Remote HEAD refers to nonexistent ref, unable to checkout.\n");
+		option_no_checkout = 1;
+	}
+
+	if (!option_no_checkout) {
+		struct lock_file lock_file;
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
+		fd = hold_locked_index(&lock_file, 1);
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
+		    commit_locked_index(&lock_file))
+			die("unable to write new index file");
+	}
+	
+	junk_work_tree = NULL;
+	junk_git_dir = NULL;
+	return 0;
+}
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 79eaf8d..bc74188 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -21,6 +21,7 @@ static void safe_create_dir(const char *dir, int share)
 {
 	if (mkdir(dir, 0777) < 0) {
 		if (errno != EEXIST) {
+			fprintf(stderr, "When creating GIT_DIR\n");
 			perror(dir);
 			exit(1);
 		}
@@ -176,6 +177,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
 	memcpy(path, git_dir, len);
+	git_dir = make_absolute_path(git_dir);
 
 	if (len && path[len-1] != '/')
 		path[len++] = '/';
@@ -250,8 +252,12 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
-		if (work_tree != git_work_tree_cfg)
+		if (prefixcmp(git_dir, work_tree) ||
+		    strcmp(git_dir + strlen(work_tree), "/.git")) {
+			fprintf(stderr, "Is %s; would be %s\n", work_tree,
+				git_dir);
 			git_config_set("core.worktree", work_tree);
+		}
 	}
 
 	/* Check if symlink is supported in the work tree */
@@ -271,42 +277,93 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	return reinit;
 }
 
-static void guess_repository_type(const char *git_dir)
+static int guess_repository_type(const char *git_dir)
 {
 	char cwd[PATH_MAX];
 	const char *slash;
 
-	if (0 <= is_bare_repository_cfg)
-		return;
-	if (!git_dir)
-		return;
-
 	/*
 	 * "GIT_DIR=. git init" is always bare.
 	 * "GIT_DIR=`pwd` git init" too.
 	 */
 	if (!strcmp(".", git_dir))
-		goto force_bare;
+		return 1;
 	if (!getcwd(cwd, sizeof(cwd)))
 		die("cannot tell cwd");
 	if (!strcmp(git_dir, cwd))
-		goto force_bare;
+		return 1;
 	/*
 	 * "GIT_DIR=.git or GIT_DIR=something/.git is usually not.
 	 */
 	if (!strcmp(git_dir, ".git"))
-		return;
+		return 0;
 	slash = strrchr(git_dir, '/');
 	if (slash && !strcmp(slash, "/.git"))
-		return;
+		return 0;
 
 	/*
 	 * Otherwise it is often bare.  At this point
 	 * we are just guessing.
 	 */
- force_bare:
-	is_bare_repository_cfg = 1;
-	return;
+	return 1;
+}
+
+int init_db(const char *git_dir, const char *template_dir, const char *work_dir,
+	    unsigned int flags)
+{
+	const char *sha1_dir;
+	char *path;
+	int len, reinit;
+
+	safe_create_dir(git_dir, 0);
+
+	set_git_dir(make_absolute_path(git_dir));
+
+	/* Check to see if the repository version is right.
+	 * Note that a newly created repository does not have
+	 * config file, so this will not fail.  What we are catching
+	 * is an attempt to reinitialize new repository with an old tool.
+	 */
+	check_repository_format();
+
+	reinit = create_default_files(git_dir, template_dir);
+
+	/*
+	 * And set up the object store.  Don't use
+	 * get_object_directory() here, since we're initializing
+	 * relative to git_dir, not $GIT_DIR.
+	 */
+	sha1_dir = getenv(DB_ENVIRONMENT);
+	if (!sha1_dir)
+		sha1_dir = mkpath("%s/objects", git_dir);
+	len = strlen(sha1_dir);
+	path = xmalloc(len + 40);
+	memcpy(path, sha1_dir, len);
+
+	safe_create_dir(sha1_dir, 1);
+	strcpy(path+len, "/pack");
+	safe_create_dir(path, 1);
+	strcpy(path+len, "/info");
+	safe_create_dir(path, 1);
+
+	if (shared_repository) {
+		char buf[10];
+		/* We do not spell "group" and such, so that
+		 * the configuration can be read by older version
+		 * of git.
+		 */
+		sprintf(buf, "%d", shared_repository);
+		git_config_set("core.sharedrepository", buf);
+		git_config_set("receive.denyNonFastforwards", "true");
+	}
+
+	if (!(flags & INIT_DB_QUIET))
+		printf("%s%s Git repository in %s/\n",
+		       reinit ? "Reinitialized existing" : "Initialized empty",
+		       shared_repository ? " shared" : "",
+		       git_dir);
+
+	return 0;
 }
 
 static const char init_db_usage[] =
@@ -320,12 +377,10 @@ static const char init_db_usage[] =
  */
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
-	const char *git_dir;
-	const char *sha1_dir;
+	const char *git_dir, *work_tree;
 	const char *template_dir = NULL;
-	char *path;
-	int len, i, reinit;
-	int quiet = 0;
+	unsigned int flags = 0;
+	int i;
 
 	for (i = 1; i < argc; i++, argv++) {
 		const char *arg = argv[1];
@@ -336,7 +391,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		else if (!prefixcmp(arg, "--shared="))
 			shared_repository = git_config_perm("arg", arg+9);
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
-		        quiet = 1;
+			flags |= INIT_DB_QUIET;
 		else
 			usage(init_db_usage);
 	}
@@ -353,64 +408,30 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		    GIT_WORK_TREE_ENVIRONMENT,
 		    GIT_DIR_ENVIRONMENT);
 
-	guess_repository_type(git_dir);
-
-	if (is_bare_repository_cfg <= 0) {
-		git_work_tree_cfg = xcalloc(PATH_MAX, 1);
-		if (!getcwd(git_work_tree_cfg, PATH_MAX))
-			die ("Cannot access current working directory.");
-		if (access(get_git_work_tree(), X_OK))
-			die ("Cannot access work tree '%s'",
-			     get_git_work_tree());
-	}
-
 	/*
 	 * Set up the default .git directory contents
 	 */
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
-	safe_create_dir(git_dir, 0);
-
-	/* Check to see if the repository version is right.
-	 * Note that a newly created repository does not have
-	 * config file, so this will not fail.  What we are catching
-	 * is an attempt to reinitialize new repository with an old tool.
-	 */
-	check_repository_format();
-
-	reinit = create_default_files(git_dir, template_dir);
-
-	/*
-	 * And set up the object store.
-	 */
-	sha1_dir = get_object_directory();
-	len = strlen(sha1_dir);
-	path = xmalloc(len + 40);
-	memcpy(path, sha1_dir, len);
 
-	safe_create_dir(sha1_dir, 1);
-	strcpy(path+len, "/pack");
-	safe_create_dir(path, 1);
-	strcpy(path+len, "/info");
-	safe_create_dir(path, 1);
+	if (is_bare_repository_cfg < 0)
+		is_bare_repository_cfg = guess_repository_type(git_dir);
 
-	if (shared_repository) {
-		char buf[10];
-		/* We do not spell "group" and such, so that
-		 * the configuration can be read by older version
-		 * of git.
-		 */
-		sprintf(buf, "%d", shared_repository);
-		git_config_set("core.sharedrepository", buf);
-		git_config_set("receive.denyNonFastforwards", "true");
+	if (!is_bare_repository_cfg) {
+		if (git_dir) {
+			const char *git_dir_parent = strrchr(git_dir, '/');
+			if (git_dir_parent)
+				git_work_tree_cfg = strdup(make_absolute_path(xstrndup(git_dir, git_dir_parent - git_dir)));
+		}
+		if (!git_work_tree_cfg) {
+			git_work_tree_cfg = xcalloc(PATH_MAX, 1);
+			if (!getcwd(git_work_tree_cfg, PATH_MAX))
+				die ("Cannot access current working directory.");
+		}
+		if (access(get_git_work_tree(), X_OK))
+			die ("Cannot access work tree '%s'",
+			     get_git_work_tree());
 	}
 
-	if (!quiet)
-		printf("%s%s Git repository in %s/\n",
-		       reinit ? "Reinitialized existing" : "Initialized empty",
-		       shared_repository ? " shared" : "",
-		       git_dir);
-
-	return 0;
+	return init_db(git_dir, template_dir, git_work_tree_cfg, flags);
 }
diff --git a/builtin.h b/builtin.h
index 674c8a1..4a382b5 100644
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
diff --git a/cache.h b/cache.h
index 660ea04..6d806c4 100644
--- a/cache.h
+++ b/cache.h
@@ -322,6 +322,11 @@ extern const char *prefix_filename(const char *prefix, int len, const char *path
 extern void verify_filename(const char *prefix, const char *name);
 extern void verify_non_filename(const char *prefix, const char *name);
 
+#define INIT_DB_QUIET 0x0001
+
+extern int init_db(const char *git_dir, const char *template_dir,
+		   const char *work_dir, unsigned int flags);
+
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /*
diff --git a/git-clone.sh b/contrib/examples/git-clone.sh
similarity index 100%
rename from git-clone.sh
rename to contrib/examples/git-clone.sh
diff --git a/environment.c b/environment.c
index 6739a3f..d6c6a6b 100644
--- a/environment.c
+++ b/environment.c
@@ -81,6 +81,12 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
+void set_git_work_tree(const char *new_work_tree)
+{
+	get_git_work_tree(); /* make sure it's initialized */
+	work_tree = xstrdup(make_absolute_path(new_work_tree));
+}
+
 const char *get_git_work_tree(void)
 {
 	static int initialized = 0;
diff --git a/git.c b/git.c
index 9cca81a..f32883a 100644
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
-- 
1.5.4.2.261.g851a5.dirty
--1547844168-1321927415-1203973849=:19024--
