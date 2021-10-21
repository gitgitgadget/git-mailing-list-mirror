Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B89C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8B461183
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhJUDmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhJUDm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:26 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B325C06174E
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:09 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i6so7158095ila.12
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lq37b5YWq2OSusH7mkUuiR3zkwMRRYoaCH9wj3gryZ4=;
        b=HWqjAZRW6xNQSj6Gq4uo34Eil9+rudICFcXcjiE1CdhR3DeJcmHdZ0wvPPCaQuKlkc
         EcGNY57/BUQiDdMqDXGTHves5yyq6TkPyx3JfFiLHIh3rPzm1Aj0G8K1/crINjZdWRaV
         wr2ll7z2dND4QsrdwIJ1yGJs7yL2C5Kf+mlZ35S0BF/ONi4LkYdvCY+DfTuOXyfU24EI
         c0V0ANOIye1plWmY+oWg5NE9JsxUUur75Q7cjawtMPlob/LSMUPV8Dshb4/T2nfv2vqs
         pNkkWLx8ZN/9EEpBEGaGYCk8Nre/a4McDYlyt7zUviQjigJO6T0zTEbxeWpKGi/bCMdK
         lvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lq37b5YWq2OSusH7mkUuiR3zkwMRRYoaCH9wj3gryZ4=;
        b=2TAXXQzdAqwtfLcsPVyN9RsyJK4maCb3bnYBh3Y+1Y+sI3ytGOJyb3WgZmMWGkqttA
         DcwYdew5KymxhwURUhGmvT4po4h484/0X7D9uZZzXJLGIjMokSXF6yLWnQe+bsDfH3Ka
         xmObOfVQdpl6Y2r7UfPcY9YYJq4LfWfjuox4Hig7kafuI7jC64VVGLgyWRJEFxd341eF
         tffOx/ch8+6nUeY0IqmTFTbYr4C7+fp05tNXw99W7IzdIqPmNxFs+dJLytzXavxVztD3
         HrRGkGPzAqnvMkMAdfzHjtrtwo0K/Ne1rbltyRMj3PiiFhURaJvqS+UVkbeRGG7lzTFe
         BCHw==
X-Gm-Message-State: AOAM531EyPFwr8J6Ok0qnWFq+GY9s+su4p5CFXcq0TevU3IApcpS7C0U
        fw6pTrivbzkqRoxYamgYkrTSpIIj3rDCAA==
X-Google-Smtp-Source: ABdhPJzCHEdZ5kbYMTM3PRjteFmBPo4ETxKbod5BEJGG0Xp3sA1xW1DKpwLM4d/J+F2SMWoGZo+cyQ==
X-Received: by 2002:a92:5206:: with SMTP id g6mr2044310ilb.232.1634787608323;
        Wed, 20 Oct 2021 20:40:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c5sm2005250ilq.71.2021.10.20.20.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:40:08 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:40:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 09/11] pack-bitmap.c: more aggressively free in
 free_bitmap_index()
Message-ID: <e65ac7deb5973b8209e8d94ad9140e005e22c44e.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function free_bitmap_index() is somewhat lax in what it frees. There
are two notable examples:

  - While it does call kh_destroy_oid_map on the "bitmaps" map (which
    maps) commit OIDs to their corresponding bitmaps, the bitmaps
    themselves are not freed. Note here that we recycle already-freed
    ewah_bitmaps into a pool, but these are handled correctly by
    ewah_pool_free().

  - We never bother to free the extended index's "positions" map, which
    we always allocate in load_bitmap().

Fix both of these.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0f6656db02..451ca3512c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1854,9 +1854,17 @@ void free_bitmap_index(struct bitmap_index *b)
 	ewah_pool_free(b->trees);
 	ewah_pool_free(b->blobs);
 	ewah_pool_free(b->tags);
+	if (b->bitmaps) {
+		struct stored_bitmap *sb;
+		kh_foreach_value(b->bitmaps, sb, {
+			ewah_pool_free(sb->root);
+			free(sb);
+		});
+	}
 	kh_destroy_oid_map(b->bitmaps);
 	free(b->ext_index.objects);
 	free(b->ext_index.hashes);
+	kh_destroy_oid_pos(b->ext_index.positions);
 	bitmap_free(b->result);
 	bitmap_free(b->haves);
 	if (bitmap_is_midx(b)) {
-- 
2.33.0.96.g73915697e6

