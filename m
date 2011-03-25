From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] Convert read_tree{,_recursive} to support struct pathspec
Date: Fri, 25 Mar 2011 16:34:19 +0700
Message-ID: <1301045660-25053-2-git-send-email-pclouds@gmail.com>
References: <7vlj048f97.fsf@alter.siamese.dyndns.org>
 <1301045660-25053-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:34:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q33Px-0004G3-F9
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934012Ab1CYJes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 05:34:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43814 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934062Ab1CYJeq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 05:34:46 -0400
Received: by pvg12 with SMTP id 12so122900pvg.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Up/bwAZNSisegM3fxyeeBMna57LQQiLbsLxi+CrXwNU=;
        b=MzcMJHGaPXUZXoXhkvWZxIrA2KU+HYLN0jD72zh9P3lSpJ002VER77Nz/pttJKPGrG
         kztxsEOOv3AW33Xdaw7GWDokRUmWnltTS9B5dsaXSZdCqAlRqOiO1ys5Rl8ziWjI9vmd
         mz+nvOEs9h4lmZ+KQh0ZnzTBZtrUDEJ3e5mx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iThRms6oMGBmQqlJtAJkawU6TPimBqOWc5tzuiHuEY+8/5IwCXcFvAhY4eOPyFes/N
         bnLkcZ+uA9r4aiJUYSNt0M/euCDRxqwiMM49dyhzUnZfcvfOAvaFBuIyrK5XHdCNxCv8
         UJRPdCNypg4Jc0LjiRqVi0lQrpPr/NIUin680=
Received: by 10.142.52.8 with SMTP id z8mr480794wfz.401.1301045685496;
        Fri, 25 Mar 2011 02:34:45 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id w11sm1090549wfh.6.2011.03.25.02.34.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 02:34:44 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 25 Mar 2011 16:34:34 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1301045660-25053-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169971>

This patch changes behavior of the two functions. Previously it does
prefix matching only. Now it can also do wildcard matching.

All callers are updated. Some gain wildcard matching (archive,
checkout), others reset pathspec_item.has_wildcard to retain old
behavior (ls-files, ls-tree as they are plumbing).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c                    |   18 ++++++++++++------
 builtin/checkout.c           |    5 ++++-
 builtin/log.c                |    4 +++-
 builtin/ls-files.c           |    9 +++++----
 builtin/ls-tree.c            |   12 +++++++-----
 merge-recursive.c            |    4 +++-
 t/t3102-ls-tree-wildcards.sh |   22 ++++++++++++++++++++++
 tree.c                       |   13 ++++---------
 tree.h                       |    4 ++--
 9 files changed, 62 insertions(+), 29 deletions(-)
 create mode 100755 t/t3102-ls-tree-wildcards.sh

