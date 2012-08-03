From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] diff_setup_done(): return void
Date: Fri, 3 Aug 2012 14:16:24 +0200
Message-ID: <6668871a0573c4d82d914137e3c7ff31fa8ce1ef.1343995614.git.trast@student.ethz.ch>
References: <CAN0XMOLp_m4jUKv_=qfXdYx4jDJMBYQtY2-19sfC_7LzfY6uXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>, <jk@jk.gs>,
	<stimming@tuhh.de>, <git@vger.kernel.org>,
	<worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:16:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxGo6-00008t-8r
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702Ab2HCMQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 08:16:32 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:45010 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618Ab2HCMQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 08:16:28 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 14:16:23 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 14:16:26 +0200
X-Mailer: git-send-email 1.7.12.rc1.219.gb14e69c
In-Reply-To: <CAN0XMOLp_m4jUKv_=qfXdYx4jDJMBYQtY2-19sfC_7LzfY6uXA@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202830>

diff_setup_done() has historically returned an error code, but lost
the last nonzero return in 943d5b7 (allow diff.renamelimit to be set
regardless of -M/-C, 2006-08-09).  The callers were in a pretty
confused state: some actually checked for the return code, and some
did not.

Let it return void, and patch all callers to take this into account.
This conveniently also gets rid of a handful of different(!) error
messages that could never be triggered anyway.

Note that the function can still die().

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

> On Fri, Aug 3, 2012 at 10:59 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> >
> > Ralf Thielow <ralf.thielow@gmail.com> writes:
> >
> >>  #: merge-recursive.c:497
> >> -#, fuzzy
> >>  msgid "diff setup failed"
> >> -msgstr "diff_setup_done fehlgeschlagen"
> >> +msgstr "Einrichtung der Optionen zur Bestimmung der Unterschiede "
> >> +"fehlgeschlagen"
> >
> > That one is really unwieldy.  Judging from a cursory look at the code,
> > it's an internal error anyway and should probably be "BUG:
> > diff_setup_done failed" to begin with.
> >
> 
> You're right. There are already places where the message is
> "diff_setup_done failed"
> 
> #: builtin/checkout.c:320 builtin/diff.c:302 builtin/merge.c:408
> msgid "diff_setup_done failed"
> msgstr "diff_setup_done fehlgeschlagen"
> 
> We could just translate it in this way. It's not really the same message,
> but the same meaning.

I looked again.  They're entirely redundant.  Let's remove all of
them.

 builtin/blame.c    | 9 +++------
 builtin/checkout.c | 3 +--
 builtin/diff.c     | 3 +--
 builtin/merge.c    | 3 +--
 diff-no-index.c    | 3 +--
 diff.c             | 4 +---
 diff.h             | 2 +-
 line.c             | 3 +++
 merge-recursive.c  | 3 +--
 notes-merge.c      | 6 ++----
 patch-ids.c        | 3 +--
 revision.c         | 3 +--
 submodule.c        | 3 +--
 tree-diff.c        | 3 +--
 14 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bae576c..dbe969b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -408,8 +408,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 	paths[1] = NULL;
 
 	diff_tree_setup_paths(paths, &diff_opts);
-	if (diff_setup_done(&diff_opts) < 0)
-		die("diff-setup");
+	diff_setup_done(&diff_opts);
 
 	if (is_null_sha1(origin->commit->object.sha1))
 		do_diff_cache(parent->tree->object.sha1, &diff_opts);
@@ -495,8 +494,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 	diff_opts.single_follow = origin->path;
 	paths[0] = NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
-	if (diff_setup_done(&diff_opts) < 0)
-		die("diff-setup");
+	diff_setup_done(&diff_opts);
 
 	if (is_null_sha1(origin->commit->object.sha1))
 		do_diff_cache(parent->tree->object.sha1, &diff_opts);
@@ -1081,8 +1079,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 
 	paths[0] = NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
