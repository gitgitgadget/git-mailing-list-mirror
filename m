From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 03/10] pathspec: support :(literal) syntax for noglob pathspec
Date: Sun, 13 Jan 2013 19:49:32 +0700
Message-ID: <1358081379-17752-4-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:50:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN0r-0000sN-MK
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab3AMMts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:49:48 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39692 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab3AMMtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:49:47 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so1758011pad.25
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=q7azzUDyjHk0rf1hhMU2wPGjEkwUTzlKtzQsaFQJp9E=;
        b=ju/biolySj61s/w9go95qxknI5EErVooUsICiyzbglfJBQoetEu+C1D81vFr9oJyZ7
         itLCxsbh0mCSl9ULEEg3zsAQvHH5tgBe2awetMwP9MWLN4sclPFjTLrjra+ILIUiEXOI
         7z+yKDImmmealmtxYfGnPNG/yFDZZS1etr/wLIg2rDSR9eQvqLnvwlJWND4SSjOtGUGQ
         KM+Ln0DU1m5U6OXYg4JvJlimedXynS7hllOv7o2xjj5sqYh1GAVwFO9WvH/hYPoQSMdg
         eE5+bUMJugKIW8nKISyRYh2zopEkVO8kvHSyMTlFR8p2BwSE9KLKp9p/x5yzNjNuMxjv
         KEVQ==
X-Received: by 10.68.197.71 with SMTP id is7mr245013998pbc.79.1358081387218;
        Sun, 13 Jan 2013 04:49:47 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id th10sm3354544pbc.76.2013.01.13.04.49.44
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:49:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:50:01 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213375>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c                  |  4 +++-
 builtin/add.c              |  8 +++++---
 builtin/checkout.c         |  4 +++-
 builtin/clean.c            |  4 +++-
 builtin/commit.c           |  6 ++++--
 builtin/diff.c             |  2 +-
 builtin/grep.c             |  4 +++-
 builtin/ls-files.c         |  3 ++-
 builtin/ls-tree.c          |  4 +++-
 builtin/rerere.c           |  4 +++-
 builtin/reset.c            |  4 +++-
 builtin/rm.c               |  4 +++-
 builtin/update-index.c     |  4 +++-
 cache.h                    |  1 +
 dir.c                      |  6 +++---
 revision.c                 |  5 +++--
 setup.c                    |  7 ++++---
 t/t6130-pathspec-noglob.sh | 18 ++++++++++++++++++
 tree-diff.c                |  2 +-
 tree-walk.c                |  2 +-
 20 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/archive.c b/archive.c
