Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49BC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJRBEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiJRBEv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:04:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C42317EC
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:04:46 -0700 (PDT)
Received: (qmail 28774 invoked by uid 109); 18 Oct 2022 01:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:04:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13378 invoked by uid 111); 18 Oct 2022 01:04:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:04:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:04:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/12] update-index: drop unused argc from do_reupdate()
Message-ID: <Y037rXjvUthkNuCW@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parse-options callback for --again soaks up all remaining options by
manipulating the parse_opt_ctx's argc and argv fields. Even though it
has to look at both, the actual parsing happens via the do_reupdate()
helper, which only looks at the argv half (by passing it along to
parse_pathspec). So that helper doesn't need to see argc at all.

Note that the helper does look at "argv + 1" without confirming that
argc is greater than 0. We know this is correct because it is skipping
past the actual "--again" string, which will always be present. However,
to make what's going on more obvious, let's move that "+1" into the
caller, which has the matching "-1" when fixing up the ctx's argc/argv.

Signed-off-by: Jeff King <peff@peff.net>
---
Generate with -U5 so you can see the context I mentioned in
reupdate_callback().

 builtin/update-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index b62249905f..7b0c924d7d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -730,23 +730,23 @@ static int do_unresolve(int ac, const char **av,
 		free(p);
 	}
 	return err;
 }
 
-static int do_reupdate(int ac, const char **av,
+static int do_reupdate(const char **paths,
 		       const char *prefix)
 {
 	/* Read HEAD and run update-index on paths that are
 	 * merged and already different between index and HEAD.
 	 */
 	int pos;
 	int has_head = 1;
 	struct pathspec pathspec;
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
-		       prefix, av + 1);
+		       prefix, paths);
 
 	if (read_ref("HEAD", &head_oid))
 		/* If there is no HEAD, that means it is an initial
 		 * commit.  Update everything in the index.
 		 */
@@ -968,11 +968,11 @@ static enum parse_opt_result reupdate_callback(
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
 	setup_work_tree();
-	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
+	*has_errors = do_reupdate(ctx->argv + 1, prefix);
 	if (*has_errors)
 		active_cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
-- 
2.38.0.371.g300879f34e

