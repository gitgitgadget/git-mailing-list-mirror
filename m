From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 06/12] Avoid accessing working directory outside sparse
	prefix
Date: Wed, 23 Jul 2008 21:56:46 +0700
Message-ID: <20080723145646.GA29112@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfnB-0002pY-Pq
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbYGWO5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbYGWO5L
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:57:11 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbYGWO5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:57:08 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=oi1mnjqnYZvUZ26oTaVu/2sf2YG1rZSgfX2cYmp4nHw=;
        b=QjB9ta2rw28k5ZKo3AA4TFM6QF0db/RsHl/Wy8njPyzsAt3NRTJtmf9Jp5BCowr4lY
         LykP3lQW6J9bXz6AxHxIaLmebGi7DhHVzwvVQbntCrieyQ7lo61ksc7TlpDB2ZA9caI1
         vl4tzTOgWqob6BUHoOLkY8MYj6QG7HSdQiPd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=F2aOwr6EsFA5IOz5RA4OLUytd55OOzRDDZPBZmIOXPyXItwaInpjthha1mOOJNxET9
         Q6OXbgTL9FTOnipYfQ+LgVkFV0Naix029jKf7qBUe/OD6ORQQ9GwlUYHUA14OTojnasb
         n3w/14FBcvno3vZO4zL5+O0Y6uAD/wkBNquyQ=
Received: by 10.110.15.9 with SMTP id 9mr96253tio.44.1216825027704;
        Wed, 23 Jul 2008 07:57:07 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id 14sm14754063tim.16.2008.07.23.07.57.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:57:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:56:46 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89676>

Low-level functions such as checkout_entry() will refuse to write
outside sparse prefix. Other functions need lstat() will simply
assume files are good. The rest should die()

On UI side, all pathspec input will be filtered by filter_pathspec()
or filter_pathspec_1() to:
 - keep pathspec if it's inside sparse prefix
 - expand pathspec if it's outside sparse prefix, but is a parent
   directory of sparse prefix
 - otherwise, die()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-add.c             |    4 +-
 builtin-apply.c           |    5 ++
 builtin-checkout-index.c  |    2 +
 builtin-checkout.c        |    2 +-
 builtin-clean.c           |    3 +
 builtin-commit.c          |    2 +-
 builtin-grep.c            |   26 +++++++------
 builtin-ls-files.c        |    4 +-
 builtin-ls-tree.c         |    2 +-
 builtin-merge-recursive.c |    2 +-
 builtin-mv.c              |    2 +-
 builtin-rm.c              |    7 +++-
 builtin-update-index.c    |   37 ++++++++++++++----
 cache.h                   |    3 +
 diff-lib.c                |    2 +-
 diff.c                    |    3 +-
 entry.c                   |    3 +
 read-cache.c              |    5 ++
 setup.c                   |   90 +++++++++++++++++++++++++++++++++++++=
+++++++-
 sha1_file.c               |    3 +
 unpack-trees.c            |   29 +++++++++++++-
 21 files changed, 199 insertions(+), 37 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index fc3f96e..8f6efca 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -151,7 +151,7 @@ static void refresh(int verbose, const char **paths=
pec)
=20
 static const char **validate_pathspec(int argc, const char **argv, con=
st char *prefix)
 {
-	const char **pathspec =3D get_pathspec(prefix, argv);
+	const char **pathspec =3D get_filtered_pathspec(prefix, argv);
=20
 	return pathspec;
 }
@@ -278,7 +278,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
 		return 0;
 	}
