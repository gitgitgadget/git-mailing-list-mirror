Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A5CC433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 16:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiEMQXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 12:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358037AbiEMQXR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 12:23:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C6340ED
        for <git@vger.kernel.org>; Fri, 13 May 2022 09:23:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s23so9183119iog.13
        for <git@vger.kernel.org>; Fri, 13 May 2022 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Twvv/2gfCO2q/uGrtKRmZPBrEAlLK5F+aR+ZbIX23Mk=;
        b=wzwLcLYbyCsszu9Cjm7EIJDzyOQcrsNGZLlBmBOEunQncAzgrovICRexz+X6+4u2eS
         0xTPk7++BYIpLpURqReRCs4UJAqPmKN076npVtayLK0ieF2PgsF3fuQK9OrDcFncxWl6
         rF40xeL1eYDMh5TFbSJgO+JgbKEGqx62z2AOTVWQ2p0GHZ02BB/3E4FkJY3BQu2CDR1k
         w8z41R3KypQomVywKwf4YD9gdoUFEoveBj54I+1ufUwqsWl2VAIyecfHy0K0XruwTCvC
         Qc12TI4MEahHO6lKiU5ayI55o6pmABqHQRuMMG3MirmDK/+Mvo7T2o2Y7IxSL0XLoG/y
         2psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Twvv/2gfCO2q/uGrtKRmZPBrEAlLK5F+aR+ZbIX23Mk=;
        b=MskJbP3zZs7SaRUpBMnyRsjUNwmmF6pVW4K8fY+khugsb77/Hf143TFhBB8unqUrjy
         ejqV+GKMy25PwwWzl4WV3rq15ZkqlZpgWrPpf0WXMLJ/9WFS3cqcJWRSOhEy4D0rADeq
         H1mxiy/288RsTOdKqVJ1J0DeaZH8W36Fx9LGUfh0E7roYopuDSgUacilIZmHMZfR4jQJ
         Xgr+6GhuTgZYwtwzYYxHcPLhZ1E7Ud4rWtZrwKRB2uSGI0eweXtsYgvt/HC6nygsOKZm
         TJjpN+/74S9eUg8fWxDzolO76HkhhgSrkaKq8NYMmxbIDEYyKS4xQNZe2+rDyhSx2rMR
         Upbg==
X-Gm-Message-State: AOAM531LLnY6dIc/XqF9anmCx4SigxgAcBLPw6O+99HfOq9guOPsBQY9
        YIkS026uN70ufOt4ehILwDO8P4rUzdpJ7dPV
X-Google-Smtp-Source: ABdhPJw+88eYxSskP4IUgH4IjqpW/nkLWhv9lKngnxd6fW1E7ImxSOrsarwEvtxOufyUqGG3igRO0g==
X-Received: by 2002:a5d:9318:0:b0:649:a18:dab8 with SMTP id l24-20020a5d9318000000b006490a18dab8mr2655160ion.96.1652458996054;
        Fri, 13 May 2022 09:23:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g17-20020a056e02131100b002cde6e352d8sm701868ilr.34.2022.05.13.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:23:15 -0700 (PDT)
Date:   Fri, 13 May 2022 12:23:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH 0/2] pack-objects: fix a pair of MIDX bitmap-related races
Message-ID: <cover.1652458395.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes two races related to using multi-pack bitmaps in pack-objects.

The crux of both is that we call `is_pack_valid()` far too late, leaving us in a
situation where `pack-objects` committed to using objects from a specific pack
in the MIDX bitmap, without having actually opened those packs. So if those
packs are removed in the background (e.g., due to a simultaneous repack),
any ongoing clones or fetches will see this error message:

    remote: Enumerating objects: 1498802, done.
    remote: fatal: packfile ./objects/pack/pack-$HASH.pack cannot be accessed
    remote: aborting due to possible repository corruption on the remote side.

See 4c08018204 (pack-objects: protect against disappearing packs, 2011-10-14)
and bab919bd44 (pack-bitmap: check pack validity when opening bitmap,
2015-03-26) for previous treatment of similar issues.

Taylor Blau (2):
  pack-bitmap: check preferred pack validity when opening MIDX bitmap
  builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects

 builtin/pack-objects.c |  8 ++++++--
 pack-bitmap.c          | 19 +++++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.36.1.76.g80c0bcd80e
