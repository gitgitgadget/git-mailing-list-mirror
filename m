Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78346DDB8
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9068C1BD7
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:26:29 -0800 (PST)
Received: (qmail 25529 invoked by uid 109); 9 Nov 2023 07:26:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:26:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20914 invoked by uid 111); 9 Nov 2023 07:26:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:26:32 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:26:28 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 9/9] commit-graph: mark chunk error messages for translation
Message-ID: <20231109072628.GI2698043@coredump.intra.peff.net>
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

The patches from f32af12cee (Merge branch 'jk/chunk-bounds', 2023-10-23)
added many new untranslated error messages. While it's unlikely for most
users to see these messages at all, most of the other commit-graph error
messages are translated (and likewise for the matching midx messages).

Let's mark them all for consistency (and to help any poor unfortunate
user who does manage to find a broken graph file).

Signed-off-by: Jeff King <peff@peff.net>
---
The "wrong size" ones may be dropped eventually if we have a generic
pair_chunk_expect() API, but it seemed easier to just fix them all
mechanically in one go.

 commit-graph.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6fbfe4c68e..acac9bf6e1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -282,7 +282,7 @@ static int graph_read_oid_fanout(const unsigned char *chunk_start,
 	int i;
 
 	if (chunk_size != 256 * sizeof(uint32_t))
-		return error("commit-graph oid fanout chunk is wrong size");
+		return error(_("commit-graph oid fanout chunk is wrong size"));
 	g->chunk_oid_fanout = (const uint32_t *)chunk_start;
 	g->num_commits = ntohl(g->chunk_oid_fanout[255]);
 
@@ -291,7 +291,7 @@ static int graph_read_oid_fanout(const unsigned char *chunk_start,
 		uint32_t oid_fanout2 = ntohl(g->chunk_oid_fanout[i + 1]);
 
 		if (oid_fanout1 > oid_fanout2) {
-			error("commit-graph fanout values out of order");
+			error(_("commit-graph fanout values out of order"));
 			return 1;
 		}
 	}
@@ -314,7 +314,7 @@ static int graph_read_commit_data(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = data;
 	if (chunk_size / GRAPH_DATA_WIDTH != g->num_commits)
-		return error("commit-graph commit data chunk is wrong size");
+		return error(_("commit-graph commit data chunk is wrong size"));
 	g->chunk_commit_data = chunk_start;
 	return 0;
 }
@@ -324,7 +324,7 @@ static int graph_read_generation_data(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = data;
 	if (chunk_size / sizeof(uint32_t) != g->num_commits)
-		return error("commit-graph generations chunk is wrong size");
+		return error(_("commit-graph generations chunk is wrong size"));
 	g->chunk_generation_data = chunk_start;
 	return 0;
 }
@@ -334,7 +334,7 @@ static int graph_read_bloom_index(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = data;
 	if (chunk_size / 4 != g->num_commits) {
-		warning("commit-graph changed-path index chunk is too small");
+		warning(_("commit-graph changed-path index chunk is too small"));
 		return -1;
 	}
 	g->chunk_bloom_indexes = chunk_start;
@@ -348,8 +348,8 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	uint32_t hash_version;
 
 	if (chunk_size < BLOOMDATA_CHUNK_HEADER_SIZE) {
-		warning("ignoring too-small changed-path chunk"
-			" (%"PRIuMAX" < %"PRIuMAX") in commit-graph file",
+		warning(_("ignoring too-small changed-path chunk"
+			" (%"PRIuMAX" < %"PRIuMAX") in commit-graph file"),
 			(uintmax_t)chunk_size,
 			(uintmax_t)BLOOMDATA_CHUNK_HEADER_SIZE);
 		return -1;
@@ -605,7 +605,7 @@ int open_commit_graph_chain(const char *chain_file,
 			/* treat empty files the same as missing */
 			errno = ENOENT;
 		} else {
-			warning("commit-graph chain file too small");
+			warning(_("commit-graph chain file too small"));
 			errno = EINVAL;
 		}
 		return 0;
@@ -946,7 +946,7 @@ static int fill_commit_in_graph(struct repository *r,
 	parent_data_pos = edge_value & GRAPH_EDGE_LAST_MASK;
 	do {
 		if (g->chunk_extra_edges_size / sizeof(uint32_t) <= parent_data_pos) {
-			error("commit-graph extra-edges pointer out of bounds");
+			error(_("commit-graph extra-edges pointer out of bounds"));
 			free_commit_list(item->parents);
 			item->parents = NULL;
 			item->object.parsed = 0;
-- 
2.43.0.rc1.572.g273fc7bed6
