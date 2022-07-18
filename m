Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C7C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 20:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiGRUgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiGRUgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 16:36:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98230F71
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:36:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk26so18702508wrb.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NSOnAY1bnzWC8MZaPu4plISH2zESF1Vikm6c7R+j4tw=;
        b=quRNf+/eeq2Tx/w1DQPCS5qBK35yKeXoRCVijqoIVFOfyhAaJaYyNTjX2UGzC7B/Ol
         ozIGlQlLX215PVYYibJPQn53qTUbPJ2ib3feT+WOuUQjzYE1ewg8aSk26O0S4Gl7UtSI
         goktS0t2YD+hgMuYH6GLYHS3mzlI6o9dDGKFqBIXieaE1XzY4pgk8z8TpPLkfVTc6+Ro
         ngTXnA5Gg6psL3pnd6a8jFFh6JS72oGyLg/9EWhHcR7vNOC5nMGqgF3h/oWsXsEmN2ii
         mq+pGU+wa8QQyBgVxraWf4vy0DgZV7wHUM1dPM/L93Y7rKEmQVQMovv5OLzmVW02hnjG
         F67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NSOnAY1bnzWC8MZaPu4plISH2zESF1Vikm6c7R+j4tw=;
        b=Ixa4t7kRdKUTKQ013QoYIfCXNJqhIYODdZk0lMA3QozXj4MfbpxDWCmu3seDbvVQ+o
         WfOay+0ZdEOkRpphMJxV+y2L1UkIHRDqt9wkFionG1EY1Hgyds1PIn3XgMe6Hvg2dJh/
         Bj8NMBAuW2EiE7KqeT/FsI9nMn+l1cd2DRYL6e2hyAVy6WyG1i/w23AKGz61RKvHOA9r
         41jmlHEqCismlVSka83K8sE4PH3N3KhwDtcG7VTkfBZHZvHtVnuwzFug1C8o7w/5oJbn
         9ij0/bLxV6Eo5u+jZwexDz9Fm7NqZ3T6pu/LRfLOku076SGQ8wiL5PYAT/oNLfW5vw54
         8hHw==
X-Gm-Message-State: AJIora9ifpkXwnxfUTm1/AqUOeZdICOFNswODtXmk4xsKv7NLVRAckXp
        SUvsyXaU7t1oJrbDe1+KWTh4FiClyz8=
X-Google-Smtp-Source: AGRyM1tXsoWiCWoFZPobfg71ZLW1AGW0YoNoEzDRZMK3ikf2qg5PE3SdlMBQX/62DcKdudWX3fYFvQ==
X-Received: by 2002:a5d:5984:0:b0:21d:7f3a:a153 with SMTP id n4-20020a5d5984000000b0021d7f3aa153mr23786297wri.568.1658176566882;
        Mon, 18 Jul 2022 13:36:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b0021bae66362esm11616980wrw.58.2022.07.18.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:36:06 -0700 (PDT)
Message-Id: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Jul 2022 20:36:05 +0000
Subject: [PATCH] midx:  reduce memory pressure while writing bitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

We noticed that some 'git multi-pack-index write --bitmap' processes
were running with very high memory. It turns out that a lot of this
memory is required to store a list of every object in the written
multi-pack-index, with a second copy that has additional information
used for the bitmap writing logic.

Using 'valgrind --tool=massif' before this change, the following chart
shows how memory load increased and was maintained throughout the
process:

    GB
4.102^                                                             ::
     |              @  @::@@::@@::::::::@::::::@@:#:::::::::::::@@:: :
     |         :::::@@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |      :::: :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |    :::: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |    : :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |    : :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @ :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @ :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
   0 +--------------------------------------------------------------->

It turns out that the 'struct write_midx_context' data is persisting
through the life of the process, including the 'entries' array. This
array is used last inside find_commits_for_midx_bitmap() within
write_midx_bitmap(). If we free (and nullify) the array at that point,
we can free a decent chunk of memory before the bitmap logic adds more
to the memory footprint.

Here is the massif memory load chart after this change:

    GB
3.111^      #
     |      #                              :::::::::::@::::::::::::::@
     |      #        ::::::::::::::::::::::::: : :: : @:: ::::: :: ::@
     |     @#  :::::::::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |  :::@#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
   0 +--------------------------------------------------------------->

It is unfortunate that the lifetime of the 'entries' array is less
clear. To make this simpler, I added a few things to try and prevent an
accidental reference:

 1. Using FREE_AND_NULL() we will at least get a segfault from reading a
    NULL pointer instead of a use-after-free.

 2. 'entries_nr' is also set to zero to make any loop that would iterate
    over the entries be trivial.

 3. Set the 'ctx' pointer to NULL within write_midx_bitmap() so it does
    not get another reference later. This requires adding a local copy
    of 'pack_order' giving us a reference that we can use later in the
    method.

 4. Add significant comments in write_midx_bitmap() and
    write_midx_internal() to add warnings for future authors who might
    accidentally add references to this cleared memory.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    midx: reduce memory pressure while writing bitmaps
    
    The thing I'm most worried about with this patch is whether there is
    enough (or too much) defensive programming.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1292%2Fderrickstolee%2Fbitmap-memory-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1292/derrickstolee/bitmap-memory-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1292

 midx.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 5f0dd386b02..cc31d803a5f 100644
--- a/midx.c
+++ b/midx.c
@@ -1063,6 +1063,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 	struct commit **commits = NULL;
 	uint32_t i, commits_nr;
 	uint16_t options = 0;
+	uint32_t *pack_order;
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
 	int ret;
 
@@ -1076,6 +1077,15 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 
 	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
 
+	/*
+	 * Remove the ctx.entries to reduce memory pressure.
+	 * Nullify 'ctx' to help avoid adding new references to ctx->entries.
+	 */
+	FREE_AND_NULL(ctx->entries);
+	ctx->entries_nr = 0;
+	pack_order = ctx->pack_order;
+	ctx = NULL;
+
 	/*
 	 * Build the MIDX-order index based on pdata.objects (which is already
 	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
@@ -1102,7 +1112,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 	 * bitmap_writer_finish().
 	 */
 	for (i = 0; i < pdata.nr_objects; i++)
-		index[ctx->pack_order[i]] = &pdata.objects[i].idx;
+		index[pack_order[i]] = &pdata.objects[i].idx;
 
 	bitmap_writer_select_commits(commits, commits_nr, -1);
 	ret = bitmap_writer_build(&pdata);
@@ -1443,6 +1453,11 @@ static int write_midx_internal(const char *object_dir,
 	if (flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
 		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
+
+	/*
+	 * Writing the bitmap must be last, as it will free ctx.entries
+	 * to reduce memory pressure during the bitmap write.
+	 */
 	if (flags & MIDX_WRITE_BITMAP) {
 		if (write_midx_bitmap(midx_name.buf, midx_hash, &ctx,
 				      refs_snapshot, flags) < 0) {

base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
-- 
gitgitgadget
