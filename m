Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D0A1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeBSXAC (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:00:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33448 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932299AbeBSXAA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 18:00:00 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E3DE26135B;
        Mon, 19 Feb 2018 22:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081199;
        bh=zL06vtmSphMUe2GK3USDKw1xnKVgiUjE8ug81IMUf3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=A2nLnQFUrtZVzChXGwmoJC77MjVFaRHCw9tB3rei9nef2lD4bT0HHFg0ZUn4oM7zu
         MZjq7dl5FnWU7AUbv96lNx3jMezp8gDvZWKwjphhnPAQXDxebTLuwwtsVWl72dYzkU
         we9SPcVNrLCeoSByS+pOFxb38YuUcQl0WuMIuBo7xRf3Kvp88pQd3RwObXN7IGg2QK
         L2S0/NmdsCnMPeZkHMY6w2kAN8qrpGEcA7k6F4GCwSRoHt61m3rkibOqyU9zRXHZ7n
         TsBUUrGKXhnz3vxHl9wPkemZBlxJCAZXBlg0cFS1Y+uUUoDnRJDSjGjvDbP0JeC7xN
         +cOKET5D5hnwCBWA8Yj2bohlDEXWTTLlYspjc+3+m4bHxQiUX5EfoQOqGU3ueLTamC
         wHDWQKE6mIFSwsBZzkw+Wi6QuwpiR9L9YfMtlnZ+8QRRi/SJHm6jCxJ92kDAQisW90
         ehL/UsYOaBrAu43QAWPp+ji6bCiEbrD2gDyYh2dkPZgGtaHy23B
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 25/36] Convert remaining callers of sha1_object_info_extended to object_id
Date:   Mon, 19 Feb 2018 22:59:16 +0000
Message-Id: <20180219225927.386065-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining caller of sha1_object_info_extended to use struct
object_id.  Introduce temporaries, which will be removed later, since
there is a dependency loop between sha1_object_info_extended and
lookup_replace_object_extended.  This allows us to convert the code in a
piecemeal fashion instead of all at once.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_file.c | 14 +++++++++++---
 streaming.c |  5 ++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fa69d86309..19995766b6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1231,6 +1231,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 				    lookup_replace_object(sha1) :
 				    sha1;
 	int already_retried = 0;
+	struct object_id realoid;
+
+	hashcpy(realoid.hash, real);
 
 	if (is_null_sha1(real))
 		return -1;
@@ -1295,7 +1298,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		return sha1_object_info_extended(real, oi, 0);
+		return sha1_object_info_extended(realoid.hash, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1323,13 +1326,16 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 static void *read_object(const unsigned char *sha1, enum object_type *type,
 			 unsigned long *size)
 {
+	struct object_id oid;
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
 	oi.typep = type;
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (sha1_object_info_extended(sha1, &oi, 0) < 0)
+	hashcpy(oid.hash, sha1);
+
+	if (sha1_object_info_extended(oid.hash, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1723,9 +1729,11 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
+	struct object_id oid;
 	if (!startup_info->have_repository)
 		return 0;
-	return sha1_object_info_extended(sha1, NULL,
+	hashcpy(oid.hash, sha1);
+	return sha1_object_info_extended(oid.hash, NULL,
 					 flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
diff --git a/streaming.c b/streaming.c
index be85507922..042d6082e8 100644
--- a/streaming.c
+++ b/streaming.c
@@ -111,10 +111,13 @@ static enum input_source istream_source(const unsigned char *sha1,
 {
 	unsigned long size;
 	int status;
+	struct object_id oid;
+
+	hashcpy(oid.hash, sha1);
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = sha1_object_info_extended(sha1, oi, 0);
+	status = sha1_object_info_extended(oid.hash, oi, 0);
 	if (status < 0)
 		return stream_error;
 
