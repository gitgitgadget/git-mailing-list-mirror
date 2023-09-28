Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6562BCE7AFE
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 04:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjI1EiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjI1EiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 00:38:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A60F180
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 21:38:19 -0700 (PDT)
Received: (qmail 3679 invoked by uid 109); 28 Sep 2023 04:38:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Sep 2023 04:38:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9656 invoked by uid 111); 28 Sep 2023 04:38:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Sep 2023 00:38:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Sep 2023 00:38:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 2/6] commit-graph: check mixed generation validation when
 loading chain file
Message-ID: <20230928043817.GB58367@coredump.intra.peff.net>
References: <20230928043746.GB57926@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928043746.GB57926@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In read_commit_graph_one(), we call validate_mixed_generation_chain()
after loading the graph. Even though we don't check the return value,
this has the side effect of clearing the read_generation_data flag,
which is important when working with mixed generation numbers.

But doing this in load_commit_graph_chain_fd_st() makes more sense:

  1. We are calling it even when we did not load a chain at all, which
     is pointless (you cannot have mixed generations in a single file).

  2. For now, all callers load the graph via read_commit_graph_one().
     But the point of factoring out the open/load in the previous commit
     was to let "commit-graph verify" call them separately. So it needs
     to trigger this function as part of the load.

     Without this patch, the mixed-generation tests in t5324 would start
     failing on "git commit-graph verify" calls, once we switch to using
     a separate open/load call there.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as v1.

 commit-graph.c | 54 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 12cdd9af8e..8b29c6de24 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -473,6 +473,31 @@ static struct commit_graph *load_commit_graph_v1(struct repository *r,
 	return g;
 }
 
+/*
+ * returns 1 if and only if all graphs in the chain have
+ * corrected commit dates stored in the generation_data chunk.
+ */
+static int validate_mixed_generation_chain(struct commit_graph *g)
+{
+	int read_generation_data = 1;
+	struct commit_graph *p = g;
+
+	while (read_generation_data && p) {
+		read_generation_data = p->read_generation_data;
+		p = p->base_graph;
+	}
+
+	if (read_generation_data)
+		return 1;
+
+	while (g) {
+		g->read_generation_data = 0;
+		g = g->base_graph;
+	}
+
+	return 0;
+}
+
 static int add_graph_to_chain(struct commit_graph *g,
 			      struct commit_graph *chain,
 			      struct object_id *oids,
@@ -581,6 +606,8 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		}
 	}
 
+	validate_mixed_generation_chain(graph_chain);
+
 	free(oids);
 	fclose(fp);
 	strbuf_release(&line);
@@ -605,31 +632,6 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	return g;
 }
 
-/*
- * returns 1 if and only if all graphs in the chain have
- * corrected commit dates stored in the generation_data chunk.
- */
-static int validate_mixed_generation_chain(struct commit_graph *g)
-{
-	int read_generation_data = 1;
-	struct commit_graph *p = g;
-
-	while (read_generation_data && p) {
-		read_generation_data = p->read_generation_data;
-		p = p->base_graph;
-	}
-
-	if (read_generation_data)
-		return 1;
-
-	while (g) {
-		g->read_generation_data = 0;
-		g = g->base_graph;
-	}
-
-	return 0;
-}
-
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb)
 {
@@ -638,8 +640,6 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 	if (!g)
 		g = load_commit_graph_chain(r, odb);
 
-	validate_mixed_generation_chain(g);
-
 	return g;
 }
 
-- 
2.42.0.773.ga6e30199be

