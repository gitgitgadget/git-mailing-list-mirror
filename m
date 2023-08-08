Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E07C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjHHUPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjHHUO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:14:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BE9122615
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 12:15:58 -0700 (PDT)
Received: (qmail 4036 invoked by uid 109); 8 Aug 2023 19:15:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 19:15:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23067 invoked by uid 111); 8 Aug 2023 19:15:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 15:15:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 15:15:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [RFC/PATCH] commit-graph: verify swapped zero/non-zero generation
 cases
Message-ID: <20230808191536.GA4033224@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In verify_one_commit_graph(), we have code that complains when a commit
is found with a generation number of zero, and then later with a
non-zero number. It works like this:

  1. When we see an entry with generation zero, we set the
     generation_zero flag to GENERATION_ZERO_EXISTS.

  2. When we later see an entry with a non-zero generation, we complain
     if the flag is GENERATION_ZERO_EXISTS.

There's a matching GENERATION_NUMBER_EXISTS value, which in theory would
be used to find the case that we see the entries in the opposite order:

  1. When we see an entry with a non-zero generation, we set the
     generation_zero flag to GENERATION_NUMBER_EXISTS.

  2. When we later see an entry with a zero generation, we complain if
     the flag is GENERATION_NUMBER_EXISTS.

But that doesn't work; step 2 is implemented, but there is no step 1. We
never use NUMBER_EXISTS at all, and Coverity rightly complains that step
2 is dead code.

We can fix that by implementing that step 1.

Signed-off-by: Jeff King <peff@peff.net>
---
This is marked as RFC because I'm still confused about a lot of things.
For one, my explanation above about what the code is doing is mostly a
guess. It _looks_ to me like that's what the existing check is trying to
do. But if so, then why is the generation_zero flag defined outside the
loop over each object? I'd think it would be a per-object thing.

Likewise, just below this code, we check:

                if (generation_zero == GENERATION_ZERO_EXISTS)
                        continue;

Is the intent here "if this is the zero-th generation, we can skip the
rest of the loop because there are no more parents to look at"? If so,
then would it make more sense to check commit_graph_generation()
directly? I took care to preserve the existing behavior by pushing the
set of NUMBER_EXISTS into an "else", but it seems like a weird use of
the flag to me.

So I kind of wonder if there's something I'm not getting here. Coverity
is definitely right that our "step 2" is dead code (because we never set
NUMBER_EXISTS). But I'm not sure if we should be deleting it, or trying
to fix an underlying bug.

 commit-graph.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0aa1640d15..40cd55eb15 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2676,9 +2676,13 @@ static int verify_one_commit_graph(struct repository *r,
 				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
 					     oid_to_hex(&cur_oid));
 			generation_zero = GENERATION_ZERO_EXISTS;
-		} else if (generation_zero == GENERATION_ZERO_EXISTS)
-			graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
+		} else {
+			if (generation_zero == GENERATION_ZERO_EXISTS)
+				graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
 				     oid_to_hex(&cur_oid));
+			else
+				generation_zero = GENERATION_NUMBER_EXISTS;
+		}
 
 		if (generation_zero == GENERATION_ZERO_EXISTS)
 			continue;
-- 
2.42.0.rc0.376.g66bfc4f195
