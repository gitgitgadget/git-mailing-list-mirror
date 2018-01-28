Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904591F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeA1P6G (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:58:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58394 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751296AbeA1P5k (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 98EF760FBD;
        Sun, 28 Jan 2018 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155059;
        bh=OL/VpMEErEah/516ggxLkmotu1LJ92j0MYbhHI9NjyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WLaqFCU5VxgLzZOGVd/v2tXTrUpuLfiWXW2B4W+dDTwagSR/3M87TXqKbDd2IMtJZ
         zrmlBi6Nx6EDla2bQGlnprul60k/eIILycmx5MnBrWOoVDpJkfakNxqh/jLdgW5tVw
         jMI2diDu0+2FnwiEBcxQcW0/G5/e1ptAWi2T9BHrzh6P4GtZyE6W4BNHVr0imovaCw
         I3B5C08uEP8cgc//pKMwI/4QeFg3ktsO1p/6Jl13iFJvMXPy6G8WuTXjhENKWc+Pcs
         1oZ1NBFkx1v3x99TedXeX4lLFqIWrzX3w+9TgUtPpfFEZL95hn1cAS7OIFbeMuoYct
         C3m7ZxTsliuOLB4UgeLUOiSQPBFl12iXt2JAluqpEUEEmgDi+cWOPa98q1Bcdfvcc7
         KSi47znX7sX53qhB7/Vu14XmXGa+GY22AKfnrR+BvF1s62lxQ2TMd9iFCN5EgvDFRT
         HavgVmgw1vooTZasRON4aMMjgmXFqYsmR5yWdhS094qP93175Al
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 08/12] pack-write: switch various SHA-1 values to abstract forms
Date:   Sun, 28 Jan 2018 15:57:18 +0000
Message-Id: <20180128155722.880805-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert various uses of hardcoded 20- and 40-based numbers to use
the_hash_algo, along with direct calls to SHA-1.  Adjust the names of
variables to refer to "hash" instead of "sha1".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-write.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index fea6284192..fe33f7464c 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -122,7 +122,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 			uint32_t offset = htonl(obj->offset);
 			sha1write(f, &offset, 4);
 		}
-		sha1write(f, obj->oid.hash, 20);
+		sha1write(f, obj->oid.hash, the_hash_algo->rawsz);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && !oidcmp(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
@@ -169,7 +169,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		}
 	}
 
-	sha1write(f, sha1, 20);
+	sha1write(f, sha1, the_hash_algo->rawsz);
 	sha1close(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
 			    ? CSUM_CLOSE : CSUM_FSYNC));
 	return index_name;
@@ -203,20 +203,20 @@ off_t write_pack_header(struct sha1file *f, uint32_t nr_entries)
  * interested in the resulting SHA1 of pack data above partial_pack_offset.
  */
 void fixup_pack_header_footer(int pack_fd,
-			 unsigned char *new_pack_sha1,
+			 unsigned char *new_pack_hash,
 			 const char *pack_name,
 			 uint32_t object_count,
-			 unsigned char *partial_pack_sha1,
+			 unsigned char *partial_pack_hash,
 			 off_t partial_pack_offset)
 {
 	int aligned_sz, buf_sz = 8 * 1024;
-	git_SHA_CTX old_sha1_ctx, new_sha1_ctx;
+	git_hash_ctx old_hash_ctx, new_hash_ctx;
 	struct pack_header hdr;
 	char *buf;
 	ssize_t read_result;
 
-	git_SHA1_Init(&old_sha1_ctx);
-	git_SHA1_Init(&new_sha1_ctx);
+	the_hash_algo->init_fn(&old_hash_ctx);
+	the_hash_algo->init_fn(&new_hash_ctx);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
@@ -228,9 +228,9 @@ void fixup_pack_header_footer(int pack_fd,
 			  pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
-	git_SHA1_Update(&old_sha1_ctx, &hdr, sizeof(hdr));
+	the_hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
-	git_SHA1_Update(&new_sha1_ctx, &hdr, sizeof(hdr));
+	the_hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
 	write_or_die(pack_fd, &hdr, sizeof(hdr));
 	partial_pack_offset -= sizeof(hdr);
 
@@ -238,28 +238,28 @@ void fixup_pack_header_footer(int pack_fd,
 	aligned_sz = buf_sz - sizeof(hdr);
 	for (;;) {
 		ssize_t m, n;
-		m = (partial_pack_sha1 && partial_pack_offset < aligned_sz) ?
+		m = (partial_pack_hash && partial_pack_offset < aligned_sz) ?
 			partial_pack_offset : aligned_sz;
 		n = xread(pack_fd, buf, m);
 		if (!n)
 			break;
 		if (n < 0)
 			die_errno("Failed to checksum '%s'", pack_name);
-		git_SHA1_Update(&new_sha1_ctx, buf, n);
+		the_hash_algo->update_fn(&new_hash_ctx, buf, n);
 
 		aligned_sz -= n;
 		if (!aligned_sz)
 			aligned_sz = buf_sz;
 
-		if (!partial_pack_sha1)
+		if (!partial_pack_hash)
 			continue;
 
-		git_SHA1_Update(&old_sha1_ctx, buf, n);
+		the_hash_algo->update_fn(&old_hash_ctx, buf, n);
 		partial_pack_offset -= n;
 		if (partial_pack_offset == 0) {
-			unsigned char sha1[20];
-			git_SHA1_Final(sha1, &old_sha1_ctx);
-			if (hashcmp(sha1, partial_pack_sha1) != 0)
+			unsigned char hash[GIT_MAX_RAWSZ];
+			the_hash_algo->final_fn(hash, &old_hash_ctx);
+			if (hashcmp(hash, partial_pack_hash) != 0)
 				die("Unexpected checksum for %s "
 				    "(disk corruption?)", pack_name);
 			/*
@@ -267,23 +267,24 @@ void fixup_pack_header_footer(int pack_fd,
 			 * pack, which also means making partial_pack_offset
 			 * big enough not to matter anymore.
 			 */
-			git_SHA1_Init(&old_sha1_ctx);
+			the_hash_algo->init_fn(&old_hash_ctx);
 			partial_pack_offset = ~partial_pack_offset;
 			partial_pack_offset -= MSB(partial_pack_offset, 1);
 		}
 	}
 	free(buf);
 
-	if (partial_pack_sha1)
-		git_SHA1_Final(partial_pack_sha1, &old_sha1_ctx);
-	git_SHA1_Final(new_pack_sha1, &new_sha1_ctx);
-	write_or_die(pack_fd, new_pack_sha1, 20);
+	if (partial_pack_hash)
+		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
+	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
+	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
 	fsync_or_die(pack_fd, pack_name);
 }
 
 char *index_pack_lockfile(int ip_out)
 {
-	char packname[46];
+	char packname[GIT_MAX_HEXSZ + 6];
+	int len = the_hash_algo->hexsz + 6;
 
 	/*
 	 * The first thing we expect from index-pack's output
@@ -292,9 +293,9 @@ char *index_pack_lockfile(int ip_out)
 	 * case, we need it to remove the corresponding .keep file
 	 * later on.  If we don't get that then tough luck with it.
 	 */
-	if (read_in_full(ip_out, packname, 46) == 46 && packname[45] == '\n') {
+	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
 		const char *name;
-		packname[45] = 0;
+		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
 				       get_object_directory(), name);
