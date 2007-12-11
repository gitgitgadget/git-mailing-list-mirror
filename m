From: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
Subject: [PATCH] builtin-clone: Implement git clone as a builtin command.
Date: Tue, 11 Dec 2007 14:57:12 -0500
Message-ID: <20071211195712.GA3865@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gister@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 11 20:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Aly-0005CI-EC
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbXLKT1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 14:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbXLKT1R
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:27:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52808 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbXLKT1P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:27:15 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBBJFAOv024364;
	Tue, 11 Dec 2007 14:15:10 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBBJFAh7011830;
	Tue, 11 Dec 2007 14:15:10 -0500
Received: from localhost (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lBBJFAbJ031855;
	Tue, 11 Dec 2007 14:15:10 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67915>

Still work-in-progress, local clones and --reference not fully function=
al.
---

Ok, don't flame me, I know this isn't appropriate at the moment with
stabilization for 1.5.4 going on, but I just wanted to post a heads up
on this work to avoid duplicate effort.  It's one big patch at this poi=
nt
and I haven't even run the test suite yet, but that will change.

cheers,
Kristian

 Makefile                                      |    2 +-
 builtin-clone.c                               |  504 +++++++++++++++++=
++++++++
 builtin-init-db.c                             |  119 +++----
 builtin-rerere.c                              |   19 +-
 builtin.h                                     |    1 +
 cache.h                                       |    5 +
 git-clone.sh =3D> contrib/examples/git-clone.sh |    0=20
 copy.c                                        |   21 +
 diff.c                                        |    8 +-
 git.c                                         |    1 +
 unpack-trees.c                                |    3 +-
 unpack-trees.h                                |    1 +
 12 files changed, 595 insertions(+), 89 deletions(-)
 create mode 100644 builtin-clone.c
 rename git-clone.sh =3D> contrib/examples/git-clone.sh (100%)

diff --git a/Makefile b/Makefile
index cb1cbb1..ca42ed1 100644
--- a/Makefile
+++ b/Makefile
@@ -213,7 +213,6 @@ BASIC_LDFLAGS =3D
=20
 SCRIPT_SH =3D \
 	git-bisect.sh git-checkout.sh \
-	git-clone.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh \
@@ -327,6 +326,7 @@ BUILTIN_OBJS =3D \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
 	builtin-clean.o \
+	builtin-clone.o \
 	builtin-commit.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
diff --git a/builtin-clone.c b/builtin-clone.c
new file mode 100644
index 0000000..acd7beb
--- /dev/null
+++ b/builtin-clone.c
@@ -0,0 +1,504 @@
+/*
+ * Builtin "git clone"
+ *
+ * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
+ *
+ * Clone a repository into a different directory that does not yet exi=
st.
+ */
+
+#include "cache.h"
+#include "parse-options.h"
+#include "fetch-pack.h"
+#include "refs.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+
+/*
+ * Overall FIXMEs:
+ *  - respect DB_ENVIRONMENT for .git/objects.
+ *  - error path cleanup of dirs+files.
+ *
+ * Implementation notes:
+ *  - dropping use-separate-remote and no-separate-remote compatibilit=
y
+ *
+ */
+static const char * const builtin_clone_usage[] =3D {
+	"git-clone [options] [--] <repo> [<dir>]",
+	NULL
+};
+
+static int option_quiet, option_no_checkout, option_bare;
+static int option_local, option_no_hardlinks, option_shared, option_de=
pth;
+static char *option_template, *option_reference;
+static char *option_origin =3D "origin";
+static char *option_upload_pack =3D "git-upload-pack";
+
+static struct option builtin_clone_options[] =3D {
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
+	OPT_INTEGER(0, "depth", &option_depth,
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
+	path =3D mkpath("%s/.git", repo);
+	if (!stat(path, &buf) && S_ISDIR(buf.st_mode))
+		return xstrdup(make_absolute_path(path));
+
+	path =3D mkpath("%s.git", repo);
+	if (!stat(path, &buf) && S_ISDIR(buf.st_mode))
+		return xstrdup(make_absolute_path(path));
+
+	if (!stat(repo, &buf) && S_ISDIR(buf.st_mode))
+		return xstrdup(make_absolute_path(repo));
+=09
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
+	after_slash_or_colon =3D 1;
+	limit =3D repo + strlen(repo);
+	start =3D repo;
+	end =3D limit;
+	for (p =3D repo; p < limit; p++) {
+		if (!prefixcmp(p, ".git")) {
+			if (!after_slash_or_colon)
+				end =3D p;
+			p +=3D 3;
+		} else if (*p =3D=3D '/' || *p =3D=3D ':') {
+			if (end =3D=3D limit)
+				end =3D p;=20
+			after_slash_or_colon =3D 1;
+		} else if (after_slash_or_colon) {
+			start =3D p;
+			end =3D limit;
+			after_slash_or_colon =3D 0;
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
+	file =3D mkpath("%s/objects/info/alternates", repo);
+	fd =3D open(file, O_CREAT | O_WRONLY, 0666);
+	if (fd < 0)
+		die("failed to create %s", file);
+	alternates =3D mkpath("%s/objects\n", reference);
+	write_or_die(fd, alternates, strlen(alternates));
+	if (close(fd))
+		die("could not close %s", file);
+}
+
+static int
+setup_tmp_ref(const char *refname,
+	      const unsigned char *sha1, int flags, void *cb_data)
+{
+	const char *ref_temp =3D cb_data;
+	char *path;
+	struct lock_file lk;
+	struct ref_lock *rl;
+
+	/*
+
+	echo "$ref_git/objects" >"$GIT_DIR/objects/info/alternates"
+	(
+		GIT_DIR=3D"$ref_git" git for-each-ref \
+			--format=3D'%(objectname) %(*objectname)'
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
+	 * possible given that get_git_dir() !=3D the repo we're writing
+	 * the refs in. */
+
+	printf("%s -> %s/%s\n",
+	       sha1_to_hex(sha1), ref_temp, sha1_to_hex(sha1));
+
+	path =3D mkpath("%s/%s", ref_temp, sha1_to_hex(sha1));
+	rl =3D xmalloc(sizeof *rl);
+	rl->force_write =3D 1;
+	rl->lk =3D &lk;
+	rl->ref_name =3D xstrdup(sha1_to_hex(sha1));
+	rl->orig_ref_name =3D xstrdup(rl->ref_name);
+	rl->lock_fd =3D hold_lock_file_for_update(rl->lk, path, 1);
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
+	ref_git =3D make_absolute_path(option_reference);
+
+	if (!stat(mkpath("%s/.git/objects", ref_git), &buf) &&
+	    S_ISDIR(buf.st_mode))
+		ref_git =3D mkpath("%s/.git", ref_git);
+	else if (stat(mkpath("%s/objects", ref_git), &buf) ||
+		 !S_ISDIR(buf.st_mode))
+		die("reference repository '%s' is not a local directory.",
+		    option_reference);
+
+	set_git_dir(ref_git);
+
+	write_alternates_file(repo, ref_git);
+
+	ref_temp =3D xstrdup(mkpath("%s/refs/reference-tmp", repo));
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
+	dir =3D opendir(ref_temp);
+	if (!dir) {
+		if (errno =3D=3D ENOENT)
+			return;
+		die("failed to open directory %s", ref_temp);
+	}
+	=09
+	while ((de =3D readdir(dir)) !=3D NULL) {
+		if (de->d_name[0] =3D=3D '.')
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
+	dir =3D opendir(src);
+	if (!dir)
+		die("failed to open %s\n", src);
+
+	if (mkdir(dest, 0777)) {
+		if (errno !=3D EEXIST)
+			die("failed to create directory %s\n", dest);
+		else if (stat(dest, &buf))
+			die("failed to stat %s\n", dest);
+		else if (!S_ISDIR(buf.st_mode))
+			die("%s exists and is not a directory\n", dest);
+	}
+
+	src_len =3D strlen(src);
+	src[src_len] =3D '/';
+	dest_len =3D strlen(dest);
+	dest[dest_len] =3D '/';
+
+	while ((de =3D readdir(dir)) !=3D NULL) {
+		strcpy(src + src_len + 1, de->d_name);
+		strcpy(dest + dest_len + 1, de->d_name);
+		if (stat(src, &buf)) {
+			fprintf(stderr, "failed to stat %s, ignoring\n", src);
+			continue;
+		}
+		if (S_ISDIR(buf.st_mode)) {
+			if (de->d_name[0] !=3D '.')
+				walk_objects(src, dest);
+			continue;
+		}
+
+		if (unlink(dest) && errno !=3D ENOENT)
+			die("failed to unlink %s\n", dest);
+		if (option_no_hardlinks) {
+			if (copy_file(dest, src, 0666))
+				die("failed to copy file to %s\n", dest);
+		} else {
+			if (link(src, dest))
+				die("failed to create link %s\n", dest);
+		}
+	}
+}	=09
+
+static struct ref *
+clone_local(const char *src_repo, const char *dest_repo)
+{
+	char src[PATH_MAX];
+	char dest[PATH_MAX];
+
+	if (option_shared) {
+		write_alternates_file(dest_repo, src_repo);
+	} else {
+		snprintf(src, PATH_MAX, "%s/objects", src_repo);
+		snprintf(dest, PATH_MAX, "%s/objects", dest_repo);
+		walk_objects(src, dest);
+	}
+
+	/* FIXME: Return list of refs for src repo. */
+
+	return NULL;
+}
+
+int cmd_clone(int argc, const char **argv, const char *prefix)
+{
+	int use_local_hardlinks =3D 1;
+	int use_separate_remote =3D 1;
+	struct stat buf;
+	const char *repo, *work_tree, *git_dir;
+	char *path, *dir, *head, *ref_temp;
+	struct ref *refs, *r, *remote_head, *head_points_at;
+	char branch_top[256], key[256], refname[256], value[256];
+
+	argc =3D parse_options(argc, argv, builtin_clone_options,
+			     builtin_clone_usage, 0);
+
+	if (argc =3D=3D 0)
+		die("You must specify a repository to clone.");
+
+	if (option_no_hardlinks)
+		use_local_hardlinks =3D 0;
+
+	if (option_bare) {
+		if (option_origin)
+			die("--bare and --origin %s options are incompatible.",
+			    option_origin);
+		option_no_checkout =3D 1;
+		use_separate_remote =3D 0;
+	}
+
+	repo =3D argv[0];
+	path =3D get_repo_path(repo);
+
+	if (argc =3D=3D 2) {
+		dir =3D xstrdup(argv[1]);
+	} else {
+		dir =3D guess_dir_name(repo);
+	}
+
+	if (!stat(dir, &buf))
+		die("destination directory '%s' already exists.", dir);
+
+	if (option_bare)
+		work_tree =3D NULL;
+	else {
+		work_tree =3D getenv("GIT_WORK_TREE");
+		if (work_tree && !stat(work_tree, &buf))
+			die("working tree '%s' already exists.", work_tree);
+	}
+
+	if (mkdir(dir, 0755))
+		die("could not create repository dir '%s'.", dir);
+	if (work_tree && mkdir(work_tree, 0755))
+		die("could not create work tree dir '%s'.", work_tree);
+
+	if (option_bare || work_tree)
+		git_dir =3D xstrdup(dir);=20
+	else
+		git_dir =3D xstrdup(mkpath("%s/.git", dir));
+
+	init_db(git_dir, option_template, option_quiet ? INIT_DB_QUIET : 0);
+
+	/* This calls set_git_dir for the reference repo so we can get
+	 * the refs there.  Thus, call this before calling
+	 * set_git_dir() on the repo we're setting up. */
+	ref_temp =3D setup_reference(git_dir);
+
+	set_git_dir(make_absolute_path(git_dir));
+
+	if (option_bare)
+		git_config_set("core.bare", "true");
+
+	if (path !=3D NULL) {
+		refs =3D clone_local(path, git_dir);
+	} else {
+		struct fetch_pack_args args;
+
+		args.uploadpack =3D option_upload_pack;
+		args.quiet =3D option_quiet;
+		args.fetch_all =3D 1;
+		args.lock_pack =3D 0;
+		args.keep_pack =3D 1;
+		args.depth =3D option_depth;
+		args.no_progress =3D 1;
+	=09
+		refs =3D fetch_pack(&args, argv[0], 0, NULL, NULL);
+	}
+
+	cleanup_reference(ref_temp);
+
+	if (option_bare)
+		strcpy(branch_top, "heads");
+	else
+		snprintf(branch_top, sizeof branch_top,
+			 "refs/remotes/%s", option_origin);
+
+	remote_head =3D NULL;
+	for (r =3D refs; r; r =3D r->next) {
+		if (!strcmp(r->name, "HEAD")) {
+			remote_head =3D r;
+			continue;
+		}
+
+		if (!prefixcmp(r->name, "refs/heads/"))
+			snprintf(refname, sizeof refname,
+				 "%s/%s", branch_top, r->name + 11);
+		else if (!prefixcmp(r->name, "refs/tags/"))
+			snprintf(refname, sizeof refname,
+				 "refs/tags/%s", r->name + 10);
+		else
+			continue;
+
+		update_ref("clone from $repo",
+			   refname, r->old_sha1, NULL, 0, DIE_ON_ERR);
+	}
+
+	if (option_bare)
+		return 0;
+
+	/* Is HEAD always first?  If so, we could do this in the loop above. =
*/
+	head_points_at =3D NULL;
+	for (r =3D refs; r; r =3D r->next) {
+		if (r !=3D remote_head &&
+		    !hashcmp(r->old_sha1, remote_head->old_sha1)) {
+			head_points_at =3D r;
+			printf("head points at %s\n", r->name);
+			break;
+		}
+	}
+
+	if (strrchr(head_points_at->name, '/'))
+		head =3D strrchr(head_points_at->name, '/') + 1;
+	else
+		head =3D head_points_at->name;
+
+	/* FIXME: What about the "Uh-oh, the remote told us..." case? */
+
+	snprintf(key, sizeof key, "remote.%s.remote", option_origin);
+	git_config_set(key, repo);
+	snprintf(key, sizeof key, "remote.%s.fetch", option_origin);
+	snprintf(value, sizeof value, "+refs/heads/*:%s/*", branch_top);
+
+	git_config_set_multivar(key, value, "^$", 0);
+
+	if (head_points_at) {
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
+	} else {
+		/* Source had detached HEAD pointing nowhere. */
+		update_ref("clone from $repo", "HEAD", remote_head->old_sha1,
+			   NULL, REF_NODEREF, DIE_ON_ERR);
+	}
+
+	if (!option_no_checkout) {
+		char base_dir[PATH_MAX];
+		struct lock_file lock_file;
+		struct unpack_trees_options opts;
+		struct tree *tree;
+		struct tree_desc t[2];
+		int fd;
+
+		fd =3D hold_locked_index(&lock_file, 1);
+
+		memset(&opts, 0, sizeof opts);
+		opts.update =3D 1;
+		opts.verbose_update =3D !option_quiet;
+		opts.merge =3D 1;
+		opts.fn =3D twoway_merge;
+
+		/* FIXME: Handle basedir ends in '/' */
+		snprintf(base_dir, sizeof base_dir, "%s/",
+			 work_tree ? work_tree : dir);
+		opts.base_dir =3D base_dir;
+
+		tree =3D parse_tree_indirect(remote_head->old_sha1);
+		parse_tree(tree);
+		init_tree_desc(&t[0], tree->buffer, tree->size);
+		init_tree_desc(&t[1], tree->buffer, tree->size);
+		unpack_trees(2, t, &opts);
+
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close(fd) || commit_locked_index(&lock_file))
+			die("unable to write new index file");
+	}
+=09
+	return 0;
+}
diff --git a/builtin-init-db.c b/builtin-init-db.c
index e1393b8..18abc43 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -29,27 +29,6 @@ static void safe_create_dir(const char *dir, int sha=
re)
 		die("Could not make %s writable by group\n", dir);
 }
=20
-static int copy_file(const char *dst, const char *src, int mode)
-{
-	int fdi, fdo, status;
-
-	mode =3D (mode & 0111) ? 0777 : 0666;
-	if ((fdi =3D open(src, O_RDONLY)) < 0)
-		return fdi;
-	if ((fdo =3D open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
-		close(fdi);
-		return fdo;
-	}
-	status =3D copy_fd(fdi, fdo);
-	if (close(fdo) !=3D 0)
-		return error("%s: write error: %s", dst, strerror(errno));
-
-	if (!status && adjust_shared_perm(dst))
-		return -1;
-
-	return status;
-}
-
 static void copy_templates_1(char *path, int baselen,
 			     char *template, int template_baselen,
 			     DIR *dir)
@@ -330,49 +309,11 @@ static void guess_repository_type(const char *git=
_dir)
 	return;
 }
=20
-static const char init_db_usage[] =3D
-"git-init [-q | --quiet] [--template=3D<template-directory>] [--shared=
]";
-
-/*
- * If you want to, you can share the DB area with any number of branch=
es.
- * That has advantages: you can save space by sharing all the SHA1 obj=
ects.
- * On the other hand, it might just make lookup slower and messier. Yo=
u
- * be the judge.  The default case is to have one DB per managed direc=
tory.
- */
-int cmd_init_db(int argc, const char **argv, const char *prefix)
+int init_db(const char *git_dir, const char *template_dir, unsigned in=
t flags)
 {
-	const char *git_dir;
 	const char *sha1_dir;
-	const char *template_dir =3D NULL;
 	char *path;
-	int len, i, reinit;
-	int quiet =3D 0;
-
-	for (i =3D 1; i < argc; i++, argv++) {
-		const char *arg =3D argv[1];
-		if (!prefixcmp(arg, "--template=3D"))
-			template_dir =3D arg+11;
-		else if (!strcmp(arg, "--shared"))
-			shared_repository =3D PERM_GROUP;
-		else if (!prefixcmp(arg, "--shared=3D"))
-			shared_repository =3D git_config_perm("arg", arg+9);
-		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
-		        quiet =3D 1;
-		else
-			usage(init_db_usage);
-	}
-
-	/*
-	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
-	 * without --bare.  Catch the error early.
-	 */
-	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
-	if ((!git_dir || is_bare_repository_cfg =3D=3D 1)
-	    && getenv(GIT_WORK_TREE_ENVIRONMENT))
-		die("%s (or --work-tree=3D<directory>) not allowed without "
-		    "specifying %s (or --git-dir=3D<directory>)",
-		    GIT_WORK_TREE_ENVIRONMENT,
-		    GIT_DIR_ENVIRONMENT);
+	int len, reinit;
=20
 	guess_repository_type(git_dir);
=20
@@ -388,7 +329,6 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	/*
 	 * Set up the default .git directory contents
 	 */
-	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	safe_create_dir(git_dir, 0);
@@ -403,9 +343,13 @@ int cmd_init_db(int argc, const char **argv, const=
 char *prefix)
 	reinit =3D create_default_files(git_dir, template_dir);
=20
 	/*
-	 * And set up the object store.
+	 * And set up the object store.  Don't use
+	 * get_object_directory() here, since we're initializing
+	 * relative to git_dir, not $GIT_DIR.
 	 */
-	sha1_dir =3D get_object_directory();
+	sha1_dir =3D getenv(DB_ENVIRONMENT);
+	if (!sha1_dir)
+		sha1_dir =3D mkpath("%s/objects", git_dir);
 	len =3D strlen(sha1_dir);
 	path =3D xmalloc(len + 40);
 	memcpy(path, sha1_dir, len);
@@ -427,7 +371,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
=20
-	if (!quiet)
+	if (!(flags & INIT_DB_QUIET))
 		printf("%s%s Git repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
 		       shared_repository ? " shared" : "",
@@ -435,3 +379,48 @@ int cmd_init_db(int argc, const char **argv, const=
 char *prefix)
=20
 	return 0;
 }
+
+static const char init_db_usage[] =3D
+"git-init [-q | --quiet] [--template=3D<template-directory>] [--shared=
]";
+
+/*
+ * If you want to, you can share the DB area with any number of branch=
es.
+ * That has advantages: you can save space by sharing all the SHA1 obj=
ects.
+ * On the other hand, it might just make lookup slower and messier. Yo=
u
+ * be the judge.  The default case is to have one DB per managed direc=
tory.
+ */
+int cmd_init_db(int argc, const char **argv, const char *prefix)
+{
+	const char *git_dir;
+	const char *template_dir =3D NULL;
+	unsigned int flags =3D 0;
+	int i;
+
+	for (i =3D 1; i < argc; i++, argv++) {
+		const char *arg =3D argv[1];
+		if (!prefixcmp(arg, "--template=3D"))
+			template_dir =3D arg+11;
+		else if (!strcmp(arg, "--shared"))
+			shared_repository =3D PERM_GROUP;
+		else if (!prefixcmp(arg, "--shared=3D"))
+			shared_repository =3D git_config_perm("arg", arg+9);
+		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
+		        flags |=3D INIT_DB_QUIET;
+		else
+			usage(init_db_usage);
+	}
+
+	/*
+	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
+	 * without --bare.  Catch the error early.
+	 */
+	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
+	if ((!git_dir || is_bare_repository_cfg =3D=3D 1)
+	    && getenv(GIT_WORK_TREE_ENVIRONMENT))
+		die("%s (or --work-tree=3D<directory>) not allowed without "
+		    "specifying %s (or --git-dir=3D<directory>)",
+		    GIT_WORK_TREE_ENVIRONMENT,
+		    GIT_DIR_ENVIRONMENT);
+
+	return init_db(git_dir, template_dir, flags);
+}
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 7449323..2d83524 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -267,23 +267,6 @@ static int diff_two(const char *file1, const char =
*label1,
 	return 0;
 }
=20
-static int copy_file(const char *src, const char *dest)
-{
-	FILE *in, *out;
-	char buffer[32768];
-	int count;
-
-	if (!(in =3D fopen(src, "r")))
-		return error("Could not open %s", src);
-	if (!(out =3D fopen(dest, "w")))
-		return error("Could not open %s", dest);
-	while ((count =3D fread(buffer, 1, sizeof(buffer), in)))
-		fwrite(buffer, 1, count, out);
-	fclose(in);
-	fclose(out);
-	return 0;
-}
-
 static int do_plain_rerere(struct path_list *rr, int fd)
 {
 	struct path_list conflict =3D { NULL, 0, 0, 1 };
@@ -343,7 +326,7 @@ static int do_plain_rerere(struct path_list *rr, in=
t fd)
 			continue;
=20
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-		copy_file(path, rr_path(name, "postimage"));
+		copy_file(path, rr_path(name, "postimage"), 0666);
 tail_optimization:
 		if (i < rr->nr - 1)
 			memmove(rr->items + i,
diff --git a/builtin.h b/builtin.h
index cb675c4..1b9da64 100644
--- a/builtin.h
+++ b/builtin.h
@@ -24,6 +24,7 @@ extern int cmd_check_attr(int argc, const char **argv=
, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const cha=
r *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_cherry_pick(int argc, const char **argv, const char *pr=
efix);
+extern int cmd_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_commit(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit_tree(int argc, const char **argv, const char *pr=
efix);
diff --git a/cache.h b/cache.h
index 4e59646..1e29e70 100644
--- a/cache.h
+++ b/cache.h
@@ -230,6 +230,10 @@ extern const char *prefix_filename(const char *pre=
fix, int len, const char *path
 extern void verify_filename(const char *prefix, const char *name);
 extern void verify_non_filename(const char *prefix, const char *name);
=20
+#define INIT_DB_QUIET 0x0001
+
+extern int init_db(const char *git_dir, const char *template_dir, unsi=
gned int flags);
+
 #define alloc_nr(x) (((x)+16)*3/2)
=20
 /*
@@ -588,6 +592,7 @@ extern const char *git_log_output_encoding;
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
+extern int copy_file(const char *dst, const char *src, int mode);
 extern int read_in_full(int fd, void *buf, size_t count);
 extern int write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
diff --git a/git-clone.sh b/contrib/examples/git-clone.sh
similarity index 100%
rename from git-clone.sh
rename to contrib/examples/git-clone.sh
diff --git a/copy.c b/copy.c
index c225d1b..afc4fbf 100644
--- a/copy.c
+++ b/copy.c
@@ -34,3 +34,24 @@ int copy_fd(int ifd, int ofd)
 	close(ifd);
 	return 0;
 }
+
+int copy_file(const char *dst, const char *src, int mode)
+{
+	int fdi, fdo, status;
+
+	mode =3D (mode & 0111) ? 0777 : 0666;
+	if ((fdi =3D open(src, O_RDONLY)) < 0)
+		return fdi;
+	if ((fdo =3D open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
+		close(fdi);
+		return fdo;
+	}
+	status =3D copy_fd(fdi, fdo);
+	if (close(fdo) !=3D 0)
+		return error("%s: write error: %s", dst, strerror(errno));
+
+	if (!status && adjust_shared_perm(dst))
+		return -1;
+
+	return status;
+}
diff --git a/diff.c b/diff.c
index 5175950..0af5b81 100644
--- a/diff.c
+++ b/diff.c
@@ -258,8 +258,8 @@ static void print_line_count(int count)
 	}
 }
=20
-static void copy_file(int prefix, const char *data, int size,
-		const char *set, const char *reset)
+static void copy_file_with_prefix(int prefix, const char *data, int si=
ze,
+				  const char *set, const char *reset)
 {
 	int ch, nl_just_seen =3D 1;
 	while (0 < size--) {
@@ -310,9 +310,9 @@ static void emit_rewrite_diff(const char *name_a,
 	print_line_count(lc_b);
 	printf(" @@%s\n", reset);
 	if (lc_a)
-		copy_file('-', one->data, one->size, old, reset);
+		copy_file_with_prefix('-', one->data, one->size, old, reset);
 	if (lc_b)
-		copy_file('+', two->data, two->size, new, reset);
+		copy_file_with_prefix('+', two->data, two->size, new, reset);
 }
=20
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
diff --git a/git.c b/git.c
index f406c4b..c8dfb6d 100644
--- a/git.c
+++ b/git.c
@@ -302,6 +302,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
diff --git a/unpack-trees.c b/unpack-trees.c
index e9eb795..752278a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -338,7 +338,8 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	memset(&df_conflict_list, 0, sizeof(df_conflict_list));
 	df_conflict_list.next =3D &df_conflict_list;
 	memset(&state, 0, sizeof(state));
-	state.base_dir =3D "";
+	state.base_dir =3D o->base_dir ? o->base_dir : "";
+	state.base_dir_len =3D strlen(state.base_dir);
 	state.force =3D 1;
 	state.quiet =3D 1;
 	state.refresh_cache =3D 1;
diff --git a/unpack-trees.h b/unpack-trees.h
index 5517faa..15b2ed9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -17,6 +17,7 @@ struct unpack_trees_options {
 	int verbose_update;
 	int aggressive;
 	const char *prefix;
+	const char *base_dir;
 	int pos;
 	struct dir_struct *dir;
 	merge_fn_t fn;
--=20
1.5.3.4
