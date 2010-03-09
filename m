From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] revision: introduce setup_revision_opt
Date: Tue,  9 Mar 2010 01:42:53 -0800
Message-ID: <1268127775-9998-2-git-send-email-gitster@pobox.com>
References: <1268127775-9998-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 13:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyXC-0001Do-5c
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab0CIJnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 04:43:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468Ab0CIJnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 04:43:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9C16A09C7
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 04:43:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=eQxk
	7dI1J9kR4j9SPpfS3Z0ADRc=; b=Rv1zc8wmLhsGrMTa46lX7KSvGLGHQPz/bXoT
	1mVFVvEKymIwSQNWmrwkpWhzbgPjgh1qSL+W1rqkRmqSvhvqW/lW2IuWHyRujTWt
	XDVnskE9IeuHI2IV+q96bs4Me3qp4tRirrAJLKuMyddD9QQt3vVQoYIgzkB7BsNZ
	GCo5Rco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DiTSXG
	XWFF3oWCFImGfUhdQEsUKF8GJutUUY4R8hjLtbDz7nQfZknWlekTMlhRlxw6J9YA
	LAmWcOI5QL+Ovqny+fD+ojxs93KARsCm6y/F4k0j3X0H7IKvG2dpPoZ7iThKm7VS
	qrStyha6ynuhsB6n8h7EEWXJYMaMPaxcmT8OU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4FC4A09C6
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 04:43:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 198AEA09C4 for
 <git@vger.kernel.org>; Tue,  9 Mar 2010 04:42:59 -0500 (EST)
X-Mailer: git-send-email 1.7.0.2.384.g015e
In-Reply-To: <1268127775-9998-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2688BE08-2B60-11DF-A4BA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141820>

So far the last parameter to setup_revisions() was to specify the default
ref when the command line did not give any (typically "HEAD").  This changes
it to take a pointer to a structure so that we can add other information without
touching too many codepaths in later patches.

There is no functionality change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-log.c |   30 ++++++++++++++++++++++--------
 diff-lib.c    |    5 ++++-
 revision.c    |    4 ++--
 revision.h    |    6 +++++-
 wt-status.c   |   15 +++++++++++----
 5 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 8d16832..dfbf6f2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -32,7 +32,7 @@ static const char * const builtin_log_usage =
 	"   or: git show [options] <object>...";
 
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
-		      struct rev_info *rev)
+			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	int i;
 	int decoration_style = 0;
@@ -56,7 +56,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	 */
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_log_usage);
-	argc = setup_revisions(argc, argv, rev, "HEAD");
+	argc = setup_revisions(argc, argv, rev, opt);
 
 	if (!rev->show_notes_given && !rev->pretty_given)
 		rev->show_notes = 1;
@@ -262,6 +262,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
+	struct setup_revision_opt opt;
 
 	git_config(git_log_config, NULL);
 
@@ -271,7 +272,9 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
-	cmd_log_init(argc, argv, prefix, &rev);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	return cmd_log_walk(&rev);
@@ -328,6 +331,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	struct object_array_entry *objects;
+	struct setup_revision_opt opt;
 	int i, count, ret = 0;
 
 	git_config(git_log_config, NULL);
@@ -342,7 +346,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.always_show_header = 1;
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
-	cmd_log_init(argc, argv, prefix, &rev);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
 	count = rev.pending.nr;
 	objects = rev.pending.objects;
@@ -405,6 +411,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
+	struct setup_revision_opt opt;
 
 	git_config(git_log_config, NULL);
 
@@ -415,7 +422,9 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_reflog_walk(&rev.reflog_info);
 	rev.abbrev_commit = 1;
 	rev.verbose_header = 1;
-	cmd_log_init(argc, argv, prefix, &rev);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
 	/*
 	 * This means that we override whatever commit format the user gave
@@ -438,6 +447,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
+	struct setup_revision_opt opt;
 
 	git_config(git_log_config, NULL);
 
@@ -446,7 +456,9 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
-	cmd_log_init(argc, argv, prefix, &rev);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	return cmd_log_walk(&rev);
 }
 
@@ -887,6 +899,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	struct commit **list = NULL;
 	struct rev_info rev;
+	struct setup_revision_opt s_r_opt;
 	int nr = 0, total, i;
 	int use_stdout = 0;
 	int start_number = -1;
@@ -964,8 +977,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
-
 	rev.subject_prefix = fmt_patch_subject_prefix;
+	memset(&s_r_opt, 0, sizeof(s_r_opt));
+	s_r_opt.def = "HEAD";
 
 	if (default_attach) {
 		rev.mime_boundary = default_attach;
@@ -1037,7 +1051,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (keep_subject && subject_prefix)
 		die ("--subject-prefix and -k are mutually exclusive.");
 
-	argc = setup_revisions(argc, argv, &rev, "HEAD");
+	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
diff --git a/diff-lib.c b/diff-lib.c
index d7e13cb..64976f9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -510,9 +510,12 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 int index_differs_from(const char *def, int diff_flags)
 {
 	struct rev_info rev;
+	struct setup_revision_opt opt;
 
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, def);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = def;
+	setup_revisions(0, NULL, &rev, &opt);
 	DIFF_OPT_SET(&rev.diffopt, QUICK);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 	rev.diffopt.flags |= diff_flags;
diff --git a/revision.c b/revision.c
index 3ba6d99..25c1bbb 100644
--- a/revision.c
+++ b/revision.c
@@ -1328,7 +1328,7 @@ static void append_prune_data(const char ***prune_data, const char **av)
  * Returns the number of arguments left that weren't recognized
  * (which are also moved to the head of the argument list)
  */
-int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
+int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
 	int i, flags, left, seen_dashdash, read_from_stdin;
 	const char **prune_data = NULL;
@@ -1462,7 +1462,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		revs->prune_data = get_pathspec(revs->prefix, prune_data);
 
 	if (revs->def == NULL)
-		revs->def = def;
+		revs->def = opt ? opt->def : NULL;
 	if (revs->show_merge)
 		prepare_show_merge(revs);
 	if (revs->def && !revs->pending.nr) {
diff --git a/revision.h b/revision.h
index a14deef..fcc0de8 100644
--- a/revision.h
+++ b/revision.h
@@ -137,8 +137,12 @@ struct rev_info {
 typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
 extern volatile show_early_output_fn_t show_early_output;
 
+struct setup_revision_opt {
+	const char *def;
+};
+
 extern void init_revisions(struct rev_info *revs, const char *prefix);
-extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
+extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *);
 extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 				 const struct option *options,
 				 const char * const usagestr[]);
diff --git a/wt-status.c b/wt-status.c
index 5807fc3..dcaec7f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -290,10 +290,13 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 static void wt_status_collect_changes_index(struct wt_status *s)
 {
 	struct rev_info rev;
+	struct setup_revision_opt opt;
 
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev,
-		s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
+	setup_revisions(0, NULL, &rev, &opt);
+
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data = s;
@@ -512,11 +515,15 @@ static void wt_status_print_untracked(struct wt_status *s)
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
+	struct setup_revision_opt opt;
 
 	init_revisions(&rev, NULL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
-	setup_revisions(0, NULL, &rev,
-		s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference);
+
+	memset(&opt, 0, sizeof(opt));
+	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
+	setup_revisions(0, NULL, &rev, &opt);
+
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.file = s->fp;
-- 
1.7.0.2.384.g015e
