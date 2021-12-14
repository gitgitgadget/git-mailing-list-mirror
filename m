Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F9DC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhLNLsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbhLNLsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C17C06173F
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i22so2117445wrb.13
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=IuXZmHH44Lek607rDpdfaQyhHvuq/lqbJnocc12KGN9frAbqfMVgwl1csLCgIhAUz/
         WTm7Zzs/fHmYRk3IlX9QEA+92M0u8MfxhV48WHLCnBdJYMeqTHJDImRpmUktHZ8QPqDw
         dKZFPKDODBiRIeOiS0B+ReU4urn2yhHcm+yKhpUkTtyRi8g4uv7b4M1188xvBexwMt5V
         c8qWfcybKzC6TMpmVNeJqMbzsvqipMj7nLOMXHyi9ia70VdRDJ6XFKI0f92zz2HOZ2ah
         sVSTRCGODsH1j5rYIn63nJINBbSWJ8mNLG1Qwz9gvP6aqj/jLmD0nyE7oN6smcwe9HTl
         Kdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=kY7iJQx+6fj6eIVsNTXhjT6UyJz6a8NmhhbfghwXBN6pKkCjaRwiIzIvmE7Y6Og9Io
         lGX2Jis9A9ath/2sHyi+bdetqXwEiofbfo6NcHzHgcr5g1xl2DovL0imKI9xMQ5BS9zW
         iAAcEbN+pk5lVO+ArxOmr1KHEKs91xCAjzpFDOa+BrAZIlTYEfuyWsHKclavZPt6ZD89
         6+LnPg/o9mweoEuwmf7d8Jxs7l7xQC6mvyrcMmeWbTbzxVOSPm7PYegJTjHtSDhByABw
         3XpQ4eXcnKeCpBl/PU9RTfyrCLEKupt29SBnU6oNOOIADpvHXk7R4yA8I8ck3LSGgzeq
         torQ==
X-Gm-Message-State: AOAM532BDwTEaRe3Dzme4FzRLdDxgs1Ft0lrTf06VuhrX1uC7pjrzWL/
        Rj30NUDjOrDDeTonQ3UHt6sR2z4hveA=
X-Google-Smtp-Source: ABdhPJzincGeIkeC3DfxbSOZF9Ak6i6ujJUw9U9FzuC4tbm9/9pQbikcyKUSN8Biy5kONGrf5bUNWg==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr5310914wrp.267.1639482480254;
        Tue, 14 Dec 2021 03:48:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm15187289wrh.18.2021.12.14.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:47:59 -0800 (PST)
Message-Id: <7a914f77756bc7c9ec5338584f955cb5930ea4e4.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:48 +0000
Subject: [PATCH v4 03/11] reftable: fix resource leak blocksource.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would be triggered in the unlikely event of fstat() failing on an opened
file.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/blocksource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 0044eecd9aa..2605371c28d 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -134,8 +134,10 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	err = fstat(fd, &st);
-	if (err < 0)
-		return -1;
+	if (err < 0) {
+		close(fd);
+		return REFTABLE_IO_ERROR;
+	}
 
 	p = reftable_calloc(sizeof(struct file_block_source));
 	p->size = st.st_size;
-- 
gitgitgadget

