Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA5A1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeH2Ex3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37326 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727607AbeH2Ex2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C344560758
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504352;
        bh=RC8/QnrumpnVGN65tgAU5FvM6tso2wmXrICXTooe+XM=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=ro12ePWSLJUbL3kOSIgr5P8BFkBdq+ceU3nEB5lI+wdUDLu3W53k4IUsxw0WrCOz+
         6LBSRu/7YNIB/5koWuWF8AK7/kDc86UFREM5eFeBw1ssuvt+NzOxdu1MoWhfEuZhkv
         0ONMjaiSiRya4pUTlg2t3v1lHyHEfFjKs6w/o/VXJSpL/01md/9Enf8biv4A3WsQ/W
         EO8D8amW06RpWgBauiK/IjlZHSCqDouepacfLV7dn5foxRtB/+h1KQPWAGDTiM3u09
         MQGCxUa8OFELTiWgAdTiKMhkDQSgs649vfVyY+qosdQvyWQ2c/ubA3V7sobbpBB4BW
         S20DqC/ktjt/bH9XLEd55R4zgJEq1SGEzpLF5t1w0kFPSzFHVECnjm6OYFVOl1Jjiw
         R2abRpRH473UGjxjXVQAbLMW7uttacJcqKaKPMsFmy+9XL8E83gJ2dVQuCHCQ4Dkc2
         CK8MbKyyY0Wk3FtTx+e8m3Y/vAb2UMP1jX8ZZjrGwFqrv/DmsyA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 08/12]  commit-graph: convert to using the_hash_algo
Date:   Wed, 29 Aug 2018 00:58:53 +0000
Message-Id: <20180829005857.980820-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005857.980820-1-sandals@crustytoothpaste.net>
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using hard-coded constants for object sizes, use
the_hash_algo to look them up.  In addition, use a function call to look
up the object ID version and produce the correct value.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit-graph.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8a1bec7b8a..29356d84a2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -25,11 +25,6 @@
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
@@ -41,13 +36,18 @@
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
@@ -100,15 +100,15 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
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
@@ -124,7 +124,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
-		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
+		if (chunk_offset > graph_size - the_hash_algo->rawsz) {
 			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
 			goto cleanup_fail;
@@ -692,6 +692,7 @@ void write_commit_graph(const char *obj_dir,
 	int num_chunks;
 	int num_extra_edges;
 	struct commit_list *parent;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	oids.nr = 0;
 	oids.alloc = approximate_object_count() / 4;
@@ -812,7 +813,7 @@ void write_commit_graph(const char *obj_dir,
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, GRAPH_OID_VERSION);
+	hashwrite_u8(f, oid_version());
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused padding byte */
 
@@ -827,8 +828,8 @@ void write_commit_graph(const char *obj_dir,
 
 	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
-	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
+	chunk_offsets[2] = chunk_offsets[1] + hashsz * commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * commits.nr;
 	chunk_offsets[4] = chunk_offsets[3] + 4 * num_extra_edges;
 
 	for (i = 0; i <= num_chunks; i++) {
@@ -841,8 +842,8 @@ void write_commit_graph(const char *obj_dir,
 	}
 
 	write_graph_chunk_fanout(f, commits.list, commits.nr);
-	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
+	write_graph_chunk_oids(f, hashsz, commits.list, commits.nr);
+	write_graph_chunk_data(f, hashsz, commits.list, commits.nr);
 	write_graph_chunk_large_edges(f, commits.list, commits.nr);
 
 	close_commit_graph();
