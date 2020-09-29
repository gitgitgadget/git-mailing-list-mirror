Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0226DC4741F
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D62207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="jHLZUZfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgI2QNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgI2QN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:29 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA97C0613D0
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Sb/pZv6ihrnIHDD41TvCFT1p1jkf5WucIaUxqbh4fps=; b=jHLZUZfgvP9VhcXONCf/KjswCn
        WA6VF6XvkGSaD+kfejQOY9aPgYYnPRsWsxi22pF5FfyaFiHw7JOjl2zrrsf3mrSWXF981fcdv16WO
        gRnHX0taqc4k8t1xOBUcgDjIie334DRLy0WX0g8pVAIl7y9VyoQpHLJ9GZuZU7HdmEvE=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNHx8-0004AY-P9; Tue, 29 Sep 2020 15:54:06 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 5/7] merge-recursive: use separate submodule repository
Date:   Tue, 29 Sep 2020 16:53:48 +0100
Message-Id: <20200929155350.49066-6-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929155350.49066-1-andrew@adoakley.name>
References: <20200929155350.49066-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using a separate repository with it's own object store should allow any
objects that need to be fetched from a promisor or an alternate object
store to work correctly.

This change is not expected to alter any behaviour.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 merge-recursive.c | 73 ++++++++++++++++++++++++++++-------------------
 revision.c        | 21 +++++---------
 revision.h        |  1 -
 submodule.c       | 11 +------
 submodule.h       | 11 +++++++
 5 files changed, 62 insertions(+), 55 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d0214335a7..4984c1e19e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -25,6 +25,7 @@
 #include "revision.h"
 #include "string-list.h"
 #include "submodule.h"
+#include "submodule-config.h"
 #include "tag.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
@@ -340,7 +341,8 @@ static void output(struct merge_options *opt, int v, const char *fmt, ...)
 		flush_output(opt);
 }
 
