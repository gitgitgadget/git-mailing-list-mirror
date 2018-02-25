Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD80D1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeBYVNi (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751954AbeBYVMw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:52 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DB4DF60E5D;
        Sun, 25 Feb 2018 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593171;
        bh=zL06vtmSphMUe2GK3USDKw1xnKVgiUjE8ug81IMUf3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MyF9ODGQTuPxVkvOUrk/u3D023JEvAuUqMJjeKbSk0T9ID30ErtIJpB+NOhbnyAys
         wrJxR23JO22MCnq1KlwFrSBpbzSVAGCMhV6DMsb9T/FNfdoSkNDFn2HN5TE8Ea9Lm1
         SjcLRvP3+rIU5xLmyjsm/yN5Tp53cQIQ7bi0gaY6OVP4nagVXWqFfSdjz+apgqah+m
         Qp6WL3exlT5PNE6sxTozR31RWUZSTYobMIzPYdmTau2MbK9P1YPMbhTa1nkBagypd7
         LkzgkDvazq+bT+YfvpEc9JjSX+BJ6IeoWsEbSRqc3SngCmYtOmywPDszGPUwLkoalS
         ftXS0K0Qo89wFrxbwhBUi2wOOOn577+8wODpD3mt2U31UHtXaZN/ysGD0GQ9IjRkjo
         6SQ2nyaUIskvxvsvgcRvNEbMYo/JJqHjb55dbk7c3ugzzg794uGaDlYMAzXS9QG7Id
         pIrnuN4HPwwxKMgjVoOOkaZMjKd3iwRCXRpFerl3ZmEnFrAidZh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 25/36] Convert remaining callers of sha1_object_info_extended to object_id
Date:   Sun, 25 Feb 2018 21:12:01 +0000
Message-Id: <20180225211212.477570-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
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
 
