Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DC6C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244570AbiF1ITd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbiF1ITE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D12CE1C
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h192so11506021pgc.4
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QR7dnif8nsv3nXwQqB2Q7wKuWJBI0ake6Y+kEG/nnnA=;
        b=YAdkH3xAt8AjhZ7PzgsVSulypaZXYY6SPeg1kEhVT1kQP7aJcdK1apUBBQxFov4uQD
         yMy1mia4wV5uX46ZlKMPzDpkt+bdCHo6/ZjduyH4a7DHIpR0I0QHXNZGk3bKqLscs+tB
         eXCvtzbHgO/MDaOl7HcYfpQ2v6pKArjSTvVRMtpteLfbI3DWHduJwP8hVG8W5vjrwi4O
         C9t9/okp4J984Ieidf86jvTqVSy2gySUJob8YAW8lkosxmbYtO7WBzbEewOsDK998OGl
         LneG1eCo++6OgMS/z/Tejo4dKWQlqhur1dL2FmDGLNnhE95A0eb7TRlijme4Aw1Z8DkE
         RnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QR7dnif8nsv3nXwQqB2Q7wKuWJBI0ake6Y+kEG/nnnA=;
        b=01+bliXOQ7ye98dp8LSHPC4meSUU4Ai/WLxM/CipAfocPkixFKCnTM+9+Sm6wvxXTu
         IMpZhpAyD3NnCbh47MJVIM3nbIafIH967BXzmdJrxtEqiY0yJpTTzZqOpCGJTfbVX6v1
         dGtxmb5U1OTjBAfF7/3A2CVb3Y5WntOecMdHXIJaYwNnxzKaLmYirLeTbHep3rYwZQU2
         M48TWr7kxx5yA+F2dh0x6Y03BDwXpmO9j2a6wnm1gwa50Lh1xpK7SSWBH4jL4Lh8kgur
         GPgTH/kIkVDOxGRSOR+QFZ+MiKMw92ZbCnUl3Y05CD1ATGI7CS0kyva6czUrdVxGoSUa
         Cg0w==
X-Gm-Message-State: AJIora/+jYs7PM3/0HyZq2SjqalHj4Rs+R4B9VgsaXpKsqGUiesGJRi4
        6IxpiGp9JIhvlZ1bbQbUYSM=
X-Google-Smtp-Source: AGRyM1tGzyKDn1dRa3uPKfhbmBQaApDNnEpzX9/FTw38sT0j6bWiwKqq8WGz7bhrnoskSjo7aPrwjQ==
X-Received: by 2002:a63:2b16:0:b0:3fa:faf9:e6d7 with SMTP id r22-20020a632b16000000b003fafaf9e6d7mr16212267pgr.325.1656404279668;
        Tue, 28 Jun 2022 01:17:59 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b0016368840c41sm8551206plb.14.2022.06.28.01.17.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:17:59 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        git@jeffhostetler.com
Subject: [PATCH v5 1/5] pack-bitmap.c: continue looping when first MIDX bitmap is found
Date:   Tue, 28 Jun 2022 16:17:46 +0800
Message-Id: <589e3f4075513b13dcd057242fa207b95371b114.1656403084.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.gf3b87a33da
In-Reply-To: <cover.1656403084.git.dyroneteng@gmail.com>
References: <cover.1656403084.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "open_midx_bitmap()", we do a loop with the MIDX(es) in repo, when
the first one has been found, then will break out by a "return"
directly.

But actually, it's better to continue the loop until we have visited
both the MIDX in our repository, as well as any alternates (along with
_their_ alternates, recursively).

The reason for this is, there may exist more than one MIDX file in
a repo. The "multi_pack_index" struct is actually designed as a singly
linked list, and if a MIDX file has been already opened successfully,
then the other MIDX files will be skipped and left with a warning
"ignoring extra bitmap file." to the output.

The discussion link of community:

  https://public-inbox.org/git/YjzCTLLDCby+kJrZ@nand.local/

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9c666cdb8b..112c2b12c6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -494,15 +494,16 @@ static int open_pack_bitmap(struct repository *r,
 static int open_midx_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
+	int ret = -1;
 	struct multi_pack_index *midx;
 
 	assert(!bitmap_git->map);
 
 	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
 		if (!open_midx_bitmap_1(bitmap_git, midx))
-			return 0;
+			ret = 0;
 	}
-	return -1;
+	return ret;
 }
 
 static int open_bitmap(struct repository *r,
-- 
2.35.1.582.gf3b87a33da

