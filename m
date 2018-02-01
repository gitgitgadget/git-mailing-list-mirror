Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB251F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeBACTa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:19:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58604 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932217AbeBACTK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:19:10 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06DB561390;
        Thu,  1 Feb 2018 02:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517451549;
        bh=9N7vwY/Wye5KFSjhkAdREu7ynKf2vFxicE0+HrmYDGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SiwsJxHBaMS/UQtOvo2kxOI0cDMaEF6BXcgLr2Ejs/NTF7WOy4phTfBhodIb76tJ2
         L1f07Csn+yGRTwfIG/Yw7+zkin2EMNSks1cld8Fd1ClZTl7r0YZUymUAa9r0Ay/sRw
         9IdIVKTR4LaGtHD+Ga5brh9x3L5mSkWloQz89+d0DKgqdtEUAMXSnA8JRPzp1nYDL3
         duIDpka5dY6zYrkDTBJiHM1KdCN20ONtRMFq/td9tMvJSVIa6o9L2KdcNFwaMxQRu6
         TXr+cht9FceEeN4dUsOh5Uf4Qcrc2Dz9tKOjuSB0SG319YT7pZokTo7nwmYCDfZY5T
         KxQMsc3ZiY7t24DuaL2TfSBY4j7mQ9ePaK5IxF23icfPi/DyfaL13NUFBiMGF0Mmkf
         yi3TUIQoiwcrdch8Aq1lAk4njglrty+Trh6emAl+mpbMRMZ3JpNNH5UHAX2trp5m81
         fS++YOxYgMEkxzWO7NhFo5jp/AxCIKPnwuJIVeH+MMowSOgYDpf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/12] read-cache: abstract away uses of SHA-1
Date:   Thu,  1 Feb 2018 02:18:45 +0000
Message-Id: <20180201021848.533188-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert various uses of direct calls to SHA-1 and 20- and 40-based
constants to use the_hash_algo instead.  Don't yet convert the on-disk
data structures, which will be handled in a future commit.

Adjust some comments so as not to refer explicitly to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 read-cache.c | 58 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..15bbb9bab4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1545,8 +1545,8 @@ int verify_ce_order;
 
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
-	git_SHA_CTX c;
-	unsigned char sha1[20];
+	git_hash_ctx c;
+	unsigned char hash[GIT_MAX_RAWSZ];
 	int hdr_version;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
