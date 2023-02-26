Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08418C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 11:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBZLvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBZLu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 06:50:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6CBEC7C
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 03:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5813360BA0
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 11:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C61C433D2;
        Sun, 26 Feb 2023 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677412255;
        bh=BwixfVR8wMjbHtZ5pHJYVGx3u/kD1DVutdeBe/BZV4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3GYrGKILblHryyQZwkqcCTG7jTdebNMgE+ETJxgK4I6eSkPt1BIICnS0+fNPHAJi
         G5QI8rTgoTVN3MkRq+HAiZl3KKAgIdgL7TFgY2TeydGWfAa/bflR6HdFllz8cEOtyG
         4UxbH7wxcrRi/8R9nITKDdCglmNWWxWFi5Pjve2ocjHaqIPUq8Zn0uP8Kl34vV8Ze4
         DI4+FbFaMJ99ZedzuP42osVukVIVkVRIeREaV39gEOKsJDeDMl88owxPUNfurVc8gX
         vfePup2atSlOq4gAU+wuJ+Z680XTvqDfwtmmhP1HFOM4RpMUxuVX8mtE1OPAJe+I9V
         el54UBiKZrCiQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 3/5] wildmatch: remove NEGATE_CLASS(2) macros with trivial refactoring
Date:   Sun, 26 Feb 2023 20:50:19 +0900
Message-Id: <20230226115021.1681834-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226115021.1681834-1-masahiroy@kernel.org>
References: <20230226115021.1681834-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The other glob patterns are hard-coded in dowild(). There is no need
to macrofy '!' or '^'. Remove the NEGATE_CLASS and REGATE_CLASS2
defines, then refactor the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

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

