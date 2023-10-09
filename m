Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA56CD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378026AbjJIU61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIU60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:58:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2977292
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:58:25 -0700 (PDT)
Received: (qmail 24298 invoked by uid 109); 9 Oct 2023 20:58:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 20:58:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18502 invoked by uid 111); 9 Oct 2023 20:58:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 16:58:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 16:58:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 01/20] chunk-format: note that pair_chunk() is unsafe
Message-ID: <20231009205823.GA3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pair_chunk() function is provided as an easy helper for parsing
chunks that just want a pointer to a set of bytes. But every caller has
a hidden bug: because we return only the pointer without the matching
chunk size, the callers have no clue how many bytes they are allowed to
look at. And as a result, they may read off the end of the mmap'd data
when the on-disk file does not match their expectations.

Since chunk files are typically used for local-repository data like
commit-graph files and midx's, the security implications here are pretty
mild. The worst that can happen is that you hand somebody a corrupted
repository tarball, and running Git on it does an out-of-bounds read and
crashes. So it's worth being more defensive, but we don't need to drop
everything and fix every caller immediately.

I noticed the problem because the pair_chunk_fn() callback does not look
at its chunk_size argument, and wanted to annotate it to silence
-Wunused-parameter. We could do that now, but we'd lose the hint that
this code should be audited and fixed.

So instead, let's set ourselves up for going down that path:

  1. Provide a pair_chunk() function that does return the size, which
     prepares us for fixing these cases.

  2. Rename the existing function to pair_chunk_unsafe(). That gives us
     an easy way to grep for cases which still need to be fixed, and the
     name should cause anybody adding new calls to think twice before
     using it.

There are no callers of the "safe" version yet, but we'll add some in
subsequent patches.

Signed-off-by: Jeff King <peff@peff.net>
---
I originally wasn't sure if I'd convert every case, or if we'd have to
leave some longer-term. But as you'll see at the end, we can get rid of
pair_chunk_unsafe() in the final patch (but we need both forms to
co-exist during the series, since the intermediate state is that we have
some safe and some unsafe calls).

 chunk-format.c | 24 ++++++++++++++++++++----
 chunk-format.h | 19 +++++++++++++++++--
 commit-graph.c | 14 +++++++-------
 midx.c         | 10 +++++-----
 4 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index 140dfa0dcc..8d910e23f6 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -154,20 +154,36 @@ int read_table_of_contents(struct chunkfile *cf,
 	return 0;
 }
 
+struct pair_chunk_data {
+	const unsigned char **p;
+	size_t *size;
+};
+
 static int pair_chunk_fn(const unsigned char *chunk_start,
 			 size_t chunk_size,
 			 void *data)
 {
-	const unsigned char **p = data;
-	*p = chunk_start;
+	struct pair_chunk_data *pcd = data;
+	*pcd->p = chunk_start;
+	*pcd->size = chunk_size;
 	return 0;
 }
 
 int pair_chunk(struct chunkfile *cf,
 	       uint32_t chunk_id,
-	       const unsigned char **p)
+	       const unsigned char **p,
+	       size_t *size)
+{
+	struct pair_chunk_data pcd = { .p = p, .size = size };
+	return read_chunk(cf, chunk_id, pair_chunk_fn, &pcd);
+}
+
+int pair_chunk_unsafe(struct chunkfile *cf,
+		      uint32_t chunk_id,
+		      const unsigned char **p)
 {
-	return read_chunk(cf, chunk_id, pair_chunk_fn, p);
+	size_t dummy;
+	return pair_chunk(cf, chunk_id, p, &dummy);
 }
 
 int read_chunk(struct chunkfile *cf,
diff --git a/chunk-format.h b/chunk-format.h
index c7794e84ad..8dce7967f4 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -43,13 +43,28 @@ int read_table_of_contents(struct chunkfile *cf,
 /*
  * Find 'chunk_id' in the given chunkfile and assign the
  * given pointer to the position in the mmap'd file where
- * that chunk begins.
+ * that chunk begins. Likewise the "size" parameter is filled
+ * with the size of the chunk.
  *
  * Returns CHUNK_NOT_FOUND if the chunk does not exist.
  */
 int pair_chunk(struct chunkfile *cf,
 	       uint32_t chunk_id,
-	       const unsigned char **p);
+	       const unsigned char **p,
+	       size_t *size);
+
+/*
+ * Unsafe version of pair_chunk; it does not return the size,
+ * meaning that the caller cannot possibly be careful about
+ * reading out of bounds from the mapped memory.
+ *
+ * No new callers should use this function, and old callers should
+ * be audited and migrated over to using the regular pair_chunk()
+ * function.
+ */
+int pair_chunk_unsafe(struct chunkfile *cf,
+		      uint32_t chunk_id,
+		      const unsigned char **p);
 
 typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
 			     size_t chunk_size, void *data);
diff --git a/commit-graph.c b/commit-graph.c
index 1a56efcf69..a689a55b79 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -394,25 +394,25 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 				   GRAPH_HEADER_SIZE, graph->num_chunks))
 		goto free_and_return;
 
-	pair_chunk(cf, GRAPH_CHUNKID_OIDFANOUT,
+	pair_chunk_unsafe(cf, GRAPH_CHUNKID_OIDFANOUT,
 		   (const unsigned char **)&graph->chunk_oid_fanout);
 	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
-	pair_chunk(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
-	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
-	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
+	pair_chunk_unsafe(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
+	pair_chunk_unsafe(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
+	pair_chunk_unsafe(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
 
 	if (s->commit_graph_generation_version >= 2) {
-		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
+		pair_chunk_unsafe(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			&graph->chunk_generation_data);
-		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
+		pair_chunk_unsafe(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			&graph->chunk_generation_data_overflow);
 
 		if (graph->chunk_generation_data)
 			graph->read_generation_data = 1;
 	}
 
 	if (s->commit_graph_read_changed_paths) {
-		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
+		pair_chunk_unsafe(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
 			   graph_read_bloom_data, graph);
diff --git a/midx.c b/midx.c
index 931f557350..3165218ab5 100644
--- a/midx.c
+++ b/midx.c
@@ -143,19 +143,19 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 				   MIDX_HEADER_SIZE, m->num_chunks))
 		goto cleanup_fail;
 
-	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names) == CHUNK_NOT_FOUND)
+	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required pack-name chunk"));
 	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required OID fanout chunk"));
-	if (pair_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup) == CHUNK_NOT_FOUND)
+	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required OID lookup chunk"));
-	if (pair_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets) == CHUNK_NOT_FOUND)
+	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets) == CHUNK_NOT_FOUND)
 		die(_("multi-pack-index missing required object offsets chunk"));
 
-	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
+	pair_chunk_unsafe(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
 
 	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
-		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex);
+		pair_chunk_unsafe(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex);
 
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
-- 
2.42.0.884.g35e1fe1a6a

