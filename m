From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 11:23:00 -0500
Message-ID: <1195662180.28318.19.camel@hinata.boston.redhat.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	 <Pine.LNX.4.64.0711211554370.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?ISO-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IusMQ-0005GR-Tk
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbXKUQXN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 11:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbXKUQXN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:23:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755221AbXKUQXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 11:23:11 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lALGN7Dv027496;
	Wed, 21 Nov 2007 11:23:07 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lALGN77O008703;
	Wed, 21 Nov 2007 11:23:07 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lALGN7e4017032;
	Wed, 21 Nov 2007 11:23:07 -0500
In-Reply-To: <Pine.LNX.4.64.0711211554370.27959@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65675>

On Wed, 2007-11-21 at 15:59 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 21 Nov 2007, Santi B?jar wrote:
>=20
> > 1) git-clone does not accept a bundle file, even if git-fetch does.=
 I've=20
> > made a patch to use git-fetch in git-clone for this.
>=20
> This, along with rewriting git-clone as a very thin wrapper over git-=
init,=20
> -remote and -fetch, is a really low hanging fruit.
>=20
> Or maybe go the full nine yards and build it in.  Should be a breeze =
now,=20
> given parse_options() and run_command().

I started doing this, which is pretty stupid as I'm pressed to find tim=
e
to finish up builtin-commit.  Nevertheless, could you elaborate on the
plan here?  How would you rewrite it to just use remote and fetch?  I
just finished the boilerplate option parsing stuff (patch below) and
started reading the core of git-clone.sh, but if most of this can be
replaced I'd like to hear about it :)

cheers,
Kristian

>From ccfa6b7b6c0bad98201166db3f91760b423ab0c9 Mon Sep 17 00:00:00 2001
=46rom: =3D?utf-8?q?Kristian=3D20H=3DC3=3DB8gsberg?=3D <krh@redhat.com>
Date: Sun, 18 Nov 2007 18:48:04 -0500
Subject: [PATCH] builtin-clone: first steps, up to and including
git-init.

---
 Makefile                                      |    2 +-
 builtin-clone.c                               |  286
+++++++++++++++++++++++++
 builtin-init-db.c                             |   90 ++++----
 builtin.h                                     |    1 +
 cache.h                                       |    4 +
 git-clone.sh =3D> contrib/examples/git-clone.sh |    0=20
 git.c                                         |    1 +
 7 files changed, 341 insertions(+), 43 deletions(-)
 create mode 100644 builtin-clone.c
 rename git-clone.sh =3D> contrib/examples/git-clone.sh (100%)

diff --git a/Makefile b/Makefile
index 4d23d12..f39b7e8 100644
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
index 0000000..8a569e0
--- /dev/null
+++ b/builtin-clone.c
@@ -0,0 +1,286 @@
+/*
+ * Builtin "git clone"
+ *
+ * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
+ *
+ * Clone a repository into a different directory that does not yet
exist.
+ */
+
+#include "cache.h"
+#include "parse-options.h"
+
+/*
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
+static int option_local, option_no_hardlinks, option_shared,
option_depth;
+static char *option_template, *option_reference, *option_origin;
+static char *option_upload_pack;
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
+setup_reference(void)
+{
+	struct stat buf;
+	const char *ref_git, *alternates;
+	int fd;
+
+	if (!option_reference)
+		return;
+
+	if (!stat(mkpath("%s/.git/objects", option_reference), &buf) &&
+	    S_ISDIR(buf.st_mode))
+		ref_git =3D mkpath("%s/.git", option_reference);
+	else if (!stat(mkpath("%s/objects", option_reference), &buf) &&
+		 S_ISDIR(buf.st_mode))
+		ref_git =3D option_reference;
+	else
+		die("reference repository '%s' is not a local directory.",
+		    option_reference);
+
+	ref_git =3D make_absolute_path(ref_git);
+=09
+	fd =3D open(git_path("objects/info/alternates"),
+		  O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die("could not create alternates file\n");
+	alternates =3D mkpath("%s/objects\n", ref_git);
+	write_or_die(fd, alternates, strlen(alternates));
+	if (close(fd) < 0)
+		die("could not close alternates file\n");
+
+	/* This part is going to be tricky, since it deals with two
+	 * repositories.  Most code in git works on global state
+	 * assumed to be coming from the one active repository, but
+	 * here we want to do for-each-ref in one repository and say
+	 * update-ref in another.  We could just say set_git_dir() and
+	 * then say for-each-ref and store the refs in an array and
+	 * the say set_git_dir() again to switch to the repository
+	 * we're creating and then write out the refs using update-ref. */
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
+}
+
+static void
+cleanup_reference(void)
+{
+	/*
+	  test -d "$GIT_DIR/refs/reference-tmp" &&
+		rm -fr "$GIT_DIR/refs/reference-tmp"
+	*/
+}
+
+static void
+clone_local(const char *path)
+{
+	/* local hardlink magic */
+	printf("local, from %s\n", path);
+}
+
+static void
+clone_rsync(const char *repo)
+{
+	printf("rsync, from %s\n", repo);
+	if (option_depth > 0)
+		die("shallow over rsync not supported");
+}
+
+static void
+clone_native(const char *repo)
+{
+		printf("native git, from %s\n", repo);
+}
+
+static void
+clone_curl(const char *repo)
+{
+	printf("curl, from %s\n", repo);
+	if (option_depth > 0)
+		die("shallow over rsync not supported");
+}
+
+int cmd_clone(int argc, const char **argv, const char *prefix)
+{
+	int use_local_hardlinks =3D 1;
+	int use_separate_remote =3D 1;
+	struct stat buf;
+	const char *repo, *work_tree, *git_dir;
+	char *path, *dir;
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
+	if (!option_origin)
+		option_origin =3D "origin";
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
+	printf("repo: %s, path: %s\n", repo, path);
+	printf("dir: %s\n", dir);
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
+	set_git_dir(make_absolute_path(git_dir));
+	init_db(git_dir, option_template, option_quiet ? INIT_DB_QUIET : 0);
+
+	if (option_bare)
+		git_config_set("core.bare", "true");
+
+	setup_reference();
+
+	if (path !=3D NULL) {
+		clone_local(path);
+	} else if (!prefixcmp(repo, "rsync://")) {
+		clone_rsync(repo);
+	} else if (!prefixcmp(repo, "https://") ||
+		   !prefixcmp(repo, "http://") ||
+		   !prefixcmp(repo, "ftp://")) {
+		clone_curl(repo);
+	} else {
+		clone_native(repo);
+	}
+
+	cleanup_reference();
+
+
+
+	return 0;
+}
diff --git a/builtin-init-db.c b/builtin-init-db.c
index e1393b8..0ddfb46 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -330,49 +330,11 @@ static void guess_repository_type(const char
*git_dir)
 	return;
 }
