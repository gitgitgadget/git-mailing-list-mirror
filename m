From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] revisions: refactor init_revisions and setup_revisions.
Date: Wed, 05 Mar 2008 00:19:45 +0100
Message-ID: <20080304231945.GC24131@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="3siQDZowHQqNOShm";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 00:21:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWgSA-0003Xv-E6
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 00:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935115AbYCDXU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 18:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934419AbYCDXUx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 18:20:53 -0500
Received: from pan.madism.org ([88.191.52.104]:53709 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934281AbYCDXTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 18:19:53 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 79DEF31BEF
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 00:19:46 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3BD92A541; Wed,  5 Mar 2008 00:19:45 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76155>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

struct rev_info gains two new field:
* .def to store --default argument;
* .show_merge 1-bit field.

The refactor consists into the following steps:
* init_revisions now takes the --default argument to initialize .def
  properly, instead of getting it through setup_revisions.
* setup_revisions has been split in two: parse_revisions that does (almost)
  only argument parsing, to be more like what parse-options can do, and
  setup_revisions that does the rest.

Many places had no arguments to pass to setup_revisions, and those don't use
parse_revisions at all.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  This is a required patch for revisions parse-optification that splits
  the logic of revision arguments parsing in parsing, and post-processing.

  The aim is to replace parsing with parse-opt at some point.

  The final version (using parse-options) will probably need more rework
  in revisions.[hc], but I'd like to avoid rebasing this patch over and
  over, and I'd be glad if it's merged now, as it's not _that_
  intrusive.

  I've been using a git with this patch for a week without issues.


 builtin-add.c           |    4 ++--
 builtin-blame.c         |    5 +++--
 builtin-checkout.c      |    7 ++++---
 builtin-commit.c        |    8 ++++----
 builtin-diff-files.c    |    8 +++++---
 builtin-diff-index.c    |    5 +++--
 builtin-diff-tree.c     |    5 +++--
 builtin-diff.c          |    8 +++++---
 builtin-fast-export.c   |    5 +++--
 builtin-fmt-merge-msg.c |    4 ++--
 builtin-log.c           |   20 +++++++++++---------
 builtin-pack-objects.c  |    5 +++--
 builtin-prune.c         |    2 +-
 builtin-reflog.c        |    2 +-
 builtin-rev-list.c      |    5 +++--
 builtin-revert.c        |    4 ++--
 builtin-shortlog.c      |    5 +++--
 bundle.c                |   10 ++++++----
 diff-lib.c              |    2 +-
 http-push.c             |    5 +++--
 revision.c              |   36 +++++++++++++++++++-----------------
 revision.h              |    7 +++++--
 upload-pack.c           |    6 +++---
 wt-status.c             |   12 ++++++------
 24 files changed, 101 insertions(+), 79 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 820110e..3757369 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -108,8 +108,8 @@ static void update_callback(struct diff_queue_struct *q,
 void add_files_to_cache(int verbose, const char *prefix, const char **path=
spec)
 {
 	struct rev_info rev;
-	init_revisions(&rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
+	init_revisions(&rev, prefix, NULL);
+	setup_revisions(&rev);
 	rev.prune_data =3D pathspec;
 	rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D update_callback;
diff --git a/builtin-blame.c b/builtin-blame.c
index bfd562d..ac5c5eb 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2323,8 +2323,9 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 	argv[unk++] =3D "--"; /* terminate the rev name */
 	argv[unk] =3D NULL;
=20
-	init_revisions(&revs, NULL);
-	setup_revisions(unk, argv, &revs, NULL);
+	init_revisions(&revs, NULL, NULL);
+	parse_revisions(unk, argv, &revs);
+	setup_revisions(&revs);
 	memset(&sb, 0, sizeof(sb));
=20
 	/*
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 6b08016..ff92ef6 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -130,7 +130,7 @@ static void show_local_changes(struct object *head)
 {
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, NULL, NULL);
 	rev.abbrev =3D 0;
 	rev.diffopt.output_format |=3D DIFF_FORMAT_NAME_STATUS;
 	add_pending_object(&rev, head, NULL);
@@ -345,8 +345,9 @@ static void report_tracking(struct branch_info *new, st=
ruct checkout_opts *opts)
 	strcpy(symmetric + 40, "...");
 	strcpy(symmetric + 43, sha1_to_hex(theirs->object.sha1));
=20
-	init_revisions(&revs, NULL);
-	setup_revisions(rev_argc, rev_argv, &revs, NULL);
+	init_revisions(&revs, NULL, NULL);
+	parse_revisions(rev_argc, rev_argv, &revs);
+	setup_revisions(&revs);
 	prepare_revision_walk(&revs);
=20
 	/* ... and count the commits on each side. */
diff --git a/builtin-commit.c b/builtin-commit.c
index f49c22e..48dbcaa 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -522,9 +522,9 @@ static int prepare_to_commit(const char *index_file, co=
nst char *prefix)
 		if (get_sha1(parent, sha1))
 			commitable =3D !!active_nr;
 		else {
-			init_revisions(&rev, "");
+			init_revisions(&rev, "", parent);
 			rev.abbrev =3D 0;
-			setup_revisions(0, NULL, &rev, parent);
+			setup_revisions(&rev);
 			DIFF_OPT_SET(&rev.diffopt, QUIET);
 			DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 			run_diff_index(&rev, 1 /* cached */);
@@ -798,8 +798,8 @@ static void print_summary(const char *prefix, const uns=
igned char *sha1)
 	if (!commit || parse_commit(commit))
 		die("could not parse newly created commit");
=20
-	init_revisions(&rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
+	init_revisions(&rev, prefix, NULL);
+	setup_revisions(&rev);
=20
 	rev.abbrev =3D 0;
 	rev.diff =3D 1;
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 4abe3c2..1f6f123 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -20,14 +20,16 @@ int cmd_diff_files(int argc, const char **argv, const c=
har *prefix)
 	int result;
=20
 	prefix =3D setup_git_directory_gently(&nongit);
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, prefix, NULL);
 	git_config(git_diff_basic_config); /* no "diff" UI options */
 	rev.abbrev =3D 0;
=20
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc =3D 0;
-	else
-		argc =3D setup_revisions(argc, argv, &rev, NULL);
+	else {
+		argc =3D parse_revisions(argc, argv, &rev);
+		setup_revisions(&rev);
+	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format =3D DIFF_FORMAT_RAW;
 	result =3D run_diff_files_cmd(&rev, argc, argv);
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 2b955de..43dc3bc 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -16,11 +16,12 @@ int cmd_diff_index(int argc, const char **argv, const c=
har *prefix)
 	int i;
 	int result;
=20
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, prefix, NULL);
 	git_config(git_diff_basic_config); /* no "diff" UI options */
 	rev.abbrev =3D 0;
=20
-	argc =3D setup_revisions(argc, argv, &rev, NULL);
+	argc =3D parse_revisions(argc, argv, &rev);
+	setup_revisions(&rev);
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 832797f..3b03d7a 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -67,12 +67,13 @@ int cmd_diff_tree(int argc, const char **argv, const ch=
ar *prefix)
 	static struct rev_info *opt =3D &log_tree_opt;
 	int read_stdin =3D 0;
=20
-	init_revisions(opt, prefix);
+	init_revisions(opt, prefix, NULL);
 	git_config(git_diff_basic_config); /* no "diff" UI options */
 	nr_sha1 =3D 0;
 	opt->abbrev =3D 0;
 	opt->diff =3D 1;
-	argc =3D setup_revisions(argc, argv, opt, NULL);
+	argc =3D parse_revisions(argc, argv, opt);
+	setup_revisions(opt);
=20
 	while (--argc > 0) {
 		const char *arg =3D *++argv;
diff --git a/builtin-diff.c b/builtin-diff.c
index 444ff2f..19f4111 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -239,13 +239,15 @@ int cmd_diff(int argc, const char **argv, const char =
*prefix)
 	if (diff_use_color_default =3D=3D -1)
 		diff_use_color_default =3D git_use_color_default;
=20
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, prefix, NULL);
 	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
=20
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc =3D 0;
-	else
-		argc =3D setup_revisions(argc, argv, &rev, NULL);
+	else {
+		argc =3D parse_revisions(argc, argv, &rev);
+		setup_revisions(&rev);
+	}
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
 		if (diff_setup_done(&rev.diffopt) < 0)
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index e1c5630..4b788e5 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -374,8 +374,9 @@ int cmd_fast_export(int argc, const char **argv, const =
char *prefix)
 	/* we handle encodings */
 	git_config(git_default_config);
=20
-	init_revisions(&revs, prefix);
-	argc =3D setup_revisions(argc, argv, &revs, NULL);
+	init_revisions(&revs, prefix, NULL);
+	argc =3D parse_revisions(argc, argv, &revs);
+	setup_revisions(&revs);
 	argc =3D parse_options(argc, argv, options, fast_export_usage, 0);
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index ebb3f37..9b84482 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -182,7 +182,7 @@ static void shortlog(const char *name, unsigned char *s=
ha1,
 	if (!branch || branch->type !=3D OBJ_COMMIT)
 		return;
=20
-	setup_revisions(0, NULL, rev, NULL);
+	setup_revisions(rev);
 	rev->ignore_merges =3D 1;
 	add_pending_object(rev, branch, name);
 	add_pending_object(rev, &head->object, "^HEAD");
@@ -339,7 +339,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, cons=
t char *prefix)
 		struct rev_info rev;
=20
 		head =3D lookup_commit(head_sha1);
-		init_revisions(&rev, prefix);
+		init_revisions(&rev, prefix, NULL);
 		rev.commit_format =3D CMIT_FMT_ONELINE;
 		rev.ignore_merges =3D 1;
 		rev.limited =3D 1;
diff --git a/builtin-log.c b/builtin-log.c
index fe8fc6f..30d13d3 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -58,7 +58,8 @@ static void cmd_log_init(int argc, const char **argv, con=
st char *prefix,
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff =3D default_show_root;
 	rev->subject_prefix =3D fmt_patch_subject_prefix;
-	argc =3D setup_revisions(argc, argv, rev, "HEAD");
+	argc =3D parse_revisions(argc, argv, rev);
+	setup_revisions(rev);
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header =3D 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
@@ -243,7 +244,7 @@ int cmd_whatchanged(int argc, const char **argv, const =
char *prefix)
 	if (diff_use_color_default =3D=3D -1)
 		diff_use_color_default =3D git_use_color_default;
=20
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, prefix, "HEAD");
 	rev.diff =3D 1;
 	rev.simplify_history =3D 0;
 	cmd_log_init(argc, argv, prefix, &rev);
@@ -319,7 +320,7 @@ int cmd_show(int argc, const char **argv, const char *p=
refix)
 	if (diff_use_color_default =3D=3D -1)
 		diff_use_color_default =3D git_use_color_default;
=20
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, prefix, "HEAD");
 	rev.diff =3D 1;
 	rev.combine_merges =3D 1;
 	rev.dense_combined_merges =3D 1;
@@ -383,7 +384,7 @@ int cmd_log_reflog(int argc, const char **argv, const c=
har *prefix)
 	if (diff_use_color_default =3D=3D -1)
 		diff_use_color_default =3D git_use_color_default;
=20
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, prefix, "HEAD");
 	init_reflog_walk(&rev.reflog_info);
 	rev.abbrev_commit =3D 1;
 	rev.verbose_header =3D 1;
@@ -415,7 +416,7 @@ int cmd_log(int argc, const char **argv, const char *pr=
efix)
 	if (diff_use_color_default =3D=3D -1)
 		diff_use_color_default =3D git_use_color_default;
=20
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, prefix, "HEAD");
 	rev.always_show_header =3D 1;
 	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
@@ -601,7 +602,7 @@ static void get_patch_ids(struct rev_info *rev, struct =
patch_ids *ids, const cha
 	init_patch_ids(ids);
=20
 	/* given a range a..b get all patch ids for b..a */
-	init_revisions(&check_rev, prefix);
+	init_revisions(&check_rev, prefix, NULL);
 	o1->flags ^=3D UNINTERESTING;
 	o2->flags ^=3D UNINTERESTING;
 	add_pending_object(&check_rev, o1, "o1");
@@ -756,7 +757,7 @@ int cmd_format_patch(int argc, const char **argv, const=
 char *prefix)
 	struct strbuf buf;
=20
 	git_config(git_format_config);
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, prefix, "HEAD");
 	rev.commit_format =3D CMIT_FMT_EMAIL;
 	rev.verbose_header =3D 1;
 	rev.diff =3D 1;
@@ -900,7 +901,8 @@ int cmd_format_patch(int argc, const char **argv, const=
 char *prefix)
 	if (numbered_files && use_stdout)
 		die ("--numbered-files and --stdout are mutually exclusive.");
=20
-	argc =3D setup_revisions(argc, argv, &rev, "HEAD");
+	argc =3D parse_revisions(argc, argv, &rev);
+	setup_revisions(&rev);
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
=20
@@ -1095,7 +1097,7 @@ int cmd_cherry(int argc, const char **argv, const cha=
r *prefix)
 		usage(cherry_usage);
 	}
=20
-	init_revisions(&revs, prefix);
+	init_revisions(&revs, prefix, NULL);
 	revs.diff =3D 1;
 	revs.combine_merges =3D 0;
 	revs.ignore_merges =3D 1;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2799e68..94d0adc 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1871,9 +1871,10 @@ static void get_object_list(int ac, const char **av)
 	char line[1000];
 	int flags =3D 0;
=20
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, NULL, NULL);
 	save_commit_buffer =3D 0;