diff --git a/archive.c b/archive.c
index 1944ed4..42f2d2f 100644
--- a/archive.c
+++ b/archive.c
@@ -157,6 +157,7 @@ int write_archive_entries(struct archiver_args *arg=
s,
 	struct archiver_context context;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
+	struct pathspec pathspec;
 	int err;
=20
 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
@@ -191,8 +192,10 @@ int write_archive_entries(struct archiver_args *ar=
gs,
 		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
 	}
=20
-	err =3D read_tree_recursive(args->tree, "", 0, 0, args->pathspec,
+	init_pathspec(&pathspec, args->pathspec);
+	err =3D read_tree_recursive(args->tree, "", 0, 0, &pathspec,
 				  write_archive_entry, &context);
+	free_pathspec(&pathspec);
 	if (err =3D=3D READ_TREE_RECURSIVE)
 		err =3D 0;
 	return err;
@@ -221,11 +224,14 @@ static int reject_entry(const unsigned char *sha1=
, const char *base,
=20
 static int path_exists(struct tree *tree, const char *path)
 {
-	const char *pathspec[] =3D { path, NULL };
-
-	if (read_tree_recursive(tree, "", 0, 0, pathspec, reject_entry, NULL)=
)
-		return 1;
-	return 0;
+	const char *paths[] =3D { path, NULL };
+	struct pathspec pathspec;
+	int ret;
+
+	init_pathspec(&pathspec, paths);
+	ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry, =
NULL);
+	free_pathspec(&pathspec);
+	return ret !=3D 0;
 }
=20
 static void parse_pathspec_arg(const char **pathspec,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2bf02f2..dc3eedf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -79,7 +79,10 @@ static int update_some(const unsigned char *sha1, co=
nst char *base, int baselen,
=20
 static int read_tree_some(struct tree *tree, const char **pathspec)
 {
-	read_tree_recursive(tree, "", 0, 0, pathspec, update_some, NULL);
+	struct pathspec ps;
+	init_pathspec(&ps, pathspec);
+	read_tree_recursive(tree, "", 0, 0, &ps, update_some, NULL);
+	free_pathspec(&ps);
=20
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
diff --git a/builtin/log.c b/builtin/log.c
index 796e9e5..cff39cf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -396,6 +396,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 	struct rev_info rev;
 	struct object_array_entry *objects;
 	struct setup_revision_opt opt;
+	struct pathspec match_all;
 	int i, count, ret =3D 0;
=20
 	git_config(git_log_config, NULL);
@@ -403,6 +404,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 	if (diff_use_color_default =3D=3D -1)
 		diff_use_color_default =3D git_use_color_default;
=20
+	init_pathspec(&match_all, NULL);
 	init_revisions(&rev, prefix);
 	rev.diff =3D 1;
 	rev.always_show_header =3D 1;
@@ -449,7 +451,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			read_tree_recursive((struct tree *)o, "", 0, 0, NULL,
+			read_tree_recursive((struct tree *)o, "", 0, 0, &match_all,
 					show_tree_object, NULL);
 			rev.shown_one =3D 1;
 			break;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index fb2d5f4..199af46 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -338,7 +338,7 @@ void overlay_tree_on_cache(const char *tree_name, c=
onst char *prefix)
 {
 	struct tree *tree;
 	unsigned char sha1[20];
-	const char **match;
+	struct pathspec pathspec;
 	struct cache_entry *last_stage0 =3D NULL;
 	int i;
=20
@@ -360,10 +360,11 @@ void overlay_tree_on_cache(const char *tree_name,=
 const char *prefix)
 		static const char *(matchbuf[2]);
 		matchbuf[0] =3D prefix;
 		matchbuf[1] =3D NULL;
-		match =3D matchbuf;
+		init_pathspec(&pathspec, matchbuf);
+		pathspec.items[0].has_wildcard =3D 0;
 	} else
-		match =3D NULL;
-	if (read_tree(tree, 1, match))
+		init_pathspec(&pathspec, NULL);
+	if (read_tree(tree, 1, &pathspec))
 		die("unable to read tree entries %s", tree_name);
=20
 	for (i =3D 0; i < active_nr; i++) {
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f73e6bd..4290723 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -19,7 +19,7 @@ static int line_termination =3D '\n';
 #define LS_SHOW_SIZE 16
 static int abbrev;
 static int ls_options;
-static const char **pathspec;
+static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
=20
@@ -35,7 +35,7 @@ static int show_recursive(const char *base, int basel=
en, const char *pathname)
 	if (ls_options & LS_RECURSIVE)
 		return 1;
=20
-	s =3D pathspec;
+	s =3D pathspec.raw;
 	if (!s)
 		return 0;
=20
@@ -120,7 +120,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 {
 	unsigned char sha1[20];
 	struct tree *tree;
-	int full_tree =3D 0;
+	int i, full_tree =3D 0;
 	const struct option ls_tree_options[] =3D {
 		OPT_BIT('d', NULL, &ls_options, "only show trees",
 			LS_TREE_ONLY),
@@ -166,11 +166,13 @@ int cmd_ls_tree(int argc, const char **argv, cons=
t char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
=20
-	pathspec =3D get_pathspec(prefix, argv + 1);
+	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
+	for (i =3D 0; i < pathspec.nr; i++)
+		pathspec.items[i].has_wildcard =3D 0;
 	tree =3D parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree, NULL);
+	read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
=20
 	return 0;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 8e82a8b..89887de 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -278,7 +278,9 @@ static int save_files_dirs(const unsigned char *sha=
1,
 static int get_files_dirs(struct merge_options *o, struct tree *tree)
 {
 	int n;
-	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs, o))
+	struct pathspec match_all;
+	init_pathspec(&match_all, NULL);
+	if (read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, =
o))
 		return 0;
 	n =3D o->current_file_set.nr + o->current_directory_set.nr;
 	return n;
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.s=
h
new file mode 100755
index 0000000..f2b2a52
--- /dev/null
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description=3D'ls-tree with(out) wildcards'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir a aa "a*" &&
+	touch a/one aa/two "a*/three" &&
+	git add a/one aa/two "a*/three" &&
+	git commit -m test
+'
+
+test_expect_success 'ls-tree a* matches literally' '
+	cat >expected <<EOF &&
+100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	a*/three
+EOF
+	git ls-tree -r HEAD "a*" >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/tree.c b/tree.c
index db3a5c3..698ecf7 100644
--- a/tree.c
+++ b/tree.c
@@ -114,20 +114,15 @@ static int read_tree_1(struct tree *tree, struct =
strbuf *base,
=20
 int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
-			int stage, const char **match,
+			int stage, struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb =3D STRBUF_INIT;
-	struct pathspec pathspec;
-	int i, ret;
+	int ret;
=20
-	init_pathspec(&pathspec, match);
-	for (i =3D 0; i < pathspec.nr; i++)
-		pathspec.items[i].has_wildcard =3D 0;
 	strbuf_add(&sb, base, baselen);
-	ret =3D read_tree_1(tree, &sb, stage, &pathspec, fn, context);
+	ret =3D read_tree_1(tree, &sb, stage, pathspec, fn, context);
 	strbuf_release(&sb);
-	free_pathspec(&pathspec);
 	return ret;
 }
=20
@@ -141,7 +136,7 @@ static int cmp_cache_name_compare(const void *a_, c=
onst void *b_)
 				  ce2->name, ce2->ce_flags);
 }
=20
-int read_tree(struct tree *tree, int stage, const char **match)
+int read_tree(struct tree *tree, int stage, struct pathspec *match)
 {
 	read_tree_fn_t fn =3D NULL;
 	int i, err;
diff --git a/tree.h b/tree.h
index 2ff01a4..69bcb5e 100644
--- a/tree.h
+++ b/tree.h
@@ -25,9 +25,9 @@ typedef int (*read_tree_fn_t)(const unsigned char *, =
const char *, int, const ch
=20
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
-			       int stage, const char **match,
+			       int stage, struct pathspec *pathspec,
 			       read_tree_fn_t fn, void *context);
=20
-extern int read_tree(struct tree *tree, int stage, const char **paths)=
;
+extern int read_tree(struct tree *tree, int stage, struct pathspec *pa=
thspec);
=20
 #endif /* TREE_H */
--=20
1.7.4.74.g639db
