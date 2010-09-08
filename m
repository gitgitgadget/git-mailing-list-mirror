From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] Introduce struct tree_pathspec_list
Date: Thu,  9 Sep 2010 01:50:17 +1000
Message-ID: <1283961023-4491-3-git-send-email-pclouds@gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:22:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXiy-0000En-Sc
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959Ab0IIDWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:22:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47382 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab0IIDWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:22:44 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so339297pwi.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PESIvGDSk0UwMtsJJV1bKMNgbuV5KRmFmE6Qa7T5jhk=;
        b=HJH5AiRy5ZIHMu5Jfx2mdHuASbLkgO/GeD1D5AfC96Y9eLrtvUZmS2r1SYuHjv8hQs
         Gqk7YsFuk/dX0bOKsQrwsEi+GfTdvr3Q9hojkBFLKkR3uU2jQRp6BkOK8yoPQL3ge0IA
         9AUcrjeJqAxAvTdX8KX6slz5MN7vDTtjVDSWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hWsEFrmJPcVd5SXMfTxJAHbXFMNA5BiYHh35IxSTdhOnLJ/KM9gCbxoCEs6XKztrLy
         /WEptZfh0OHQxpLzrisPIaFTO0Mt6r/rQt6Ig20xYm1H5nVyItz2a+zQMiTZZZKDFJZ+
         hlLJZkbNdH0qC3ZEiJbPr0nZVySAUoVLRm+gQ=
Received: by 10.142.203.12 with SMTP id a12mr254996wfg.19.1284002563856;
        Wed, 08 Sep 2010 20:22:43 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id s34sm820808wfc.20.2010.09.08.20.22.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:22:42 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:50:47 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155831>

This struct replaces paths, nr_paths and pathlens fields in struct
diff_options. Actually diff_options.paths is still kept, now as
tree_pathspec_list.paths because a lot of places depend on a
continuous list of pathspecs.

tree_entry_interesting() is going to be updated to use these instead.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff-files.c |    2 +-
 builtin/diff.c       |    4 ++--
 builtin/log.c        |    2 +-
 diff-lib.c           |    2 +-
 diff-no-index.c      |    4 ++--
 diff.h               |    4 +---
 revision.c           |    6 +-----
 tree-diff.c          |   46 +++++++++++-------------------------------=
