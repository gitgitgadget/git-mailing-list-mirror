Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A431C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356064AbiALSIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356010AbiALSIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:08:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C802CC061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:08:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t28so5746874wrb.4
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nflc5OL0l2+WTlx5voRLLLe810fY06mgtUWSK/SMGUk=;
        b=EQ+Bmucs9jUzK4XSOG17kBpg9JapfijWRtnO7RelcOJZN0vtQr+H54GU0Z+TyBpHBc
         i9H43iH8auZOHZoV2mk2QP3QAoGvvGtCClT5LQ8tedQ8Qm4r/9MuQ5jzonVQh2Ku4aAu
         x/iseQd3rWoKrgQqsMymm9TPs7AnkvblvT/lPenn5UNy7o/0k8bylaGq54QgVm1PT/9u
         55Re+2H2x/L6o9BQ9OQVfdxrQEstPjOQSXrxLVks5FV+MaBTUJgUgnzaLs8+Bn4AMjaM
         J1h5Pdb3ZnDXxNvs/q4TP/9oYAgm0R0ufSWHseGlCY688QWu6DvlGH2WBwMROomwmrPL
         NCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nflc5OL0l2+WTlx5voRLLLe810fY06mgtUWSK/SMGUk=;
        b=SGI7jIaLFVOCBsgzsg3G05smdoRBThaaJJyysbYApP0G4ucp78VcsPmnYmuTb6ukPc
         gw48eVLREFYqi0fXp9vnDTmHWyQKBoT2XdNeQ42UProB1FDmLRLEswie17rQzk0+duxo
         99zT37YdPAx5Xaj3DT8nl6UA/aOXNijJIdD52x7Guy7mfSWtCY3U80oHMwE80RH1QgV5
         gOm8lc0hy29WjE1E8y06dKz5pTkuV06H6jcH3+pqYcI+4rdUBlFDweRYu6MVU1TZDfUA
         xcmrOVQpn0TQoYzZxN3cfNfMhz2ZGgAMYzS9a9yHJWJSpbriZ8U3oyTXbIZKZJwLny4r
         2gkA==
X-Gm-Message-State: AOAM530dtEYcw3jvlYXVSwLEq2crTdRiyUm2hqWW6zmX6Vd6Np1UshyP
        iPqzXL1xfVD3MbQzDPVhkPetgsV84Tg=
X-Google-Smtp-Source: ABdhPJz6jeZ8Hn2HwwQ8gnmsZDyqhHhu8ff6Pa7xgh5PX2IfJ2fDzCXXMgEKClNeaPcXW1iWMzq/uQ==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr123618wrt.40.1642010879248;
        Wed, 12 Jan 2022 10:07:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm668892wrs.0.2022.01.12.10.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:07:58 -0800 (PST)
Message-Id: <e4c1cc58265ca7ae7b32b9faf41324883011d1a6.1642010868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 18:07:45 +0000
Subject: [PATCH 4/7] reftable: avoid writing empty keys at the block layer
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

The public interface (reftable_writer) already ensures that keys are
written in strictly increasing order, and an empty key by definition
fails this check.

However, by also enforcing this at the block layer, it is easier to
verify that records (which are written into blocks) never have to
consider the possibility of empty keys.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c      | 27 +++++++++++++++++----------
 reftable/block_test.c |  5 +++++
 reftable/writer.c     |  3 +--
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 855e3f5c947..8725eaaf64f 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -88,8 +88,9 @@ uint8_t block_writer_type(struct block_writer *bw)
 	return bw->buf[bw->header_off];
 }
 
-/* adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
-   success */
+/* Adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
+   success. Returns REFTABLE_API_ERROR if attempting to write a record with
+   empty key. */
 int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 {
 	struct strbuf empty = STRBUF_INIT;
@@ -105,8 +106,14 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	int is_restart = 0;
 	struct strbuf key = STRBUF_INIT;
 	int n = 0;
+	int err = -1;
 
 	reftable_record_key(rec, &key);
+	if (!key.len) {
+		err = REFTABLE_API_ERROR;
+		goto done;
+	}
+
 	n = reftable_encode_key(&is_restart, out, last, key,
 				reftable_record_val_type(rec));
 	if (n < 0)
@@ -118,16 +125,11 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 		goto done;
 	string_view_consume(&out, n);
 
-	if (block_writer_register_restart(w, start.len - out.len, is_restart,
-					  &key) < 0)
-		goto done;
-
-	strbuf_release(&key);
-	return 0;
-
+	err = block_writer_register_restart(w, start.len - out.len, is_restart,
+					    &key);
 done:
 	strbuf_release(&key);
-	return -1;
+	return err;
 }
 
 int block_writer_finish(struct block_writer *w)
@@ -324,6 +326,9 @@ int block_iter_next(struct block_iter *it, struct reftable_record *rec)
 	if (n < 0)
 		return -1;
 
+	if (!key.len)
+		return REFTABLE_FORMAT_ERROR;
+
 	string_view_consume(&in, n);
 	n = reftable_record_decode(rec, key, extra, in, it->br->hash_size);
 	if (n < 0)
@@ -350,6 +355,8 @@ int block_reader_first_key(struct block_reader *br, struct strbuf *key)
 	int n = reftable_decode_key(key, &extra, empty, in);
 	if (n < 0)
 		return n;
+	if (!key->len)
+		return -1;
 
 	return 0;
 }
diff --git a/reftable/block_test.c b/reftable/block_test.c
index 4b3ea262dcb..5112ddbf468 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -42,6 +42,11 @@ static void test_block_read_write(void)
 			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	reftable_record_from_ref(&rec, &ref);
 
+	ref.refname = "";
+	ref.value_type = REFTABLE_REF_DELETION;
+	n = block_writer_add(&bw, &rec);
+	EXPECT(n == REFTABLE_API_ERROR);
+
 	for (i = 0; i < N; i++) {
 		char name[100];
 		uint8_t hash[GIT_SHA1_RAWSZ];
diff --git a/reftable/writer.c b/reftable/writer.c
index 35c8649c9b7..e3c042b9d84 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -238,14 +238,13 @@ static int writer_add_record(struct reftable_writer *w,
 
 	writer_reinit_block_writer(w, reftable_record_type(rec));
 	err = block_writer_add(w->block_writer, rec);
-	if (err < 0) {
+	if (err == -1) {
 		/* we are writing into memory, so an error can only mean it
 		 * doesn't fit. */
 		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
 		goto done;
 	}
 
-	err = 0;
 done:
 	strbuf_release(&key);
 	return err;
-- 
gitgitgadget

