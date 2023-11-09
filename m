Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F50D2FE
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE7093
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:17:12 -0800 (PST)
Received: (qmail 25399 invoked by uid 109); 9 Nov 2023 07:17:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:17:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20729 invoked by uid 111); 9 Nov 2023 07:17:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:17:15 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:17:11 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 5/9] commit-graph: abort as soon as we see a bogus chunk
Message-ID: <20231109071711.GE2698043@coredump.intra.peff.net>
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

The code to read commit-graph files tries to read all of the required
chunks, but doesn't abort if we can't find one (or if it's corrupted).
It's only at the end of reading the file that we then do some sanity
checks for NULL entries. But it's preferable to detect the errors and
bail immediately, for a few reasons:

  1. It's less error-prone. It's easy in the reader functions to flag an
     error but still end up setting some struct fields (an error I in
     fact made while working on this patch series).

  2. It's safer. Since verifying some chunks depends on the values of
     other chunks, we may be depending on not-yet-verified data. I don't
     know offhand of any case where this can cause problems, but it's
     one less subtle thing to worry about in the reader code.

  3. It prevents the user from seeing nonsense errors. If we're missing
     an OIDL chunk, then g->num_commits will be zero. And so we may
     complain that the size of our CDAT chunk (which should have a
     fixed-size record for each commit) is wrong unless it's also zero.
     But that's misleading; the problem is the missing OIDL chunk; the
     CDAT one might be fine!

So let's just check the return value from read_chunk(). This is exactly
how the midx chunk-reading code does it.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 989ebbe816..374575b484 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -291,19 +291,6 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	 * over g->num_commits, or runs a checksum on the commit-graph
 	 * itself.
 	 */
-	if (!g->chunk_oid_fanout) {
-		error(_("commit-graph required OID fanout chunk missing or corrupted"));
-		return 1;
-	}
-	if (!g->chunk_oid_lookup) {
-		error(_("commit-graph required OID lookup chunk missing or corrupted"));
-		return 1;
-	}
-	if (!g->chunk_commit_data) {
-		error(_("commit-graph required commit data chunk missing or corrupted"));
-		return 1;
-	}
-
 	for (i = 0; i < 255; i++) {
 		uint32_t oid_fanout1 = ntohl(g->chunk_oid_fanout[i]);
 		uint32_t oid_fanout2 = ntohl(g->chunk_oid_fanout[i + 1]);
@@ -462,9 +449,19 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 				   GRAPH_HEADER_SIZE, graph->num_chunks, 1))
 		goto free_and_return;
 
-	read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
-	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
-	read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph);
+	if (read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph)) {
+		error(_("commit-graph required OID fanout chunk missing or corrupted"));
+		goto free_and_return;
+	}
+	if (read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph)) {
+		error(_("commit-graph required OID lookup chunk missing or corrupted"));
+		goto free_and_return;
+	}
+	if (read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph)) {
+		error(_("commit-graph required commit data chunk missing or corrupted"));
+		goto free_and_return;
+	}
+
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges,
 		   &graph->chunk_extra_edges_size);
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs,
-- 
2.43.0.rc1.572.g273fc7bed6

