Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC59FCD37B2
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 06:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjIPGLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 02:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbjIPGLV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 02:11:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F42B1BE6
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 23:11:15 -0700 (PDT)
Received: (qmail 1749 invoked by uid 109); 16 Sep 2023 06:11:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 06:11:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9214 invoked by uid 111); 16 Sep 2023 06:11:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 02:11:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 02:11:14 -0400
From:   Jeff King <peff@peff.net>
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Izzy <winglovet@gmail.com>
Subject: Re: [PATCH v4] merge-tree: add -X strategy option
Message-ID: <20230916061114.GF13092@coredump.intra.peff.net>
References: <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com>
 <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 16, 2023 at 03:47:05AM +0000, Izzy via GitGitGadget wrote:

> +static int option_parse_x(const struct option *opt,
> +			  const char *arg, int unset)
> +{
> +	if (unset)
> +		return 0;
> +
> +	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
> +	xopts[xopts_nr++] = xstrdup(arg);
> +	return 0;
> +}

This callback was presumably copied from the one in builtin/merge.c, and
it suffers from the same "--no-strategy-option" bug. You should make a
similar change here to the one we did in dee02da826 (merge: make xopts a
strvec, 2023-08-31). And as a bonus, it will make your patch even
shorter. :)

It would also make it easier to get rid of the global variables, I
think. Something like (squashed into your patch):

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 2ec6ec0d39..e13dbc4c79 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -18,9 +18,8 @@
 #include "quote.h"
 #include "tree.h"
 #include "config.h"
+#include "strvec.h"
 
-static const char **xopts;
-static size_t xopts_nr, xopts_alloc;
 static int line_termination = '\n';
 
 struct merge_list {
@@ -515,20 +514,10 @@ static int real_merge(struct merge_tree_options *o,
 	return !result.clean; /* result.clean < 0 handled above */
 }
 
-static int option_parse_x(const struct option *opt,
-			  const char *arg, int unset)
-{
-	if (unset)
-		return 0;
-
-	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
-	xopts[xopts_nr++] = xstrdup(arg);
-	return 0;
-}
-
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
 	struct merge_tree_options o = { .show_messages = -1 };
+	struct strvec xopts = STRVEC_INIT;
 	int expected_remaining_argc;
 	int original_argc;
 	const char *merge_base = NULL;
@@ -564,10 +553,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &merge_base,
 			   N_("commit"),
 			   N_("specify a merge-base for the merge")),
-		OPT_CALLBACK('X', "strategy-option", &xopts,
-			N_("option=value"),
-			N_("option for selected merge strategy"),
-			option_parse_x),
+		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
+			   N_("option for selected merge strategy")),
 		OPT_END()
 	};
 
@@ -576,9 +563,9 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
-	for (int x = 0; x < xopts_nr; x++)
-		if (parse_merge_opt(&o.merge_options, xopts[x]))
-			die(_("unknown strategy option: -X%s"), xopts[x]);
+	for (int x = 0; x < xopts.nr; x++)
+		if (parse_merge_opt(&o.merge_options, xopts.v[x]))
+			die(_("unknown strategy option: -X%s"), xopts.v[x]);
 
 	/* Handle --stdin */
 	if (o.use_stdin) {
