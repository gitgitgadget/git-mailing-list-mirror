Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE941F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeH2BQZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:16:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:59542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726998AbeH2BQY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:16:24 -0400
Received: (qmail 29825 invoked by uid 109); 28 Aug 2018 21:22:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 21:22:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5861 invoked by uid 111); 28 Aug 2018 21:23:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 Aug 2018 17:23:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2018 17:22:52 -0400
Date:   Tue, 28 Aug 2018 17:22:52 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 6/9] convert "hashcmp() != 0" to "!hasheq()"
Message-ID: <20180828212252.GF11036@sigill.intra.peff.net>
References: <20180828212126.GA7039@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212126.GA7039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rounds out the previous three patches, covering the
inequality logic for the "hash" variant of the functions.

As with the previous three, the accompanying code changes
are the mechanical result of applying the coccinelle patch;
see those patches for more discussion.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c               | 4 ++--
 builtin/show-branch.c              | 2 +-
 builtin/unpack-objects.c           | 2 +-
 commit-graph.c                     | 2 +-
 contrib/coccinelle/object_id.cocci | 9 +++++++++
 http-walker.c                      | 2 +-
 http.c                             | 2 +-
 pack-check.c                       | 6 +++---
 pack-write.c                       | 2 +-
 packfile.c                         | 2 +-
 read-cache.c                       | 4 ++--
 sha1-file.c                        | 2 +-
 12 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index edcb0a3dca..2004e25da2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1166,7 +1166,7 @@ static void parse_pack_objects(unsigned char *hash)
 	/* Check pack integrity */
 	flush();
 	the_hash_algo->final_fn(hash, &input_ctx);
-	if (hashcmp(fill(the_hash_algo->rawsz), hash))
+	if (!hasheq(fill(the_hash_algo->rawsz), hash))
 		die(_("pack is corrupted (SHA1 mismatch)"));
 	use(the_hash_algo->rawsz);
 
@@ -1280,7 +1280,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		fixup_pack_header_footer(output_fd, pack_hash,
 					 curr_pack, nr_objects,
 					 read_hash, consumed_bytes-the_hash_algo->rawsz);
