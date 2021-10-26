Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F45C433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B6760FE8
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbhJZVEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbhJZVDu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:50 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17843C06122B
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h20so679114ila.4
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0QQ8cMtcjtTT22hoGkncPPVHt+E3hy22Eb3Oz0dKmA=;
        b=nCHRl3jAJfxgJWlKUWqfvpfY4/iuyc4hSN9lXvpnuTUqb5dDXijP3mLu/B2MksGGKU
         44j2jImv3KyqrLI9qA4NEiiJ9UMjMGQ3r9XBqPdK+6+l0D39cfhb+kHGYhOBdRS38PSS
         l3V3IDq9BokGj1Sn95ObxcmWCiH+NFJErgdAQS008JQSFpXFIDsWBDfBQL0L22bpLv4c
         mxvlwK9F1dhhI1oSvvk5aExN3SbhqsYTozUwEZI7pJlpxRSx+cWPIRbG4OkRVY0ssA3Y
         X6R5YEKyODxoKTImlVr6TC9kKEiUzN4s6KadXwjMgTorzZneemB11NUOt01bJUThIBHu
         BIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0QQ8cMtcjtTT22hoGkncPPVHt+E3hy22Eb3Oz0dKmA=;
        b=ezoBtd3KRjUTgNDCzD7NjUW7nYlMZ19VX3cIPt074ddTPhLxk6ckJ+Ls2MP73HSiIV
         X2u9VAgkkAfsGskI/NnCNmFVdyIKw4aR+8YKkHE8QMsgK2ZakfGTHJEG91xar36It7ld
         WXvnvOq4qtzfgRYYM7kx12sc3Mf2PRE9vJj5L8Yq0tq4h3VNOjVS7d7vimn8cN2Mz2OB
         Y0Q3UvBv6Wz6EQ2EuqiXkLt/WsjCpEkZ2/KSQ0ViYdAc4JM7RGhB5lH9YJgEIdqzho6B
         WqaI+76i/vSV7BvGzZvbosxDauSx89Z7XNu4HDi45zAqUjsvKWxx1sQS1mBSUxj0aYjf
         LYCQ==
X-Gm-Message-State: AOAM532OQzhPkCtqrl8HUHNslHOxfjQr7aqupDiwjqIrS8GKvUoLuNpn
        ZM7MjQgeVot87H7Zk0UQUsVV6Q7p32k1ig==
X-Google-Smtp-Source: ABdhPJxRvOZGS8C0x7D/aY3gDum5HNwP/A/vBlqqFuT1k+g18fmA+o60LemPpOArtmFZSAf6BRy6Vg==
X-Received: by 2002:a92:3211:: with SMTP id z17mr692921ile.271.1635282084971;
        Tue, 26 Oct 2021 14:01:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n17sm10973224ile.76.2021.10.26.14.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:24 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 8/9] pack-bitmap.c: don't leak type-level bitmaps
Message-ID: <77a445463298cac69f00a0b9c5b5951bae80b2dd.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_bitmap_walk() is used to implement `git rev-list --test-bitmap`,
which compares the result of the on-disk bitmaps with ones generated
on-the-fly during a revision walk.

In fa95666a40 (pack-bitmap.c: harden 'test_bitmap_walk()' to check type
bitmaps, 2021-08-24), we hardened those tests to also check the four
special type-level bitmaps, but never freed those bitmaps. We should
have, since each required an allocation when we EWAH-decompressed them.

Free those, plugging that leak, and also free the base (the scratch-pad
bitmap), too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3f603425c9..3d81425c29 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1726,6 +1726,12 @@ void test_bitmap_walk(struct rev_info *revs)
 	else
 		die("mismatch in bitmap results");
 
+	bitmap_free(result);
+	bitmap_free(tdata.base);
+	bitmap_free(tdata.commits);
+	bitmap_free(tdata.trees);
+	bitmap_free(tdata.blobs);
+	bitmap_free(tdata.tags);
 	free_bitmap_index(bitmap_git);
 }
 
-- 
2.33.0.96.g73915697e6

