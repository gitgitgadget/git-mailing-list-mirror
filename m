From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] diff: refactor init/release API
Date: Thu, 10 Mar 2011 10:13:38 +0700
Message-ID: <1299726819-5576-5-git-send-email-pclouds@gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 04:15:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxWLf-0008Vg-Bm
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 04:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab1CJDPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 22:15:30 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41493 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab1CJDP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 22:15:29 -0500
Received: by mail-yw0-f46.google.com with SMTP id 3so484792ywj.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 19:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=gGchKXdxbfDKogoDDV59kWyHVXeT3xRBQNSnp+KK22s=;
        b=yFoPdpPfX96Ofvw2EoqXT7i+LAblc+HhxfTi5KZYKuOF2wpt/GmeSKKLXfReJiAw/1
         oA3xTkOAlsRkU9YQqbIMb/R+cS9ly/xO7noLIMZCMshg9dPpGUwwmVfGgkISvY1D+ZAN
         hc/yaddWgUg92oMwKAEgxlpnjMFNZ1XrktEmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=w0XW+WMPI3xVp9MyCLeiAPRBhglbl5yuutgKa1sshlFhoKaPx9QHgCO4jT5Mo5mQTX
         wYsHM55AzCjiowbL0h1TOiSD/5IWZQlV2gOfOFUy59xqxKIeT0Kj/zEIvyV/FLQ89mAg
         qZjmX7RroQq5qx/lQmvDhFPppVxnCiwTfmWrM=
Received: by 10.236.190.229 with SMTP id e65mr668374yhn.127.1299726929029;
        Wed, 09 Mar 2011 19:15:29 -0800 (PST)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id i10sm1796428yhd.10.2011.03.09.19.15.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 19:15:27 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 Mar 2011 10:14:23 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168783>

This patch:

 - renames diff_setup() to init_diff()
 - gets rid of diff_tree_setup_paths()
 - renames diff_tree_release_paths() to release_diff()

The first one makes it probably just personal taste. I find "init"
better name for where input can be garbage, as opposed to "setup",
where the input is at least sane.

release_diff() is supposed to take care of more cleanup stuff as
struct diff_options grows.

diff_tree_release_paths() is not just a simple wrapper around
init_pathspec(). Remove it and manipulate diff_options->pathspec
directly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/api-diff.txt |    2 +-
 builtin/blame.c                      |   22 +++++++---------------
 builtin/merge.c                      |    2 +-
 builtin/reset.c                      |    4 ++--
 diff-no-index.c                      |    6 +++---
 diff.c                               |    8 +++++++-
 diff.h                               |    5 ++---
 merge-recursive.c                    |    2 +-
 notes-merge.c                        |    8 ++++----
 patch-ids.c                          |    2 +-
 revision.c                           |    4 ++--
 tree-diff.c                          |   21 ++++-----------------
 12 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/Documentation/technical/api-diff.txt b/Documentation/techn=
ical/api-diff.txt
index 20b0241..b88ee9e 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -18,7 +18,7 @@ Calling sequence
 ----------------
=20
 * Prepare `struct diff_options` to record the set of diff options, and
-  then call `diff_setup()` to initialize this structure.  This sets up
+  then call `init_diff()` to initialize this structure.  This sets up
   the vanilla default.
=20
 * Fill in the options structure to specify desired output format, rena=