index d9da58b..d3b6969 100644
--- a/archive.c
+++ b/archive.c
@@ -234,7 +234,9 @@ static void parse_pathspec_arg(const char **pathspe=
c,
 	 * mark "used" pathspec. The magic mask cannot be lifted until
 	 * it does.
 	 */
-	parse_pathspec(&ar_args->pathspec, PATHSPEC_FROMTOP, 0, "", pathspec)=
;
+	parse_pathspec(&ar_args->pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       0, "", pathspec);
 	if (ar_args->pathspec.nr) {
 		pathspec =3D ar_args->pathspec._raw;
 		while (*pathspec) {
diff --git a/builtin/add.c b/builtin/add.c
index a7840c8..d09a07a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -202,7 +202,8 @@ int interactive_add(int argc, const char **argv, co=
nst char *prefix, int patch)
 	 * Do not enable fancy magic here.  git-add--interactive may
 	 * not be able to handle it.
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
 		       PATHSPEC_EMPTY_MATCH_ALL |
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
@@ -377,7 +378,8 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE,
 		       prefix, argv);
@@ -414,7 +416,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		/*
 		 * file_exists() assumes exact match
 		 */
-		GUARD_PATHSPEC(&pathspec, PATHSPEC_FROMTOP);
+		GUARD_PATHSPEC(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1b413e2..90f4a01 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1112,7 +1112,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		 * cannot handle. Magic mask is pretty safe to be
 		 * lifted for new magic when opts.patch_mode =3D=3D 0.
 		 */
-		parse_pathspec(&opts.pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
+		parse_pathspec(&opts.pathspec,
+			       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+			       0, prefix, argv);
=20
 		if (!opts.pathspec.nr)
 			die(_("invalid path specification"));
diff --git a/builtin/clean.c b/builtin/clean.c
index 1d8ff5f..b4ffa2b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -100,7 +100,9 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 		add_exclude(exclude_list.items[i].string, "", 0,
 			    &dir.exclude_list[EXC_CMDL]);
=20
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       0, prefix, argv);
=20
 	fill_directory(&dir, &pathspec);
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index 2011f98..433fdb9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -281,7 +281,8 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
=20
 	if (is_status)
 		refresh_flags |=3D REFRESH_UNMERGED;
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
 		       PATHSPEC_EMPTY_MATCH_ALL,
 		       prefix, argv);
=20
@@ -1203,7 +1204,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
 		s.show_ignored_files =3D 1;
-	parse_pathspec(&s.pathspec, PATHSPEC_FROMTOP,
+	parse_pathspec(&s.pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
 		       PATHSPEC_EMPTY_MATCH_ALL,
 		       prefix, argv);
=20
diff --git a/builtin/diff.c b/builtin/diff.c
index 6b4e3f9..b78435f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -372,7 +372,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	}
 	if (rev.prune_data.nr) {
 		/* builtin_diff_b_f() */
-		GUARD_PATHSPEC(&rev.prune_data, PATHSPEC_FROMTOP);
+		GUARD_PATHSPEC(&rev.prune_data, PATHSPEC_FROMTOP | PATHSPEC_LITERAL)=
;
 		if (!path)
 			path =3D rev.prune_data.items[0].match;
 		paths +=3D rev.prune_data.nr;
diff --git a/builtin/grep.c b/builtin/grep.c
index f370bad..4d8e82c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -856,7 +856,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			verify_filename(prefix, argv[j], j =3D=3D i);
 	}
=20
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv + i);
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       0, prefix, argv + i);
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e3ccf50..1cbd211 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -535,7 +535,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 58899a5..4764683 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -172,7 +172,9 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec_depth() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv + 1);
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       0, prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len =3D pathspec.items[i].len;
 	pathspec.has_wildcard =3D 0;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index a573c4a..779fc77 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -71,7 +71,9 @@ int cmd_rerere(int argc, const char **argv, const cha=
r *prefix)
 		struct pathspec pathspec;
 		if (argc < 2)
 			warning("'git rerere forget' without paths is deprecated");
-		parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv + 1);
+		parse_pathspec(&pathspec,
+			       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+			       0, prefix, argv + 1);
 		return rerere_forget(&pathspec);
 	}
=20
diff --git a/builtin/reset.c b/builtin/reset.c
index 0185bb0..69ce164 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -183,7 +183,9 @@ static int read_from_tree(const char *prefix, const=
 char **argv,
 	struct diff_options opt;
=20
 	memset(&opt, 0, sizeof(opt));
-	parse_pathspec(&opt.pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
+	parse_pathspec(&opt.pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       0, prefix, argv);
 	opt.output_format =3D DIFF_FORMAT_CALLBACK;
 	opt.format_callback =3D update_index_from_diff;
 	opt.format_callback_data =3D &index_was_discarded;
diff --git a/builtin/rm.c b/builtin/rm.c
index b2a99c2..d46f1aa 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -249,7 +249,9 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 		}
 	}
=20
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       0, prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
=20
 	seen =3D NULL;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6728e59..1dd6178 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -548,7 +548,9 @@ static int do_reupdate(int ac, const char **av,
 	int has_head =3D 1;
 	struct pathspec pathspec;
=20
-	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, av + 1);
+	parse_pathspec(&pathspec,
+		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       0, prefix, av + 1);
=20
 	if (read_ref("HEAD", head_sha1))
 		/* If there is no HEAD, that means it is an initial
diff --git a/cache.h b/cache.h
index f3de28d..900b81a 100644
--- a/cache.h
+++ b/cache.h
@@ -478,6 +478,7 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
=20
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP    (1<<0)
+#define PATHSPEC_LITERAL    (1<<1)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
diff --git a/dir.c b/dir.c
index efc676c..63d07cd 100644
--- a/dir.c
+++ b/dir.c
@@ -64,7 +64,7 @@ static size_t common_prefix_len(const struct pathspec=
 *pathspec)
 	int n;
 	size_t max =3D 0;
=20
-	GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP);
+	GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
=20
 	for (n =3D 0; n < pathspec->nr; n++) {
 		size_t i =3D 0, len =3D 0;
@@ -181,7 +181,7 @@ int match_pathspec_depth(const struct pathspec *ps,
 {
 	int i, retval =3D 0;
=20
-	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP);
+	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
@@ -1230,7 +1230,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 	 * Check out create_simplify()
 	 */
 	if (pathspec)
