Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2928C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1C0611CA
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhDJPW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234863AbhDJPWw (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 74D1660798;
        Sat, 10 Apr 2021 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068156;
        bh=ZOjnyRr9hRX5DLBLBGdlBCS5pe9Ya5VGQHVYthcU5D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=iIzFDdqgaa/yF9z+esb8aqV6zNP85hm72I2K31Skb5gMKgM1fYLXuY/wwlDpK1wtg
         IliaA6qUXdqkM0s4gr82EqfMNbVvZo0t54PgfiqV0RUkcaYdHx6Dy5qafih5AIMiKk
         Nx+PM3T9+2YpRteN4haRxvDuksSZKSnKfFRYqWfSe27iclaH5ZA9dizVTmYqlijs1r
         odcoOiazmXOvLAov7jOg3JrLXkTjuk5GNMu05F6as6MfzXrFKQdoMtxFXYdemq8mbh
         5FP0ss3je1RLe9JU3uHm02Wk5v0haDhZEnAfVBHV3VrMxpCxpUkd1aYVjq+RBnI+Ue
         GlJFJjo0o2aMe/lpekif/P7GKZyKB/nVODOoMNr6DoXP4+F0P2TgkVzgmD8xFH2G5b
         c72PmO7KR+kkiyHfqssN6GchD2+2iOaIj/S5Uv13rXQiOqdnY0MT60o84akjjZ8BLp
         QS8khnj7gTbw6COQipCVNDMN/vBbKGklGRpcRwHWOWHvv/KUwEI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 12/15] commit-graph: don't store file hashes as struct object_id
Date:   Sat, 10 Apr 2021 15:21:37 +0000
Message-Id: <20210410152140.3525040-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
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
