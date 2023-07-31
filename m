Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E811CC001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 12:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGaMPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 08:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjGaMPq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 08:15:46 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8F10FA
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 05:15:45 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 97BB11F549
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1690805288;
        bh=OVWhh2sxzshHMF9XQj+K8FeNofFaIkWsEYXGjr7aNyo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=yrE19kNMwice2hr3DR7QiOu9hw7Brr08P+aLUsj0M7XRhq1YD13bSKpxK5Rm56Kvy
         X5ZrsiUza9tdFYUSqF26q1wvRvAt6wuOkLTBbBWS3lLwPflSiRRZWydGjqAdd621bf
         tAdiXCGlriG4jANCyuPL/YlYoDSUoKZ3VbGjf+SE=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] sha256/gcrypt: die on gcry_md_open failures
Date:   Mon, 31 Jul 2023 12:08:08 +0000
Message-Id: <20230731120808.1230210-4-e@80x24.org>
In-Reply-To: <20230731120808.1230210-1-e@80x24.org>
References: <20230731120808.1230210-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`gcry_md_open' allocates memory and must (like all allocation
functions) be checked for failure.

Signed-off-by: Eric Wong <e@80x24.org>
---
 sha256/gcrypt.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sha256/gcrypt.h b/sha256/gcrypt.h
index 1d06a778af..17a90f1052 100644
--- a/sha256/gcrypt.h
+++ b/sha256/gcrypt.h
@@ -9,7 +9,9 @@ typedef gcry_md_hd_t gcrypt_SHA256_CTX;
 
 static inline void gcrypt_SHA256_Init(gcrypt_SHA256_CTX *ctx)
 {
-	gcry_md_open(ctx, GCRY_MD_SHA256, 0);
+	gcry_error_t err = gcry_md_open(ctx, GCRY_MD_SHA256, 0);
+	if (err)
+		die("gcry_md_open: %s", gcry_strerror(err));
 }
 
 static inline void gcrypt_SHA256_Update(gcrypt_SHA256_CTX *ctx, const void *data, size_t len)