me
diff --git a/builtin/blame.c b/builtin/blame.c
index aa30ec5..f58e6e4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -383,14 +383,13 @@ static struct origin *find_origin(struct scoreboa=
rd *sb,
 	 * and origin first.  Most of the time they are the
 	 * same and diff-tree is fairly efficient about this.
 	 */
-	diff_setup(&diff_opts);
+	init_diff(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.detect_rename =3D 0;
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	paths[0] =3D origin->path;
 	paths[1] =3D NULL;
-
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("diff-setup");
=20
@@ -441,7 +440,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	release_diff(&diff_opts);
 	if (porigin) {
 		/*
 		 * Create a freestanding copy that is not part of
@@ -469,15 +468,12 @@ static struct origin *find_rename(struct scoreboa=
rd *sb,
 	struct origin *porigin =3D NULL;
 	struct diff_options diff_opts;
 	int i;
-	const char *paths[2];
=20
-	diff_setup(&diff_opts);
+	init_diff(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.detect_rename =3D DIFF_DETECT_RENAME;
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow =3D origin->path;
-	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("diff-setup");
=20
@@ -500,7 +496,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	release_diff(&diff_opts);
 	return porigin;
 }
=20
@@ -1048,7 +1044,6 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 			       int opt)
 {
 	struct diff_options diff_opts;
-	const char *paths[1];
 	int i, j;
 	int retval;
 	struct blame_list *blame_list;
@@ -1058,12 +1053,9 @@ static int find_copy_in_parent(struct scoreboard=
 *sb,
 	if (!blame_list)
 		return 1; /* nothing remains for this target */
=20
-	diff_setup(&diff_opts);
+	init_diff(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-
-	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("diff-setup");
=20
@@ -1147,7 +1139,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 	}
 	reset_scanned_flag(sb);
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	release_diff(&diff_opts);
 	return retval;
 }
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index a89ddbb..c74ed1f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -379,7 +379,7 @@ static void finish(const unsigned char *new_head, c=
onst char *msg)
 	}
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
-		diff_setup(&opts);
+		init_diff(&opts);
 		opts.output_format |=3D
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename =3D DIFF_DETECT_RENAME;
diff --git a/builtin/reset.c b/builtin/reset.c
index 5de2bce..36b0605 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -195,10 +195,10 @@ static int read_from_tree(const char *prefix, con=
st char **argv,
 	struct diff_options opt;
=20
 	memset(&opt, 0, sizeof(opt));
-	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt=
);
 	opt.output_format =3D DIFF_FORMAT_CALLBACK;
 	opt.format_callback =3D update_index_from_diff;
 	opt.format_callback_data =3D &index_was_discarded;
+	init_pathspec(&opt.pathspec, get_pathspec(prefix, (const char **)argv=
));
=20
 	index_fd =3D hold_locked_index(lock, 1);
 	index_was_discarded =3D 0;
@@ -207,7 +207,7 @@ static int read_from_tree(const char *prefix, const=
 char **argv,
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
-	diff_tree_release_paths(&opt);
+	release_diff(&opt);
=20
 	if (!index_was_discarded)
 		/* The index is still clobbered from do_diff_cache() */
diff --git a/diff-no-index.c b/diff-no-index.c
index 3a36144..a60eda7 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -203,7 +203,7 @@ void diff_no_index(struct rev_info *revs,
 		usagef("git diff %s <path> <path>",
 		       no_index ? "--no-index" : "[--no-index]");
=20
-	diff_setup(&revs->diffopt);
+	init_diff(&revs->diffopt);
 	for (i =3D 1; i < argc - 2; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
@@ -245,10 +245,10 @@ void diff_no_index(struct rev_info *revs,
 			     : p);
 			paths[i] =3D p;
 		}
-		diff_tree_setup_paths(paths, &revs->diffopt);
+		init_pathspec(&revs->diffopt.pathspec, paths);
 	}
 	else
-		diff_tree_setup_paths(argv + argc - 2, &revs->diffopt);
+		init_pathspec(&revs->diffopt.pathspec, argv + argc - 2);
 	revs->diffopt.skip_stat_unmatch =3D 1;
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format =3D DIFF_FORMAT_PATCH;
diff --git a/diff.c b/diff.c
index 6640857..6f206a9 100644
--- a/diff.c
+++ b/diff.c
@@ -2847,7 +2847,7 @@ static void run_checkdiff(struct diff_filepair *p=
, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
=20
-void diff_setup(struct diff_options *options)
+void init_diff(struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
=20
@@ -2976,6 +2976,12 @@ int diff_setup_done(struct diff_options *options=
)
 	return 0;
 }
=20
+
+void release_diff(struct diff_options *o)
+{
+	free_pathspec(&o->pathspec);
+}
+
 static int opt_arg(const char *arg, int arg_short, const char *arg_lon=
g, int *val)
 {
 	char c, *eq;
diff --git a/diff.h b/diff.h
index 310bd6b..12a9907 100644
--- a/diff.h
+++ b/diff.h
@@ -160,8 +160,6 @@ const char *diff_get_color(int diff_use_color, enum=
 color_diff ix);
=20
 extern const char mime_boundary_leader[];
=20
-extern void diff_tree_setup_paths(const char **paths, struct diff_opti=
ons *);
-extern void diff_tree_release_paths(struct diff_options *);
 extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		     const char *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned cha=
r *new,
@@ -226,9 +224,10 @@ extern int parse_long_opt(const char *opt, const c=
har **argv,
 extern int git_diff_basic_config(const char *var, const char *value, v=
oid *cb);
 extern int git_diff_ui_config(const char *var, const char *value, void=
 *cb);
 extern int diff_use_color_default;
-extern void diff_setup(struct diff_options *);
+extern void init_diff(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
 extern int diff_setup_done(struct diff_options *);
+extern void release_diff(struct diff_options *);
=20
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..bbf48c9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -429,7 +429,7 @@ static struct string_list *get_renames(struct merge=
_options *o,
 	struct diff_options opts;
=20
 	renames =3D xcalloc(1, sizeof(struct string_list));
-	diff_setup(&opts);
+	init_diff(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	opts.detect_rename =3D DIFF_DETECT_RENAME;
 	opts.rename_limit =3D o->merge_rename_limit >=3D 0 ? o->merge_rename_=
limit :
diff --git a/notes-merge.c b/notes-merge.c
index 1467ad3..acf98e5 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -131,7 +131,7 @@ static struct notes_merge_pair *diff_tree_remote(st=
ruct notes_merge_options *o,
 	trace_printf("\tdiff_tree_remote(base =3D %.7s, remote =3D %.7s)\n",
 	       sha1_to_hex(base), sha1_to_hex(remote));
=20
-	diff_setup(&opt);
+	init_diff(&opt);
 	DIFF_OPT_SET(&opt, RECURSIVE);
 	opt.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opt) < 0)
@@ -178,7 +178,7 @@ static struct notes_merge_pair *diff_tree_remote(st=
ruct notes_merge_options *o,
 		       sha1_to_hex(mp->remote));
 	}
 	diff_flush(&opt);
-	diff_tree_release_paths(&opt);
+	release_diff(&opt);
=20
 	*num_changes =3D len;
 	return changes;
@@ -195,7 +195,7 @@ static void diff_tree_local(struct notes_merge_opti=
ons *o,
 	trace_printf("\tdiff_tree_local(len =3D %i, base =3D %.7s, local =3D =
%.7s)\n",
 	       len, sha1_to_hex(base), sha1_to_hex(local));
=20
-	diff_setup(&opt);
+	init_diff(&opt);
 	DIFF_OPT_SET(&opt, RECURSIVE);
 	opt.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opt) < 0)
@@ -265,7 +265,7 @@ static void diff_tree_local(struct notes_merge_opti=
ons *o,
 		       sha1_to_hex(mp->local));
 	}
 	diff_flush(&opt);
-	diff_tree_release_paths(&opt);
+	release_diff(&opt);
 }
=20
 static void check_notes_merge_worktree(struct notes_merge_options *o)
diff --git a/patch-ids.c b/patch-ids.c
index 5717257..e8ff156 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -37,7 +37,7 @@ struct patch_id_bucket {
 int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
-	diff_setup(&ids->diffopts);
+	init_diff(&ids->diffopts);
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	if (diff_setup_done(&ids->diffopts) < 0)
 		return error("diff_setup_done failed");
diff --git a/revision.c b/revision.c
index f9f66de..014b723 100644
--- a/revision.c
+++ b/revision.c
@@ -925,7 +925,7 @@ void init_revisions(struct rev_info *revs, const ch=
ar *prefix)
 	revs->grep_filter.header_tail =3D &(revs->grep_filter.header_list);
 	revs->grep_filter.regflags =3D REG_NEWLINE;
=20
-	diff_setup(&revs->diffopt);
+	init_diff(&revs->diffopt);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix =3D prefix;
 		revs->diffopt.prefix_length =3D strlen(prefix);
@@ -1662,7 +1662,7 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 	revs->diffopt.abbrev =3D revs->abbrev;
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
-	diff_tree_setup_paths(revs->diffopt.pathspec.raw, &revs->pruning);
+	init_pathspec(&revs->pruning.pathspec, revs->diffopt.pathspec.raw);
=20
 	compile_grep_patterns(&revs->grep_filter);
=20
diff --git a/tree-diff.c b/tree-diff.c
index 3954281..7df9064 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -209,26 +209,23 @@ static void try_to_follow_renames(struct tree_des=
c *t1, struct tree_desc *t2, co
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
 	struct diff_filepair *choice;
-	const char *paths[1];
 	int i;
=20
 	/* Remove the file creation entry from the diff queue, and remember i=
t */
 	choice =3D q->queue[0];
 	q->nr =3D 0;
=20
-	diff_setup(&diff_opts);
+	init_diff(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow =3D opt->pathspec.raw[0];
 	diff_opts.break_opt =3D opt->break_opt;
-	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("unable to set up diff options to follow renames");
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	release_diff(&diff_opts);
=20
 	/* Go through the new set of filepairing, and see if we find a more i=
nteresting one */
 	opt->found_follow =3D 0;
@@ -247,9 +244,9 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 			choice =3D p;
=20
 			/* Update the path we use from now on.. */
-			diff_tree_release_paths(opt);
+			release_diff(opt);
 			opt->pathspec.raw[0] =3D xstrdup(p->one->path);
-			diff_tree_setup_paths(opt->pathspec.raw, opt);
+			init_pathspec(&opt->pathspec, opt->pathspec.raw);
=20
 			/*
 			 * The caller expects us to return a set of vanilla
@@ -323,13 +320,3 @@ int diff_root_tree_sha1(const unsigned char *new, =
const char *base, struct diff_
 	free(tree);
 	return retval;
 }
-
-void diff_tree_release_paths(struct diff_options *opt)
-{
-	free_pathspec(&opt->pathspec);
-}
-
-void diff_tree_setup_paths(const char **p, struct diff_options *opt)
-{
-	init_pathspec(&opt->pathspec, p);
-}
--=20
1.7.3.1.256.g2539c.dirty
