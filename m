Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75235C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiADSQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiADSQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:16:04 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58557C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:16:04 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id kc16so35192774qvb.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tYyExQra/AYrSHJ9ncfj6OUd6kL1FAK9ugP68Yl3AMU=;
        b=DBHvSI3EpshEnUp8kOp6MT7OyaT+vwyWo+A4gtOCea49WKDMRN8OsIpgnBTopvOa3G
         NdktQDxK2AR5C7iP8YB6jdUwRyoiC0zxbQOdwgQDj0yyZgf9D0B1RwHm+XM8PAgnXlvz
         J8sB6Doji/T75jrFYpSvfPcSuX38Ln7T8QA8CVOoiJmeChYZNWDWYo7jAkLqrF58lYNw
         icco7+uYCOozamv4bF+/G+Hmau1k9bTD6o8UfKYSCC2SVZNaLu9b1S/nRCAAhkrs2LDg
         pIFCWEqa3xZJUII35hPm1WtHcXxFIXbkqeUK3EK6B/6znRzGG8Z6dNFbU4JoUN5FXnc3
         3+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYyExQra/AYrSHJ9ncfj6OUd6kL1FAK9ugP68Yl3AMU=;
        b=NDKuiEWuXOCmXy7lF3sGz7T3jbcSs8yUbm+3HDBGfocwCO7g1DL88/xb7S7RbjhnXM
         8nCaeFO2qMPzwXgGebzlCrdU1Zk7Nc4NcMdwLyugiSMfrcmvAZqshzxENYSBSP+uBRoW
         UfFKov1YhfSfwbOomJjUrTRrXDCQyLboqfGlapxOY4L7jWZ1PgnI2OiKVmAQM4jd4qNB
         /+/mPXhEakafCk+Ld5Ekw3k4I1OY3Q4waNaEX/prfy/GS8qvZG8NxkT2aVJZNISrT9aX
         GgdIr/Vkmv4UZGgbXt9WA5dZpGSMsy70nBhU7DM0QPt99/gV5hagAX4UR+n5koZLRTGR
         FxLw==
X-Gm-Message-State: AOAM533uK4H3gFaUKUM4si2WN/ZFWe1FKDK/OjuvvyHPx4Txhk9KAJ8o
        wzUyLRaiO2zan8EsMIAKGEfyZgxVlWaiekKL
X-Google-Smtp-Source: ABdhPJzbX23JCDb/1w1Lmo/Iq1/b6WUf54pOODJT1Wher8ZIdByruYirNLv87ir49sst1dj4HaPVFw==
X-Received: by 2002:a05:6214:248a:: with SMTP id gi10mr42979931qvb.101.1641320163412;
        Tue, 04 Jan 2022 10:16:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h16sm35323087qtx.20.2022.01.04.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:16:03 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:16:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 9/9] pack-bitmap.c: gracefully fallback after opening
 pack/MIDX
Message-ID: <9707d5ea4433d9a5c7f8581dbb2d8a05f410efd3.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641320129.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When opening a MIDX/pack-bitmap, we call open_midx_bitmap_1() or
open_pack_bitmap_1() respectively in a loop over the set of MIDXs/packs.
By design, these functions are supposed to be called over every pack and
MIDX, since only one of them should have a valid bitmap.

Ordinarily we return '0' from these two functions in order to indicate
that we successfully loaded a bitmap To signal that we couldn't load a
bitmap corresponding to the MIDX/pack (either because one doesn't exist,
or because there was an error with loading it), we can return '-1'. In
either case, the callers each enumerate all MIDXs/packs to ensure that
at most one bitmap per-kind is present.

But when we fail to load a bitmap that does exist (for example, loading
a MIDX bitmap without finding a corresponding reverse index), we'll
return -1 but leave the 'midx' field non-NULL. So when we fallback to
loading a pack bitmap, we'll complain that the bitmap we're trying to
populate already is "opened", even though it isn't.

Rectify this by setting the '->pack' and '->midx' field back to NULL as
appropriate. Two tests are added: one to ensure that the MIDX-to-pack
bitmap fallback works, and another to ensure we still complain when
there are multiple pack bitmaps in a repository.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c                 |  4 ++++
 t/t5310-pack-bitmaps.sh       | 28 ++++++++++++++++++++++++++++
 t/t5326-multi-pack-bitmaps.sh | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f772d3cb7f..9c666cdb8b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -358,7 +358,9 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 cleanup:
 	munmap(bitmap_git->map, bitmap_git->map_size);
 	bitmap_git->map_size = 0;
+	bitmap_git->map_pos = 0;
 	bitmap_git->map = NULL;
+	bitmap_git->midx = NULL;
 	return -1;
 }
 
@@ -405,6 +407,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		munmap(bitmap_git->map, bitmap_git->map_size);
 		bitmap_git->map = NULL;
 		bitmap_git->map_size = 0;
+		bitmap_git->map_pos = 0;
+		bitmap_git->pack = NULL;
 		return -1;
 	}
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index d05ab716f6..f775fc1ce6 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -397,4 +397,32 @@ test_expect_success 'pack.preferBitmapTips' '
 	)
 '
 
+test_expect_success 'complains about multiple pack bitmaps' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+
+		git repack -adb &&
+		bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
+		mv "$bitmap" "$bitmap.bak" &&
+
+		test_commit other &&
+		git repack -ab &&
+
+		mv "$bitmap.bak" "$bitmap" &&
+
+		find .git/objects/pack -type f -name "*.pack" >packs &&
+		find .git/objects/pack -type f -name "*.bitmap" >bitmaps &&
+		test_line_count = 2 packs &&
+		test_line_count = 2 bitmaps &&
+
+		git rev-list --use-bitmap-index HEAD 2>err &&
+		grep "ignoring extra bitmap file" err
+	)
+'
+
 test_done
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index c0924074c4..3c1ecc7e25 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -266,4 +266,23 @@ test_expect_success 'hash-cache values are propagated from pack bitmaps' '
 	)
 '
 
+test_expect_success 'graceful fallback when missing reverse index' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+
+		# write a pack and MIDX bitmap containing base
+		git repack -adb &&
+		git multi-pack-index write --bitmap &&
+
+		GIT_TEST_MIDX_READ_RIDX=0 \
+			git rev-list --use-bitmap-index HEAD 2>err &&
+		! grep "ignoring extra bitmap file" err
+	)
+'
+
 test_done
-- 
2.34.1.25.gb3157a20e6
