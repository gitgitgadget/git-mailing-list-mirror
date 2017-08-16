Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6581F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbdHPUQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:47 -0400
Received: from vie01a-dmta-pe04-1.mx.upcmail.net ([62.179.121.163]:35088 "EHLO
        vie01a-dmta-pe04-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752441AbdHPUQo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:44 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4k6-0005Ls-0K
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:42 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGf1v01k5BuuEg01wGgK0; Wed, 16 Aug 2017 22:16:41 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id C99F745D4512; Wed, 16 Aug 2017 22:16:39 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 03/19] Convert zlib.c to size_t
Date:   Wed, 16 Aug 2017 22:16:15 +0200
Message-Id: <1502914591-26215-4-git-send-email-martin@mail.zuhause>
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
 builtin/pack-objects.c |  8 ++++----
 cache.h                | 12 ++++++------
 pack-check.c           |  4 ++--
 sha1_file.c            |  6 +++---
 wrapper.c              |  8 ++++----
 zlib.c                 |  8 ++++----
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d94fd17..9067803 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -225,12 +225,12 @@ static void copy_pack_data(struct sha1file *f,
 		off_t len)
 {
 	unsigned char *in;
-	unsigned long avail;
+	size_t avail;
 
 	while (len) {
 		in = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
-			avail = (unsigned long)len;
+			avail = len;
 		sha1write(f, in, avail);
 		offset += avail;
 		len -= avail;
@@ -1388,8 +1388,8 @@ static void check_object(struct object_entry *entry)
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
-		unsigned long used, used_0;
-		unsigned long avail;
+		size_t used, used_0;
+		size_t avail;
 		off_t ofs;
 		unsigned char *buf, c;
 
diff --git a/cache.h b/cache.h
index ee96192..5c85844 100644
--- a/cache.h
+++ b/cache.h
@@ -42,10 +42,10 @@
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
-	unsigned long avail_in;
-	unsigned long avail_out;
-	unsigned long total_in;
-	unsigned long total_out;
+	size_t avail_in;
+	size_t avail_out;
+	size_t total_in;
+	size_t total_out;
 	unsigned char *next_in;
 	unsigned char *next_out;
 } git_zstream;
@@ -62,7 +62,7 @@ void git_deflate_end(git_zstream *);
 int git_deflate_abort(git_zstream *);
 int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
+size_t git_deflate_bound(git_zstream *, size_t);
 
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
@@ -1686,7 +1686,7 @@ extern int open_pack_index(struct packed_git *);
  */
 extern void close_pack_index(struct packed_git *);
 
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, size_t *);
 extern void close_pack_windows(struct packed_git *);
 extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
diff --git a/pack-check.c b/pack-check.c
index 6f7714f..a78da5a 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -30,7 +30,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	uint32_t data_crc = crc32(0, NULL, 0);
 
 	do {
-		unsigned long avail;
+		size_t avail;
 		void *data = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = len;
@@ -65,7 +65,7 @@ static int verify_packfile(struct packed_git *p,
 
 	git_SHA1_Init(&ctx);
 	do {
-		unsigned long remaining;
+		size_t remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
diff --git a/sha1_file.c b/sha1_file.c
index 97b39b0..3428172 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1228,7 +1228,7 @@ static int in_window(struct pack_window *win, off_t offset)
 unsigned char *use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
 		off_t offset,
-		unsigned long *left)
+		size_t *left)
 {
 	struct pack_window *win = *w_cursor;
 
@@ -2122,8 +2122,8 @@ int unpack_object_header(struct packed_git *p,
 			 size_t *sizep)
 {
 	unsigned char *base;
-	unsigned long left;
-	unsigned long used;
+	size_t left;
+	size_t used;
 	enum object_type type;
 
 	/* use_pack() assures us we have [base, base + 20) available
diff --git a/wrapper.c b/wrapper.c
index 36630e5..c4253f7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -67,11 +67,11 @@ static void *do_xmalloc(size_t size, int gentle)
 			ret = malloc(1);
 		if (!ret) {
 			if (!gentle)
-				die("Out of memory, malloc failed (tried to allocate %lu bytes)",
-				    (unsigned long)size);
+				die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
+				    (uintmax_t)size);
 			else {
-				error("Out of memory, malloc failed (tried to allocate %lu bytes)",
-				      (unsigned long)size);
+				error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
+				      (uintmax_t)size);
 				return NULL;
 			}
 		}
diff --git a/zlib.c b/zlib.c
index 4223f1a..e98e499 100644
--- a/zlib.c
+++ b/zlib.c
@@ -29,7 +29,7 @@ static const char *zerr_to_string(int status)
  */
 /* #define ZLIB_BUF_MAX ((uInt)-1) */
 #define ZLIB_BUF_MAX ((uInt) 1024 * 1024 * 1024) /* 1GB */
-static inline uInt zlib_buf_cap(unsigned long len)
+static inline uInt zlib_buf_cap(size_t len)
 {
 	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
 }
@@ -46,8 +46,8 @@ static void zlib_pre_call(git_zstream *s)
 
 static void zlib_post_call(git_zstream *s)
 {
-	unsigned long bytes_consumed;
-	unsigned long bytes_produced;
+	size_t bytes_consumed;
+	size_t bytes_produced;
 
 	bytes_consumed = s->z.next_in - s->next_in;
 	bytes_produced = s->z.next_out - s->next_out;
@@ -150,7 +150,7 @@ int git_inflate(git_zstream *strm, int flush)
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
-unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
+size_t git_deflate_bound(git_zstream *strm, size_t size)
 {
 	return deflateBound(&strm->z, size);
 }
-- 
2.1.4