-	setup_revisions(ac, av, &revs, NULL);
+	parse_revisions(ac, av, &revs);
+	setup_revisions(&revs);
=20
 	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
 		int len =3D strlen(line);
diff --git a/builtin-prune.c b/builtin-prune.c
index bb8ead9..c18f8c2 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -146,7 +146,7 @@ int cmd_prune(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	save_commit_buffer =3D 0;
-	init_revisions(&revs, prefix);
+	init_revisions(&revs, prefix, NULL);
 	mark_reachable_objects(&revs, 1);
=20
 	prune_object_dir(get_object_directory());
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 280e24e..133f6f3 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -399,7 +399,7 @@ static int cmd_reflog_expire(int argc, const char **arg=
v, const char *prefix)
 			break;
 	}
 	if (cb.stalefix) {
-		init_revisions(&cb.revs, prefix);
+		init_revisions(&cb.revs, prefix, NULL);
 		if (cb.verbose)
 			printf("Marking reachable objects...");
 		mark_reachable_objects(&cb.revs, 0);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index d0a1416..2a02b07 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -546,10 +546,11 @@ int cmd_rev_list(int argc, const char **argv, const c=
har *prefix)
 	int quiet =3D 0;
=20
 	git_config(git_default_config);
-	init_revisions(&revs, prefix);
+	init_revisions(&revs, prefix, NULL);
 	revs.abbrev =3D 0;
 	revs.commit_format =3D CMIT_FMT_UNSPECIFIED;
-	argc =3D setup_revisions(argc, argv, &revs, NULL);
+	argc =3D parse_revisions(argc, argv, &revs);
+	setup_revisions(&revs);
=20
 	for (i =3D 1 ; i < argc; i++) {
 		const char *arg =3D argv[i];
diff --git a/builtin-revert.c b/builtin-revert.c
index 607a2f0..e538dc1 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -251,8 +251,8 @@ static char *help_msg(const unsigned char *sha1)
 static int index_is_dirty(void)
 {
 	struct rev_info rev;
-	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, "HEAD");
+	init_revisions(&rev, NULL, "HEAD");
+	setup_revisions(&rev);
 	DIFF_OPT_SET(&rev.diffopt, QUIET);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 	run_diff_index(&rev, 1);
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index af31aba..2966bdd 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -252,8 +252,9 @@ int cmd_shortlog(int argc, const char **argv, const cha=
r *prefix)
 		argv++;
 		argc--;
 	}
-	init_revisions(&rev, prefix);
-	argc =3D setup_revisions(argc, argv, &rev, NULL);
+	init_revisions(&rev, prefix, NULL);
+	argc =3D parse_revisions(argc, argv, &rev);
+	setup_revisions(&rev);
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
=20
diff --git a/bundle.c b/bundle.c
index 0ba5df1..24d5009 100644
--- a/bundle.c
+++ b/bundle.c
@@ -104,7 +104,7 @@ int verify_bundle(struct bundle_header *header, int ver=
bose)
 	int i, ret =3D 0, req_nr;
 	const char *message =3D "Repository lacks these prerequisite commits:";
=20
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, NULL, NULL);
 	for (i =3D 0; i < p->nr; i++) {
 		struct ref_list_entry *e =3D p->list + i;
 		struct object *o =3D parse_object(e->sha1);
@@ -120,7 +120,8 @@ int verify_bundle(struct bundle_header *header, int ver=
bose)
 	if (revs.pending.nr !=3D p->nr)
 		return ret;
 	req_nr =3D revs.pending.nr;
-	setup_revisions(2, argv, &revs, NULL);
+	parse_revisions(2, argv, &revs);
+	setup_revisions(&revs);
=20
 	memset(&refs, 0, sizeof(struct object_array));
 	for (i =3D 0; i < revs.pending.nr; i++) {
@@ -192,7 +193,7 @@ int create_bundle(struct bundle_header *header, const c=
har *path,
=20
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer =3D 0;
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, NULL, NULL);
=20
 	/* write prerequisites */
 	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
@@ -226,7 +227,8 @@ int create_bundle(struct bundle_header *header, const c=
har *path,
 		return error("rev-list died");
=20
 	/* write references */
-	argc =3D setup_revisions(argc, argv, &revs, NULL);
+	argc =3D parse_revisions(argc, argv, &revs);
+	setup_revisions(&revs);
 	if (argc > 1)
 		return error("unrecognized argument: %s'", argv[1]);
=20
diff --git a/diff-lib.c b/diff-lib.c
index 4581b59..76e1ce2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -775,7 +775,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struc=
t diff_options *opt)
 	}
 	active_nr =3D dst - active_cache;
=20
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, NULL, NULL);
 	revs.prune_data =3D opt->paths;
 	tree =3D parse_tree_indirect(tree_sha1);
 	if (!tree)