-	if (diff_setup_done(&diff_opts) < 0)
-		die("diff-setup");
+	diff_setup_done(&diff_opts);
 
 	/* Try "find copies harder" on new path if requested;
 	 * we do not want to use diffcore_rename() actually to
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d812219..7d922c6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -316,8 +316,7 @@ static void show_local_changes(struct object *head, struct diff_options *opts)
 	init_revisions(&rev, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
-	if (diff_setup_done(&rev.diffopt) < 0)
-		die(_("diff_setup_done failed"));
+	diff_setup_done(&rev.diffopt);
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index bf72298..9650be2 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -302,8 +302,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
-		if (diff_setup_done(&rev.diffopt) < 0)
-			die(_("diff_setup_done failed"));
+		diff_setup_done(&rev.diffopt);
 	}
 
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
diff --git a/builtin/merge.c b/builtin/merge.c
index dd50a0c..e81fde6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -404,8 +404,7 @@ static void finish(struct commit *head_commit,
 		opts.output_format |=
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
-		if (diff_setup_done(&opts) < 0)
-			die(_("diff_setup_done failed"));
+		diff_setup_done(&opts);
 		diff_tree_sha1(head, new_head, "", &opts);
 		diffcore_std(&opts);
 		diff_flush(&opts);
diff --git a/diff-no-index.c b/diff-no-index.c
index 0b46a0f..74da659 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -258,8 +258,7 @@ void diff_no_index(struct rev_info *revs,
 	DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
 
 	revs->max_count = -2;
-	if (diff_setup_done(&revs->diffopt) < 0)
-		die("diff_setup_done failed");
+	diff_setup_done(&revs->diffopt);
 
 	setup_diff_pager(&revs->diffopt);
 	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
diff --git a/diff.c b/diff.c
index 0c1e4fc..e8678c8 100644
--- a/diff.c
+++ b/diff.c
@@ -3187,7 +3187,7 @@ void diff_setup(struct diff_options *options)
 	}
 }
 
-int diff_setup_done(struct diff_options *options)
+void diff_setup_done(struct diff_options *options)
 {
 	int count = 0;
 
@@ -3286,8 +3286,6 @@ int diff_setup_done(struct diff_options *options)
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
-
-	return 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
diff --git a/diff.h b/diff.h
index e9284f2..d89d989 100644
--- a/diff.h
+++ b/diff.h
@@ -247,7 +247,7 @@ extern int parse_long_opt(const char *opt, const char **argv,
 extern int diff_use_color_default;
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
-extern int diff_setup_done(struct diff_options *);
+extern void diff_setup_done(struct diff_options *);
 
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
diff --git a/line.c b/line.c
index a008c2c..fe7ace7 100644
--- a/line.c
+++ b/line.c
@@ -1177,6 +1177,9 @@ static int process_diff_filepair(struct rev_info *rev,
 		return 0;
 	if (rg->ranges.nr == 0)
 		return 0;
+	if (rg->ranges.nr == 1 &&
+	    rg->ranges.ranges[0].start == rg->ranges.ranges[0].end)
+		return 0;
 
 	assert(pair->two->sha1_valid);
 	diff_populate_filespec(pair->two, 0);
diff --git a/merge-recursive.c b/merge-recursive.c
index 8903a73..a7bb212 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -493,8 +493,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	opts.rename_score = o->rename_score;
 	opts.show_rename_progress = o->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	if (diff_setup_done(&opts) < 0)
-		die(_("diff setup failed"));
+	diff_setup_done(&opts);
 	diff_tree_sha1(o_tree->object.sha1, tree->object.sha1, "", &opts);
 	diffcore_std(&opts);
 	if (opts.needed_rename_limit > o->needed_rename_limit)
diff --git a/notes-merge.c b/notes-merge.c
index 29c6411..0f67bd3 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -126,8 +126,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	diff_setup(&opt);
 	DIFF_OPT_SET(&opt, RECURSIVE);
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
-	if (diff_setup_done(&opt) < 0)
-		die("diff_setup_done failed");
+	diff_setup_done(&opt);
 	diff_tree_sha1(base, remote, "", &opt);
 	diffcore_std(&opt);
 
@@ -190,8 +189,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	diff_setup(&opt);
 	DIFF_OPT_SET(&opt, RECURSIVE);
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
-	if (diff_setup_done(&opt) < 0)
-		die("diff_setup_done failed");
+	diff_setup_done(&opt);
 	diff_tree_sha1(base, local, "", &opt);
 	diffcore_std(&opt);
 
diff --git a/patch-ids.c b/patch-ids.c
index 5717257..bc8a28f 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -39,8 +39,7 @@ int init_patch_ids(struct patch_ids *ids)
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
-	if (diff_setup_done(&ids->diffopts) < 0)
-		return error("diff_setup_done failed");
+	diff_setup_done(&ids->diffopts);
 	return 0;
 }
 
diff --git a/revision.c b/revision.c
index d20ff72..2253a82 100644
--- a/revision.c
+++ b/revision.c
@@ -1870,8 +1870,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revs->topo_order = 1;
 	}
 
-	if (diff_setup_done(&revs->diffopt) < 0)
-		die("diff_setup_done failed");
+	diff_setup_done(&revs->diffopt);
 
 	compile_grep_patterns(&revs->grep_filter);
 
diff --git a/submodule.c b/submodule.c
index 959d349..19dc6a6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -574,8 +574,7 @@ static void calculate_changed_submodule_paths(void)
 			DIFF_OPT_SET(&diff_opts, RECURSIVE);
 			diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
 			diff_opts.format_callback = submodule_collect_changed_cb;
-			if (diff_setup_done(&diff_opts) < 0)
-				die("diff_setup_done failed");
+			diff_setup_done(&diff_opts);
 			diff_tree_sha1(parent->item->object.sha1, commit->object.sha1, "", &diff_opts);
 			diffcore_std(&diff_opts);
 			diff_flush(&diff_opts);
diff --git a/tree-diff.c b/tree-diff.c
index 7e54833..ba01563 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -212,8 +212,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_opts.rename_score = opt->rename_score;
 	paths[0] = NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
-	if (diff_setup_done(&diff_opts) < 0)
-		die("unable to set up diff options to follow renames");
+	diff_setup_done(&diff_opts);
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
 	diff_tree_release_paths(&diff_opts);
-- 
1.7.12.rc1.219.gb14e69c
