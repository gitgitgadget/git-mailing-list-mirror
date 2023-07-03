Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2518DEB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGCGoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjGCGoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF320D2
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:17 -0700 (PDT)
Received: (qmail 14058 invoked by uid 109); 3 Jul 2023 06:44:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2628 invoked by uid 111); 3 Jul 2023 06:44:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/14] revisions: drop unused "opt" parameter in "tweak"
 callbacks
Message-ID: <20230703064416.GG3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The setup_revision_opt struct has a "tweak" function pointer, which can
be used to adjust parameters after setup_revisions() parses arguments,
but before it finalizes setup. In addition to the rev_info struct, the
callback receives a pointer to the setup_revision_opt, as well.

But none of the existing callbacks looks at the extra "opt" parameter,
leading to -Wunused-parameter warnings.

We could mark it as UNUSED, but instead let's remove it entirely. It's
conceivable that it could be useful for a callback to have access to the
"opt" struct. But in the 13 years that this mechanism has existed,
nobody has used it. So let's just drop it in the name of simplifying.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff-tree.c | 2 +-
 builtin/log.c       | 6 ++----
 revision.c          | 2 +-
 revision.h          | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index d62caa6c8b..c9ba35f143 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -99,7 +99,7 @@ static const char diff_tree_usage[] =
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
 
-static void diff_tree_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
+static void diff_tree_tweak_rev(struct rev_info *rev)
 {
 	if (!rev->diffopt.output_format) {
 		if (rev->dense_combined_merges)
diff --git a/builtin/log.c b/builtin/log.c
index 89442dceda..91bc7d967e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -718,8 +718,7 @@ static int show_tree_object(const struct object_id *oid UNUSED,
 	return 0;
 }
 
-static void show_setup_revisions_tweak(struct rev_info *rev,
-				       struct setup_revision_opt *opt)
+static void show_setup_revisions_tweak(struct rev_info *rev)
 {
 	if (rev->first_parent_only)
 		diff_merges_default_to_first_parent(rev);
@@ -862,8 +861,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
 
-static void log_setup_revisions_tweak(struct rev_info *rev,
-				      struct setup_revision_opt *opt)
+static void log_setup_revisions_tweak(struct rev_info *rev)
 {
 	if (rev->diffopt.flags.default_follow_renames &&
 	    diff_check_follow_pathspec(&rev->prune_data, 0))
diff --git a/revision.c b/revision.c
index 84768565ce..73f8c7e2e0 100644
--- a/revision.c
+++ b/revision.c
@@ -2955,7 +2955,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (!revs->def)
 		revs->def = opt ? opt->def : NULL;
 	if (opt && opt->tweak)
-		opt->tweak(revs, opt);
+		opt->tweak(revs);
 	if (revs->show_merge)
 		prepare_show_merge(revs);
 	if (revs->def && !revs->pending.nr && !revs->rev_input_given) {
diff --git a/revision.h b/revision.h
index 25776af381..18f49565c2 100644
--- a/revision.h
+++ b/revision.h
@@ -428,7 +428,7 @@ void repo_init_revisions(struct repository *r,
  */
 struct setup_revision_opt {
 	const char *def;
-	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
+	void (*tweak)(struct rev_info *);
 	unsigned int	assume_dashdash:1,
 			allow_exclude_promisor_objects:1,
 			free_removed_argv_elements:1;
-- 
2.41.0.586.g3c0cc15bc7

