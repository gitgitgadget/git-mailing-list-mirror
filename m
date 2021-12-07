Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F57BC433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhLGRtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbhLGRs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:48:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F6C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t9so31088712wrx.7
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2mX0ewo9yheSDENuy2H8jhMj0liBRlVQnqnpNtjTveM=;
        b=dG8yyqYk7p/QXxaPu858F0ph1tKSp14hAdLeMa/yKB2a3m2bv2ftlMOOogPxSr/NVh
         7z43oLGmlt00DHPd59igi7OdYTMK7QM0yZ1yDF4zo8c9fiRQMpst/1XxH+vAVwAS1M4s
         JF2mb5gWFHDNDNzSUU1Xg04l0V6H71/im2Q2sW+whWqROM5LS8Q3Wf7GZbWoifp0xpHV
         1rbck1yWiEWOpvFlnG2DASlWklQZcBCwVTE8kUL4vsR0wxI/zotLZn1uuHjQelusP/CA
         EHYv+c6rLG2e7VKpP/eHBIAo0oPHuekUIZbpK2so8O54RmCnEi5NpN7w7NTUtPqvlVAW
         spoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2mX0ewo9yheSDENuy2H8jhMj0liBRlVQnqnpNtjTveM=;
        b=k4L+isMCodX4JqQrLZlnujlaOYaTBrcSQqKtOZZK0BMK7EEPHnF4MDXfnqsWp/2OtC
         xzcOl3F7Af9ONvM9O0bV7pjJVfv/oujtm1d68osDTpzC5f594Ycl5ZrOYc4X5HeXQcab
         nQbTe3x17l6RFy2c2mjQ0SgDJLt2QpHEjnD4+yUtuEsQDV5szvQbIDv2sU7m9RQ+Zuoi
         aZUpL9zwTMWtwxYdzmvmM2WIfo7Znk+s7LwQBwGfKsjxZjlh34N2MWnIYIc0dYDvaYnK
         nLmo/hrBXJTkVdQM8ThTbV4xhVwTD1db4g6pfxyQENvkg9JKIqkJBRzrKbZP+i9EibWQ
         N9jg==
X-Gm-Message-State: AOAM530gK6WkNryocVJ5l1878XUsXvxS2/I+jfrAWmyJFpLijA8POPFO
        HsZxKh/ZGvI2tlxxaeRVMFsAoEhP0KU=
X-Google-Smtp-Source: ABdhPJwnYzhR07GR3Z9SkhWj85goIBQu/gI23uqbepHt5xWtl6TvrJFxffF6mpZVy0vbXGMdsCxXjA==
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr6027381wry.266.1638899127535;
        Tue, 07 Dec 2021 09:45:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm354651wrh.16.2021.12.07.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:27 -0800 (PST)
Message-Id: <603bd1d4f6e4ceda02a5165eedd3ae5b92b8929e.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:16 +0000
Subject: [PATCH 02/10] reftable: fix resource leak in error path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would be triggered by corrupt files, so it doesn't have test coverage. This
was discovered by a Coverity scan.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 855e3f5c947..d7347bb3152 100644
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
@@ -213,15 +216,19 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		    uncompress2(uncompressed + block_header_skip, &dst_len,
 				block->data + block_header_skip, &src_len)) {
 			reftable_free(uncompressed);
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
@@ -251,7 +258,11 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	br->restart_count = restart_count;
 	br->restart_bytes = restart_bytes;
 
-	return 0;
+done:
+	if (uncompressed) {
+		reftable_free(uncompressed);
+	}
+	return err;
 }
 
 static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
-- 
gitgitgadget

