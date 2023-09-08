Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DABEEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjIHXac (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345268AbjIHXab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:30:31 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E91FCD
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:30:27 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37160)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdj-00FHI6-0m; Fri, 08 Sep 2023 17:11:51 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdh-009u13-Ul; Fri, 08 Sep 2023 17:11:50 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:29 -0500
Message-Id: <20230908231049.2035003-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdh-009u13-Ul;;;mid=<20230908231049.2035003-12-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/LPmC0Nn0+hQWPa2fNSTXarTtI+MHhI9Y=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 12/32] bulk-checkin: hash object with compatibility algorithm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Any time we write an object into the repository when we're in dual hash
mode, we need to compute both algorithms.  We already do this when we
write a loose object into the repository, but we also need to do so in
the other case we write an object, which is the bulk check-in code.

****

Write the compatibility hash into idx->compat_oid so it is available
for code that generates indexes that include the compatibilty
mappings.

--EWB

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 bulk-checkin.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 223562b4e748..3206412a19e0 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -156,7 +156,8 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
  * with a new pack.
  */
 static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
-			       git_hash_ctx *ctx, off_t *already_hashed_to,
+			       git_hash_ctx *ctx, git_hash_ctx *compat_ctx,
+			       off_t *already_hashed_to,
 			       int fd, size_t size, const char *path,
 			       unsigned flags)
 {
@@ -167,6 +168,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 	int status = Z_OK;
 	int write_object = (flags & HASH_WRITE_OBJECT);
 	off_t offset = 0;
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
 
 	git_deflate_init(&s, pack_compression_level);
 
@@ -188,8 +190,11 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 				size_t hsize = offset - *already_hashed_to;
 				if (rsize < hsize)
 					hsize = rsize;
-				if (hsize)
+				if (hsize) {
 					the_hash_algo->update_fn(ctx, ibuf, hsize);
+					if (compat)
+						compat->update_fn(compat_ctx, ibuf, hsize);
+				}
 				*already_hashed_to = offset;
 			}
 			s.next_in = ibuf;
@@ -253,11 +258,13 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				const char *path, unsigned flags)
 {
 	off_t seekback, already_hashed_to;
-	git_hash_ctx ctx;
+	git_hash_ctx ctx, compat_ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
+	struct object_id compat_oid = {};
 
 	seekback = lseek(fd, 0, SEEK_CUR);
 	if (seekback == (off_t) -1)
@@ -267,6 +274,10 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 					  OBJ_BLOB, size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
+	if (compat) {
+		compat->init_fn(&compat_ctx);
+		compat->update_fn(&compat_ctx, obuf, header_len);
+	}
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0)
@@ -281,7 +292,8 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			idx->offset = state->offset;
 			crc32_begin(state->f);
 		}
-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
+		if (!stream_blob_to_pack(state, &ctx, &compat_ctx,
+					 &already_hashed_to,
 					 fd, size, path, flags))
 			break;
 		/*
@@ -298,6 +310,8 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			return error("cannot seek back");
 	}
 	the_hash_algo->final_oid_fn(result_oid, &ctx);
+	if (compat)
+		compat->final_oid_fn(&compat_oid, &compat_ctx);
 	if (!idx)
 		return 0;
 
@@ -308,6 +322,8 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		free(idx);
 	} else {
 		oidcpy(&idx->oid, result_oid);
+		if (compat)
+			oidcpy(&idx->compat_oid, &compat_oid);
 		ALLOC_GROW(state->written,
 			   state->nr_written + 1,
 			   state->alloc_written);
-- 
2.41.0

