Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719C0C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C1460720
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhJZVDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhJZVDb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:31 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E9C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:07 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j3so668172ilr.6
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lrFvOvandisktvz6zA26AkghajF9mLwRnXfkHlapEoE=;
        b=St4G6sGNEqFvBq/6+Swa4RQMIQg2QR71+g56697Da0qXSJlhGqIyScnaU8uPU5JwW3
         VK749dHB3/fRXPDXnB4eO5q6ZpTCs7pXPFQQgC5aFfqehtsOYmc6NMsHBsEbPNKcT2gI
         2Er3ceWUubNkFmdrah+Sfh46r99qgwEYbxikw/JnbXS9LSGNV1shvmuSybG0W8NW/ZyF
         JLMsnjfC4rePwnEq+6puP43rpVPuNczHUgK7m7zViws8DBVCkaD2K4y7bHuuZ/IdHuCn
         yHmNTl0V1SzufTQQygifsiXs4BGOxn08UvxuxTZ+HZZ20TMTK8ZybaROyY8c82DMvBsF
         P6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lrFvOvandisktvz6zA26AkghajF9mLwRnXfkHlapEoE=;
        b=3b1dzEQsYn3r0SVc174fRv4NYpNzSw4OOgFuJ9cTxnZjLDhJyelDrb4pV+KuzG0C7S
         yqlydrYREdzW5PDdhoOltUSNTc66zkdftOs8PRVKbcxzYgxhjyJpkf4/Xe6ee13mDGte
         rpLRQITrkH2rMBQ2M1/xT1fAFUzqIjw1I8SSri78ZIzl03xW30I9Lgz2W2r0PeMR7kCi
         FikRSLYehuid+0i5peyJv9JknB+J3yoYYMrPECBCGRADvGpiZ9SI/TfWyODrJhqwQg+U
         8xXqHvg3ADx1YhPr690oBn+6qUDgH0Kn/uw8Sa0oVV2IpgE6Es/BjH9HT/pZTMwymTH7
         04KQ==
X-Gm-Message-State: AOAM5305ctU6QmeWK0jUFProXCxaUcFAog3SXaLueSSrLsejYLOdVjXn
        QZ5mz4id7Rfm0kF3FEC/LbVZ4C1CThaoXA==
X-Google-Smtp-Source: ABdhPJzioLOuZtZSsIzKBUjMjpQNnjiX4olFOr4XfsbXHEqk+DC8qOn0gbRHbvrOmWhaGOKAQEX7sQ==
X-Received: by 2002:a92:c264:: with SMTP id h4mr13032547ild.101.1635282066327;
        Tue, 26 Oct 2021 14:01:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k16sm10565260ior.50.2021.10.26.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:05 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 1/9] midx.c: clean up chunkfile after reading the MIDX
Message-ID: <dcc599807292cbd03a0a60d5ff0f73f49ea45234.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to read the contents of a MIDX, we initialize a chunkfile
structure which can read the table of contents and assign pointers into
different sections of the file for us.

We do call free(), since the chunkfile struct is heap allocated, but not
the more appropriate free_chunkfile(), which also frees memory that the
structure itself owns.

Call that instead to avoid leaking memory in this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 8433086ac1..36e4754767 100644
--- a/midx.c
+++ b/midx.c
@@ -179,12 +179,13 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	trace2_data_intmax("midx", the_repository, "load/num_packs", m->num_packs);
 	trace2_data_intmax("midx", the_repository, "load/num_objects", m->num_objects);
 
+	free_chunkfile(cf);
 	return m;
 
 cleanup_fail:
 	free(m);
 	free(midx_name);
-	free(cf);
+	free_chunkfile(cf);
 	if (midx_map)
 		munmap(midx_map, midx_size);
 	if (0 <= fd)
-- 
2.33.0.96.g73915697e6