diff --git a/http-push.c b/http-push.c
index 5b23038..65d9f5b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2382,8 +2382,9 @@ int main(int argc, char **argv)
 			commit_argv[3] =3D old_sha1_hex;
 			commit_argc++;
 		}
-		init_revisions(&revs, setup_git_directory());
-		setup_revisions(commit_argc, commit_argv, &revs, NULL);
+		init_revisions(&revs, setup_git_directory(), NULL);
+		parse_revisions(commit_argc, commit_argv, &revs);
+		setup_revisions(&revs);
 		free(new_sha1_hex);
 		if (old_sha1_hex) {
 			free(old_sha1_hex);
diff --git a/revision.c b/revision.c
index 63bf2c5..bab6228 100644
--- a/revision.c
+++ b/revision.c
@@ -717,7 +717,7 @@ static int add_parents_only(struct rev_info *revs, cons=
t char *arg, int flags)
 	return 1;
 }
=20
-void init_revisions(struct rev_info *revs, const char *prefix)
+void init_revisions(struct rev_info *revs, const char *prefix, const char =
*def)
 {
 	memset(revs, 0, sizeof(*revs));
=20
@@ -731,6 +731,7 @@ void init_revisions(struct rev_info *revs, const char *=
prefix)
 	revs->lifo =3D 1;
 	revs->dense =3D 1;
 	revs->prefix =3D prefix;
+	revs->def =3D def;
 	revs->max_age =3D -1;
 	revs->min_age =3D -1;
 	revs->skip_count =3D -1;
@@ -892,8 +893,7 @@ static void add_grep(struct rev_info *revs, const char =
*ptn, enum grep_pat_token
 		opt->regflags =3D REG_NEWLINE;
 		revs->grep_filter =3D opt;
 	}
-	append_grep_pattern(revs->grep_filter, ptn,
-			    "command line", 0, what);
+	append_grep_pattern(revs->grep_filter, ptn, "command line", 0, what);
 }
