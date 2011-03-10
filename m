From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] revision.c: get rid of struct rev_info.prune_data
Date: Thu, 10 Mar 2011 10:13:37 +0700
Message-ID: <1299726819-5576-4-git-send-email-pclouds@gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 04:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxWLU-0008T7-38
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 04:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab1CJDPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 22:15:18 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41493 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab1CJDPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 22:15:17 -0500
Received: by mail-yw0-f46.google.com with SMTP id 3so484792ywj.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 19:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=7ystcJhRAH/JykFxum4CbjpO2tiDUkLg68GO+A1uzKE=;
        b=qOp4BbxdlVuSmFFOuMYfArfvIySrsxOAeaktwKQmUNLLQYYkCc0MXBcYfHdQKm2v8Y
         FVjX+Nde6yC0UCNCfwsQL2sXt4G5u1iLWbcrVTJbf1hOoiGQscHBQdPGzEWlFtUFXK2C
         1FROyWDUP7OAPBX7tbDTZDKwvMb0eLBEMDJ0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ahzer2rzcCF+Pm+OwC6YENBry5z7tWMxEI2JTI8rtkNOpF41VDkXrW87jONjngQfeQ
         6JEGa2O5B51SJgGcOmYSVq4UWDBnApqnnA8O52+v5XUpR6hpualBGBASocPgZYCWxLM9
         Wk+c/HkednUVrZPgidLZCb4VOqfNc5GMOpjqY=
Received: by 10.236.114.193 with SMTP id c41mr165746yhh.252.1299726915946;
        Wed, 09 Mar 2011 19:15:15 -0800 (PST)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id m25sm1774920yhm.31.2011.03.09.19.15.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 19:15:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 Mar 2011 10:14:12 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168782>

There are three struct pathspec(s) in struct rev_info:

 - prune_data
 - pruning.pathspec
 - diffopt.pathspec

In some places, this pathspec is used, in other places another
one. I'd like to have only one pathspec in struct rev_info, but i'm
not sure why diffopt can't be used in place of pruning. So in the
meantime, prune_data will be gone.

The driving force behind this is now diff_options.pathspec can be
manipulated behind the scene by diff_setup_done() to support
--exclude. Rev machinery does not know about this and does not need
to. Remove prune_data in favor of diffopt.pathspec, handing complex
pathspec manipulation to diff machinery.

As part of the changes, setup_revisions() now can take pathspecs
directly by setting argc =3D 0, argv =3D pathspec

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c         |    3 +--
 builtin/diff.c        |    6 +++---
 builtin/fast-export.c |    2 +-
 diff-lib.c            |    6 +++---
 revision.c            |   20 +++++++++++---------
 revision.h            |    1 -
 wt-status.c           |    6 ++----
 7 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f7a17e4..904db6b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -85,8 +85,7 @@ int add_files_to_cache(const char *prefix, const char=
 **pathspec, int flags)
 	struct update_callback_data data;
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
-	init_pathspec(&rev.prune_data, pathspec);
+	setup_revisions(0, pathspec, &rev, NULL);
 	rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D update_callback;
 	data.flags =3D flags;
diff --git a/builtin/diff.c b/builtin/diff.c
index 4c9deb2..1c69da2 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -374,10 +374,10 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
 		}
 		die("unhandled object '%s' given.", name);
 	}
-	if (rev.prune_data.nr) {
+	if (rev.diffopt.pathspec.nr) {
 		if (!path)
-			path =3D rev.prune_data.items[0].match;
-		paths +=3D rev.prune_data.nr;
+			path =3D rev.diffopt.pathspec.items[0].match;
+		paths +=3D rev.diffopt.pathspec.nr;
 	}
=20
 	/*
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index daf1945..b225427 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -651,7 +651,7 @@ int cmd_fast_export(int argc, const char **argv, co=
nst char *prefix)
 	if (import_filename)
 		import_marks(import_filename);
=20
-	if (import_filename && revs.prune_data.nr)
+	if (import_filename && revs.diffopt.pathspec.nr)
 		full_tree =3D 1;
=20
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
diff --git a/diff-lib.c b/diff-lib.c
index 1e22992..b3ac269 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -106,7 +106,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
=20
-		if (!ce_path_match(ce, &revs->prune_data))
+		if (!ce_path_match(ce, &revs->diffopt.pathspec))
 			continue;
=20
 		if (ce_stage(ce)) {
@@ -427,7 +427,7 @@ static int oneway_diff(struct cache_entry **src, st=
ruct unpack_trees_options *o)
 	if (tree =3D=3D o->df_conflict_entry)
 		tree =3D NULL;
=20
-	if (ce_path_match(idx ? idx : tree, &revs->prune_data))
+	if (ce_path_match(idx ? idx : tree, &revs->diffopt.pathspec))
 		do_oneway_diff(o, idx, tree);
=20
 	return 0;
@@ -501,7 +501,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
 	active_nr =3D dst - active_cache;
=20
 	init_revisions(&revs, NULL);
-	init_pathspec(&revs.prune_data, opt->pathspec.raw);
+	init_pathspec(&revs.diffopt.pathspec, opt->pathspec.raw);
 	tree =3D parse_tree_indirect(tree_sha1);
 	if (!tree)
 		die("bad tree object %s", sha1_to_hex(tree_sha1));
diff --git a/revision.c b/revision.c
index 86d2470..f9f66de 100644
--- a/revision.c
+++ b/revision.c
@@ -323,7 +323,7 @@ static int rev_compare_tree(struct rev_info *revs, =
struct commit *parent, struct
 		 * tagged commit by specifying both --simplify-by-decoration
 		 * and pathspec.
 		 */
-		if (!revs->prune_data.nr)
+		if (!revs->diffopt.pathspec.nr)
 			return REV_TREE_SAME;
 	}
