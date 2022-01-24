Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9EC433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346785AbiAXTib (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352025AbiAXT30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:29:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7677C02980D
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a13so15475423wrh.9
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6BcPZYQ0vVLjzOTN+CeTC1tPkkZaBRc4T5nwILhJrdk=;
        b=W0E6lg+OH5VvYwLZreuhQWq3P+Lz9Ey2zrmcz6lmSYNpz29vcKKxck+LYLY32IhTfn
         xw00uuk7JAiQJ7DYInnW8NeozMNsyNFDR5KYkG3jnFUUs6wi539OvXh8Ch5p8F0wT5ue
         NbRZzHG7kRrPLoA3PqtW2g3zp3q2E011Oqz1H9arFFDGn+LCRnENnnpS12fhsI0057g8
         yTT6FSXzMsjfIRhneMzqckiTu3Hv1rfeg5b9xgc0EumLCUPum0v9ypenZao9tr2myjUz
         6YB7/FmRTZ8LtYMwSITslHmHiV82OYGpXtLnbL2HffTyXvjDg3DY0oWK29ZmutWsA8o4
         ViWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6BcPZYQ0vVLjzOTN+CeTC1tPkkZaBRc4T5nwILhJrdk=;
        b=mjBaNdQ+nMuUsgASygh+jbngWszw/rtuz95ySHlAiHTnt62ZcFlloAjCHYC3ekDzf0
         stin7Do67wJgS/7ENahFSIWsPwXUYCNcvIrrXRB7V5uHXAWmu0As/GrtHqKMVw1UpbAv
         fhiM0zeoXxHhLhnpEnyX5xGWFInoU7HFdPLHoxpXTMVgLT39sh/s1ox3ybOsUy9d0WTh
         tKQJHMIQn8kwchua8bUEvv1mSahvYCZ/E4xYISDIfKVdpn/2ER5aythNX9LtoLWfyKGv
         gclMEe1RwZ2eLpDzk/h+/OGcWPnCcI+vlr6E78qsIZ7wKrQdZrE9zxlPIqlCyN8H+i0T
         mtNg==
X-Gm-Message-State: AOAM532WoUaka9C4wQ4+07khqhDM9U6bLOMhr3nDB9eBRsMKE+3MxpEp
        XpjcY8GkrBNGovAIQuFENk+a90NKlRndew==
X-Google-Smtp-Source: ABdhPJxETZnIsGladkPwu7EkFh9/jtrOO77dbQ1rqVW6IAX37vwyAuTkxrYrGa3dxudS3iCBSw5Y2w==
X-Received: by 2002:a5d:5548:: with SMTP id g8mr2042339wrw.534.1643051627361;
        Mon, 24 Jan 2022 11:13:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm170542wms.9.2022.01.24.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:46 -0800 (PST)
Message-Id: <1c5441d2f7e81307550194f44d235174fee49441.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:30 +0000
Subject: [PATCH v7 02/16] reftable: fix resource leak in block.c error path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Add test coverage for corrupt zlib data. Fix memory leaks demonstrated by
unittest.

This problem was discovered by a Coverity scan.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c          | 25 ++++++++++-----
 reftable/reader.c         | 23 ++++++++------
 reftable/readwrite_test.c | 66 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 17 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 855e3f5c947..5832f85501d 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -189,12 +189,16 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	uint8_t typ = block->data[header_off];
 	uint32_t sz = get_be24(block->data + header_off + 1);
 
+	int err = 0;
 	uint16_t restart_count = 0;
 	uint32_t restart_start = 0;
 	uint8_t *restart_bytes = NULL;
+	uint8_t *uncompressed = NULL;
 
-	if (!reftable_is_block_type(typ))
-		return REFTABLE_FORMAT_ERROR;
+	if (!reftable_is_block_type(typ)) {
+		err =  REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
 
 	if (typ == BLOCK_TYPE_LOG) {
 		int block_header_skip = 4 + header_off;
@@ -203,7 +207,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		uLongf src_len = block->len - block_header_skip;
 		/* Log blocks specify the *uncompressed* size in their header.
 		 */
-		uint8_t *uncompressed = reftable_malloc(sz);
+		uncompressed = reftable_malloc(sz);
 
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(uncompressed, block->data, block_header_skip);
@@ -212,16 +216,19 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		if (Z_OK !=
 		    uncompress2(uncompressed + block_header_skip, &dst_len,
 				block->data + block_header_skip, &src_len)) {
-			reftable_free(uncompressed);
-			return REFTABLE_ZLIB_ERROR;
+			err = REFTABLE_ZLIB_ERROR;
+			goto done;
 		}
 
-		if (dst_len + block_header_skip != sz)
-			return REFTABLE_FORMAT_ERROR;
+		if (dst_len + block_header_skip != sz) {
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		}
 
 		/* We're done with the input data. */
 		reftable_block_done(block);
 		block->data = uncompressed;
+		uncompressed = NULL;
 		block->len = sz;
 		block->source = malloc_block_source();
 		full_block_size = src_len + block_header_skip;
@@ -251,7 +258,9 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	br->restart_count = restart_count;
 	br->restart_bytes = restart_bytes;
 
-	return 0;
+done:
+	reftable_free(uncompressed);
+	return err;
 }
 
 static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
diff --git a/reftable/reader.c b/reftable/reader.c
index 006709a645a..35781593a29 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -290,28 +290,33 @@ int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
 
 	err = reader_get_block(r, &block, next_off, guess_block_size);
 	if (err < 0)
-		return err;
+		goto done;
 
 	block_size = extract_block_size(block.data, &block_typ, next_off,
 					r->version);
-	if (block_size < 0)
-		return block_size;
-
+	if (block_size < 0) {
+		err = block_size;
+		goto done;
+	}
 	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
-		reftable_block_done(&block);
-		return 1;
+		err = 1;
+		goto done;
 	}
 
 	if (block_size > guess_block_size) {
 		reftable_block_done(&block);
 		err = reader_get_block(r, &block, next_off, block_size);
 		if (err < 0) {
-			return err;
+			goto done;
 		}
 	}
 
-	return block_reader_init(br, &block, header_off, r->block_size,
-				 hash_size(r->hash_id));
+	err = block_reader_init(br, &block, header_off, r->block_size,
+				hash_size(r->hash_id));
+done:
+	reftable_block_done(&block);
+
+	return err;
 }
 
 static int table_iter_next_block(struct table_iter *dest,
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 70c7aedba2c..edb9cfc1930 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -288,6 +288,71 @@ static void test_log_write_read(void)
 	reader_close(&rd);
 }
 
