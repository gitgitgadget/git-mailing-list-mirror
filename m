Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE60C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiGRQsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRQsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:48:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9002AC7D
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:48:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g4so11120881pgc.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CM42Ot848eprLj08Np8l8RYtncjprn826AsYP6mnDm0=;
        b=I3GherC68YcsSoOJCtT49Y15W41t+2bvumZBgolyr6fp/6DQQ2cL1JdZNv6R9i7+m2
         pGOyvZvNTvDcK5SRkE9tEa0SBuGuEpNueghYGcg7Gki4DNfGgjVQEVe5UA0XvZz6t24b
         H3BEQt6Kw+CIwDj7yX0DU1t1C/vLD/aleRj9vn71vhVNMdmn3L/43pOo5kt6WrOC0bKp
         i//5Afk9e8zXkQWQ0t3E5sJh476+pWEqCeG5N1/ojUWSsaIsmgKrW2fVHjsgIG4cZlDc
         4liLxRXDDowkRL74bako+dlR9blYBVvCv8e6oNQXKBGwCPLGgb0EOnvBvjXq5YcAEC/6
         9ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CM42Ot848eprLj08Np8l8RYtncjprn826AsYP6mnDm0=;
        b=cDxdF7b+Iwi2D8BDBuJMhTBEhpE2rILvAVqYK+j60sx2IYP/lgTVjOq8hZYYGivs4c
         WyyXYoG/X2+AjjMRhHWERRmLzW3/WS50vMyYEUU3GvgtALkIE8U1QR8sG4HakjwQtUXt
         I+ZUh/2rOml1az3KhigrPLjZRyO837LGVeSWUU+HiaG9aMq6NhMeCVz8TNHmRvxAxfBR
         iwe1ZfASX05WD7Tqq3QJxSr5o5Iyysd+yWS4X6wLfEFqi76nZREYH0YLBIpaDaanGWJk
         McW8bcQTwRoVTcQTJXYuhCldLi9cpUCeQ4Jpl5UQkUNRcgGAgQEDrcwgXOqRUC6AK2Jv
         gvTg==
X-Gm-Message-State: AJIora92sHZxnBsJez3gTycTxU7kMuCIWTZxYyKfO3yAcrKjtqksnvhd
        EcgjtnqD8gCckt+YYRTS8xmi1Zywj/xoJQ==
X-Google-Smtp-Source: AGRyM1t42mqnpwJNvQegydet0UjaLf7W5UW9wtx+45oQ3eqz8l1unlUCcamEdJncUXif56JiX08ISw==
X-Received: by 2002:aa7:82ca:0:b0:51b:cf43:d00a with SMTP id f10-20020aa782ca000000b0051bcf43d00amr28979382pfn.58.1658162902683;
        Mon, 18 Jul 2022 09:48:22 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id d66-20020a621d45000000b00528669a770esm9671074pfd.90.2022.07.18.09.47.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:47:56 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 6/7] pack-bitmap.c: continue looping when first MIDX bitmap is found
Date:   Tue, 19 Jul 2022 00:46:05 +0800
Message-Id: <83090308ad63543c9becfb4cec9c1cedcffb1fdc.1658159746.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <cover.1658159745.git.dyroneteng@gmail.com>
References: <cover.1658159745.git.dyroneteng@gmail.com>
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
index 318edd8e0d..d013ea0277 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -506,15 +506,16 @@ static int open_pack_bitmap(struct repository *r,
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
2.35.0.rc0.679.gc613175da2

