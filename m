Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C1B1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeBYVM3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33830 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751760AbeBYVM0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:26 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D978660E4C;
        Sun, 25 Feb 2018 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593145;
        bh=srvlUylHOJSzffY4an6tbaxNcuR5y1CSUgv9jc/3K6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yRUP5IAowf8OU5ooIitz986VlrtyFt96E0vEBKvwjt54i/ZiekASKgXw7D61Hrsas
         lh6eSsyVoAI5EAxNHjAlMXYIxDgDDqUqdhvPn6NpPCHkknQexhjFK06jRfEbgZlTGt
         HsFN7wo2JhE1fOHxXh+vm+jZgRg3oMKU4tGoUM1+vkcmK/zQdwdwKTlKYVWxCo0UDg
         we/JmMyCX9Z1HL1CG0y7WKeCZ0uF410qfWtGDI1Qb6jbXbuAWgyHtaBToMeZN0jocm
         eYDb4BHZMSOavV1xC5CVXBqYigm51whi79TcyctlqvtaBzvBFbzsXcDB4CGWu3VA0b
         Nl6R8iPrZkDUYRy32oow9YzR7wIIRJU46SbpTymA135iOMdnSFRZSlKEpAKS784YvB
         +nM+oUYQq46fMMfsUKIvcuHP0Qg+w9XU/yeEUEwyC1rI7rjzsrmNdO6oj1p9ahXf5X
         Rv6yfkQspn4pkykFwr7iZDk4unB5weDP+doYNMMaxhch9TyMljp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/36] bulk-checkin: convert index_bulk_checkin to struct object_id
Date:   Sun, 25 Feb 2018 21:11:37 +0000
Message-Id: <20180225211212.477570-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the index_bulk_checkin function, and the static functions it
calls, to use pointers to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bulk-checkin.c | 18 +++++++++---------
 bulk-checkin.h |  2 +-
 sha1_file.c    |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8bcd1c8665..6f5ee25bff 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -60,17 +60,17 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 	reprepare_packed_git();
 }
 
-static int already_written(struct bulk_checkin_state *state, unsigned char sha1[])
+static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
 {
 	int i;
 
 	/* The object may already exist in the repository */
-	if (has_sha1_file(sha1))
+	if (has_sha1_file(oid->hash))
 		return 1;
 
 	/* Might want to keep the list sorted */
 	for (i = 0; i < state->nr_written; i++)
-		if (!hashcmp(state->written[i]->oid.hash, sha1))
+		if (!oidcmp(&state->written[i]->oid, oid))
 			return 1;
 
 	/* This is a new object we need to keep */
@@ -186,7 +186,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,
 }
 
 static int deflate_to_pack(struct bulk_checkin_state *state,
-			   unsigned char result_sha1[],
+			   struct object_id *result_oid,
 			   int fd, size_t size,
 			   enum object_type type, const char *path,
 			   unsigned flags)
@@ -236,17 +236,17 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	the_hash_algo->final_fn(result_sha1, &ctx);
+	the_hash_algo->final_fn(result_oid->hash, &ctx);
 	if (!idx)
 		return 0;
 
 	idx->crc32 = crc32_end(state->f);
-	if (already_written(state, result_sha1)) {
+	if (already_written(state, result_oid)) {
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		free(idx);
 	} else {
-		hashcpy(idx->oid.hash, result_sha1);
+		oidcpy(&idx->oid, result_oid);
 		ALLOC_GROW(state->written,
 			   state->nr_written + 1,
 			   state->alloc_written);
@@ -255,11 +255,11 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	return 0;
 }
 
-int index_bulk_checkin(unsigned char *sha1,
+int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&state, sha1, fd, size, type,
+	int status = deflate_to_pack(&state, oid, fd, size, type,
 				     path, flags);
 	if (!state.plugged)
 		finish_bulk_checkin(&state);
diff --git a/bulk-checkin.h b/bulk-checkin.h
index fbd40fc98c..a85527318b 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -4,7 +4,7 @@
 #ifndef BULK_CHECKIN_H
 #define BULK_CHECKIN_H
 
-extern int index_bulk_checkin(unsigned char sha1[],
+extern int index_bulk_checkin(struct object_id *oid,
 			      int fd, size_t size, enum object_type type,
 			      const char *path, unsigned flags);
 
diff --git a/sha1_file.c b/sha1_file.c
index 826d7a0ae3..c1d06c6109 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1892,7 +1892,7 @@ static int index_stream(struct object_id *oid, int fd, size_t size,
 			enum object_type type, const char *path,
 			unsigned flags)
 {
-	return index_bulk_checkin(oid->hash, fd, size, type, path, flags);
+	return index_bulk_checkin(oid, fd, size, type, path, flags);
 }
 
 int index_fd(struct object_id *oid, int fd, struct stat *st,