=20
 static void add_header_grep(struct rev_info *revs, const char *field, cons=
t char *pattern)
@@ -936,9 +936,9 @@ static void add_ignore_packed(struct rev_info *revs, co=
nst char *name)
  * Returns the number of arguments left that weren't recognized
  * (which are also moved to the head of the argument list)
  */
-int setup_revisions(int argc, const char **argv, struct rev_info *revs, co=
nst char *def)
+int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 {
-	int i, flags, seen_dashdash, show_merge;
+	int i, flags, seen_dashdash;
 	const char **unrecognized =3D argv + 1;
 	int left =3D 1;
 	int all_match =3D 0;
@@ -959,7 +959,7 @@ int setup_revisions(int argc, const char **argv, struct=
 rev_info *revs, const ch
 		break;
 	}
=20
-	flags =3D show_merge =3D 0;
+	flags =3D 0;
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
 		if (*arg =3D=3D '-') {
@@ -1047,11 +1047,11 @@ int setup_revisions(int argc, const char **argv, st=
ruct rev_info *revs, const ch
 			if (!strcmp(arg, "--default")) {
 				if (++i >=3D argc)
 					die("bad --default argument");
-				def =3D argv[i];
+				revs->def =3D argv[i];
 				continue;
 			}
 			if (!strcmp(arg, "--merge")) {
-				show_merge =3D 1;
+				revs->show_merge =3D 1;
 				continue;
 			}
 			if (!strcmp(arg, "--topo-order")) {
@@ -1315,18 +1315,23 @@ int setup_revisions(int argc, const char **argv, st=
ruct rev_info *revs, const ch
 	if (revs->grep_filter) {
 		revs->grep_filter->regflags |=3D regflags;
 		revs->grep_filter->fixed =3D fixed;
+		revs->grep_filter->all_match =3D all_match;
 	}
+	return left;
+}
=20
-	if (show_merge)
+void setup_revisions(struct rev_info *revs)
+{
+	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (def && !revs->pending.nr) {
+	if (revs->def && !revs->pending.nr) {
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(def, sha1, &mode))
-			die("bad default revision '%s'", def);
-		object =3D get_reference(revs, def, sha1, 0);
-		add_pending_object_with_mode(revs, object, def, mode);
+		if (get_sha1_with_mode(revs->def, sha1, &mode))
+			die("bad default revision '%s'", revs->def);
+		object =3D get_reference(revs, revs->def, sha1, 0);
+		add_pending_object_with_mode(revs, object, revs->def, mode);
 	}
=20
 	/* Did the user ask for any diff output? Run the diff! */
@@ -1360,14 +1365,11 @@ int setup_revisions(int argc, const char **argv, st=
ruct rev_info *revs, const ch
 		die("diff_setup_done failed");
=20
 	if (revs->grep_filter) {
-		revs->grep_filter->all_match =3D all_match;
 		compile_grep_patterns(revs->grep_filter);
 	}
=20
 	if (revs->reverse && revs->reflog_info)
 		die("cannot combine --reverse with --walk-reflogs");
-
-	return left;
 }
=20
 int prepare_revision_walk(struct rev_info *revs)
diff --git a/revision.h b/revision.h
index c8b3b94..9f727d7 100644
--- a/revision.h
+++ b/revision.h
@@ -25,6 +25,7 @@ struct rev_info {
=20
 	/* Basic information */
 	const char *prefix;
+	const char *def;
 	void *prune_data;
 	unsigned int early_output;
=20
@@ -64,6 +65,7 @@ struct rev_info {
=20
 	/* Format info */
 	unsigned int	shown_one:1,
+			show_merge:1,
 			abbrev_commit:1;
 	enum date_mode date_mode;
=20
@@ -108,8 +110,9 @@ struct rev_info {
 typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_li=
st *);
 volatile show_early_output_fn_t show_early_output;
=20
-extern void init_revisions(struct rev_info *revs, const char *prefix);
-extern int setup_revisions(int argc, const char **argv, struct rev_info *r=
evs, const char *def);
+extern void init_revisions(struct rev_info *revs, const char *prefix, cons=
t char *def);
+extern int parse_revisions(int argc, const char **argv, struct rev_info *r=
evs);
+extern void setup_revisions(struct rev_info *revs);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int =
flags,int cant_be_filename);
=20
 extern int prepare_revision_walk(struct rev_info *revs);
diff --git a/upload-pack.c b/upload-pack.c
index 660134a..8adf0f8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -106,7 +106,7 @@ static int do_rev_list(int fd, void *create_full_pack)
 	pack_pipe =3D fdopen(fd, "w");
 	if (create_full_pack)
 		use_thin_pack =3D 0; /* no point doing it */
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, NULL, NULL);
 	revs.tag_objects =3D 1;
 	revs.tree_objects =3D 1;
 	revs.blob_objects =3D 1;
@@ -115,7 +115,7 @@ static int do_rev_list(int fd, void *create_full_pack)
=20
 	if (create_full_pack) {
 		const char *args[] =3D {"rev-list", "--all", NULL};
-		setup_revisions(2, args, &revs, NULL);
+		parse_revisions(2, args, &revs);
 	} else {
 		for (i =3D 0; i < want_obj.nr; i++) {
 			struct object *o =3D want_obj.objects[i].item;
@@ -128,8 +128,8 @@ static int do_rev_list(int fd, void *create_full_pack)
 			o->flags |=3D UNINTERESTING;
 			add_pending_object(&revs, o, NULL);
 		}
-		setup_revisions(0, NULL, &revs, NULL);
 	}
+	setup_revisions(&revs);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
diff --git a/wt-status.c b/wt-status.c
index 32d780a..bf3df7c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -241,8 +241,8 @@ static void wt_status_print_initial(struct wt_status *s)
 static void wt_status_print_updated(struct wt_status *s)
 {
 	struct rev_info rev;
-	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, s->reference);
+	init_revisions(&rev, NULL, s->reference);
+	setup_revisions(&rev);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data =3D s;
@@ -255,8 +255,8 @@ static void wt_status_print_updated(struct wt_status *s)
 static void wt_status_print_changed(struct wt_status *s)
 {
 	struct rev_info rev;
-	init_revisions(&rev, "");
-	setup_revisions(0, NULL, &rev, NULL);
+	init_revisions(&rev, "", NULL);
+	setup_revisions(&rev);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
@@ -322,8 +322,8 @@ static void wt_status_print_verbose(struct wt_status *s)
 	if (saved_stdout < 0 ||dup2(fileno(s->fp), STDOUT_FILENO) < 0)
 		die("couldn't redirect stdout\n");
=20
-	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, s->reference);
+	init_revisions(&rev, NULL, s->reference);
+	setup_revisions(&rev);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename =3D 1;
 	run_diff_index(&rev, 1);
--=20
1.5.4.3.534.g7c43.dirty


--3siQDZowHQqNOShm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHzdkRvGr7W6HudhwRAmALAJ9hRBzYXm6xsBXJzrWc6/wPmYTX/QCgpjm+
mCF9+3Mwzt/Q9GbGXMF8kzA=
=T9KK
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
