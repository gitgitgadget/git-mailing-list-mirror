Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AAAC433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 07:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiFLHos (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiFLHoj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 03:44:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4E52507
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y196so3134191pfb.6
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgyEqFO25WCyU7I9GVaJVUI3rVWPjoC4fLZPVAUAAJY=;
        b=Ry8K+7GlEzWx+NJnz0uSBdZRd3r/l/qbGTlRvICQO+oQ787bW3foXnhrBrC6XM2SpF
         Q1lf0cNJMKpE3alsanyVFH3G45uHLyniZ3L1BesheK7jaSVvgwZAThw3uXxqw1j3EZCo
         NzkAgPbMIAa6hyxiA/5m+JTKLXGSwKoXSTTHVVJ1OpBwfCfYB/5qImBs6p3Gj0G1AG1u
         P/c/Hdr5JWzxMmOFegp1/jSaiwCcAVkzYKKLi8JwS6rmJwU8Im9uCDa9eTNlpPHsduDA
         rbXRNpcIatUCIoPBpSY1UkPRyePTM/Qu+sNNZalrjbF4Jc2zkQiP5uZTLd2FskFPAXU+
         AIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgyEqFO25WCyU7I9GVaJVUI3rVWPjoC4fLZPVAUAAJY=;
        b=GxVNQYbU71auBiX4Ys+KRykSjKBP6s4bw/BrVAou7YtkDGAA4CMa7j05Y7X2SEpbxC
         VcHpw3JfBUkOmz2LmGXMIxbDkvaqhfowYvL6n1bMO7FPQGad3kHgxrDFYxFJunEb/Wv+
         KsD35urJfldO61wBhUHERsRgLC0aF0XfMIq9zrzV6QEOsMnHsKtS1yHzM0xRecGcqCh6
         ycNEn1j7JYzOXovsHHZUVqbSF17FpcjmXHJB0rDkLTMP+cIT5e9azc34O+Al9xqMY9uP
         oNjDwBfuICqBKcW4hUzxpgjqTvC7j6Md/oJwryvvJbwcoFIevI81ux+ACplVEfQVQ80d
         GMRw==
X-Gm-Message-State: AOAM530uqwnRIL76s5sYfAtPBwilXJfyMV54mBh4ojhs5My25Qdx19Um
        o8IRQin37LpcStkHkvARxOc=
X-Google-Smtp-Source: ABdhPJxl803TCSBTmet7yqUTEmK4nUBmI5g2GpFLwbeSurAxJ5Br4pfJfQgac2EiWI2cOyoo8t8a/Q==
X-Received: by 2002:a63:2b8b:0:b0:3fc:c510:7941 with SMTP id r133-20020a632b8b000000b003fcc5107941mr47950295pgr.47.1655019872994;
        Sun, 12 Jun 2022 00:44:32 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm2559707plp.302.2022.06.12.00.44.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 00:44:32 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 1/5] pack-bitmap.c: continue looping when first MIDX bitmap is found
Date:   Sun, 12 Jun 2022 15:44:16 +0800
Message-Id: <589e3f4075513b13dcd057242fa207b95371b114.1655018322.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g320e881567
In-Reply-To: <cover.1655018322.git.dyroneteng@gmail.com>
References: <cover.1655018322.git.dyroneteng@gmail.com>
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
2.35.1.582.g320e881567