-	pathspec =3D get_pathspec(prefix, argv);
+	pathspec =3D get_filtered_pathspec(prefix, argv);
=20
 	/*
 	 * If we are adding new files, we need to scan the working
diff --git a/builtin-apply.c b/builtin-apply.c
index 2216a0b..25d3523 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2389,6 +2389,9 @@ static int check_preimage(struct patch *patch, st=
ruct cache_entry **ce, struct s
 	if (!old_name)
 		return 0;
=20
+	if (outside_sparse_prefix(old_name))
+		return error("%s: could not apply outside sparse checkout", old_name=
);
+
 	assert(patch->is_new <=3D 0);
=20
 	if (!(patch->is_copy || patch->is_rename) &&
@@ -2491,6 +2494,8 @@ static int check_patch(struct patch *patch)
 		    cache_name_pos(new_name, strlen(new_name)) >=3D 0 &&
 		    !ok_if_exists)
 			return error("%s: already exists in index", new_name);
+		if (outside_sparse_prefix(new_name))
+			return error("%s: could not apply outside sparse checkout", new_nam=
e);
 		if (!cached) {
 			int err =3D check_to_create_blob(new_name, ok_if_exists);
 			if (err)
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 71ebabf..f0e829c 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -134,6 +134,8 @@ static void checkout_all(const char *prefix, int pr=
efix_length)
 		    (ce_namelen(ce) <=3D prefix_length ||
 		     memcmp(prefix, ce->name, prefix_length)))
 			continue;
+		if (outside_sparse_prefix(ce->name))
+			continue;
 		if (last_ce && to_tempfile) {
 			if (ce_namelen(last_ce) !=3D ce_namelen(ce)
 			    || memcmp(last_ce->name, ce->name, ce_namelen(ce)))
diff --git a/builtin-checkout.c b/builtin-checkout.c
index fbd5105..eec1bde 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -472,7 +472,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 		die("git checkout: -f and -m are incompatible");
=20
 	if (argc) {
-		const char **pathspec =3D get_pathspec(prefix, argv);
+		const char **pathspec =3D get_filtered_pathspec(prefix, argv);
=20
 		if (!pathspec)
 			die("invalid path specification");
diff --git a/builtin-clean.c b/builtin-clean.c
index 48bf29f..5f0a632 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -76,6 +76,9 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 		setup_standard_excludes(&dir);
=20
 	pathspec =3D get_pathspec(prefix, argv);
+	pathspec =3D filter_pathspec(pathspec);
+	if (!pathspec && sparse_checkout_enabled())
+		pathspec =3D (const char **)get_sparse_prefix();
 	read_cache();
=20
 	/*
diff --git a/builtin-commit.c b/builtin-commit.c
index f2d301a..aaa208d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -237,7 +237,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix)
 		die("index file corrupt");
=20
 	if (*argv)
-		pathspec =3D get_pathspec(prefix, argv);
+		pathspec =3D get_filtered_pathspec(prefix, argv);
=20
 	/*
 	 * Non partial, non as-is commit.
diff --git a/builtin-grep.c b/builtin-grep.c
index ee96d01..c9dc30a 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -776,19 +776,21 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 			verify_filename(prefix, argv[j]);
 	}
=20
-	if (i < argc) {
-		paths =3D get_pathspec(prefix, argv + i);
-		if (opt.prefix_length && opt.relative) {
-			/* Make sure we do not get outside of paths */
-			for (i =3D 0; paths[i]; i++)
-				if (strncmp(prefix, paths[i], opt.prefix_length))
-					die("git-grep: cannot generate relative filenames containing '..'=
");
-		}
-	}
+	if (i < argc)
+		paths =3D get_filtered_pathspec(prefix, argv + i);
 	else if (prefix) {
-		paths =3D xcalloc(2, sizeof(const char *));
-		paths[0] =3D prefix;
-		paths[1] =3D NULL;
+		static const char *fake_argv[2];
+		fake_argv[0] =3D prefix;
+		fake_argv[1] =3D NULL;
+		paths =3D get_filtered_pathspec(NULL, fake_argv);
+	}
+	if (!paths && sparse_checkout_enabled())
+		paths =3D (const char **)get_sparse_prefix();
+	if (paths && opt.prefix_length && opt.relative) {
+		/* Make sure we do not get outside of paths */
+		for (i =3D 0; paths[i]; i++)
+			if (strncmp(prefix, paths[i], opt.prefix_length))
+				die("git-grep: cannot generate relative filenames containing '..'"=
);
 	}
