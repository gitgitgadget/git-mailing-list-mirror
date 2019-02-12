Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2505A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBLBXW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:22 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34250 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726949AbfBLBXU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:20 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D058360737;
        Tue, 12 Feb 2019 01:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934598;
        bh=2J0p3k1C4WeqnaBhIcuvMunKCzVGO3+S7hPfdtIQOBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DvwzQod8mp0edw/NrosfWJCLPahk3Rdu4wTRGOUMd8T/Ha/cbtETTSXgWuiLEgCxK
         g+vBYydY1UReD+9Zb0jse3cKVI/82Jz8nbYwJmGg5mvKpPNJjSblraGYzOGMuomWDZ
         gkVH+jTSIY+88sfX529BdDByngTnh5fUfKZoBOe21sx4/L/tRz8psUfXFanIu14dI5
         XmvQhRmwM1Wz+2Pj3aUpt7uA+/D87JUPAMEZJB0HLm+LHgC0aDl8Qhrg1mBMFXNXho
         Rxnh7EafBjvcqs35IR8HVZuRG/YzW+khQC0IIeQZNiUaZbjBZkv64p0YH8cqmnHQi7
         GMDuYYdo2ZySTrJywoSHAJEDRaiqc5A1YsZ1hgv5kJzr4HnTDt45QPKo6/VXT5xrgW
         /FM+afc7XTblYf8joh3VvhKjPuXS5HRZWHhBJRudiNJSWZm+82dGOD6KqWBrDyA8tb
         yJAZI2KX2r69Bw10ev+C1zTHQBi7A8t361UxG6eIYLuGfvkvm3d
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 04/31] pack-bitmap: replace sha1_to_hex
Date:   Tue, 12 Feb 2019 01:22:29 +0000
Message-Id: <20190212012256.1005924-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the uses of sha1_to_hex in the pack bitmap code with hash_to_hex
to allow the use of SHA-256 as well.  Rename a few variables since they
are no longer limited to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-bitmap-write.c | 6 +++---
 pack-bitmap.c       | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c82fb01fd7..802ed62677 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -142,13 +142,13 @@ static inline void reset_all_seen(void)
 	seen_objects_nr = 0;
 }
 
-static uint32_t find_object_pos(const unsigned char *sha1)
+static uint32_t find_object_pos(const unsigned char *hash)
 {
-	struct object_entry *entry = packlist_find(writer.to_pack, sha1, NULL);
+	struct object_entry *entry = packlist_find(writer.to_pack, hash, NULL);
 
 	if (!entry) {
 		die("Failed to write bitmap index. Packfile doesn't have full closure "
-			"(object %s is missing)", sha1_to_hex(sha1));
+			"(object %s is missing)", hash_to_hex(hash));
 	}
 
 	return oe_in_pack_pos(writer.to_pack, entry);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index c760913cea..6d6fa68563 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -169,7 +169,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 
 static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 					  struct ewah_bitmap *root,
-					  const unsigned char *sha1,
+					  const unsigned char *hash,
 					  struct stored_bitmap *xor_with,
 					  int flags)
 {
@@ -181,7 +181,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	stored->root = root;
 	stored->xor = xor_with;
 	stored->flags = flags;
-	oidread(&stored->oid, sha1);
+	oidread(&stored->oid, hash);
 
 	hash_pos = kh_put_sha1(index->bitmaps, stored->oid.hash, &ret);
 
@@ -189,7 +189,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	 * because the SHA1 already existed on the map. this is bad, there
 	 * shouldn't be duplicated commits in the index */
 	if (ret == 0) {
-		error("Duplicate entry in bitmap index: %s", sha1_to_hex(sha1));
+		error("Duplicate entry in bitmap index: %s", hash_to_hex(hash));
 		return NULL;
 	}
 
@@ -805,7 +805,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 
 		fprintf(stderr, "Failed to reuse at %d (%016llx)\n",
 			reuse_objects, result->words[i]);
-		fprintf(stderr, " %s\n", sha1_to_hex(sha1));
+		fprintf(stderr, " %s\n", hash_to_hex(sha1));
 	}
 #endif
 