@@ -1558,10 +1558,10 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	if (!verify_index_checksum)
 		return 0;
 
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, size - 20);
-	git_SHA1_Final(sha1, &c);
-	if (hashcmp(sha1, (unsigned char *)hdr + size - 20))
+	the_hash_algo->init_fn(&c);
+	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
+	the_hash_algo->final_fn(hash, &c);
+	if (hashcmp(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
 		return error("bad index file sha1 signature");
 	return 0;
 }
@@ -1791,7 +1791,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		die_errno("cannot stat the open index");
 
 	mmap_size = xsize_t(st.st_size);
-	if (mmap_size < sizeof(struct cache_header) + 20)
+	if (mmap_size < sizeof(struct cache_header) + the_hash_algo->rawsz)
 		die("index file smaller than expected");
 
 	mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -1803,7 +1803,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
-	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
+	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - the_hash_algo->rawsz);
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
@@ -1831,7 +1831,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
-	while (src_offset <= mmap_size - 20 - 8) {
+	while (src_offset <= mmap_size - the_hash_algo->rawsz - 8) {
 		/* After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
 		 * sections, each of which is prefixed with
@@ -1957,11 +1957,11 @@ int unmerged_index(const struct index_state *istate)
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
 
-static int ce_write_flush(git_SHA_CTX *context, int fd)
+static int ce_write_flush(git_hash_ctx *context, int fd)
 {
 	unsigned int buffered = write_buffer_len;
 	if (buffered) {
-		git_SHA1_Update(context, write_buffer, buffered);
+		the_hash_algo->update_fn(context, write_buffer, buffered);
 		if (write_in_full(fd, write_buffer, buffered) < 0)
 			return -1;
 		write_buffer_len = 0;
@@ -1969,7 +1969,7 @@ static int ce_write_flush(git_SHA_CTX *context, int fd)
 	return 0;
 }
 
-static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
+static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
 {
 	while (len) {
 		unsigned int buffered = write_buffer_len;
@@ -1991,7 +1991,7 @@ static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len)
 	return 0;
 }
 
-static int write_index_ext_header(git_SHA_CTX *context, int fd,
+static int write_index_ext_header(git_hash_ctx *context, int fd,
 				  unsigned int ext, unsigned int sz)
 {
 	ext = htonl(ext);
@@ -2000,26 +2000,26 @@ static int write_index_ext_header(git_SHA_CTX *context, int fd,
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
 
-static int ce_flush(git_SHA_CTX *context, int fd, unsigned char *sha1)
+static int ce_flush(git_hash_ctx *context, int fd, unsigned char *hash)
 {
 	unsigned int left = write_buffer_len;
 
 	if (left) {
 		write_buffer_len = 0;
-		git_SHA1_Update(context, write_buffer, left);
+		the_hash_algo->update_fn(context, write_buffer, left);
 	}
 
-	/* Flush first if not enough space for SHA1 signature */
-	if (left + 20 > WRITE_BUFFER_SIZE) {
+	/* Flush first if not enough space for hash signature */
+	if (left + the_hash_algo->rawsz > WRITE_BUFFER_SIZE) {
 		if (write_in_full(fd, write_buffer, left) < 0)
 			return -1;
 		left = 0;
 	}
 
-	/* Append the SHA1 signature at the end */
-	git_SHA1_Final(write_buffer + left, context);
-	hashcpy(sha1, write_buffer + left);
-	left += 20;
+	/* Append the hash signature at the end */
+	the_hash_algo->final_fn(write_buffer + left, context);
+	hashcpy(hash, write_buffer + left);
+	left += the_hash_algo->rawsz;
 	return (write_in_full(fd, write_buffer, left) < 0) ? -1 : 0;
 }
 
@@ -2100,7 +2100,7 @@ static void copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
+static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
 {
 	int size;
@@ -2167,7 +2167,7 @@ static int verify_index_from(const struct index_state *istate, const char *path)
 	int fd;
 	ssize_t n;
 	struct stat st;
-	unsigned char sha1[20];
+	unsigned char hash[GIT_MAX_RAWSZ];
 
 	if (!istate->initialized)
 		return 0;
@@ -2179,14 +2179,14 @@ static int verify_index_from(const struct index_state *istate, const char *path)
 	if (fstat(fd, &st))
 		goto out;
 
-	if (st.st_size < sizeof(struct cache_header) + 20)
+	if (st.st_size < sizeof(struct cache_header) + the_hash_algo->rawsz)
 		goto out;
 
-	n = pread_in_full(fd, sha1, 20, st.st_size - 20);
-	if (n != 20)
+	n = pread_in_full(fd, hash, the_hash_algo->rawsz, st.st_size - the_hash_algo->rawsz);
+	if (n != the_hash_algo->rawsz)
 		goto out;
 
-	if (hashcmp(istate->sha1, sha1))
+	if (hashcmp(istate->sha1, hash))
 		goto out;
 
 	close(fd);
@@ -2235,7 +2235,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			  int strip_extensions)
 {
 	int newfd = tempfile->fd;
-	git_SHA_CTX c;
+	git_hash_ctx c;
 	struct cache_header hdr;
 	int i, err = 0, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
@@ -2273,7 +2273,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	hdr.hdr_version = htonl(hdr_version);
 	hdr.hdr_entries = htonl(entries - removed);
 
-	git_SHA1_Init(&c);
+	the_hash_algo->init_fn(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
