Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18381C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0220761183
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJUDmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhJUDm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:26 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B130C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r134so27254967iod.11
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CWYFBqmXuslCDXLcEsxvRiItt+CZNtKeixJGGfE6KgA=;
        b=HM2+rfsJ/Wae5+gE3skyxRF3iTwIPM4oqGyiqVy6hBL9Y2lYzCOk4G+tjXySH2GjQ3
         Nwpr1dtDj/r/j70jgdOg2nmcT8aaeY0nL1+ZnT1UiXIXM6OdpC8igNM3H50L6PNznKGF
         t0NkBw+UWHmemsr9QYRwcrE/MSWMstrtfJKZeJtzDynEZ9bATgu1qglmNlHQ5dwEzkAB
         d6S6wHm25MSM0yx7bq4e7ZZIrXtQ1zDC71qBH180l3idAXLjxcBWeYY6u8gJuqW1ii7d
         ufnm5zFL7SyGu1GrYY+XdPz+oNlQx8UkV+OyxIxx3BV+X3SouCj6d/4MEa2rN2gTw4zC
         6s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CWYFBqmXuslCDXLcEsxvRiItt+CZNtKeixJGGfE6KgA=;
        b=qHY9qbDPQARpwL1ObIHnAOAnttYk6VspgpuWHZ40sUoF/hvYDmgPw4ACOheS7nkFOu
         S1wUnvOJeGpeJ9Bj4RIOjeic+CTP7YeJoxMOZcq3UiJ1Fhpc4sDCkiuPSM9jJyNpG5UM
         izXg1J2eWQfDjxsuGQsVvRwJd2t8Usy4O1vypEPma8MuCucMBHakC0k6bjmMjFew24PZ
         LjpLkClkr/Dwu8cxZIzPItsxvczRsVKUfdYD4YuWj9IBTPhcekjGdMf//d3K/o5iU/vI
         wyc+IgerCjNPyCiU8Z0BNz5nhUl1VACuaR090mrBO92XoaBi8rrl8h5YCFvvcStAz5lY
         Iwxw==
X-Gm-Message-State: AOAM5304ZmPWlMMwxvYlkBx5TAQjSuHLWvj7oVXGOL6gks5hJbf06gvv
        B+ilRAx+vKKVAIeKXtSoz9JEZDmZDZTz+g==
X-Google-Smtp-Source: ABdhPJwgFl64lgAL4FbufXFMElJWicSii1/le7N3RjTzD3VQet5Rhun1M9ALV/Cn7hxzgyqNUYoaeA==
X-Received: by 2002:a05:6602:2599:: with SMTP id p25mr2308085ioo.90.1634787603457;
        Wed, 20 Oct 2021 20:40:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i15sm2059714ilu.24.2021.10.20.20.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:40:03 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:40:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 07/11] pack-bitmap.c: avoid leaking via midx_bitmap_filename()
Message-ID: <f3897c3afc0e47933289025c269a4d5f248241ef.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To construct the path for a MIDX bitmap, midx_bitmap_filename() calls
get_midx_filename(), and uses the result as an argument to xstrfmt().
But get_midx_filename() also uses xstrfmt, and it assumes that the
caller will free the results.

get_midx_filename() could take a strbuf and write to that, but it would
make more work for every other caller. midx_bitmap_filename() could
store the result of get_midx_filename() in a temporary variable which is
freed before returning.

But that intermediate allocation feels wasteful. Since this function is
simple enough, we can instead "inline" its implementation into the
xstrfmt call itself. That is a little gross, but arguably better than
allocating memory unnecessarily.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f47a0a7db4..d292e81af1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -292,8 +292,8 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 
 char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
-	return xstrfmt("%s-%s.bitmap",
-		       get_midx_filename(midx->object_dir),
+	return xstrfmt("%s/pack/multi-pack-index-%s.bitmap",
+		       midx->object_dir,
 		       hash_to_hex(get_midx_checksum(midx)));
 }
 
-- 
2.33.0.96.g73915697e6

