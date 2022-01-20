Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91086C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376498AbiATPMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346179AbiATPMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37823C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id w26so12860826wmi.0
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MAFv42Wdf02HqJQ1K4AFLDNAvLgG2Dg41xMO3uHwiLc=;
        b=Gn6/pt0+Lq1kihtiOl+S6gpQxkBBA0tg+JgAncP2TVwBe6w8dF1lwT/JtiI7ILJuyo
         vK+GQBAA6ftfYy7KF71RzsBPWgyCiP/xYy57t3UJF3/m7dzLw+Yx0fK5mV4x4brRaSLy
         aesiqWPHnx3c243dsjI+/Ams7ZE66Q2dpiAoDLsANLXHjlLkbT72wuo1k1qILBdktep4
         Y2L5i5W+xAHczNDbybe6ntDxXhnwzBBHYVVRv8kPQUshr6vrdjX3J1+d4YmZYCi3clw1
         dzebXFnRrVYOi956pxU77I+IUetCQw9R9X4aHQv/dr6UkA7gg4ItIRjFPD59XpXkoHAO
         9DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MAFv42Wdf02HqJQ1K4AFLDNAvLgG2Dg41xMO3uHwiLc=;
        b=CJ8PFFCmy8LsRtsX0EDh7tG4Hs0ESAAt2FHIrVJhyjk0HWX5whUjfaQMfK8oSo1nHT
         B1h3BN/UIDxc/XyUnQ6BDMIg9RCP2dojNqksAKlmJzy5I0E2ioOiSJWkM/kYIDoofzFe
         kHAFmx4SXW8pClfh7aXr/e+TVdo86IwouJylRlhSS9O84mjVjcT4yVeu6tuLdjwVlSFE
         FV8IEI8VjOE8SVclSev5i0rn5Mr6WwJ1OL5ye6ykPjkRMp71QxkditUTwyi3tUJUB890
         XLzLUZYAd1yyPBqEschU417m1A5OHYaEEt1BJxxtt/D93P6kTQ2nIp+slnrJWNSEQIIU
         ELSg==
X-Gm-Message-State: AOAM533zzf4iRKBoByV7NJLe+H29RiZ4CYkYTm9Yr/veWQpvDOddffzr
        8j61KQNmlf5oqsKIodXy8zzL/s2XNkE=
X-Google-Smtp-Source: ABdhPJz9t/QJ3/zTE0nCYgaAiwZYh4474iasnH/uSVjYA6J7IOlHA3uqOavFleNW1bzRo0HFzLwKXA==
X-Received: by 2002:a05:600c:4e8e:: with SMTP id f14mr9539418wmq.175.1642691537529;
        Thu, 20 Jan 2022 07:12:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o26sm970896wro.9.2022.01.20.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:17 -0800 (PST)
Message-Id: <315ce62e710e6e80dc8a4d959e5532b5f9142669.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:01 +0000
Subject: [PATCH v6 02/15] reftable: fix resource leak in block.c error path
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
 reftable/block.c          | 26 +++++++++------
 reftable/reader.c         | 23 ++++++++------
 reftable/readwrite_test.c | 66 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 855e3f5c947..6c8e8705205 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -188,13 +188,16 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	uint32_t full_block_size = table_block_size;
 	uint8_t typ = block->data[header_off];
 	uint32_t sz = get_be24(block->data + header_off + 1);
-
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
@@ -203,7 +206,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		uLongf src_len = block->len - block_header_skip;
 		/* Log blocks specify the *uncompressed* size in their header.
 		 */
-		uint8_t *uncompressed = reftable_malloc(sz);
+		uncompressed = reftable_malloc(sz);
 
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(uncompressed, block->data, block_header_skip);
@@ -212,16 +215,19 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
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
@@ -251,7 +257,9 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
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

