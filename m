Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F2A1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeCLC3L (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:29:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932638AbeCLC26 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 593D9610EF;
        Mon, 12 Mar 2018 02:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821737;
        bh=R2FjBaRJbBjj/AqNw8zwESHgUqTdOwtZCA5BXfnRnpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NmuJXlQ34UZ1mnCRacjVZ2n8GpXwsbyYDUqGXPkfmYsAtLPf9Csq8P8OfqB/3JrB+
         qHIXX2AECmZkEJbHvZ0CqOzvHY7nBbTVjPUJpvbgXXZNVs6oZeAbh3JzOis/K7p1K1
         qFTmkFIlRUP5S3m19Pjd6HX5+XYZiarlSpX/i35x20qz6u+M1+/v6Wkjth3t5uESO9
         SZKO1fQm27AhdmXRWSxUGXrCtGx7C5ZII6JiWb2oFRsTp+8rjbhWYTW54mfDY51F4I
         Ut6b/VlUYi85vDvAC67OdwPTf5NAQ+3kUwzwHWVXjqacLS1DB7bNq27i3S1885R2g7
         cdU2qdUPvKOdVhSmFtvt7DXgBtbB/xFCHwDX4e92Pm0p2xut3phili+n1ofFkpNpad
         s8rvgSepszYYO3Uv/KNQvyWxmvzUOiHi2dL9dIF72hEu1z4AKivs1WUZ2bAx4h4Ua7
         ref+wJp6LyfRZtFxPlcPRX6FlYCxFk+eM/ivc0tEjjE7qIrFxj6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 35/36] sha1_file: introduce a constant for max header length
Date:   Mon, 12 Mar 2018 02:27:55 +0000
Message-Id: <20180312022756.483934-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
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
index 60418da10b..581a9dc522 100644
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
 
@@ -1514,7 +1517,7 @@ static int write_buffer(int fd, const void *buf, size_t len)
 int hash_object_file(const void *buf, unsigned long len, const char *type,
 		     struct object_id *oid)
 {
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
 	return 0;
@@ -1669,7 +1672,7 @@ static int freshen_packed_object(const unsigned char *sha1)
 int write_object_file(const void *buf, unsigned long len, const char *type,
 		      struct object_id *oid)
 {
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 
 	/* Normally if we have it in the pack then we do not bother writing
@@ -1689,7 +1692,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 	int hdrlen, status = 0;
 
 	/* type string, SP, %lu of the length plus NUL must fit this */
-	hdrlen = strlen(type) + 32;
+	hdrlen = strlen(type) + MAX_HEADER_LEN;
 	header = xmalloc(hdrlen);
 	write_object_file_prepare(buf, len, type, oid, header, &hdrlen);
 
@@ -1709,7 +1712,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	void *buf;
 	unsigned long len;
 	enum object_type type;
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 	int ret;
 
@@ -2191,7 +2194,7 @@ int read_loose_object(const char *path,
 	void *map = NULL;
 	unsigned long mapsize;
 	git_zstream stream;
-	char hdr[32];
+	char hdr[MAX_HEADER_LEN];
 
 	*contents = NULL;
 