----
 tree-walk.c          |   28 ++++++++++++++++++++++++++++
 tree-walk.h          |   11 +++++++++++
 10 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 951c7c8..e740b77 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -61,7 +61,7 @@ int cmd_diff_files(int argc, const char **argv, const=
 char *prefix)
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		rev.combine_merges =3D rev.dense_combined_merges =3D 1;
=20
-	if (read_cache_preload(rev.diffopt.paths) < 0) {
+	if (read_cache_preload(rev.diffopt.pathspec.paths) < 0) {
 		perror("read_cache_preload");
 		return -1;
 	}
diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..4247377 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -135,7 +135,7 @@ static int builtin_diff_index(struct rev_info *revs=
,
 	    revs->max_count !=3D -1 || revs->min_age !=3D -1 ||
 	    revs->max_age !=3D -1)
 		usage(builtin_diff_usage);
-	if (read_cache_preload(revs->diffopt.paths) < 0) {
+	if (read_cache_preload(revs->diffopt.pathspec.paths) < 0) {
 		perror("read_cache_preload");
 		return -1;
 	}
@@ -237,7 +237,7 @@ static int builtin_diff_files(struct rev_info *revs=
, int argc, const char **argv
 		revs->combine_merges =3D revs->dense_combined_merges =3D 1;
=20
 	setup_work_tree();
-	if (read_cache_preload(revs->diffopt.paths) < 0) {
+	if (read_cache_preload(revs->diffopt.pathspec.paths) < 0) {
 		perror("read_cache_preload");
 		return -1;
 	}
diff --git a/builtin/log.c b/builtin/log.c
index 08b8722..d78744f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -89,7 +89,7 @@ static void cmd_log_init(int argc, const char **argv,=
 const char *prefix,
 		rev->always_show_header =3D 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
 		rev->always_show_header =3D 0;
-		if (rev->diffopt.nr_paths !=3D 1)
+		if (rev->diffopt.pathspec.nr !=3D 1)
 			usage("git logs can only follow renames on one pathname at a time")=
;
 	}
 	for (i =3D 1; i < argc; i++) {
diff --git a/diff-lib.c b/diff-lib.c
index 392ce2b..0107e23 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -501,7 +501,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
 	active_nr =3D dst - active_cache;
=20
 	init_revisions(&revs, NULL);
-	revs.prune_data =3D opt->paths;
+	revs.prune_data =3D opt->pathspec.paths;
 	tree =3D parse_tree_indirect(tree_sha1);
 	if (!tree)
 		die("bad tree object %s", sha1_to_hex(tree_sha1));
diff --git a/diff-no-index.c b/diff-no-index.c
index e48ab92..832d692 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -260,8 +260,8 @@ void diff_no_index(struct rev_info *revs,
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
=20
-	if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
-		       revs->diffopt.paths[1]))
+	if (queue_diff(&revs->diffopt, revs->diffopt.pathspec.paths[0],
+		       revs->diffopt.pathspec.paths[1]))
 		exit(1);
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
diff --git a/diff.h b/diff.h
index bf2f44d..aaa2983 100644
--- a/diff.h
+++ b/diff.h
@@ -133,9 +133,7 @@ struct diff_options {
 	FILE *file;
 	int close_file;
=20
-	int nr_paths;
-	const char **paths;
-	int *pathlens;
+	struct tree_pathspec_list pathspec;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
diff --git a/revision.c b/revision.c
index b1c1890..b2a5867 100644
--- a/revision.c
+++ b/revision.c
@@ -553,11 +553,7 @@ static void cherry_pick_list(struct commit_list *l=
ist, struct rev_info *revs)
=20
 	left_first =3D left_count < right_count;
 	init_patch_ids(&ids);
-	if (revs->diffopt.nr_paths) {
-		ids.diffopts.nr_paths =3D revs->diffopt.nr_paths;
-		ids.diffopts.paths =3D revs->diffopt.paths;
-		ids.diffopts.pathlens =3D revs->diffopt.pathlens;
-	}
+	ids.diffopts.pathspec =3D revs->diffopt.pathspec;
=20
 	/* Compute patch-ids for one side */
 	for (p =3D list; p; p =3D p->next) {
diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..270dea0 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -100,16 +100,16 @@ static int tree_entry_interesting(struct tree_des=
c *desc, const char *base, int
 	int pathlen;
 	int never_interesting =3D -1;
=20
-	if (!opt->nr_paths)
+	if (!opt->pathspec.nr)
 		return 1;
=20
 	sha1 =3D tree_entry_extract(desc, &path, &mode);
=20
 	pathlen =3D tree_entry_len(path, sha1);
=20
-	for (i =3D 0; i < opt->nr_paths; i++) {
-		const char *match =3D opt->paths[i];
-		int matchlen =3D opt->pathlens[i];
+	for (i =3D 0; i < opt->pathspec.nr; i++) {
+		const char *match =3D opt->pathspec.paths[i];
+		int matchlen =3D opt->pathspec.info[i].pathlen;
 		int m =3D -1; /* signals that we haven't called strncmp() */
=20
 		if (baselen >=3D matchlen) {
@@ -289,7 +289,7 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2, const char *base, stru
 		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
-		if (opt->nr_paths) {
+		if (opt->pathspec.nr) {
 			skip_uninteresting(t1, base, baselen, opt);
 			skip_uninteresting(t2, base, baselen, opt);
 		}
@@ -348,7 +348,7 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow =3D opt->paths[0];
+	diff_opts.single_follow =3D opt->pathspec.paths[0];
 	diff_opts.break_opt =3D opt->break_opt;
 	paths[0] =3D NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
@@ -368,15 +368,15 @@ static void try_to_follow_renames(struct tree_des=
c *t1, struct tree_desc *t2, co
 		 * diff_queued_diff, we will also use that as the path in
 		 * the future!
 		 */
-		if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') && !strcmp(p->two=
->path, opt->paths[0])) {
+		if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') && !strcmp(p->two=
->path, opt->pathspec.paths[0])) {
 			/* Switch the file-pairs around */
 			q->queue[i] =3D choice;
 			choice =3D p;
=20
 			/* Update the path we use from now on.. */
 			diff_tree_release_paths(opt);
-			opt->paths[0] =3D xstrdup(p->one->path);
-			diff_tree_setup_paths(opt->paths, opt);
+			opt->pathspec.paths[0] =3D xstrdup(p->one->path);
+			diff_tree_setup_paths(opt->pathspec.paths, opt);
=20
 			/*
 			 * The caller expects us to return a set of vanilla
@@ -451,36 +451,12 @@ int diff_root_tree_sha1(const unsigned char *new,=
 const char *base, struct diff_
 	return retval;
 }
=20
-static int count_paths(const char **paths)
-{
-	int i =3D 0;
-	while (*paths++)
-		i++;
-	return i;
-}
-
 void diff_tree_release_paths(struct diff_options *opt)
 {
-	free(opt->pathlens);
+	free(opt->pathspec.info);
 }
=20
 void diff_tree_setup_paths(const char **p, struct diff_options *opt)
 {
-	opt->nr_paths =3D 0;
-	opt->pathlens =3D NULL;
-	opt->paths =3D NULL;
-
-	if (p) {
-		int i;
-
-		opt->paths =3D p;
-		opt->nr_paths =3D count_paths(p);
-		if (opt->nr_paths =3D=3D 0) {
-			opt->pathlens =3D NULL;
-			return;
-		}
-		opt->pathlens =3D xmalloc(opt->nr_paths * sizeof(int));
-		for (i=3D0; i < opt->nr_paths; i++)
-			opt->pathlens[i] =3D strlen(p[i]);
-	}
+	setup_tree_pathspec(p, &opt->pathspec);
 }
diff --git a/tree-walk.c b/tree-walk.c
index a9bbf4e..30c2aa1 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -455,3 +455,31 @@ int get_tree_entry(const unsigned char *tree_sha1,=
 const char *name, unsigned ch
 	free(tree);
 	return retval;
 }
+
+static int count_paths(const char **paths)
+{
+	int i =3D 0;
+	while (*paths++)
+		i++;
+	return i;
+}
+
+int setup_tree_pathspec(const char **paths, struct tree_pathspec_list =
*ps)
+{
+	int i;
+
+	memset(ps, 0, sizeof(*ps));
+	ps->nr =3D count_paths(paths);
+	if (!ps->nr)
+		return 0;
+
+	ps->paths =3D paths;
+	ps->info =3D xmalloc(ps->nr * sizeof(struct tree_pathspec));
+	memset(ps->info, 0, ps->nr * sizeof(struct tree_pathspec));
+	for (i=3D0; i < ps->nr; i++) {
+		struct tree_pathspec *exc =3D ps->info+i;
+		exc->path =3D ps->paths[i];
+		exc->pathlen =3D strlen(exc->path);
+	}
+	return 0;
+}
diff --git a/tree-walk.h b/tree-walk.h
index 88ea7e9..2d09b7c 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -13,6 +13,15 @@ struct tree_desc {
 	unsigned int size;
 };
=20
+struct tree_pathspec_list {
+	const char **paths;
+	int nr;
+	struct tree_pathspec {
+		const char *path;
+		int pathlen;
+	} *info;
+};
+
 static inline const unsigned char *tree_entry_extract(struct tree_desc=
 *desc, const char **pathp, unsigned int *modep)
 {
 	*pathp =3D desc->entry.path;
@@ -57,4 +66,6 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
+extern int setup_tree_pathspec(const char **paths, struct tree_pathspe=
c_list *ps);
+
 #endif
--=20
1.7.1.rc1.70.g13aff
