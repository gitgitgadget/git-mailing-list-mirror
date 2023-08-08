Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A42CC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjHHUSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHHUSa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:18:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0144F76
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 12:22:42 -0700 (PDT)
Received: (qmail 4475 invoked by uid 109); 8 Aug 2023 19:22:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 19:22:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23114 invoked by uid 111); 8 Aug 2023 19:22:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 15:22:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 15:22:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: leak in jt/path-filter-fix, was Re: What's cooking in git.git (Aug
 2023, #01; Wed, 2)
Message-ID: <20230808192240.GA4091261@coredump.intra.peff.net>
References: <xmqqfs518gdh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs518gdh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2023 at 11:10:34AM -0700, Junio C Hamano wrote:

> * jt/path-filter-fix (2023-08-01) 7 commits
>  - commit-graph: new filter ver. that fixes murmur3
>  - repo-settings: introduce commitgraph.changedPathsVersion
>  - t4216: test changed path filters with high bit paths
>  - t/helper/test-read-graph: implement `bloom-filters` mode
>  - bloom.h: make `load_bloom_filter_from_graph()` public
>  - t/helper/test-read-graph.c: extract `dump_graph_info()`
>  - gitformat-commit-graph: describe version 2 of BDAT
> 
>  The Bloom filter used for path limited history traversal was broken
>  on systems whose "char" is unsigned; update the implementation and
>  bump the format version to 2.
> 
>  Still under discussion.
>  cf. <20230801185232.1457172-1-jonathantanmy@google.com>
>  source: <cover.1690912539.git.jonathantanmy@google.com>

Since this hit 'next', Coverity complained about a small leak. Fixed by
the patch below.

-- >8 --
Subject: [PATCH] commit-graph: fix small leak with invalid changedPathsVersion

When writing a commit graph, we sanity-check the value of
commitgraph.changedPathsVersion and return early if it's invalid. But we
only do so after allocating the write_commit_graph_context, meaing we
leak it. We could "goto cleanup" to fix this, but instead let's push
this check to the top of the function with the other early checks which
return before doing any work.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 38edb12669..ccc21c6708 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2372,6 +2372,12 @@ int write_commit_graph(struct object_directory *odb,
 	}
 	if (!commit_graph_compatible(r))
 		return 0;
+	if (r->settings.commit_graph_changed_paths_version < -1
+	    || r->settings.commit_graph_changed_paths_version > 2) {
+		warning(_("attempting to write a commit-graph, but 'commitgraph.changedPathsVersion' (%d) is not supported"),
+			r->settings.commit_graph_changed_paths_version);
+		return 0;
+	}
 
 	CALLOC_ARRAY(ctx, 1);
 	ctx->r = r;
@@ -2384,12 +2390,6 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
-	if (r->settings.commit_graph_changed_paths_version < -1
-	    || r->settings.commit_graph_changed_paths_version > 2) {
-		warning(_("attempting to write a commit-graph, but 'commitgraph.changedPathsVersion' (%d) is not supported"),
-			r->settings.commit_graph_changed_paths_version);
-		return 0;
-	}
 	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
 		? 2 : 1;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
-- 
2.42.0.rc0.376.g66bfc4f195

