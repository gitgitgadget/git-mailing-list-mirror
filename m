Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A123A3217
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155981BFD
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:25:25 -0800 (PST)
Received: (qmail 25512 invoked by uid 109); 9 Nov 2023 07:25:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:25:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20901 invoked by uid 111); 9 Nov 2023 07:25:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:25:29 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:25:24 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 8/9] commit-graph: drop verify_commit_graph_lite()
Message-ID: <20231109072524.GH2698043@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109070310.GA2697602@coredump.intra.peff.net>

As we've moved all of the checks from this function directly into the
chunk-reading code used by the caller (and there is only one caller), we
can just drop it entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4ba523cd15..6fbfe4c68e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -275,23 +275,6 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	return ret;
 }
 
-static int verify_commit_graph_lite(struct commit_graph *g)
-{
-	/*
-	 * Basic validation shared between parse_commit_graph()
-	 * which'll be called every time the graph is used, and the
-	 * much more expensive verify_commit_graph() used by
-	 * "commit-graph verify".
-	 *
-	 * There should only be very basic checks here to ensure that
-	 * we don't e.g. segfault in fill_commit_in_graph(), but
-	 * because this is a very hot codepath nothing that e.g. loops
-	 * over g->num_commits, or runs a checksum on the commit-graph
-	 * itself.
-	 */
-	return 0;
-}
-
 static int graph_read_oid_fanout(const unsigned char *chunk_start,
 				 size_t chunk_size, void *data)
 {
@@ -495,9 +478,6 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_len);
 
-	if (verify_commit_graph_lite(graph))
-		goto free_and_return;
-
 	free_chunkfile(cf);
 	return graph;
 
-- 
2.43.0.rc1.572.g273fc7bed6

