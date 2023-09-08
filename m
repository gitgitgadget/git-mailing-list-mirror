Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7DEEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjIHXVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbjIHXVl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:21:41 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B59C133
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:21:37 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34564)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekde-007QwO-Pg; Fri, 08 Sep 2023 17:11:46 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdd-009u13-Jj; Fri, 08 Sep 2023 17:11:46 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:27 -0500
Message-Id: <20230908231049.2035003-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdd-009u13-Jj;;;mid=<20230908231049.2035003-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19hb3NqikBjoXtD6PxGAiK3Dbiy+vxXvZ8=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 10/32] bulk-checkin: Only accept blobs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the code is written today bulk_checkin only accepts blobs.  When
dealing with multiple hash algorithms it is necessary to distinguish
between blobs and object types that have embedded oids.  For object
that embed oids a completely new object needs to be generated to
compute the compatibility hash on.  For blobs however all that is
needed is to compute the compatibility hash on the same blob as the
default hash.

As the code will soon need the compatiblity hash from
a bulk checkin remove support for a bulk checking of
anything except blobs.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 bulk-checkin.c | 35 +++++++++++++++++------------------
 bulk-checkin.h |  6 +++---
 object-file.c  | 12 ++++++------
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 73bff3a23d27..223562b4e748 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -155,10 +155,10 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
  * status before calling us just in case we ask it to call us again
  * with a new pack.
  */
-static int stream_to_pack(struct bulk_checkin_packfile *state,
-			  git_hash_ctx *ctx, off_t *already_hashed_to,
-			  int fd, size_t size, enum object_type type,
-			  const char *path, unsigned flags)
+static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
+			       git_hash_ctx *ctx, off_t *already_hashed_to,
+			       int fd, size_t size, const char *path,
+			       unsigned flags)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
@@ -170,7 +170,7 @@ static int stream_to_pack(struct bulk_checkin_packfile *state,
 
 	git_deflate_init(&s, pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
@@ -247,11 +247,10 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 		die_errno("unable to write pack header");
 }
 
-static int deflate_to_pack(struct bulk_checkin_packfile *state,
-			   struct object_id *result_oid,
-			   int fd, size_t size,
-			   enum object_type type, const char *path,
-			   unsigned flags)
+static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
+				struct object_id *result_oid,
+				int fd, size_t size,
+				const char *path, unsigned flags)
 {
 	off_t seekback, already_hashed_to;
 	git_hash_ctx ctx;
@@ -265,7 +264,7 @@ static int deflate_to_pack(struct bulk_checkin_packfile *state,
 		return error("cannot find the current offset");
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  type, size);
+					  OBJ_BLOB, size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
 
@@ -282,8 +281,8 @@ static int deflate_to_pack(struct bulk_checkin_packfile *state,
 			idx->offset = state->offset;
 			crc32_begin(state->f);
 		}
-		if (!stream_to_pack(state, &ctx, &already_hashed_to,
-				    fd, size, type, path, flags))
+		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
+					 fd, size, path, flags))
 			break;
 		/*
 		 * Writing this object to the current pack will make
@@ -350,12 +349,12 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename)
 	}
 }
 
-int index_bulk_checkin(struct object_id *oid,
-		       int fd, size_t size, enum object_type type,
-		       const char *path, unsigned flags)
+int index_blob_bulk_checkin(struct object_id *oid,
+			    int fd, size_t size,
+			    const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&bulk_checkin_packfile, oid, fd, size, type,
-				     path, flags);
+	int status = deflate_blob_to_pack(&bulk_checkin_packfile, oid, fd, size,
+					  path, flags);
 	if (!odb_transaction_nesting)
 		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
 	return status;
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 48fe9a6e9171..aa7286a7b3e1 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -9,9 +9,9 @@
 void prepare_loose_object_bulk_checkin(void);
 void fsync_loose_object_bulk_checkin(int fd, const char *filename);
 
-int index_bulk_checkin(struct object_id *oid,
-		       int fd, size_t size, enum object_type type,
-		       const char *path, unsigned flags);
+int index_blob_bulk_checkin(struct object_id *oid,
+			    int fd, size_t size,
+			    const char *path, unsigned flags);
 
 /*
  * Tell the object database to optimize for adding
diff --git a/object-file.c b/object-file.c
index 6a14b8875343..6cc4ae1fd957 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2587,11 +2587,11 @@ static int index_core(struct index_state *istate,
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_stream(struct object_id *oid, int fd, size_t size,
-			enum object_type type, const char *path,
-			unsigned flags)
+static int index_blob_stream(struct object_id *oid, int fd, size_t size,
+			     const char *path,
+			     unsigned flags)
 {
-	return index_bulk_checkin(oid, fd, size, type, path, flags);
+	return index_blob_bulk_checkin(oid, fd, size, path, flags);
 }
 
 int index_fd(struct index_state *istate, struct object_id *oid,
@@ -2613,8 +2613,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	else
-		ret = index_stream(oid, fd, xsize_t(st->st_size), type, path,
-				   flags);
+		ret = index_blob_stream(oid, fd, xsize_t(st->st_size), path,
+					flags);
 	close(fd);
 	return ret;
 }
-- 
2.41.0

