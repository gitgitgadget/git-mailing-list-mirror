Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B348CC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiAYWl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiAYWlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:21 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E563C061748
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:21 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q204so10967659iod.8
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tu54T4TM8MnCyKyVm4Gpl9KMb4VU4U+WTg6hJEH5WpI=;
        b=yLN7fy2KjlmZM0OhW67CGfHxFFkvCBN9/pIsm1F0XiCYkpKuJ+/xmDClOofExArC7s
         IsBSkjDo2i8xq/vDpvJSimAXsu+WmQSm9SJsZTpA+ytak0ormzYUMVkvU2Vlzh7W7q/x
         AJzwdYJbkw9NOxqrbfi8YL25twa/661r0DFK1IFF7tNkMKT6/2cfd4fNze8nGiQUNIBU
         iV0Z+LVDtcCk11lVy4zfvP3pKhZ0Il2dT1Z+2zIoxvw3nF5/WRQa53zQ/XY0OkAHXyZ6
         M4oRRvJhy+HlSWtF1UGCGfnjOve2C2Gf6OHDFVrx0O3jjE46aftWM7/zM3Ci/NFMwGZo
         fvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tu54T4TM8MnCyKyVm4Gpl9KMb4VU4U+WTg6hJEH5WpI=;
        b=x2Z0TMtcPnKJXbkCUeviQj3j2png2KttBAKeywytbKKQEDrLq62sIEQ0k0p2cvuznd
         jCe6i296OYgLCcToV155qsJnH/IqYiC8oJ8xCS33uldZk+VXy10+JIPs7kPblE+ew54G
         53Z3nSuqCDniulkC9gOXEnnuHhHG2MIYMex2w3HebiZgaYzva/ZBM30Q7oqCBEMAa/n8
         uIvtu2cqar9xq1Dl86jIyQ9lhNWaoDJA9Iw5MhJjH9dDHwhGkvbHLCKZTiw5WUGPp+dS
         Zol3a3ag/eYI2ER8crYbDISvNXvEHgsBtPdUya3S5K+EKn87nr6iZ9NfOxL/NIDiwzpd
         ugsA==
X-Gm-Message-State: AOAM530AmErIyI7NRa94KLRi7xtPb4DaXuMi1cmpz4qQGqFN5hHKthSg
        Xvb+lcuTOw79wcX13gbvrV5DoLavn9YxvQ==
X-Google-Smtp-Source: ABdhPJwab1uwnWEVBKBfCPif3rNOyYBDBSe04dCtkrFgLsgO2LHu/R9p+gtm9QPGVGq6r8wFgLYVnA==
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr6013602ioh.87.1643150480986;
        Tue, 25 Jan 2022 14:41:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l10sm1383531ilg.23.2022.01.25.14.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:41:20 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 9/9] pack-bitmap.c: gracefully fallback after opening
 pack/MIDX
Message-ID: <581b723792c2bec1ba66025c7ebb0344d5541865.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
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
2.34.1.455.gd6eb6fd089
