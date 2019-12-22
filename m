Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF5C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6383920665
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVJcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 04:32:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:52222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725899AbfLVJcI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 04:32:08 -0500
Received: (qmail 12634 invoked by uid 109); 22 Dec 2019 09:32:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Dec 2019 09:32:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26879 invoked by uid 111); 22 Dec 2019 09:36:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Dec 2019 04:36:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Dec 2019 04:32:06 -0500
From:   Jeff King <peff@peff.net>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] commit-graph: examine changed-path objects in pack order
Message-ID: <20191222093206.GA3460818@coredump.intra.peff.net>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191222093036.GA3449072@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking at the diff of commit objects in pack order is much faster than
in sha1 order, as it gives locality to the access of tree deltas
(whereas sha1 order is effectively random). Unfortunately the
commit-graph code sorts the commits (several times, sometimes as an oid
and sometimes a pointer-to-commit), and we ultimately traverse in sha1
order.

Instead, let's remember the position at which we see each commit, and
traverse in that order when looking at bloom filters. This drops my time
for "git commit-graph write --changed-paths" in linux.git from ~4
minutes to ~1.5 minutes.

Probably the "--reachable" code path would want something similar.

Or alternatively, we could use a different data structure (either a
hash, or maybe even just a bit in "struct commit") to keep track of
which oids we've seen, etc instead of sorting. And then we could keep
the original order.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0580ce75d5..bf6c663772 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -17,6 +17,7 @@
 #include "replace-object.h"
 #include "progress.h"
 #include "bloom.h"
+#include "commit-slab.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -48,6 +49,29 @@
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
+/* Keep track of the order in which commits are added to our list. */
+define_commit_slab(commit_pos, int);
+static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
+
+static void set_commit_pos(struct repository *r, const struct object_id *oid)
+{
+	static int32_t max_pos;
+	struct commit *commit = lookup_commit(r, oid);
+
+	if (!commit)
+		return; /* should never happen, but be lenient */
+
+	*commit_pos_at(&commit_pos, commit) = max_pos++;
+}
+
+static int commit_pos_cmp(const void *va, const void *vb)
+{
+	const struct commit *a = *(const struct commit **)va;
+	const struct commit *b = *(const struct commit **)vb;
+	return commit_pos_at(&commit_pos, a) -
+	       commit_pos_at(&commit_pos, b);
+}
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
@@ -1088,6 +1112,8 @@ static int add_packed_commits(const struct object_id *oid,
 	oidcpy(&(ctx->oids.list[ctx->oids.nr]), oid);
 	ctx->oids.nr++;
 
+	set_commit_pos(ctx->r, oid);
+
 	return 0;
 }
 
@@ -1208,6 +1234,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct progress *progress = NULL;
+	struct commit **sorted_by_pos;
 
 	load_bloom_filters();
 
@@ -1216,13 +1243,18 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			_("Computing commit diff Bloom filters"),
 			ctx->commits.nr);
 
+	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
+	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
+	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
+
 	for (i = 0; i < ctx->commits.nr; i++) {
-		struct commit *c = ctx->commits.list[i];
+		struct commit *c = sorted_by_pos[i];
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
 		ctx->total_bloom_filter_size += sizeof(uint64_t) * filter->len;
 		display_progress(progress, i + 1);
 	}
 
+	free(sorted_by_pos);
 	stop_progress(&progress);
 }
 
-- 
2.24.1.1152.gda0b849012

