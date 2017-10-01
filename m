Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F6120A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbdJAWJ7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54160 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752005AbdJAWJA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D83260DA6;
        Sun,  1 Oct 2017 22:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895739;
        bh=yt8vGPDcSbAO5h9/Y/58XoKgYwyXn0hR7+2bWIPFacM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucUybIbX6LjByehtTe/Kttous+xKuvxlPoz6Qz4meLdpPmLR5WAcJaiPTbmkuE2XX
         KMD0ubmo+Izi7Ir4kfcRnox/Wd7y2m7klE6hSCqoqu3X6dbcGySzWa7kITppmWA3Ug
         nC6OsRnZK8qKKCNPPQa5G3Se+4M2HvJOVQ9JtggOb8RWcqwHPUlEABcMCtW/ssRc54
         gEv6YSoUXiSRyhVdwZmnTdiVKFwH6KUsi/q3sdQczkud25KwrtywVM6fRwQhc6t2BM
         QLkmX+51tPrJsX83IMBnJowuaA0EubwaZsBSHxalmjvbYdFpiMeOfj542CiQjOzOA/
         l0ocWrDLeNCdQB/4Gh8/oQvTr47cB8LAc22Nl3SDfM8/7/UuLRUsgn9DAmdQr7pJFw
         Mz4VqT2D7nQJpUB7iEnbCPHngaydhC3hgkiBoknwyL5r3rphuWY03XAlyXQKr/+D7r
         qxgIKEco0FDWg5gYBogQ18rA2VyCKWP1+QesYo23NwKa456D/cx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 12/24] pack-bitmap: convert traverse_bitmap_commit_list to object_id
Date:   Sun,  1 Oct 2017 22:08:19 +0000
Message-Id: <20171001220831.214705-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert traverse_bitmap_commit_list and the callbacks it takes to use a
pointer to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c | 8 ++++----
 builtin/rev-list.c     | 4 ++--
 pack-bitmap.c          | 8 ++++----
 pack-bitmap.h          | 2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5ee2c48ffb..180c17904b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1097,20 +1097,20 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	return 1;
 }
 
-static int add_object_entry_from_bitmap(const unsigned char *sha1,
+static int add_object_entry_from_bitmap(const struct object_id *oid,
 					enum object_type type,
 					int flags, uint32_t name_hash,
 					struct packed_git *pack, off_t offset)
 {
 	uint32_t index_pos;
 
-	if (have_duplicate_entry(sha1, 0, &index_pos))
+	if (have_duplicate_entry(oid->hash, 0, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, 0, &pack, &offset))
+	if (!want_object_in_pack(oid->hash, 0, &pack, &offset))
 		return 0;
 
-	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
+	create_object_entry(oid->hash, type, name_hash, 0, 0, index_pos, pack, offset);
 
 	display_progress(progress_state, nr_result);
 	return 1;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c1c74d4a79..9bf8d5991c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -258,14 +258,14 @@ static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 }
 
 static int show_object_fast(
-	const unsigned char *sha1,
+	const struct object_id *oid,
 	enum object_type type,
 	int exclude,
 	uint32_t name_hash,
 	struct packed_git *found_pack,
 	off_t found_offset)
 {
-	fprintf(stdout, "%s\n", sha1_to_hex(sha1));
+	fprintf(stdout, "%s\n", oid_to_hex(oid));
 	return 1;
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 42e3d5f4f2..9270983e5f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -587,7 +587,7 @@ static void show_extended_objects(struct bitmap *objects,
 			continue;
 
 		obj = eindex->objects[i];
-		show_reach(obj->oid.hash, obj->type, 0, eindex->hashes[i], NULL, 0);
+		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
 	}
 }
 
@@ -612,7 +612,7 @@ static void show_objects_for_type(
 		eword_t word = objects->words[i] & filter;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
-			const unsigned char *sha1;
+			struct object_id oid;
 			struct revindex_entry *entry;
 			uint32_t hash = 0;
 
@@ -625,12 +625,12 @@ static void show_objects_for_type(
 				continue;
 
 			entry = &bitmap_git.pack->revindex[pos + offset];
-			sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
+			nth_packed_object_oid(&oid, bitmap_git.pack, entry->nr);
 
 			if (bitmap_git.hashes)
 				hash = get_be32(bitmap_git.hashes + entry->nr);
 
-			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
+			show_reach(&oid, object_type, 0, hash, bitmap_git.pack, entry->offset);
 		}
 
 		pos += BITS_IN_EWORD;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 0adcef77b5..3742a00e14 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -27,7 +27,7 @@ enum pack_bitmap_flags {
 };
 
 typedef int (*show_reachable_fn)(
-	const unsigned char *sha1,
+	const struct object_id *oid,
 	enum object_type type,
 	int flags,
 	uint32_t hash,
-- 
2.14.2.822.g60be5d43e6

