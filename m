Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD9C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7D861350
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhDZBES (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhDZBEP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 77FD461476;
        Mon, 26 Apr 2021 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399014;
        bh=ZOjnyRr9hRX5DLBLBGdlBCS5pe9Ya5VGQHVYthcU5D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JhTjZgZu/uWducFsWKzflB8SDHAb3YXTxfrhDQvN5LaN5v8moeVAlTxYQ3jWfb5vo
         6SemwQFuXR2HV2gmWz7EGUW9gbQnRRCw/DBpMSd8KkAB0Tcz5swLLR2vBUTdiR3kWF
         a9JipEY0BhL9TwtMGG4jAivQ49r29Cuj0LwYcP1plkrURwMM7ySEyBbIJK/cs4mu3U
         AsglL/bcTwr6+6tUPIEq0B/ErUcI3zFONDWjtwvXJ1S3VjB6O8csS9mVtp4QNmgpA2
         T1dKWH9PkRzpzjtf5inloIpsbceJp0eX/sfMTilEzCXJte3l1iwPPf6orYztTlnduK
         /NcfunPokAZVDsrm4B/Hokd6wOXB3gsQTPqbTqVnNPf52Cd6C3i1cVrMFaIHSLAhgf
         kjWcdQ8GOyh7nDN2cG1IGOl5GORAnTyPpJ+cJWrMPz/IuFH80STZ4DDItDUgF/A+HY
         izibb/1Qg6esRYxHc14ETpHWJXrvDARF74qediI3aNLc1IWTHF7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/13] commit-graph: don't store file hashes as struct object_id
Date:   Mon, 26 Apr 2021 01:02:58 +0000
Message-Id: <20210426010301.1093562-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The idea behind struct object_id is that it is supposed to represent the
identifier of a standard Git object or a special pseudo-object like the
all-zeros object ID.  In this case, we have file hashes, which, while
similar, are distinct from the identifiers of objects.

Switch these code paths to use an unsigned char array.  This is both
more logically consistent and it means that we need not set the
algorithm identifier for the struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit-graph.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 23fef56d31..2bcb4e0f89 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1793,8 +1793,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct lock_file lk = LOCK_INIT;
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
-	struct object_id file_hash;
 	struct chunkfile *cf;
+	unsigned char file_hash[GIT_MAX_RAWSZ];
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -1909,7 +1909,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	close_commit_graph(ctx->r->objects);
-	finalize_hashfile(f, file_hash.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	finalize_hashfile(f, file_hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	free_chunkfile(cf);
 
 	if (ctx->split) {
@@ -1945,7 +1945,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			unlink(graph_name);
 		}
 
-		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(oid_to_hex(&file_hash));
+		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
 		final_graph_name = get_split_graph_filename(ctx->odb,
 					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
@@ -2425,7 +2425,8 @@ static void graph_report(const char *fmt, ...)
 int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 {
 	uint32_t i, cur_fanout_pos = 0;
-	struct object_id prev_oid, cur_oid, checksum;
+	struct object_id prev_oid, cur_oid;
+	unsigned char checksum[GIT_MAX_HEXSZ];
 	int generation_zero = 0;
 	struct hashfile *f;
 	int devnull;
@@ -2444,8 +2445,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	devnull = open("/dev/null", O_WRONLY);
 	f = hashfd(devnull, NULL);
 	hashwrite(f, g->data, g->data_len - g->hash_len);
-	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
-	if (!hasheq(checksum.hash, g->data + g->data_len - g->hash_len)) {
+	finalize_hashfile(f, checksum, CSUM_CLOSE);
+	if (!hasheq(checksum, g->data + g->data_len - g->hash_len)) {
 		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));
 		verify_commit_graph_error = VERIFY_COMMIT_GRAPH_ERROR_HASH;
 	}
