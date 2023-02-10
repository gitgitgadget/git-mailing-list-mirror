Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB4C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 08:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjBJIAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 03:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjBJH76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 02:59:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2407AE32
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 23:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA93B61CCC
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7683EC4339C;
        Fri, 10 Feb 2023 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676015997;
        bh=JApj1QOA8VvnQjgKoJ8YKpkF4MuZES9jA41ffX5gdmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PE/uYyG9+pPRbODRf5hVw91jeit0fn2Xhi9DsZVYV9zg7oY059iEUClR7xSWLRM+N
         wION/6+G7QcM2IDzDnTxsr7lJwVmgRfCog6uxXZHKWuWgEm8noIYuRxX32NvyxcSCE
         bj0UwLnkwoHW85+uTKwi3Bi0zchV5ZHgStU2uLt6eqwmLlTCGuheAI0fxA/RiOfk3z
         0OtmIDFR3d1Vk/peKKyaNrMqA1eZm1R1tSBuyWW7Du08uzA1EeO9qNwPtYNdSlIrdo
         Hk9axnTub1INpTZAZEsMkMIbxnaB4hbngDW6jHDSMY+Se01iMHVuR34lwy12SEh9qJ
         8g+MHUamZsNuA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/5] wildmatch: remove NEGATE_CLASS and NEGATE_CLASS2 macros
Date:   Fri, 10 Feb 2023 16:59:37 +0900
Message-Id: <20230210075939.44949-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210075939.44949-1-masahiroy@kernel.org>
References: <20230210075939.44949-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The other glob patterns are hard-coded in dowild(). Do likewise.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 wildmatch.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index a510b3fd23..93800b8eac 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -14,10 +14,6 @@
 
 typedef unsigned char uchar;
 
-/* What character marks an inverted character class? */
-#define NEGATE_CLASS	'!'
-#define NEGATE_CLASS2	'^'
-
 #define CC_EQ(class, len, litmatch) ((len) == sizeof (litmatch)-1 \
 				    && *(class) == *(litmatch) \
 				    && strncmp((char*)class, litmatch, len) == 0)
@@ -137,12 +133,8 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 			return WM_ABORT_ALL;
 		case '[':
 			p_ch = *++p;
-#ifdef NEGATE_CLASS2
-			if (p_ch == NEGATE_CLASS2)
-				p_ch = NEGATE_CLASS;
-#endif
 			/* Assign literal 1/0 because of "matched" comparison. */
-			negated = p_ch == NEGATE_CLASS ? 1 : 0;
+			negated = p_ch == '!' || p_ch == '^' ? 1 : 0;
 			if (negated) {
 				/* Inverted character class. */
 				p_ch = *++p;
-- 
2.34.1

