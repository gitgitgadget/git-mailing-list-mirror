Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAC2C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhLGSaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbhLGSaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:30:12 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580EC061748
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:26:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y196so37088wmc.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uycJOgZjS1ilY6ExAuPKHz0Yiufkcvb3Ta35cuXsRI=;
        b=lixYfbHVIZVulyTHYADwqLDUF/l8mEE51ug7ITlwxo49mGJ0oCmnqRBpbNWxr656iV
         jlelbteqOkh8s0Ettua2BCgKu9wOWdbufwQMND5PjTu5zQSG9ZRG/4A9ePlCAj19QDAT
         092ft8S7mrRgbNLnvf3SYSw7t9OfDvW52OcpIgA3exUF0NKNyFPDKL6os9x/eYahUL/a
         b2ODqVD6BZkdLM5BPYarQaGRr85DL7J6UhiI8DMxFb76qbUlogoD9/EAGO4LU8lvz3av
         tJWuaTGQg4UukUliIpUFooGJfjCVO8Gy8q9Rhpi2n/hmkE4e/g0BsHLltdZyhd1HMfjn
         7wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uycJOgZjS1ilY6ExAuPKHz0Yiufkcvb3Ta35cuXsRI=;
        b=p9gcICRIgrIFzvD/9a5TQiuM5DBJz99qTn4rD60dPXkYyJE/TFw/77F7/8rhF2cYn2
         c05ne604PZqpfN1QK/Jxe+89d26hNpgp3Krd7A1pDrBxZrzU0Vkrt4N3iHMdxWVd7+wy
         RRnVW/46FGrF62jHun5BVZlHOTCCr8pTidTGzShmdkEwRVCG9v/ebOx+mvUmZ4OoW7j9
         wLpAjewJcFpLoR/RShMnuCZhGVhady7w1qNdGblr1d8VeZpF4O1sKECu8iG4F1yyojN8
         BkCaM0RPAnoOPJUIiz9OP1sgrUsbqCnUY1x94yoHenohwCiwaBpy0+uwrXTRa/VltT/7
         sPuA==
X-Gm-Message-State: AOAM530Chd3ENzPoj7M/eietzQQd1IK34kPTZ4O8aOPVFUA991uAH7yU
        YmMGdH4Po7E6UN1CcExVO5gJ1gz05xyO0w==
X-Google-Smtp-Source: ABdhPJxmyQ+DaXxflaFHo9hfAnqO3vY/b26BW02MpnCCwkVZBZ5pIAgkrjKSRQwTHg+YrWn/44qJ9Q==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr9139388wmj.12.1638901600529;
        Tue, 07 Dec 2021 10:26:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm450496wrv.30.2021.12.07.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:26:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] gc: return from cmd_gc(), don't call exit()
Date:   Tue,  7 Dec 2021 19:26:32 +0100
Message-Id: <patch-v2-4.6-f224a281a10-20211207T182419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A minor code cleanup. Let's "return" from cmd_gc() instead of calling
exit(). See 338abb0f045 (builtins + test helpers: use return instead
of exit() in cmd_*, 2021-06-08) for other such cases.

While we're at it add a \n to separate the variable declaration from
the rest of the code in this block. Both of these changes make a
subsequent change smaller and easier to read.

This change isn't really needed for that subsequent change, but now
someone viewing that future behavior change won't need to wonder why
we're either still calling exit() here, or fixing it while we're at
it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcef6a4c8da..900ccfb8d48 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -611,9 +611,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		}
 		if (detach_auto) {
 			int ret = report_last_gc_error();
+
 			if (ret < 0)
 				/* an I/O error occurred, already reported */
-				exit(128);
+				return 128;
 			if (ret == 1)
 				/* Last gc --auto failed. Skip this one. */
 				return 0;
-- 
2.34.1.898.g5a552c2e5f0

