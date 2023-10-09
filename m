Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2070DCD6123
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377392AbjJISwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJISwk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:52:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B54A6
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:52:36 -0700 (PDT)
Received: (qmail 22732 invoked by uid 109); 9 Oct 2023 18:52:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 18:52:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17180 invoked by uid 111); 9 Oct 2023 18:52:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 14:52:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 14:52:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Izzy <winglovet@gmail.com>
Subject: Re: [PATCH v6] merge-tree: add -X strategy option
Message-ID: <20231009185234.GB3270793@coredump.intra.peff.net>
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
 <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
 <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>
 <20231009155315.GA3252778@coredump.intra.peff.net>
 <xmqq4jiz3env.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jiz3env.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 10:10:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I agree that struct-copying is an unusual pattern, and we'd potentially
> > run into problems with duplication. But I think it is even trickier than
> > that here. We also go on to actually _modify_ opt in this function,
> > assigning to various members (both directly, and I think the merge code
> > itself will write to opt->priv).
> >
> > So if we use a pointer (rather than struct assignment), those changes
> > will persist in the merge_options struct that was passed in. Which is
> > also weird.
> >
> > Between the two, I think using a pointer is probably the least-weird.
> > This real_merge() function is only called once, and is a static-local
> > helper for cmd_merge_tree(). So the two functions work as a single unit,
> > and munging "opt" is not a big deal.
> 
> It is called once per --stdin input to perform many merges in a row.
> The most obvious "structure to pointer to structure" conversion
> below seems to break an assertion (which is not very surprising, as
> it happens inside that --stdin loop), so I am tempted to revert the
> whole thing for now.

Oops, I totally missed the loop around the call to real_merge(). So
yeah, I think this is rather tricky.

Before Izzy's patch, real_merge() always makes its own fresh
merge_options. After, we have a template merge_options that we copy, but
we are assuming that a shallow struct copy is OK (probably true, but an
anti-pattern that may bite us later).  If we add Phillip's suggestion on
top, then we do not copy at all, and end up reusing the same options
struct (which is definitely wrong).

I don't think there are any bugs with the state at the current tip of
ty/merge-tree-strategy-options, but if we want to make it safer, I think
we have two options:

  - delay the conversion of the "xopts" list into merge_options until we
    initialize it in real_merge(). This avoids breaking abstraction
    boundaries, but does mean that the sanity-checking of the options
    happens a little later (but not much in practice).

  - provide a copy_merge_options() function, which makes this kind of
    "set up a template and then copy it" pattern official. It can be a
    struct assignment for now, but it at least alerts anybody adding new
    options to the notion that a deep copy might be required.

Option 1 looks something like this (a lot of the hunks are just
reverting the tip of that branch, so squashed in it would be even
smaller):

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 7024b5ce2e..f9dbbdb867 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -415,7 +415,7 @@ struct merge_tree_options {
 	int show_messages;
 	int name_only;
 	int use_stdin;
-	struct merge_options merge_options;
+	struct strvec xopts;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -425,7 +425,7 @@ static int real_merge(struct merge_tree_options *o,
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *merge_bases = NULL;
-	struct merge_options opt = o->merge_options;
+	struct merge_options opt;
 	struct merge_result result = { 0 };
 	int show_messages = o->show_messages;
 
@@ -439,11 +439,17 @@ static int real_merge(struct merge_tree_options *o,
 		help_unknown_ref(branch2, "merge-tree",
 				 _("not something we can merge"));
 
+	init_merge_options(&opt, the_repository);
+
 	opt.show_rename_progress = 0;
 
 	opt.branch1 = branch1;
 	opt.branch2 = branch2;
 
+	for (size_t x = 0; x < o->xopts.nr; x++)
+		if (parse_merge_opt(&opt, o->xopts.v[x]))
+			die(_("unknown strategy option: -X%s"), o->xopts.v[x]);
+
 	if (merge_base) {
 		struct commit *base_commit;
 		struct tree *base_tree, *parent1_tree, *parent2_tree;
@@ -512,8 +518,7 @@ static int real_merge(struct merge_tree_options *o,
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
-	struct merge_tree_options o = { .show_messages = -1 };
-	struct strvec xopts = STRVEC_INIT;
+	struct merge_tree_options o = { .show_messages = -1,.xopts = STRVEC_INIT };
 	int expected_remaining_argc;
 	int original_argc;
 	const char *merge_base = NULL;
@@ -549,24 +554,18 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &merge_base,
 			   N_("commit"),
 			   N_("specify a merge-base for the merge")),
-		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
+		OPT_STRVEC('X', "strategy-option", &o.xopts, N_("option=value"),
 			N_("option for selected merge strategy")),
 		OPT_END()
 	};
 
-	/* Init merge options */
-	init_merge_options(&o.merge_options, the_repository);
-
 	/* Parse arguments */
 	original_argc = argc - 1; /* ignoring argv[0] */
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (xopts.nr && o.mode == MODE_TRIVIAL)
+	if (o.xopts.nr && o.mode == MODE_TRIVIAL)
 		die(_("--trivial-merge is incompatible with all other options"));
-	for (int x = 0; x < xopts.nr; x++)
-		if (parse_merge_opt(&o.merge_options, xopts.v[x]))
-			die(_("unknown strategy option: -X%s"), xopts.v[x]);
 
 	/* Handle --stdin */
 	if (o.use_stdin) {