=20
 	if (!list.nr)
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 4d18873..37041cd 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -571,7 +571,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
-	pathspec =3D get_pathspec(prefix, argv + i);
+	pathspec =3D get_filtered_pathspec(prefix, argv + i);
+	if (!pathspec && sparse_checkout_enabled())
+		pathspec =3D (const char **)get_sparse_prefix();
=20
 	/* Verify that the pathspec matches the prefix */
 	if (pathspec)
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index d25767a..45b1ef5 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -185,7 +185,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
=20
-	pathspec =3D get_pathspec(prefix, argv + 2);
+	pathspec =3D get_filtered_pathspec(prefix, argv + 2);
 	tree =3D parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 7ce015b..5c62743 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -526,7 +526,7 @@ static void update_file_flags(const unsigned char *=
sha,
 	if (index_only)
 		update_wd =3D 0;
=20
-	if (update_wd) {
+	if (update_wd && !outside_sparse_prefix(path)) {
 		enum object_type type;
 		void *buf;
 		unsigned long size;
diff --git a/builtin-mv.c b/builtin-mv.c
index 736a0b8..0591aa2 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -33,7 +33,7 @@ static const char **copy_pathspec(const char *prefix,=
 const char **pathspec,
 				result[i] =3D last_slash + 1;
 		}
 	}
-	return get_pathspec(prefix, result);
+	return get_filtered_pathspec(prefix, result);
 }
=20
 static void show_list(const char *label, struct string_list *list)
diff --git a/builtin-rm.c b/builtin-rm.c
index ee8247b..082dd95 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -158,7 +158,10 @@ int cmd_rm(int argc, const char **argv, const char=
 *prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
=20
-	pathspec =3D get_pathspec(prefix, argv);
+	pathspec =3D get_filtered_pathspec(prefix, argv);
+	if (!pathspec)
+		return 0;
+
 	seen =3D NULL;
 	for (i =3D 0; pathspec[i] ; i++)
 		/* nothing */;
@@ -166,6 +169,8 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
=20
 	for (i =3D 0; i < active_nr; i++) {
 		struct cache_entry *ce =3D active_cache[i];
+		if (outside_sparse_prefix(ce->name))
+			continue;
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
 		add_list(ce->name);
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 38eb53c..25e3e98 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -242,6 +242,9 @@ static void chmod_path(int flip, const char *path)
 	struct cache_entry *ce;
 	unsigned int mode;
=20
+	if (outside_sparse_prefix(path))
+		die("%s: cannot update sparse outside %s", path, get_sparse_prefix_s=
tr());
+
 	pos =3D cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
@@ -521,7 +524,7 @@ static int do_reupdate(int ac, const char **av,
 	 */
 	int pos;
 	int has_head =3D 1;
-	const char **pathspec =3D get_pathspec(prefix, av + 1);
+	const char **pathspec =3D get_filtered_pathspec(prefix, av + 1);
=20
 	if (read_ref("HEAD", head_sha1))
 		/* If there is no HEAD, that means it is an initial
@@ -582,7 +585,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
=20
 	for (i =3D 1 ; i < argc; i++) {
 		const char *path =3D argv[i];
-		const char *p;
+		const char *p, **pathspec;
=20
 		if (allow_options && *path =3D=3D '-') {
 			if (!strcmp(path, "--")) {
@@ -703,9 +706,17 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
 			die("unknown option %s", path);
 		}
 		p =3D prefix_path(prefix, prefix_length, path);
-		update_one(p, NULL, 0);
-		if (set_executable_bit)
-			chmod_path(set_executable_bit, p);
+		pathspec =3D filter_pathspec_1(p);
+		if (pathspec) {
+			const char **pp =3D pathspec;
+			while (*pp) {
+				update_one(*pp, NULL, 0);
+				if (set_executable_bit)
+					chmod_path(set_executable_bit, *pp);
+				pp ++;
+			}
+			free(pathspec);
+		}
 		if (p < path || p > path + strlen(path))
 			free((char*)p);
 	}
@@ -715,7 +726,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 		strbuf_init(&buf, 0);
 		strbuf_init(&nbuf, 0);
 		while (strbuf_getline(&buf, stdin, line_termination) !=3D EOF) {
-			const char *p;
+			const char *p, **pathspec;
 			if (line_termination && buf.buf[0] =3D=3D '"') {
 				strbuf_reset(&nbuf);
 				if (unquote_c_style(&nbuf, buf.buf, NULL))
@@ -723,9 +734,17 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
 				strbuf_swap(&buf, &nbuf);
 			}
 			p =3D prefix_path(prefix, prefix_length, buf.buf);
-			update_one(p, NULL, 0);
-			if (set_executable_bit)
-				chmod_path(set_executable_bit, p);
+			pathspec =3D filter_pathspec_1(p);
+			if (pathspec) {
+				const char **pp =3D pathspec;
+				while (*pp) {
+					update_one(*pp, NULL, 0);
+					if (set_executable_bit)
+						chmod_path(set_executable_bit, *pp);
+					pp++;
+				}
+				free(pathspec);
+			}
 			if (p < buf.buf || p > buf.buf + buf.len)
 				free((char *)p);
 		}
diff --git a/cache.h b/cache.h
index f6bbadc..b9a1d96 100644
--- a/cache.h
+++ b/cache.h
@@ -336,6 +336,9 @@ extern int check_index_prefix(const struct index_st=
ate *index, int is_merge);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
 extern const char **get_pathspec(const char *prefix, const char **path=
spec);
+extern const char **filter_pathspec(const char **pathspec);
+extern const char **filter_pathspec_1(const char *path);
+extern const char **get_filtered_pathspec(const char *prefix, const ch=
ar **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/diff-lib.c b/diff-lib.c
index 2908146..9382114 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -356,7 +356,7 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	cached =3D o->index_only;
+	cached =3D outside_sparse_prefix(idx->name) || o->index_only;
 	match_missing =3D !revs->ignore_merges;
=20
 	if (cached && idx && ce_stage(idx)) {
diff --git a/diff.c b/diff.c
index a07812c..e344916 100644
--- a/diff.c
+++ b/diff.c
@@ -1721,7 +1721,8 @@ static int reuse_worktree_file(const char *name, =
const unsigned char *sha1, int
 	 * If ce matches the file in the work tree, we can reuse it.
 	 */
 	if (ce_uptodate(ce) ||
-	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
+	    (!outside_sparse_prefix(name) &&
+	     !lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
 		return 1;
=20
 	return 0;
diff --git a/entry.c b/entry.c
index 222aaa3..e2921c2 100644
--- a/entry.c
+++ b/entry.c
@@ -201,6 +201,9 @@ int checkout_entry(struct cache_entry *ce, const st=
ruct checkout *state, char *t
=20
 	memcpy(path, state->base_dir, len);
 	strcpy(path + len, ce->name);
+	if (outside_sparse_prefix(path))
+		die("%s: unable to checkout entry outside sparse checkout", path);
+
=20
 	if (!lstat(path, &st)) {
 		unsigned changed =3D ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
diff --git a/read-cache.c b/read-cache.c
index 4fea40e..dd42c7c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -232,6 +232,8 @@ int ie_match_stat(const struct index_state *istate,
 	int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
 	int assume_racy_is_modified =3D options & CE_MATCH_RACY_IS_DIRTY;
=20
+	if (outside_sparse_prefix(ce->name))
+		return 0;
 	/*
 	 * If it's marked as always valid in the index, it's
 	 * valid whatever the checked-out copy says.
@@ -953,6 +955,9 @@ static struct cache_entry *refresh_cache_ent(struct=
 index_state *istate,
 		return ce;
 	}
=20
+	if (outside_sparse_prefix(ce->name))
+		return ce;
+
 	if (lstat(ce->name, &st) < 0) {
 		if (err)
 			*err =3D errno;
diff --git a/setup.c b/setup.c
index 6cf9094..4ae68fd 100644
--- a/setup.c
+++ b/setup.c
@@ -164,7 +164,7 @@ void verify_filename(const char *prefix, const char=
 *arg)
 	if (*arg =3D=3D '-')
 		die("bad flag '%s' used after filename", arg);
 	name =3D prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
-	if (!lstat(name, &st))
+	if (!outside_sparse_prefix(name) && !lstat(name, &st))
 		return;
 	if (errno =3D=3D ENOENT)
 		die("ambiguous argument '%s': unknown revision or path not in the wo=
rking tree.\n"
@@ -187,7 +187,7 @@ void verify_non_filename(const char *prefix, const =
char *arg)
 	if (*arg =3D=3D '-')
 		return; /* flag */
 	name =3D prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
-	if (!lstat(name, &st))
+	if (!outside_sparse_prefix(name) && !lstat(name, &st))
 		die("ambiguous argument '%s': both revision and filename\n"
 		    "Use '--' to separate filenames from revisions", arg);
 	if (errno !=3D ENOENT && errno !=3D ENOTDIR)
@@ -229,6 +229,92 @@ const char **get_pathspec(const char *prefix, cons=
t char **pathspec)
 }
=20
 /*
+ * if path is inside sparse prefix, leave it as-is
+ * if path is parent of sparse prefix, expand it to sparse prefix
+ * if path is outside sparse prefix, die()
+ */
+static void filter_pathspec_internal(const char *path, const char ***d=
st, int *dst_alloc, int *dst_nr)
+{
+	char **iprefix;
+	int filtered =3D 1;
+
+	for (iprefix =3D get_sparse_prefix(); *iprefix; iprefix++) {
+		const char *new_dst =3D NULL;
+		if (!prefixcmp(path, *iprefix))
+			new_dst =3D path;
+		else if (!prefixcmp(*iprefix, path))
+			new_dst =3D *iprefix;
+
+		if (!new_dst)
+			continue;
+
+		if (*dst_alloc <=3D *dst_nr) {
+			*dst_alloc =3D alloc_nr(*dst_alloc);
+			*dst =3D xrealloc(*dst, *dst_alloc * sizeof(**dst));
+		}
+		(*dst)[(*dst_nr)++] =3D new_dst;
+		filtered =3D 0;
+
+		/*
+		 * if it's inside sparse prefix,
+		 * no need to search more
+		 */
+		if (new_dst =3D=3D path)
+			break;
+	}
+	if (filtered)
+		die("pathspec %s is outside sparse checkout %s", path, get_sparse_pr=
efix_str());
+}
+
+const char **filter_pathspec(const char **pathspec)
+{
+	const char **src, **dst;
+	int dst_alloc =3D 0;
+	int dst_nr =3D 0;
+
+	if (!sparse_checkout_enabled())
+		return pathspec;
+	if (!pathspec || !*pathspec)
+		return NULL;
+
+	src =3D pathspec;
+	dst =3D NULL;
+	while (*src) {
+		filter_pathspec_internal(*src, &dst, &dst_alloc, &dst_nr);
+		src++;
+	}
+	if (!dst)
+		return NULL;
+	dst[dst_nr] =3D NULL;
+	return dst;
+}
+
+const char **filter_pathspec_1(const char *path)
+{
+	int dst_alloc =3D 0, dst_nr =3D 0;
+	const char **dst =3D NULL;
+
+	if (!path)
+		return NULL;
+	if (!sparse_checkout_enabled()) {
+		dst =3D xmalloc(2*sizeof(*dst));
+		dst[0] =3D path;
+		dst[1] =3D NULL;
+		return dst;
+	}
+	filter_pathspec_internal(path, &dst, &dst_alloc, &dst_nr);
+	if (!dst)
+		return NULL;
+	dst[dst_nr] =3D NULL;
+	return dst;
+}
+
+const char **get_filtered_pathspec(const char *prefix, const char **pa=
thspec)
+{
+	return filter_pathspec(get_pathspec(prefix,pathspec));
+}
+
+/*
  * Test if it looks like we're at a git directory.
  * We want to see:
  *
diff --git a/sha1_file.c b/sha1_file.c
index e281c14..60f9e2a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2422,6 +2422,9 @@ int index_path(unsigned char *sha1, const char *p=
ath, struct stat *st, int write
 	char *target;
 	size_t len;
=20
+	if (outside_sparse_prefix(path))
+		die("%s: cannot index a file outside sparse checkout", path);
+
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
 		fd =3D open(path, O_RDONLY);
diff --git a/unpack-trees.c b/unpack-trees.c
index 0a6723b..0a30d68 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -84,6 +84,19 @@ static void unlink_entry(struct cache_entry *ce)
 	}
 }
=20
+static int check_sparse_checkout(struct unpack_trees_options *o)
+{
+	unsigned cnt =3D 0;
+	struct index_state *index =3D &o->result;
+
+	for (cnt =3D 0; cnt < index->cache_nr; cnt++) {
+		struct cache_entry *ce =3D index->cache[cnt];
+		if (ce_stage(ce) && outside_sparse_prefix(ce->name))
+			return 0;
+	}
+	return 1;
+}
+
 static struct checkout state;
 static int check_updates(struct unpack_trees_options *o)
 {
@@ -96,6 +109,8 @@ static int check_updates(struct unpack_trees_options=
 *o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
+			if (outside_sparse_prefix(ce->name))
+				continue;
 			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 				total++;
 		}
@@ -108,6 +123,8 @@ static int check_updates(struct unpack_trees_option=
s *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		if (outside_sparse_prefix(ce->name))
+			continue;
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
@@ -121,6 +138,8 @@ static int check_updates(struct unpack_trees_option=
s *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		if (outside_sparse_prefix(ce->name))
+			continue;
 		if (ce->ce_flags & CE_UPDATE) {
 			display_progress(progress, ++cnt);
 			ce->ce_flags &=3D ~CE_UPDATE;
@@ -411,6 +430,9 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	if (o->check_index_prefix && !check_index_prefix(&o->result, o->merge=
 && !o->prefix))
 		return unpack_failed(o, "Merge outside index prefix");
=20
+	if (sparse_checkout_enabled() && !check_sparse_checkout(o))
+		return unpack_failed(o, "Merge conflicts outside sparse checkout");
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -445,7 +467,7 @@ static int verify_uptodate(struct cache_entry *ce,
 {
 	struct stat st;
=20
-	if (o->index_only || o->reset)
+	if (o->index_only || o->reset || outside_sparse_prefix(ce->name))
 		return 0;
=20
 	if (!lstat(ce->name, &st)) {
@@ -583,7 +605,7 @@ static int verify_absent(struct cache_entry *ce, co=
nst char *action,
 {
 	struct stat st;
=20
-	if (o->index_only || o->reset || !o->update)
+	if (o->index_only || o->reset || !o->update || outside_sparse_prefix(=
ce->name))
 		return 0;
=20
 	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
@@ -994,7 +1016,8 @@ int oneway_merge(struct cache_entry **src, struct =
unpack_trees_options *o)
 		int update =3D 0;
 		if (o->reset) {
 			struct stat st;
-			if (lstat(old->name, &st) ||
+			if (outside_sparse_prefix(old->name) ||
+			    lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
 				update |=3D CE_UPDATE;
 		}
--=20
1.5.5.GIT
