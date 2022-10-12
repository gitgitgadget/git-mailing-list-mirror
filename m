Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077FEC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 22:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiJLWFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJLWE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 18:04:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE5F12C893
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:01:57 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r142so10434355iod.11
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pq8CdmarZyBLqUJFowBNihbqqz1CcoqXvVHo5rt8o8=;
        b=szxjUpLosjIMLGyheL88lgU3KsZB/ZmJDW4EYRhG94DzMMGBmimVc2lFMpk62975AX
         cmh6a2gd/d2e/EOlftg9C4dAcXyB2066UqM+1CiPLeW0fuCOntB9KvMpHvUXH6xL6was
         gcDKHZ5QW1OK5TFH9Eo2icIzBn3GtTGtE7+S/KcnV4qNLOs695Z4v0e4DSAgVf9CkaXE
         ecVAS7SvvxPfVsQJ/9ssganXCJABo45FoC+jpG89P+wQ+oBEkyHnzn7k853ZjZ5h+4Au
         HL7PgQo4JtuHSAvt6ZNz5aVTR6BftZp1oyCThrYwm0mIcp6F/bJNsxPfjYFkotdAOxaY
         MSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Pq8CdmarZyBLqUJFowBNihbqqz1CcoqXvVHo5rt8o8=;
        b=whfi3t2hDJpk2TlQg8C9GHatzkh42ovkE2MH3FV83rOxAUVYcxZYf7fXB8jYF/Gb1i
         VZ4+2JbaoLChauvAdjwrVbkfzstcLUPK+MNmMtv0BpLFf/bETGAxOK/JLBxGIfpQxYR3
         Gp/7x+9+9s44eepOjqASZmawjTfS01KDifWPnq3GczO+wizv0msCdN174CDaHY5dPmis
         ukTwCFBPo+u4xe5sfjxTc0Hvm16SNSZ05Ay0CybCLcZm4ChbIAiJrK5AHNuB2i4R8ftQ
         +sPWUNfe56QGoDdTeM6g3B57GCycTslhe4IFuUcyFZqWHD1t/8LFUo39Qw/mHxteHRDz
         iLyA==
X-Gm-Message-State: ACrzQf2HUPiCegLUNQNy/H/qEhyPdh/Om7QpMJfntZyyEglKrFQaIZho
        biIjkTNITCzzQzJlPQ9H0G5HbvblMfhQLbMK
X-Google-Smtp-Source: AMsMyM6HzzDcNBVivwo65f0FnrVTrHfNRzPzhWo3Yf8oU8MGLZu8//5YvRaibhiGIqB9pCWvZTldiQ==
X-Received: by 2002:a05:6602:1409:b0:6a4:cef3:ea7f with SMTP id t9-20020a056602140900b006a4cef3ea7fmr14882317iov.41.1665612116817;
        Wed, 12 Oct 2022 15:01:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i132-20020a6bb88a000000b006bbf0466587sm5361296iof.49.2022.10.12.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:01:56 -0700 (PDT)
Date:   Wed, 12 Oct 2022 18:01:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, derrickstolee@github.com, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH 3/4] midx.c: instrument MIDX and bitmap generation with
 trace2 regions
Message-ID: <dc50527d99680fb0ff1f3240531105badaa221dc.1665612094.git.me@ttaylorr.com>
References: <cover.1665612094.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665612094.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When debugging MIDX and MIDX-bitmap related issues, it is useful to
figure out where Git is spending its time.

GitHub has been using the below trace2 regions to instrument various
components of generating a MIDX itself, as well time spent preparing to
build a MIDX bitmap.

These are limited to instrumenting the following functions:

  - midx.c::find_commits_for_midx_bitmap()
  - midx.c::midx_pack_order()
  - midx.c::prepare_midx_packing_data()
  - midx.c::write_midx_bitmap()
  - midx.c::write_midx_internal()
  - midx.c::write_midx_reverse_index()

to start and end with a trace2_region_enter() and trace2_region_leave(),
respectively.

The category for all of these is "midx", which matches the existing
convention. The region description matches the name of the function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/midx.c b/midx.c
index d41dfd8174..7cfad04a24 100644
--- a/midx.c
+++ b/midx.c
@@ -913,6 +913,8 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	uint32_t *pack_order;
 	uint32_t i;
 
+	trace2_region_enter("midx", "midx_pack_order", the_repository);
+
 	ALLOC_ARRAY(data, ctx->entries_nr);
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[i];
@@ -930,6 +932,8 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 		pack_order[i] = data[i].nr;
 	free(data);
 
+	trace2_region_leave("midx", "midx_pack_order", the_repository);
+
 	return pack_order;
 }
 
@@ -939,6 +943,8 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	struct strbuf buf = STRBUF_INIT;
 	const char *tmp_file;
 
+	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
+
 	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
 
 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
@@ -948,6 +954,8 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 		die(_("cannot store reverse index file"));
 
 	strbuf_release(&buf);
+
+	trace2_region_leave("midx", "write_midx_reverse_index", the_repository);
 }
 
 static void clear_midx_files_ext(const char *object_dir, const char *ext,
@@ -963,6 +971,8 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 {
 	uint32_t i;
 
+	trace2_region_enter("midx", "prepare_midx_packing_data", the_repository);
+
 	memset(pdata, 0, sizeof(struct packing_data));
 	prepare_packing_data(the_repository, pdata);
 
@@ -973,6 +983,8 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 		oe_set_in_pack(pdata, to,
 			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
 	}
+
+	trace2_region_leave("midx", "prepare_midx_packing_data", the_repository);
 }
 
 static int add_ref_to_pending(const char *refname,
@@ -1070,6 +1082,9 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	struct rev_info revs;
 	struct bitmap_commit_cb cb = {0};
 
+	trace2_region_enter("midx", "find_commits_for_midx_bitmap",
+			    the_repository);
+
 	cb.ctx = ctx;
 
 	repo_init_revisions(the_repository, &revs, NULL);
@@ -1103,6 +1118,10 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 		*indexed_commits_nr_p = cb.commits_nr;
 
 	release_revisions(&revs);
+
+	trace2_region_leave("midx", "find_commits_for_midx_bitmap",
+			    the_repository);
+
 	return cb.commits;
 }
 
@@ -1120,6 +1139,8 @@ static int write_midx_bitmap(const char *midx_name,
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
 					hash_to_hex(midx_hash));
 
+	trace2_region_enter("midx", "write_midx_bitmap", the_repository);
+
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
 
@@ -1165,6 +1186,9 @@ static int write_midx_bitmap(const char *midx_name,
 cleanup:
 	free(index);
 	free(bitmap_name);
+
+	trace2_region_leave("midx", "write_midx_bitmap", the_repository);
+
 	return ret;
 }
 
@@ -1211,6 +1235,8 @@ static int write_midx_internal(const char *object_dir,
 	int result = 0;
 	struct chunkfile *cf;
 
+	trace2_region_enter("midx", "write_midx_internal", the_repository);
+
 	get_midx_filename(&midx_name, object_dir);
 	if (safe_create_leading_directories(midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
@@ -1552,6 +1578,8 @@ static int write_midx_internal(const char *object_dir,
 	free(ctx.pack_order);
 	strbuf_release(&midx_name);
 
+	trace2_region_leave("midx", "write_midx_internal", the_repository);
+
 	return result;
 }
 
-- 
2.38.0.16.g393fd4c6db

