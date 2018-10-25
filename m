Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718291F453
	for <e@80x24.org>; Thu, 25 Oct 2018 02:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJYLLH (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:11:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52378 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727372AbeJYLLG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 07:11:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9F8BB61B77;
        Thu, 25 Oct 2018 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540435223;
        bh=F/c1ZoxK5ohKZOnnWlLwi+Ho3wYh4kdchbWu0avYb28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FkNTq3hSiuS4j1gQiI+oinF44uFvCcAzjC46IPQCmUnKrSZorU+keVHPWoRm3idCf
         i1UN24w2v4gqjHvLdJ3/L4VyyvHpXYoFsf++bM/pNTgdvljzmZT+ibEvXBlWjS+aSq
         q7Iz0ja6rK8oeSaoMMWc3aIZDQqjFJ6rwHGrbXivYi/Cjh5FXMsOceGBcL/DlP03XJ
         jbLfC3eYtzF48dV7w0trcm372iHFlGhdt66nde13kL1zn098rJrLhLn6VPBPPMaOgz
         l5tiermd+kr8b2UWZzZqQrJFYh5Zi3CdPkVESk5kwcQaDRSpFsv1pmViu+GLg4QEHp
         An9Qw4sRANKHMq6xNF5p7PXcLkJdy+2ey06gr0fcISH3/thDBxdjYF7X78FFXH2hls
         SSBod5VVx3CxyHw9Nlm8Q3wGIMqk2Ya+Mw3xCSwr6FBKdtcJosj2nDH+rIQokM+YnP
         TVTbvS3hPIDAdlTpaTvRyWb1/ZVKIsiapN5PJoetEQ3m6Gjga24
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 09/12] commit-graph: convert to using the_hash_algo
Date:   Thu, 25 Oct 2018 02:40:02 +0000
Message-Id: <20181025024005.154208-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181025024005.154208-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using hard-coded constants for object sizes, use
the_hash_algo to look them up.  In addition, use a function call to look
up the object ID version and produce the correct value.  For now, we use
version 1, which means to use the default algorithm used in the rest of
the repository.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit-graph.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..6763d19288 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -23,16 +23,11 @@
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_LARGEEDGES 0x45444745 /* "EDGE" */
 
-#define GRAPH_DATA_WIDTH 36
+#define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
 #define GRAPH_VERSION_1 0x1
 #define GRAPH_VERSION GRAPH_VERSION_1
 
-#define GRAPH_OID_VERSION_SHA1 1
-#define GRAPH_OID_LEN_SHA1 GIT_SHA1_RAWSZ
-#define GRAPH_OID_VERSION GRAPH_OID_VERSION_SHA1
-#define GRAPH_OID_LEN GRAPH_OID_LEN_SHA1
-
 #define GRAPH_OCTOPUS_EDGES_NEEDED 0x80000000
 #define GRAPH_PARENT_MISSING 0x7fffffff
 #define GRAPH_EDGE_LAST_MASK 0x7fffffff
@@ -44,13 +39,18 @@
 #define GRAPH_FANOUT_SIZE (4 * 256)
 #define GRAPH_CHUNKLOOKUP_WIDTH 12
 #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
-			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
+			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
 
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir);
 }
 
+static uint8_t oid_version(void)
+{
+	return 1;
+}
+
 static struct commit_graph *alloc_commit_graph(void)
 {
 	struct commit_graph *g = xcalloc(1, sizeof(*g));
@@ -125,15 +125,15 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
-	if (hash_version != GRAPH_OID_VERSION) {
+	if (hash_version != oid_version()) {
 		error(_("hash version %X does not match version %X"),
-		      hash_version, GRAPH_OID_VERSION);
+		      hash_version, oid_version());
 		goto cleanup_fail;
 	}
 
 	graph = alloc_commit_graph();
 
-	graph->hash_len = GRAPH_OID_LEN;
+	graph->hash_len = the_hash_algo->rawsz;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->graph_fd = fd;
 	graph->data = graph_map;
@@ -149,7 +149,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
-		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
+		if (chunk_offset > graph_size - the_hash_algo->rawsz) {
 			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
 			goto cleanup_fail;
@@ -764,6 +764,7 @@ void write_commit_graph(const char *obj_dir,
 	int num_extra_edges;
 	struct commit_list *parent;
 	struct progress *progress = NULL;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -909,7 +910,7 @@ void write_commit_graph(const char *obj_dir,
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, GRAPH_OID_VERSION);
+	hashwrite_u8(f, oid_version());
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused padding byte */
 
@@ -924,8 +925,8 @@ void write_commit_graph(const char *obj_dir,
 
 	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
-	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
+	chunk_offsets[2] = chunk_offsets[1] + hashsz * commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * commits.nr;
 	chunk_offsets[4] = chunk_offsets[3] + 4 * num_extra_edges;
 
 	for (i = 0; i <= num_chunks; i++) {
@@ -938,8 +939,8 @@ void write_commit_graph(const char *obj_dir,
 	}
 
 	write_graph_chunk_fanout(f, commits.list, commits.nr);
-	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
+	write_graph_chunk_oids(f, hashsz, commits.list, commits.nr);
+	write_graph_chunk_data(f, hashsz, commits.list, commits.nr);
 	write_graph_chunk_large_edges(f, commits.list, commits.nr);
 
 	close_commit_graph(the_repository);