=20
-static const char init_db_usage[] =3D
-"git-init [-q | --quiet] [--template=3D<template-directory>] [--shared=
]";
-
-/*
- * If you want to, you can share the DB area with any number of
branches.
- * That has advantages: you can save space by sharing all the SHA1
objects.
- * On the other hand, it might just make lookup slower and messier. Yo=
u
- * be the judge.  The default case is to have one DB per managed
directory.
- */
-int cmd_init_db(int argc, const char **argv, const char *prefix)
+int init_db(const char *git_dir, const char *template_dir, unsigned in=
t
flags)
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
@@ -388,7 +350,6 @@ int cmd_init_db(int argc, const char **argv, const
char *prefix)
 	/*
 	 * Set up the default .git directory contents
 	 */
-	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	safe_create_dir(git_dir, 0);
@@ -427,7 +388,7 @@ int cmd_init_db(int argc, const char **argv, const
char *prefix)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
=20
-	if (!quiet)
+	if (!(flags & INIT_DB_QUIET))
 		printf("%s%s Git repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
 		       shared_repository ? " shared" : "",
@@ -435,3 +396,48 @@ int cmd_init_db(int argc, const char **argv, const
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
+ * If you want to, you can share the DB area with any number of
branches.
+ * That has advantages: you can save space by sharing all the SHA1
objects.
+ * On the other hand, it might just make lookup slower and messier. Yo=
u
+ * be the judge.  The default case is to have one DB per managed
directory.
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
diff --git a/builtin.h b/builtin.h
index 6f01e96..8e59778 100644
--- a/builtin.h
+++ b/builtin.h
@@ -24,6 +24,7 @@ extern int cmd_check_attr(int argc, const char **argv=
,
const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const cha=
r
*prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_cherry_pick(int argc, const char **argv, const char
*prefix);
+extern int cmd_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_commit(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit_tree(int argc, const char **argv, const char
*prefix);
diff --git a/cache.h b/cache.h
index 510154b..8c5f6af 100644
--- a/cache.h
+++ b/cache.h
@@ -230,6 +230,10 @@ extern const char *prefix_filename(const char
*prefix, int len, const char *path
 extern void verify_filename(const char *prefix, const char *name);
 extern void verify_non_filename(const char *prefix, const char *name);
=20
+#define INIT_DB_QUIET 0x0001
+
+extern int init_db(const char *git_dir, const char *template_dir,
unsigned int flags);
+
 #define alloc_nr(x) (((x)+16)*3/2)
=20
 /*
diff --git a/git-clone.sh b/contrib/examples/git-clone.sh
similarity index 100%
rename from git-clone.sh
rename to contrib/examples/git-clone.sh
diff --git a/git.c b/git.c
index 9606937..9236833 100644
--- a/git.c
+++ b/git.c
@@ -293,6 +293,7 @@ static void handle_internal_command(int argc, const
char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
--=20
1.5.3.4
