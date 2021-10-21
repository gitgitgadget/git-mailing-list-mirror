Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289DC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873E461183
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJUDmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhJUDm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB7BC061778
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:06 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y67so27201031iof.10
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3JvKg4/5+cWRfF5MfVvwjUCwpf6sym1bluzELYkWUNo=;
        b=qsoDxGKXWSisu1CgC4WFCeIz8vXkT/NpJW0OUFhu7cXbtf2Kc6ukPy1wgeCTR1Y3ZT
         BnTNaKwEBsPqbdEXIku8hElmssGDsRbk0oNCCu64WdiuKanr1cl8ZMwZGHxHS4bI1KhZ
         vwClnGcdSop0wMqxMC0SU1ehHjua37kspHPsWz32eGdABG8osgGr48+9WDxBVTH+iMKT
         gnjQuPhSg6q/z0vpIFpSy+vP+H60E0NvIlcJtC/Xq2Tqh+dqKw4J65iJFtxPwvaHxCp7
         Dg53aUC/rDyOuwqWJDf7UrEjrPeVMBMUTyls+dAAwcwSWVIdBOVx8ZZxC8IhqFrvagSM
         BIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3JvKg4/5+cWRfF5MfVvwjUCwpf6sym1bluzELYkWUNo=;
        b=hVuigFPI3jp+c9Bi3bUj50sBjlma5BOZE/sROtiTDpVGzECCmAyCWru3Ss/Nzjoqu1
         NDCLJlgs4xAvZslgiuvus9HfqK3fHlETJkfOxndDg1hGYlM4FyAZLjRBFoT6cMAzlKZP
         ivGGmei3IME5VHd2rvXFf5GSQ4/PuMdWVAVbUQtPoMv71DvPBM8cVKaOuvC28523DOV2
         CdfyWVd+UkrJokKm4mvdWOogc9IdO0y+qQ50ngIocVl0ghUMyr9AoaiRVdXTnY9F6HuU
         6GsxCY+7ooSZNk1m8087+GjmMBPz5TpIkb/8JyTr3ffwc+Hq4RY0eFTqAO7lVfSpveSE
         HQ7Q==
X-Gm-Message-State: AOAM532lYc8h4NVEvopEkeB5sC/uVOkadmUMh2kcmOjJZLU6nIm8n7xg
        ETwbrtiU0s386SOD9zCztwtkZ/mtxUI=
X-Google-Smtp-Source: ABdhPJwNbO3zmFgzukNQBpSlv6004yOAZ3b7ItuDMAkXqCg9GmnjHx7y4TY0fNVTQJWageqn4s85hA==
X-Received: by 2002:a05:6602:140d:: with SMTP id t13mr2222402iov.176.1634787605857;
        Wed, 20 Oct 2021 20:40:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k14sm2218895ilu.87.2021.10.20.20.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:40:05 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:40:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 08/11] pack-bitmap.c: don't leak type-level bitmaps
Message-ID: <29920e773527e6e82065205ed98262ce9b01de28.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
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
index d292e81af1..0f6656db02 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1721,6 +1721,12 @@ void test_bitmap_walk(struct rev_info *revs)
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

