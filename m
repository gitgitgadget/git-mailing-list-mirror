Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE11C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiGKMp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiGKMou (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3038B11152
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 145so4606480pga.12
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=falzEKBgGDPv/P5KOgkBl0kQztInYCV/JAGAERoEarQ=;
        b=XAmNeOl+kovf1/R6ju0suavQNJ+xOIgdhorZGR4cK35w0Alma4817dLKAxnZAsN8Tj
         Ya4TjOK4/zpBGqrOHQqO2YhtPDDiduPvBmBW/gly2of69bK6vGKUboaNrzu5tjSjrkz4
         VbB2WnYt4nRmaYNNltEfBLylUm59NebdzPiZwQPcNW+tXVINjs15E08s1o9UNIEDGPT3
         XWXbT4l+44np6eDdavn4SyXOdgqVMc/EXy9CX5cfAS3GAKs52zxVBTnHOP2Cf4DxPKVZ
         F86PLIRQdd4GDLBD2ujfkdzH/iTk1bZKKEwlccglMxpIEzsH5rE/Vw9y0eV9df2FgzIp
         zB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=falzEKBgGDPv/P5KOgkBl0kQztInYCV/JAGAERoEarQ=;
        b=RQYYQwK2YtxH6QqJIjsoOgDWTDcUnq1GzvHsPlVOhfUxJ682fAJU9FS+AoIRJFZcoV
         L67ZsHRXPmLyfmmJ+Mni7cB86MoEYWj7KCfzYszRe4pClcZfijvT7KBcxIvfZcGIN+HJ
         7JZtYsO+mwA+FLCvwtZN3jpi8u/ayie+rdW1ZlBHP67Hih7X4/FJIhM5w89PQda3wqL4
         ets89aM+AvsD+XSSCJ+ml5mTKHStlez3W13/q8gbitKQxz4VPQICtep9v7wsg/k0hzSn
         c1DMboRn/fa3KMvVJkhYk0Ddx1sSoatlqlhdkvkCW30GxYYonitUVf7eVOBwlHWwROL9
         FdCQ==
X-Gm-Message-State: AJIora9xgBb9KK5fxQ+Sa1K0msSgQ75Q1qIfqkVZXoM+GyjKJGXF+eE4
        g6c1pUf9t+Unup7p58ZnbeE=
X-Google-Smtp-Source: AGRyM1tVEUgYK4x5sYiqwFWawwELfOAW7CgB7KlxXb5h3pShsMZjtBMVql/BRXab8CDxZ2Oapc8P1g==
X-Received: by 2002:a05:6a00:134e:b0:52a:d5b4:19bb with SMTP id k14-20020a056a00134e00b0052ad5b419bbmr3070588pfu.45.1657543472310;
        Mon, 11 Jul 2022 05:44:32 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm6866084pjd.52.2022.07.11.05.44.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:44:31 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 6/7] pack-bitmap.c: continue looping when first MIDX bitmap is found
Date:   Mon, 11 Jul 2022 20:44:02 +0800
Message-Id: <95832190b8bba72622ffe1474e99990a29706db8.1657540174.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <cover.1657540174.git.dyroneteng@gmail.com>
References: <cover.1657540174.git.dyroneteng@gmail.com>
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
index fbe3f58aff..7e69093d5a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -504,15 +504,16 @@ static int open_pack_bitmap(struct repository *r,
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
2.35.0.rc0.676.g60105b7097.dirty