+static void test_log_zlib_corruption(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader rd = { 0 };
+	struct reftable_block_source source = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	const struct reftable_stats *stats = NULL;
+	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
+	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
+	char message[100] = { 0 };
+	int err, i, n;
+
+	struct reftable_log_record log = {
+		.refname = "refname",
+		.value_type = REFTABLE_LOG_UPDATE,
+		.value = {
+			.update = {
+				.new_hash = hash1,
+				.old_hash = hash2,
+				.name = "My Name",
+				.email = "myname@invalid",
+				.message = message,
+			},
+		},
+	};
+
+	for (i = 0; i < sizeof(message) - 1; i++)
+		message[i] = (uint8_t)(rand() % 64 + ' ');
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_log(w, &log);
+	EXPECT_ERR(err);
+
+	n = reftable_writer_close(w);
+	EXPECT(n == 0);
+
+	stats = writer_stats(w);
+	EXPECT(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+	w = NULL;
+
+	/* corrupt the data. */
+	buf.buf[50] ^= 0x99;
+
+	block_source_from_strbuf(&source, &buf);
+
+	err = init_reader(&rd, &source, "file.log");
+	EXPECT_ERR(err);
+
+	err = reftable_reader_seek_log(&rd, &it, "refname");
+	EXPECT(err == REFTABLE_ZLIB_ERROR);
+
+	reftable_iterator_destroy(&it);
+
+	/* cleanup. */
+	strbuf_release(&buf);
+	reader_close(&rd);
+}
+
 static void test_table_read_write_sequential(void)
 {
 	char **names;
@@ -667,6 +732,7 @@ static void test_corrupt_table(void)
 
 int readwrite_test_main(int argc, const char *argv[])
 {
+	RUN_TEST(test_log_zlib_corruption);
 	RUN_TEST(test_corrupt_table);
 	RUN_TEST(test_corrupt_table_empty);
 	RUN_TEST(test_log_write_read);
-- 
gitgitgadget

