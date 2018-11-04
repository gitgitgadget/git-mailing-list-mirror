Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E2A1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 23:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbeKEJCC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:02:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53236 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729686AbeKEJCC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Nov 2018 04:02:02 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D154061B76;
        Sun,  4 Nov 2018 23:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541375116;
        bh=F/c1ZoxK5ohKZOnnWlLwi+Ho3wYh4kdchbWu0avYb28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nrR7OemcrgJb4MLnneyU0oSbGAlf/h6LplCLpu+Axok31bqsu67mo5U2rxqpX0Mga
         k++M4LeXWWhKL4Q966jfY+tt+ZVjtZwAekqELR7v6KJBeLVbr5rZNvCEcCe4K80zk2
         fL1UwIevQ/NIStP0A70GP81OFa4BHLtpGatfRM239+FFvraKc0MNTlj3xlEpMn7vrh
         YsLVnfGrJAg3cphTpMMOS9sSI83AUuioCgUxFnu3v+94W5oXKaFr0Qepht4lEoc5X5
         63Th9bvZsM9Je2YljhwuV0DRkaZZyVVtAL+V9Btn9Lo/8KqkXeCOXVaQerX+jvHbrC
         DxPsYDMqZJWjMsBMcDhiCN1u7lpBB+UTNFCul2Ok5/QtZWfyJ4Tl0bMfveCL7YVxyn
         o+0FyQAyqYOICOuz6PF0+vhxO+BE02qD5RKP32+f2Cp4IsxhLBKSxQtFCTTtSIqEGm
         8GuAoru6V/+Qp9kJFDTwXamv5v6xrvlT4YgYvpySWD7DxWmdBWp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 09/12] commit-graph: convert to using the_hash_algo
Date:   Sun,  4 Nov 2018 23:44:55 +0000
Message-Id: <20181104234458.139223-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181104234458.139223-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
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
