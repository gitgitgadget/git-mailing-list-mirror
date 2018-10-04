Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C421F453
	for <e@80x24.org>; Thu,  4 Oct 2018 10:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJDRAa (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 13:00:30 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:53957 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeJDRA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 13:00:29 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 80XsgfYebVlGZ80XzgOCEa; Thu, 04 Oct 2018 11:07:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538647675;
        bh=1UsSYg+fmExmm2/N/wzKIK6G0VGS8ax6OdJvn4JX6Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=N3q3erreZvrPrXoXM8PrRspZYFPAW5FeZoMY3Q0pV8VVR9vnMJ3hGGq6dTC/cuOkj
         0IpgN3BE6BT1TJTrkj9gad8Abs21k8uQ4Z/wmxirlqI3qQ+CO1sonv6vq2yg0tuLi2
         sHv9OIIecPa3bxHe2NzHt8cy4IMssPRzoGRkMzIE=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=zrg1TGVO0JqqeQklKD4A:9
 a=jG1ZfxoQ3ncelOT3:21 a=PxowXhvarQ7drk-q:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/5] diff --color-moved-ws: fix out of bounds string access
Date:   Thu,  4 Oct 2018 11:07:42 +0100
Message-Id: <20181004100745.4568-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004100745.4568-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <20181004100745.4568-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHnJ+W9y4dFZtsqOa2McTFttGuO7JBAetyCjRPSQTkPu9wXB7RYKSTCBZDp/711u/1mwNHU5lAZCSllyM9VRgBFnQkaw0dpycDtohRJt6tPB2k3ovKM2
 oCOP+YHc1IDkb8GQadJSJKMcbOj6GWUM2t4q4WPHiAph/SwqlOzYUMuA4S2C0btSTHGwmJRf1Eok3tvA86SkUSPPtPZPaTckuWeX2wQZI2ewhTkiYTcDIKGC
 ER/mHDK440j6B6Rk/Z5vLv9mlxsoHA9UwBEUCzTrsMs00QE760UJfbybeHsFNKHKS30XQkS1IvMGO4OUSymtSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When adjusting the start of the string to take account of the change
in indentation the code was not checking that the string being
adjusted was in fact longer than the indentation change. This was
detected by asan.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    Changes since v1:
     - simplified comparison as suggested by Stefan

 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 02d885f039..e492f8b74f 100644
--- a/diff.c
+++ b/diff.c
@@ -840,7 +840,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 		al -= wslen;
 	}
 
-	if (strcmp(a, c))
+	if (al != cl || memcmp(a, c, al))
 		return 1;
 
 	return 0;
-- 
2.19.0

