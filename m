Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6031D1F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425890AbdEACb5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:57 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35798 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999476AbdEACbC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E71CB280D3;
        Mon,  1 May 2017 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605812;
        bh=88tUE7L2KlPzIkfF8whvzWpWaSoV8EsocH8Rbpvq1DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tr6FStqI0LTQ3tmXYFakKOMCmENTe6w1W5/UhYNFu/w7jg49FUSzuy4Elz8IgJj3Z
         R9CdKP7PkfJuKWWFnptReUii6Nu5M123ajGB2WquVOMFP8NKC0dozxsU2ucnrKEuU5
         TCt4tS8R7KdfycPjkPsrd8R1mXi9HVb1TauMCOIiqPCqBWqfn+qsqDd0Ro/7Sh3g+M
         652G+61HiPS15zRvH9KDsjJdRlUSzUu5hyOp/C3hOPZQ4gLzMWGT+8vab84llnk09/
         RNglOhc10mUyHcjhfzi1+Wj1+5iVzfLTSVDD+oCqulT+e9ovE/2qBk3C+KtIdQZvlN
         zVY5cDMNrvk6fiyv9SrZ5CLfN5j7J/M91dbUj60whr0Uh2BfwcSbHLPV2XOG4rP0PT
         lQ4hpU2Ookw7IQF0NVvOLleX8k74snrx+MqxUjl+4fwXERhv7+7HTLrvVT/kh7DzUZ
         GIYGdFMg832uGbhv+5do3QUXQtqtLhTSjRSY27hqUqCGbYkbK4d
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 35/53] Convert the verify_pack callback to struct object_id
Date:   Mon,  1 May 2017 02:29:28 +0000
Message-Id: <20170501022946.258735-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the verify_pack_callback take a pointer to struct object_id.
Change the pack checksum to use GIT_MAX_RAWSZ, even though it is not
strictly an object ID.  Doing so ensures resilience against future hash
size changes, and allows us to remove hard-coded assumptions about how
big the buffer needs to be.

Also, use a union to convert the pointer from nth_packed_object_sha1 to
to a pointer to struct object_id.  This behavior is compatible with GCC
and clang and explicitly sanctioned by C11.  The alternatives are to
just perform a cast, which would run afoul of strict aliasing rules, but
should just work, and changing the pointer into an instance of struct
object_id and copying the value.  The latter operation could seriously
bloat memory usage on fsck, which already uses a lot of memory on some
repositories.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fsck.c |  6 +++---
 pack-check.c   | 25 ++++++++++++++-----------
 pack.h         |  2 +-
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2f67e8217..a187054da 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -377,7 +377,7 @@ static int fsck_obj(struct object *obj)
 	return 0;
 }
 
-static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
+static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 			   unsigned long size, void *buffer, int *eaten)
 {
 	/*
@@ -385,10 +385,10 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 	 * verify_packfile(), data_valid variable for details.
 	 */
 	struct object *obj;
-	obj = parse_object_buffer(sha1, type, size, buffer, eaten);
+	obj = parse_object_buffer(oid->hash, type, size, buffer, eaten);
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
-		return error("%s: object corrupt or missing", sha1_to_hex(sha1));
+		return error("%s: object corrupt or missing", oid_to_hex(oid));
 	}
 	obj->flags = HAS_OBJ;
 	return fsck_obj(obj);
diff --git a/pack-check.c b/pack-check.c
index 27f70d345..e1fcb228f 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -5,7 +5,10 @@
 
 struct idx_entry {
 	off_t                offset;
-	const unsigned char *sha1;
+	union idx_entry_object {
+		const unsigned char *hash;
+		struct object_id *oid;
+	} oid;
 	unsigned int nr;
 };
 
@@ -51,7 +54,7 @@ static int verify_packfile(struct packed_git *p,
 	off_t index_size = p->index_size;
 	const unsigned char *index_base = p->index_data;
 	git_SHA_CTX ctx;
-	unsigned char sha1[20], *pack_sig;
+	unsigned char hash[GIT_MAX_RAWSZ], *pack_sig;
 	off_t offset = 0, pack_sig_ofs = 0;
 	uint32_t nr_objects, i;
 	int err = 0;
@@ -71,9 +74,9 @@ static int verify_packfile(struct packed_git *p,
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
 		git_SHA1_Update(&ctx, in, remaining);
 	} while (offset < pack_sig_ofs);
-	git_SHA1_Final(sha1, &ctx);
+	git_SHA1_Final(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
-	if (hashcmp(sha1, pack_sig))
+	if (hashcmp(hash, pack_sig))
 		err = error("%s SHA1 checksum mismatch",
 			    p->pack_name);
 	if (hashcmp(index_base + index_size - 40, pack_sig))
@@ -90,8 +93,8 @@ static int verify_packfile(struct packed_git *p,
 	entries[nr_objects].offset = pack_sig_ofs;
 	/* first sort entries by pack offset, since unpacking them is more efficient that way */
 	for (i = 0; i < nr_objects; i++) {
-		entries[i].sha1 = nth_packed_object_sha1(p, i);
-		if (!entries[i].sha1)
+		entries[i].oid.hash = nth_packed_object_sha1(p, i);
+		if (!entries[i].oid.hash)
 			die("internal error pack-check nth-packed-object");
 		entries[i].offset = nth_packed_object_offset(p, i);
 		entries[i].nr = i;
@@ -112,7 +115,7 @@ static int verify_packfile(struct packed_git *p,
 			if (check_pack_crc(p, w_curs, offset, len, nr))
 				err = error("index CRC mismatch for object %s "
 					    "from %s at offset %"PRIuMAX"",
-					    sha1_to_hex(entries[i].sha1),
+					    oid_to_hex(entries[i].oid.oid),
 					    p->pack_name, (uintmax_t)offset);
 		}
 
@@ -135,14 +138,14 @@ static int verify_packfile(struct packed_git *p,
 
 		if (data_valid && !data)
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
-				    sha1_to_hex(entries[i].sha1), p->pack_name,
+				    oid_to_hex(entries[i].oid.oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_sha1_signature(entries[i].sha1, data, size, typename(type)))
+		else if (check_sha1_signature(entries[i].oid.hash, data, size, typename(type)))
 			err = error("packed %s from %s is corrupt",
-				    sha1_to_hex(entries[i].sha1), p->pack_name);
+				    oid_to_hex(entries[i].oid.oid), p->pack_name);
 		else if (fn) {
 			int eaten = 0;
-			err |= fn(entries[i].sha1, type, size, data, &eaten);
+			err |= fn(entries[i].oid.oid, type, size, data, &eaten);
 			if (eaten)
 				data = NULL;
 		}
diff --git a/pack.h b/pack.h
index c7de42ef3..8294341af 100644
--- a/pack.h
+++ b/pack.h
@@ -75,7 +75,7 @@ struct pack_idx_entry {
 
 struct progress;
 /* Note, the data argument could be NULL if object type is blob */
-typedef int (*verify_fn)(const unsigned char*, enum object_type, unsigned long, void*, int*);
+typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