-static void output_commit_title(struct merge_options *opt, struct commit *commit)
+static void output_commit_title(struct merge_options *opt,
+				struct repository *repo, struct commit *commit)
 {
 	struct merge_remote_desc *desc;
 
@@ -352,15 +354,16 @@ static void output_commit_title(struct merge_options *opt, struct commit *commit
 		strbuf_add_unique_abbrev(&opt->obuf, &commit->object.oid,
 					 DEFAULT_ABBREV);
 		strbuf_addch(&opt->obuf, ' ');
-		if (parse_commit(commit) != 0)
+		if (repo_parse_commit(repo, commit) != 0)
 			strbuf_addstr(&opt->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
-			const char *msg = get_commit_buffer(commit, NULL);
+			const char *msg = repo_get_commit_buffer(repo, commit,
+								 NULL);
 			int len = find_commit_subject(msg, &title);
 			if (len)
 				strbuf_addf(&opt->obuf, "%.*s\n", len, title);
-			unuse_commit_buffer(commit, msg);
+			repo_unuse_commit_buffer(repo, commit, msg);
 		}
 	}
 	flush_output(opt);
@@ -1110,9 +1113,8 @@ static int find_first_merges(struct repository *repo,
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
 	repo_init_revisions(repo, &revs, NULL);
-	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
-	revs.single_worktree = path != NULL;
+	revs.single_worktree = repo != the_repository;
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
 
 	/* save all revisions from the above list that contain b */
@@ -1149,12 +1151,12 @@ static int find_first_merges(struct repository *repo,
 	return result->nr;
 }
 
-static void print_commit(struct commit *commit)
+static void print_commit(struct repository *repo, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode.type = DATE_NORMAL;
-	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
+	repo_format_commit_message(repo, commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
 }
@@ -1169,9 +1171,11 @@ static int merge_submodule(struct merge_options *opt,
 			   const struct object_id *base, const struct object_id *a,
 			   const struct object_id *b)
 {
+	struct repository *subrepo;
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
+	int clean = 0;
 
 	int i;
 	int search = !opt->priv->call_depth;
@@ -1187,49 +1191,52 @@ static int merge_submodule(struct merge_options *opt,
 	if (is_null_oid(b))
 		return 0;
 
-	if (add_submodule_odb(path)) {
+	subrepo = open_submodule(path);
+	if (!subrepo) {
 		output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(opt->repo, base)) ||
-	    !(commit_a = lookup_commit_reference(opt->repo, a)) ||
-	    !(commit_b = lookup_commit_reference(opt->repo, b))) {
+	if (!(commit_base = lookup_commit_reference(subrepo, base)) ||
+	    !(commit_a = lookup_commit_reference(subrepo, a)) ||
+	    !(commit_b = lookup_commit_reference(subrepo, b))) {
 		output(opt, 1, _("Failed to merge submodule %s (commits not present)"), path);
-		return 0;
+		goto cleanup;
 	}
 
 	/* check whether both changes are forward */
-	if (!in_merge_bases(commit_base, commit_a) ||
-	    !in_merge_bases(commit_base, commit_b)) {
+	if (!repo_in_merge_bases(subrepo, commit_base, commit_a) ||
+	    !repo_in_merge_bases(subrepo, commit_base, commit_b)) {
 		output(opt, 1, _("Failed to merge submodule %s (commits don't follow merge-base)"), path);
-		return 0;
+		goto cleanup;
 	}
 
 	/* Case #1: a is contained in b or vice versa */
-	if (in_merge_bases(commit_a, commit_b)) {
+	if (repo_in_merge_bases(subrepo, commit_a, commit_b)) {
 		oidcpy(result, b);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
-			output_commit_title(opt, commit_b);
+			output_commit_title(opt, subrepo, commit_b);
 		} else if (show(opt, 2))
 			output(opt, 2, _("Fast-forwarding submodule %s"), path);
 		else
 			; /* no output */
 
-		return 1;
+		clean = 1;
+		goto cleanup;
 	}
-	if (in_merge_bases(commit_b, commit_a)) {
+	if (repo_in_merge_bases(subrepo, commit_b, commit_a)) {
 		oidcpy(result, a);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
-			output_commit_title(opt, commit_a);
+			output_commit_title(opt, subrepo, commit_a);
 		} else if (show(opt, 2))
 			output(opt, 2, _("Fast-forwarding submodule %s"), path);
 		else
 			; /* no output */
 
-		return 1;
+		clean = 1;
+		goto cleanup;
 	}
 
 	/*
@@ -1241,10 +1248,10 @@ static int merge_submodule(struct merge_options *opt,
 
 	/* Skip the search if makes no sense to the calling context.  */
 	if (!search)
-		return 0;
+		goto cleanup;
 
 	/* find commit which merges them */
-	parent_count = find_first_merges(opt->repo, &merges, path,
+	parent_count = find_first_merges(subrepo, &merges, path,
 					 commit_a, commit_b);
 	switch (parent_count) {
 	case 0:
@@ -1254,7 +1261,8 @@ static int merge_submodule(struct merge_options *opt,
 	case 1:
 		output(opt, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
 		output(opt, 2, _("Found a possible merge resolution for the submodule:\n"));
-		print_commit((struct commit *) merges.objects[0].item);
+		print_commit(subrepo,
+			     (struct commit *) merges.objects[0].item);
 		output(opt, 2, _(
 		       "If this is correct simply add it to the index "
 		       "for example\n"
@@ -1267,11 +1275,16 @@ static int merge_submodule(struct merge_options *opt,
 	default:
 		output(opt, 1, _("Failed to merge submodule %s (multiple merges found)"), path);
 		for (i = 0; i < merges.nr; i++)
-			print_commit((struct commit *) merges.objects[i].item);
+			print_commit(subrepo,
+				     (struct commit *) merges.objects[i].item);
 	}
 
 	object_array_clear(&merges);
-	return 0;
+
+cleanup:
+	repo_clear(subrepo);
+	free(subrepo);
+	return clean;
 }
 
 static int merge_mode_and_contents(struct merge_options *opt,
@@ -3548,8 +3561,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 
 	if (show(opt, 4)) {
 		output(opt, 4, _("Merging:"));
-		output_commit_title(opt, h1);
-		output_commit_title(opt, h2);
+		output_commit_title(opt, opt->repo, h1);
+		output_commit_title(opt, opt->repo, h2);
 	}
 
 	if (!merge_bases) {
@@ -3563,7 +3576,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 		output(opt, 5, Q_("found %u common ancestor:",
 				"found %u common ancestors:", cnt), cnt);
 		for (iter = merge_bases; iter; iter = iter->next)
-			output_commit_title(opt, iter->item);
+			output_commit_title(opt, opt->repo, iter->item);
 	}
 
 	merged_merge_bases = pop_commit(&merge_bases);
diff --git a/revision.c b/revision.c
index 067030e64c..a3747aaecc 100644
--- a/revision.c
+++ b/revision.c
@@ -2582,16 +2582,15 @@ static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void
 	return for_each_bisect_ref(refs, fn, cb_data, term_good);
 }
 
-static int handle_revision_pseudo_opt(const char *submodule,
-				struct rev_info *revs,
-				int argc, const char **argv, int *flags)
+static int handle_revision_pseudo_opt(struct rev_info *revs,
+				      int argc, const char **argv, int *flags)
 {
 	const char *arg = argv[0];
 	const char *optarg;
 	struct ref_store *refs;
 	int argcount;
 
-	if (submodule) {
+	if (revs->repo != the_repository) {
 		/*
 		 * We need some something like get_submodule_worktrees()
 		 * before we can go through all worktrees of a submodule,
@@ -2600,9 +2599,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		 */
 		if (!revs->single_worktree)
 			BUG("--single-worktree cannot be used together with submodule");
-		refs = get_submodule_ref_store(submodule);
-	} else
-		refs = get_main_ref_store(revs->repo);
+	}
+	refs = get_main_ref_store(revs->repo);
 
 	/*
 	 * NOTE!
@@ -2720,12 +2718,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 {
 	int i, flags, left, seen_dashdash, revarg_opt;
 	struct strvec prune_data = STRVEC_INIT;
-	const char *submodule = NULL;
 	int seen_end_of_options = 0;
 
-	if (opt)
-		submodule = opt->submodule;
-
 	/* First, search for "--" */
 	if (opt && opt->assume_dashdash) {
 		seen_dashdash = 1;
@@ -2754,9 +2748,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (!seen_end_of_options && *arg == '-') {
 			int opts;
 
-			opts = handle_revision_pseudo_opt(submodule,
-						revs, argc - i, argv + i,
-						&flags);
+			opts = handle_revision_pseudo_opt(revs, argc - i,
+							  argv + i, &flags);
 			if (opts > 0) {
 				i += opts - 1;
 				continue;
diff --git a/revision.h b/revision.h
index f6bf860d19..2b8396fc44 100644
--- a/revision.h
+++ b/revision.h
@@ -330,7 +330,6 @@ extern volatile show_early_output_fn_t show_early_output;
 struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
-	const char *submodule;	/* TODO: drop this and use rev_info->repo */
 	unsigned int	assume_dashdash:1,
 			allow_exclude_promisor_objects:1;
 	unsigned revarg_opt;
diff --git a/submodule.c b/submodule.c
index 3889dc7d9a..1671800340 100644
--- a/submodule.c
+++ b/submodule.c
@@ -505,16 +505,7 @@ static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
 	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
 }
 
-/*
- * Initialize a repository struct for a submodule based on the provided 'path'.
- *
- * Unlike repo_submodule_init, this tolerates submodules not present
- * in .gitmodules. This function exists only to preserve historical behavior,
- *
- * Returns the repository struct on success,
- * NULL when the submodule is not present.
- */
-static struct repository *open_submodule(const char *path)
+struct repository *open_submodule(const char *path)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct repository *out = xmalloc(sizeof(*out));
diff --git a/submodule.h b/submodule.h
index 4ac6e31cf1..6a66d3e05f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -99,6 +99,17 @@ int bad_to_remove_submodule(const char *path, unsigned flags);
 
 int add_submodule_odb(const char *path);
 
+/*
+ * Initialize a repository struct for a submodule based on the provided 'path'.
+ *
+ * Unlike repo_submodule_init, this tolerates submodules not present
+ * in .gitmodules. This function exists only to preserve historical behavior,
+ *
+ * Returns the repository struct on success,
+ * NULL when the submodule is not present.
+ */
+struct repository *open_submodule(const char *path);
+
 /*
  * Checks if there are submodule changes in a..b. If a is the null OID,
  * checks b and all its ancestors instead.
-- 
2.26.2