=20
@@ -969,7 +969,7 @@ static void prepare_show_merge(struct rev_info *rev=
s)
 		struct cache_entry *ce =3D active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		if (ce_path_match(ce, &revs->prune_data)) {
+		if (ce_path_match(ce, &revs->diffopt.pathspec)) {
 			prune_num++;
 			prune =3D xrealloc(prune, sizeof(*prune) * prune_num);
 			prune[prune_num-2] =3D ce->name;
@@ -979,8 +979,8 @@ static void prepare_show_merge(struct rev_info *rev=
s)
 		       ce_same_name(ce, active_cache[i+1]))
 			i++;
 	}
-	free_pathspec(&revs->prune_data);
-	init_pathspec(&revs->prune_data, prune);
+	free_pathspec(&revs->diffopt.pathspec);
+	init_pathspec(&revs->diffopt.pathspec, prune);
 	revs->limited =3D 1;
 }
=20
@@ -1488,6 +1488,10 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
 	if (opt)
 		submodule =3D opt->submodule;
=20
+	/* argv is a list of pathspec */
+	if (!argc && argv)
+		prune_data =3D argv;
+
 	/* First, search for "--" */
 	seen_dashdash =3D 0;
 	for (i =3D 1; i < argc; i++) {
@@ -1617,7 +1621,7 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 	}
=20
 	if (prune_data)
-		init_pathspec(&revs->prune_data, get_pathspec(revs->prefix, prune_da=
ta));
+		init_pathspec(&revs->diffopt.pathspec, get_pathspec(revs->prefix, pr=
une_data));
=20
 	if (revs->def =3D=3D NULL)
 		revs->def =3D opt ? opt->def : NULL;
@@ -1648,19 +1652,17 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, struct s
 	if (revs->topo_order)
 		revs->limited =3D 1;
=20
-	if (revs->prune_data.nr) {
-		diff_tree_setup_paths(revs->prune_data.raw, &revs->pruning);
+	if (revs->diffopt.pathspec.nr) {
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 			revs->prune =3D 1;
-		if (!revs->full_diff)
-			diff_tree_setup_paths(revs->prune_data.raw, &revs->diffopt);
 	}
 	if (revs->combine_merges)
 		revs->ignore_merges =3D 0;
 	revs->diffopt.abbrev =3D revs->abbrev;
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
+	diff_tree_setup_paths(revs->diffopt.pathspec.raw, &revs->pruning);
=20
 	compile_grep_patterns(&revs->grep_filter);
=20
diff --git a/revision.h b/revision.h
index 82509dd..066e407 100644
--- a/revision.h
+++ b/revision.h
@@ -34,7 +34,6 @@ struct rev_info {
 	/* Basic information */
 	const char *prefix;
 	const char *def;
-	struct pathspec prune_data;
 	unsigned int early_output;
=20
 	/* Traversal flags */
diff --git a/wt-status.c b/wt-status.c
index a82b11d..7c4171e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -312,7 +312,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 	struct rev_info rev;
=20
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, NULL);
+	setup_revisions(0, s->pathspec, &rev, NULL);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
 	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
 	if (!s->show_untracked_files)
@@ -323,7 +323,6 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
     }
 	rev.diffopt.format_callback =3D wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
-	init_pathspec(&rev.prune_data, s->pathspec);
 	run_diff_files(&rev, 0);
 }
=20
@@ -335,7 +334,7 @@ static void wt_status_collect_changes_index(struct =
wt_status *s)
 	init_revisions(&rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def =3D s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
-	setup_revisions(0, NULL, &rev, &opt);
+	setup_revisions(0, s->pathspec, &rev, &opt);
=20
 	if (s->ignore_submodule_arg) {
 		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
@@ -348,7 +347,6 @@ static void wt_status_collect_changes_index(struct =
wt_status *s)
 	rev.diffopt.detect_rename =3D 1;
 	rev.diffopt.rename_limit =3D 200;
 	rev.diffopt.break_opt =3D 0;
-	init_pathspec(&rev.prune_data, s->pathspec);
 	run_diff_index(&rev, 1);
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
