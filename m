Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E653B1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeBSXAQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:00:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33534 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932169AbeBSXAN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 18:00:13 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BBB4861397;
        Mon, 19 Feb 2018 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081212;
        bh=lKHCbr8GVOI+bJ7kpLbyTwOYQ2oeAl+4+A8ZH123TXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JxRDLrrAO1286YUDdBWlm8ZZ6zA+7RncTTYNRW9yHB/zGsPggrkPrjmCdWpqigiPv
         TWidvXe5sBBzN4kcEY++OJAaW2wSv/PsqANDfDfZ0RmQhuqqGAb8Ugv/+1UMHZQlJ6
         UaesuVahntTgYoh/lEuFKainDi7Aj6Rf+h7gbcTQggLz5q2I0zTLdGZ6siby1bB0F/
         h0tP6iAozX7g5tSHKTiLQhm3fGs4CUlQrg1CG7OB8HG6MFMhZnCOj2AlNq5SNlJVo6
         D8lUnn7MzI0AueOaKzbP4dXPwNh5KONrNUI1o+Oj3qWFEPQxvmxMTxg3I5AZOvArYD
         Qbxnf3WwZvjCPPhMfnOvBRMht16nIUcqr88yh4JpFsI+0meILbRuELGLBfk2fXrvfP
         /xY27VBtsR7NRxjBa7mO7McgR4igfhoR/4J9SskZdBOJd2cKwDhrwocHHR2/zB9jLI
         oyJvJ1eNMktboIdDborQSez6vEdbsFiwvYVMxEZ+0hXvXtToMdP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 35/36] sha1_file: introduce a constant for max header length
Date:   Mon, 19 Feb 2018 22:59:26 +0000
Message-Id: <20180219225927.386065-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were several instances of 32 sprinkled throughout this file, all
of which were used for allocating a buffer to store the header of an
object.  Introduce a constant, MAX_HEADER_LEN, for this purpose.

Note that this constant is slightly larger than required; the longest
possible header is 28 (7 for "commit", 1 for a space, 20 for a 63-bit
length in decimal, and 1 for the NUL).  However, the overallocation
should not cause any problems, so leave it as it is.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_file.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c41fbe2f01..4d4f9248c7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -30,6 +30,9 @@
 #include "packfile.h"
 #include "fetch-object.h"
 
+/* The maximum size for an object header. */
+#define MAX_HEADER_LEN 32
+
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
 const struct object_id empty_tree_oid = {
@@ -791,7 +794,7 @@ int check_object_signature(const struct object_id *oid, void *map,
 	enum object_type obj_type;
 	struct git_istream *st;
 	git_hash_ctx c;
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
 	if (map) {
@@ -1150,7 +1153,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	unsigned long mapsize;
 	void *map;
 	git_zstream stream;
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
 
@@ -1512,7 +1515,7 @@ static int write_buffer(int fd, const void *buf, size_t len)
 int hash_object_file(const void *buf, unsigned long len, const char *type,
 		     struct object_id *oid)
 {
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
 	return 0;
@@ -1667,7 +1670,7 @@ static int freshen_packed_object(const unsigned char *sha1)
 int write_object_file(const void *buf, unsigned long len, const char *type,
 		      struct object_id *oid)
 {
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 
 	/* Normally if we have it in the pack then we do not bother writing
@@ -1687,7 +1690,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 	int hdrlen, status = 0;
 
 	/* type string, SP, %lu of the length plus NUL must fit this */
-	hdrlen = strlen(type) + 32;
+	hdrlen = strlen(type) + MAX_HEADER_LEN;
 	header = xmalloc(hdrlen);
 	write_object_file_prepare(buf, len, type, oid, header, &hdrlen);
 
@@ -1707,7 +1710,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	void *buf;
 	unsigned long len;
 	enum object_type type;
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 	int ret;
 
@@ -2189,7 +2192,7 @@ int read_loose_object(const char *path,
 	void *map = NULL;
 	unsigned long mapsize;
 	git_zstream stream;
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 
 	*contents = NULL;
 
