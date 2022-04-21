Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F46CC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352770AbiDUN3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376881AbiDUN3l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DA37030
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id bo5so5014695pfb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7g9eW9RwCBNx2B1/hay/W26lr/E3QDlUS38CQTOIlE=;
        b=aM8F44RVVwts1AMiQJpFbGgKrvSO19e5kybIy9HqCgb9gafC0CcYAg2SIEY050gW8d
         Zjrnot/Tk+eE2Y2PYPEkfTpThUZSJEKeUR0CiV2732CbIXs4CWPk0zGG609/UKSpla6H
         ELydmse+/A6PV1gOxVXhZnsbyLzwY+ocgvs09G0jXjVVhRcyV8IIPdrDLjJr0XY1xhIu
         W2FfIIfe6KkEfoua83MQki9SdQ1DGhGC6yeuRedWZ48+XsMvL2S6cnU+llJq9AAHc55h
         K268xPTn7NODzd+lm7VgfUIGD0Y42G6IVNPBKIDrckgP9UGSSXYxzh6Fz+fMnGqYc7i7
         7Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7g9eW9RwCBNx2B1/hay/W26lr/E3QDlUS38CQTOIlE=;
        b=EBeGnLXKHq9clEYN5kPrpXaQUsjcRzFfgqh0L5e2vU24hSVuu36RDVEh+F6/iPcWRm
         pqeLhJZNhR/a/G0DkSC4faHAOILHS/rwhp7WPMJ1mIpbVPinUN7whvG1V+acv2ZslB58
         2R/pKr1ZB4zEtOKoLlHrfRYx4eOMCfP3zf2hf8kqVS+1p3rQ16HIFGTjnoGBf0mFqjO1
         vQdlbLsGaRuXYlD8wARpiWzpA0WDutt0JryWavnPbZ7MG89XVcbX0PotxaCXgVZQWw9h
         HiLqhZbN2wb2HcaV9QXO9+uwIR79WdEUqowpEsfkfGHd28hn0+M0rjyjx27upz9ajrIn
         re1w==
X-Gm-Message-State: AOAM533h1trDYLG5GNDZ7yTQsjVSEvO5s6cyXVkm61umPF3vE03iNypw
        y7zfo93iBJNqkDdTjmrATdI=
X-Google-Smtp-Source: ABdhPJzTHKaqWrx/ZW2Dpe9d54XYd6qf0gK5h3uub0XmfPQvY9XvWw/Kjd2nIKN0WmPLV8aZ/IvphQ==
X-Received: by 2002:a63:2d47:0:b0:399:53e3:5b4c with SMTP id t68-20020a632d47000000b0039953e35b4cmr24138595pgt.165.1650547611467;
        Thu, 21 Apr 2022 06:26:51 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.42])
        by smtp.gmail.com with ESMTPSA id bd42-20020a056a0027aa00b0050a6e0ccc54sm15463647pfb.186.2022.04.21.06.26.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:26:51 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v2 1/5] pack-bitmap.c: continue looping when first MIDX bitmap is found
Date:   Thu, 21 Apr 2022 21:26:36 +0800
Message-Id: <1bfd2fb6ab01af689fc6495e2f32d3f64c19f4b7.1650547400.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.583.g30faa5f068
In-Reply-To: <cover.1650547400.git.dyroneteng@gmail.com>
References: <cover.1650547400.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "open_midx_bitmap()", we do a loop with the MIDX(es) in repo, when
the first one has been found, then will break out by a "return"
directly.

But actually, it's better to don't stop the loop until we have visited
both the MIDX in our repository, as well as any alternates (along with
_their_ alternates, recursively).

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
2.35.1.583.g30faa5f068

