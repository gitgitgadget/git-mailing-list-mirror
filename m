Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F761F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeA1P5m (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:57:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58394 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752006AbeA1P5h (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:37 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 115E660FBD;
        Sun, 28 Jan 2018 15:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155056;
        bh=ZPA2ELOyd0LyPnohIcsjssuXfYn0r/jyiGMqmbA/Et0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=j7XLgQ8kDUpvFia4QqE3r+xfZ2VFd/0r5j73zsxFs0QPdL1VU35tDnPC+o7gpXeNT
         1w1xQgSJjZMzlRhU2Xb385wXFJHTGjZzKJtZZEyUhhgil8ECYZXytdsbaYic7NVZSS
         rI6gJi5dv6eNK+V+UJ4exkFnEuYXUMp2NzxoIDNrmGjxPJrbhTEnntO3+4bVoZg2a3
         eVBHmYuiSWaAKCs5yND0zwzWC7CstlvKUWbNoTuK6/8h3y1LgfOpBXF97tgp5rFSV/
         1E2LvDh2tKHAoFC0TqKe6we3KwnwMUrUP3lLoPX9QnIfEaEOxE5m+aE6ow0q3cfg9M
         AqPzHhcFswUz/gYB64976IT3a8zDfBonubN5C5a7cKJAmVwtwATPnFinRsSc0h9ujU
         h8wkr/SAc2+TWxr0v5hg6oSHQ5E8YKwAm1jHKtFg7RAH+lAD9v/reYZ5d0w0QtgKGB
         PeSaqsCm93oCpCCc1nWlD7+DHCbc9fmHKzYe0XK9N7HhhhK4NF/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 05/12] sha1_file: switch uses of SHA-1 to the_hash_algo
Date:   Sun, 28 Jan 2018 15:57:15 +0000
Message-Id: <20180128155722.880805-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch various uses of explicit calls to SHA-1 into references to
the_hash_algo for better abstraction.  Convert some calls to use struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_file.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e61d93a6e8..d9e2b1f285 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -786,16 +786,16 @@ void *xmmap(void *start, size_t length,
 int check_sha1_signature(const unsigned char *sha1, void *map,
 			 unsigned long size, const char *type)
 {
-	unsigned char real_sha1[20];
+	struct object_id real_oid;
 	enum object_type obj_type;
 	struct git_istream *st;
-	git_SHA_CTX c;
+	git_hash_ctx c;
 	char hdr[32];
 	int hdrlen;
 
 	if (map) {
-		hash_sha1_file(map, size, type, real_sha1);
-		return hashcmp(sha1, real_sha1) ? -1 : 0;
+		hash_sha1_file(map, size, type, real_oid.hash);
+		return hashcmp(sha1, real_oid.hash) ? -1 : 0;
 	}
 
 	st = open_istream(sha1, &obj_type, &size, NULL);
@@ -806,8 +806,8 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(obj_type), size) + 1;
 
 	/* Sha1.. */
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, hdrlen);
+	the_hash_algo->init_fn(&c);
+	the_hash_algo->update_fn(&c, hdr, hdrlen);
 	for (;;) {
 		char buf[1024 * 16];
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
@@ -818,11 +818,11 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 		}
 		if (!readlen)
 			break;
-		git_SHA1_Update(&c, buf, readlen);
+		the_hash_algo->update_fn(&c, buf, readlen);
 	}
-	git_SHA1_Final(real_sha1, &c);
+	the_hash_algo->final_fn(real_oid.hash, &c);
 	close_istream(st);
-	return hashcmp(sha1, real_sha1) ? -1 : 0;
+	return hashcmp(sha1, real_oid.hash) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -1421,16 +1421,16 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
                                     const char *type, unsigned char *sha1,
                                     char *hdr, int *hdrlen)
 {
-	git_SHA_CTX c;
+	git_hash_ctx c;
 
 	/* Generate the header */
 	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %lu", type, len)+1;
 
 	/* Sha1.. */
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, *hdrlen);
-	git_SHA1_Update(&c, buf, len);
-	git_SHA1_Final(sha1, &c);
+	the_hash_algo->init_fn(&c);
+	the_hash_algo->update_fn(&c, hdr, *hdrlen);
+	the_hash_algo->update_fn(&c, buf, len);
+	the_hash_algo->final_fn(sha1, &c);
 }
 
 /*
@@ -1552,8 +1552,8 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	int fd, ret;
 	unsigned char compressed[4096];
 	git_zstream stream;
-	git_SHA_CTX c;
-	unsigned char parano_sha1[20];
+	git_hash_ctx c;
+	struct object_id parano_oid;
 	static struct strbuf tmp_file = STRBUF_INIT;
 	const char *filename = sha1_file_name(sha1);
 
@@ -1569,14 +1569,14 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_deflate_init(&stream, zlib_compression_level);
 	stream.next_out = compressed;
 	stream.avail_out = sizeof(compressed);
-	git_SHA1_Init(&c);
+	the_hash_algo->init_fn(&c);
 
 	/* First header.. */
 	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
 	while (git_deflate(&stream, 0) == Z_OK)
 		; /* nothing */
-	git_SHA1_Update(&c, hdr, hdrlen);
+	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
 	stream.next_in = (void *)buf;
@@ -1584,7 +1584,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	do {
 		unsigned char *in0 = stream.next_in;
 		ret = git_deflate(&stream, Z_FINISH);
-		git_SHA1_Update(&c, in0, stream.next_in - in0);
+		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die("unable to write sha1 file");
 		stream.next_out = compressed;
@@ -1596,8 +1596,8 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	ret = git_deflate_end_gently(&stream);
 	if (ret != Z_OK)
 		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
-	git_SHA1_Final(parano_sha1, &c);
-	if (hashcmp(sha1, parano_sha1) != 0)
+	the_hash_algo->final_fn(parano_oid.hash, &c);
+	if (hashcmp(sha1, parano_oid.hash) != 0)
 		die("confused by unstable object source data for %s", sha1_to_hex(sha1));
 
 	close_sha1_file(fd);
@@ -2091,14 +2091,14 @@ static int check_stream_sha1(git_zstream *stream,
 			     const char *path,
 			     const unsigned char *expected_sha1)
 {
-	git_SHA_CTX c;
+	git_hash_ctx c;
 	unsigned char real_sha1[GIT_MAX_RAWSZ];
 	unsigned char buf[4096];
 	unsigned long total_read;
 	int status = Z_OK;
 
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, stream->total_out);
+	the_hash_algo->init_fn(&c);
+	the_hash_algo->update_fn(&c, hdr, stream->total_out);
 
 	/*
 	 * We already read some bytes into hdr, but the ones up to the NUL
@@ -2117,7 +2117,7 @@ static int check_stream_sha1(git_zstream *stream,
 		if (size - total_read < stream->avail_out)
 			stream->avail_out = size - total_read;
 		status = git_inflate(stream, Z_FINISH);
-		git_SHA1_Update(&c, buf, stream->next_out - buf);
+		the_hash_algo->update_fn(&c, buf, stream->next_out - buf);
 		total_read += stream->next_out - buf;
 	}
 	git_inflate_end(stream);
@@ -2132,7 +2132,7 @@ static int check_stream_sha1(git_zstream *stream,
 		return -1;
 	}
 
-	git_SHA1_Final(real_sha1, &c);
+	the_hash_algo->final_fn(real_sha1, &c);
 	if (hashcmp(expected_sha1, real_sha1)) {
 		error("sha1 mismatch for %s (expected %s)", path,
 		      sha1_to_hex(expected_sha1));