-		GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP);
+		GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
diff --git a/revision.c b/revision.c
index 231f53b..079955f 100644
--- a/revision.c
+++ b/revision.c
@@ -1851,8 +1851,9 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 		 */
 		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] =3D NULL;
-		parse_pathspec(&revs->prune_data, PATHSPEC_FROMTOP, 0,
-			       revs->prefix, prune_data.path);
+		parse_pathspec(&revs->prune_data,
+			       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+			       0, revs->prefix, prune_data.path);
 	}
=20
 	if (revs->def =3D=3D NULL)
diff --git a/setup.c b/setup.c
index c5e97c9..6b48f1b 100644
--- a/setup.c
+++ b/setup.c
@@ -157,7 +157,6 @@ void verify_non_filename(const char *prefix, const =
char *arg)
  *
  * Possible future magic semantics include stuff like:
  *
- *	{ PATHSPEC_NOGLOB, '!', "noglob" },
  *	{ PATHSPEC_ICASE, '\0', "icase" },
  *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
  *	{ PATHSPEC_REGEXP, '\0', "regexp" },
@@ -170,6 +169,7 @@ static struct pathspec_magic {
 	const char *name;
 } pathspec_magic[] =3D {
 	{ PATHSPEC_FROMTOP, '/', "top" },
+	{ PATHSPEC_LITERAL,   0, "literal" },
 };
=20
 /*
@@ -303,7 +303,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 		}
=20
 	item->flags =3D 0;
-	if (limit_pathspec_to_literal())
+	if (limit_pathspec_to_literal() || (magic & PATHSPEC_LITERAL))
 		item->nowildcard_len =3D item->len;
 	else {
 		item->nowildcard_len =3D simple_length(item->match);
@@ -397,7 +397,8 @@ void parse_pathspec(struct pathspec *pathspec,
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	struct pathspec ps;
-	parse_pathspec(&ps, PATHSPEC_FROMTOP, 0, prefix, pathspec);
+	parse_pathspec(&ps, PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       0, prefix, pathspec);
 	return ps._raw;
 }
=20
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index 39ef619..49c148e 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -47,18 +47,36 @@ test_expect_success 'no-glob option matches literal=
ly (vanilla)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'no-glob option matches literally (vanilla)' '
+	echo vanilla >expect &&
+	git log --format=3D%s -- ":(literal)foo" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no-glob option matches literally (star)' '
 	echo star >expect &&
 	git --literal-pathspecs log --format=3D%s -- "f*" >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success 'no-glob option matches literally (star)' '
+	echo star >expect &&
+	git log --format=3D%s -- ":(literal)f*" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no-glob option matches literally (bracket)' '
 	echo bracket >expect &&
 	git --literal-pathspecs log --format=3D%s -- "f[o][o]" >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success 'no-glob option matches literally (bracket)' '
+	echo bracket >expect &&
+	git log --format=3D%s -- ":(literal)f[o][o]" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no-glob environment variable works' '
 	echo star >expect &&
 	GIT_LITERAL_PATHSPECS=3D1 git log --format=3D%s -- "f*" >actual &&
diff --git a/tree-diff.c b/tree-diff.c
index 718f938..0e2e138 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -203,7 +203,7 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	 * path. Magic that matches more than one path is not
 	 * supported.
 	 */
-	GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP);
+	GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
 #if 0
 	/*
 	 * We should reject wildcards as well. Unfortunately we
diff --git a/tree-walk.c b/tree-walk.c
index dd03750..d4ed51f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -635,7 +635,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 	enum interesting never_interesting =3D ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
=20
-	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP);
+	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
--=20
1.8.0.rc2.23.g1fb49df