-		if (hashcmp(read_hash, tail_hash) != 0)
+		if (!hasheq(read_hash, tail_hash))
 			die(_("Unexpected tail checksum for %s "
 			      "(disk corruption?)"), curr_pack);
 	}
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 5f9432861b..65f4a4c83c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -485,7 +485,7 @@ static void snarf_refs(int head, int remotes)
 static int rev_is_head(const char *head, const char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
-	if (!head || (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
+	if (!head || (head_sha1 && sha1 && !hasheq(head_sha1, sha1)))
 		return 0;
 	skip_prefix(head, "refs/heads/", &head);
 	if (!skip_prefix(name, "refs/heads/", &name))
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index ad438f5b41..80478808b3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -579,7 +579,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 		if (fsck_finish(&fsck_options))
 			die(_("fsck error in pack objects"));
 	}
-	if (hashcmp(fill(the_hash_algo->rawsz), oid.hash))
+	if (!hasheq(fill(the_hash_algo->rawsz), oid.hash))
 		die("final sha1 did not match");
 	use(the_hash_algo->rawsz);
 
diff --git a/commit-graph.c b/commit-graph.c
index 7aed9f5371..64ce79420d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -900,7 +900,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	f = hashfd(devnull, NULL);
 	hashwrite(f, g->data, g->data_len - g->hash_len);
 	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
-	if (hashcmp(checksum.hash, g->data + g->data_len - g->hash_len)) {
+	if (!hasheq(checksum.hash, g->data + g->data_len - g->hash_len)) {
 		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));
 		verify_commit_graph_error = VERIFY_COMMIT_GRAPH_ERROR_HASH;
 	}
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 4e1f1a7431..d8bdb48712 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -129,3 +129,12 @@ expression E1, E2;
 @@
 - oidcmp(E1, E2) != 0
 + !oideq(E1, E2)
+
+@@
+identifier f != hasheq;
+expression E1, E2;
+@@
+  f(...) {<...
+- hashcmp(E1, E2) != 0
++ !hasheq(E1, E2)
+  ...>}
diff --git a/http-walker.c b/http-walker.c
index 3a8edc7f2f..b3334bf657 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -543,7 +543,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 	} else if (req->zret != Z_STREAM_END) {
 		walker->corrupt_object_found++;
 		ret = error("File %s (%s) corrupt", hex, req->url);
-	} else if (hashcmp(obj_req->oid.hash, req->real_sha1)) {
+	} else if (!hasheq(obj_req->oid.hash, req->real_sha1)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/http.c b/http.c
index 4162860ee3..98ff122585 100644
--- a/http.c
+++ b/http.c
@@ -2394,7 +2394,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	if (hashcmp(freq->sha1, freq->real_sha1)) {
+	if (!hasheq(freq->sha1, freq->real_sha1)) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
diff --git a/pack-check.c b/pack-check.c
index d3a57df34f..fa5f0ff8fa 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -79,10 +79,10 @@ static int verify_packfile(struct packed_git *p,
 	} while (offset < pack_sig_ofs);
 	the_hash_algo->final_fn(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
-	if (hashcmp(hash, pack_sig))
+	if (!hasheq(hash, pack_sig))
 		err = error("%s pack checksum mismatch",
 			    p->pack_name);
-	if (hashcmp(index_base + index_size - the_hash_algo->hexsz, pack_sig))
+	if (!hasheq(index_base + index_size - the_hash_algo->hexsz, pack_sig))
 		err = error("%s pack checksum does not match its index",
 			    p->pack_name);
 	unuse_pack(w_curs);
@@ -180,7 +180,7 @@ int verify_pack_index(struct packed_git *p)
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, index_base, (unsigned int)(index_size - the_hash_algo->rawsz));
 	the_hash_algo->final_fn(hash, &ctx);
-	if (hashcmp(hash, index_base + index_size - the_hash_algo->rawsz))
+	if (!hasheq(hash, index_base + index_size - the_hash_algo->rawsz))
 		err = error("Packfile index for %s hash mismatch",
 			    p->pack_name);
 	return err;
diff --git a/pack-write.c b/pack-write.c
index 7d14716c40..29d17a9bec 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -260,7 +260,7 @@ void fixup_pack_header_footer(int pack_fd,
 		if (partial_pack_offset == 0) {
 			unsigned char hash[GIT_MAX_RAWSZ];
 			the_hash_algo->final_fn(hash, &old_hash_ctx);
-			if (hashcmp(hash, partial_pack_hash) != 0)
+			if (!hasheq(hash, partial_pack_hash))
 				die("Unexpected checksum for %s "
 				    "(disk corruption?)", pack_name);
 			/*
diff --git a/packfile.c b/packfile.c
index c2e96293ad..1e9eacd9b3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -517,7 +517,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (read_result != hashsz)
 		return error("packfile %s signature is unavailable", p->pack_name);
 	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
-	if (hashcmp(hash, idx_hash))
+	if (!hasheq(hash, idx_hash))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
index 88bb80326b..421a7f4953 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1668,7 +1668,7 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
 	the_hash_algo->final_fn(hash, &c);
-	if (hashcmp(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
+	if (!hasheq(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
 		return error("bad index file sha1 signature");
 	return 0;
 }
@@ -2395,7 +2395,7 @@ static int verify_index_from(const struct index_state *istate, const char *path)
 	if (n != the_hash_algo->rawsz)
 		goto out;
 
-	if (hashcmp(istate->oid.hash, hash))
+	if (!hasheq(istate->oid.hash, hash))
 		goto out;
 
 	close(fd);
diff --git a/sha1-file.c b/sha1-file.c
index cc8a196349..d85f4e93e1 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2213,7 +2213,7 @@ static int check_stream_sha1(git_zstream *stream,
 	}
 
 	the_hash_algo->final_fn(real_sha1, &c);
-	if (hashcmp(expected_sha1, real_sha1)) {
+	if (!hasheq(expected_sha1, real_sha1)) {
 		error(_("sha1 mismatch for %s (expected %s)"), path,
 		      sha1_to_hex(expected_sha1));
 		return -1;
-- 
2.19.0.rc0.584.g84d5b2a847

