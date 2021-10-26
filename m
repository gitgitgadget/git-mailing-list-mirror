Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8988BC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CF261039
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhJZVED (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbhJZVDz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD1C061235
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:28 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f9so953924ioo.11
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B6Pe1TTYNS9Q8z0noJ4i5DWNrdimfhRp/iP6KRF7+tE=;
        b=sGAgiKCuCBUdg/tmDHhQ8g/3NWIWcqD6phcpfJdlLcQ0Y0HH3QZpqm9wTxsKpcATwa
         LbzwpljquQ2VdxA+aGuZ+/PMQyx//0wHBgEdQRrAqSF9bITGNGeKiKTnHlBiSI4mw0qi
         Le73FhGETP2wuO1bu/b1GlfMKWa5/PLYVMVAwpmsuJys4mfIlyiXGfXrnKAaCIXeinwq
         YWEyRUaEnDHPY8ZhMuML4oonO5nmj6sOyA2WE8nFomFW2gmyOkfWrlYtmAGzc8yH0W9w
         lTPX34pm+P0g6sgHbxUpfS0FKOCWLHGT5T1OsLs/rzW3mJGFBewh2stkwZhyOYmHXHl8
         hI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6Pe1TTYNS9Q8z0noJ4i5DWNrdimfhRp/iP6KRF7+tE=;
        b=SYUWP9GDDfwDVyKoWTDUmQ7W4nEIo98wyYKVRuTe2bTmLftBZOuq3gTPs+wI6v5w4O
         rthAKMYSLtJB6MbV5rlsRqnZHXNFkJFbtWA+UE7r2/HWl7neHwxVkhZg7L6Mhk35rpL3
         QwrNl2DclRlplCOfdmrC211f8BdHH+2t5OjHS4jxra67wykhAZsFF4do29mp6vRUpafm
         vYlfzg26CMRiHIZHgXAiY8rOBbRmGFRBqBJgM4E9TEemLXnCNvIy5LJArhAa576pcXv6
         ZVlILvvQGd3yIgsZ6OGqjX7TzblBfMRQcwRAfr/e0zlfuZkY3ruUyAGYmIpplb19NGUm
         Ghng==
X-Gm-Message-State: AOAM530mVz+X4ylACJeGYZUnSnKB0KQ+wBzRrMhpZ6uZndm+OPqTWEVb
        TecznYNTlx2JrHHSKUUadJbWqjcHvXcmnQ==
X-Google-Smtp-Source: ABdhPJwhWFMTbU5yEcDYsj/N/PvQIEmdcWmcW9e+O6VmUXpeJm/Ojjtk4KvF9vxyQBQCfaq1ztlSOw==
X-Received: by 2002:a05:6602:1542:: with SMTP id h2mr16777239iow.190.1635282087764;
        Tue, 26 Oct 2021 14:01:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v4sm616758ilq.57.2021.10.26.14.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:27 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 9/9] pack-bitmap.c: more aggressively free in
 free_bitmap_index()
Message-ID: <c1e7e6cc924f61d237e5cc7045ad9698fbe4c3b2.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function free_bitmap_index() is somewhat lax in what it frees. There
are two notable examples:

  - While it does call kh_destroy_oid_map on the "bitmaps" map, which
    maps commit OIDs to their corresponding bitmaps, the bitmaps
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
index 3d81425c29..a56ceb9441 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1859,9 +1859,17 @@ void free_bitmap_index(struct bitmap_index *b)
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
