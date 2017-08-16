Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A691F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbdHPURW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:17:22 -0400
Received: from vie01a-dmta-pe04-1.mx.upcmail.net ([62.179.121.163]:49374 "EHLO
        vie01a-dmta-pe04-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752586AbdHPUQw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:52 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kF-0005Ls-0K
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:51 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGl1v01c5BuuEg01wGmMi; Wed, 16 Aug 2017 22:16:47 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id D918445D4512; Wed, 16 Aug 2017 22:16:45 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 15/19] Convert archive functions to size_t
Date:   Wed, 16 Aug 2017 22:16:27 +0200
Message-Id: <1502914591-26215-16-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 archive-tar.c | 16 ++++++++--------
 archive-zip.c | 22 +++++++++++-----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 719673d..ee56b2b 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -12,7 +12,7 @@
 #define BLOCKSIZE	(RECORDSIZE * 20)
 
 static char block[BLOCKSIZE];
-static unsigned long offset;
+static size_t offset;
 
 static int tar_umask = 002;
 
@@ -50,12 +50,12 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void do_write_blocked(const void *data, unsigned long size)
+static void do_write_blocked(const void *data, size_t size)
 {
 	const char *buf = data;
 
 	if (offset) {
-		unsigned long chunk = BLOCKSIZE - offset;
+		size_t chunk = BLOCKSIZE - offset;
 		if (size < chunk)
 			chunk = size;
 		memcpy(block + offset, buf, chunk);
@@ -77,7 +77,7 @@ static void do_write_blocked(const void *data, unsigned long size)
 
 static void finish_record(void)
 {
-	unsigned long tail;
+	size_t tail;
 	tail = offset % RECORDSIZE;
 	if (tail)  {
 		memset(block + offset, 0, RECORDSIZE - tail);
@@ -86,7 +86,7 @@ static void finish_record(void)
 	write_if_needed();
 }
 
-static void write_blocked(const void *data, unsigned long size)
+static void write_blocked(const void *data, size_t size)
 {
 	do_write_blocked(data, size);
 	finish_record();
@@ -198,10 +198,10 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 
 static void prepare_header(struct archiver_args *args,
 			   struct ustar_header *header,
-			   unsigned int mode, unsigned long size)
+			   unsigned int mode, size_t size)
 {
 	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
-	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
+	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? (unsigned long)size : 0);
 	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
 
 	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
@@ -219,7 +219,7 @@ static void prepare_header(struct archiver_args *args,
 
 static void write_extended_header(struct archiver_args *args,
 				  const unsigned char *sha1,
-				  const void *buffer, unsigned long size)
+				  const void *buffer, size_t size)
 {
 	struct ustar_header header;
 	unsigned int mode;
diff --git a/archive-zip.c b/archive-zip.c
index 4492d64..3a54d80 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -186,12 +186,12 @@ static uint32_t clamp32(uintmax_t n)
 	return (n < max) ? n : max;
 }
 
-static void *zlib_deflate_raw(void *data, unsigned long size,
+static void *zlib_deflate_raw(void *data, size_t size,
 			      int compression_level,
-			      unsigned long *compressed_size)
+			      size_t *compressed_size)
 {
 	git_zstream stream;
-	unsigned long maxsize;
+	size_t maxsize;
 	void *buffer;
 	int result;
 
@@ -219,9 +219,9 @@ static void *zlib_deflate_raw(void *data, unsigned long size,
 	return buffer;
 }
 
-static void write_zip_data_desc(unsigned long size,
-				unsigned long compressed_size,
-				unsigned long crc)
+static void write_zip_data_desc(size_t size,
+				size_t compressed_size,
+				uint32_t crc)
 {
 	if (size >= 0xffffffff || compressed_size >= 0xffffffff) {
 		struct zip64_data_desc trailer;
@@ -243,9 +243,9 @@ static void write_zip_data_desc(unsigned long size,
 }
 
 static void set_zip_header_data_desc(struct zip_local_header *header,
-				     unsigned long size,
-				     unsigned long compressed_size,
-				     unsigned long crc)
+				     size_t size,
+				     size_t compressed_size,
+				     uint32_t crc)
 {
 	copy_le32(header->crc32, crc);
 	copy_le32(header->compressed_size, compressed_size);
@@ -287,8 +287,8 @@ static int write_zip_entry(struct archiver_args *args,
 	size_t header_extra_size = ZIP_EXTRA_MTIME_SIZE;
 	int need_zip64_extra = 0;
 	unsigned long attr2;
-	unsigned long compressed_size;
-	unsigned long crc;
+	size_t compressed_size;
+	uint32_t crc;
 	int method;
 	unsigned char *out;
 	void *deflated = NULL;
-- 
2.1.4

