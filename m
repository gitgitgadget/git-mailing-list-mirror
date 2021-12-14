Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE65C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 19:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhLNTqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 14:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbhLNTqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 14:46:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135EAC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 11:46:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so67248222eds.10
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cezsk8EYjdelUu+a9IBPSNeQjQGTWtvFaz1Iz8e3cOs=;
        b=T9VZMmZRqCiIWLMkjgSOzcNPeDz8yUADDwr0rrXgZQxSCf5ecffJEPRm5ZTWcbSVMe
         eZ3eWS22L0lEAfKhHeMd5MZ5k6hsSMT+NZcWBovFkr+vP+T0Eapy6+LzFFLsohW7bDW3
         zYcIJeWdsb8m3dG0QqLyQ8jlrmw6qD7TFY+8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cezsk8EYjdelUu+a9IBPSNeQjQGTWtvFaz1Iz8e3cOs=;
        b=mTmW4egFmDxaYhyRFsx6nJRLR4cU4wCJQjrHnAfFvN2pGjjOjwGNXjYEGE3/bzOSBK
         xz0KJvFKu7z9Lt4avmCXnWFC37RZUFimS9kmhDLcGCeX8D8mToyjBbbdR0ngwfXhjObt
         rTLhmXXshZjr1NP2wzKnOHDCyHKJ2R3/4XkenHAbfE47sBEYRUHzYyIzAA/zTyeSFvIr
         4SHk22ygNIIYHZaZNVuO3GKt6B7gHpeAkDTf9hj6IvSicYXVgimPNFaDFB0HqY0yg1O2
         o44KMS5taVP42iEmAOhxQfGnWhvdFCqVeVCWNr7azKXbIZjcyT/HfBoNHsw1QR5H/g/I
         mXBQ==
X-Gm-Message-State: AOAM531dRD6R5ZOihXR37G41D1Y62y2BT5SdJwN2swEU/RVkS+e4iJPa
        gZV2DiFcCTipEzVpa4uHc6ikppR6tWOqrA==
X-Google-Smtp-Source: ABdhPJygBGupNe1Fbpf+4qbFn+6DtXvMTx6BeiypVkX4DJR1lqAcwd88NzLqqwYTm866wZwPfqFFig==
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr10873900edz.217.1639511204220;
        Tue, 14 Dec 2021 11:46:44 -0800 (PST)
Received: from localhost.localdomain (a164154.upc-a.chello.nl. [62.163.164.154])
        by smtp.gmail.com with ESMTPSA id hz2sm229518ejc.141.2021.12.14.11.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:46:43 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v2 0/1] upload-pack.c: increase output buffer size
Date:   Tue, 14 Dec 2021 20:46:25 +0100
Message-Id: <20211214194626.33814-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YbizfdGq+RSu9BGe@coredump.intra.peff.net>
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Ævar and Peff for your comments on the previous iteration
of this patch. I have made the buffer size fixed at the pktline
maximum, and I have changed the storage of output_state from stack
to heap.

As far as I can tell, all return paths from create_pack_file call
"die", except the happy path. So I only free the heap-allocated
output_state on the happy path. Is that OK, or should I use a "goto
out" function shape?

Jacob Vosmaer (1):
  upload-pack.c: increase output buffer size

 upload-pack.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.33.0

