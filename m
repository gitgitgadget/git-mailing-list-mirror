Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395BE1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 10:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJDRAc (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 13:00:32 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:55839 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeJDRAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 13:00:31 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 80XsgfYebVlGZ80Y0gOCEs; Thu, 04 Oct 2018 11:07:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538647677;
        bh=lrxcaQQEPF84V3THxbNrjBkNNPqKfNW5Zo9l+9oKBKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=hrXL38+s/R3qPaV9fo+iuueVGPqpVwWOVM6hNeLcecBPW9xsGaNbZLwUP+fWC2F1i
         m+E+C/V93AMZt/D0LTHBSRXIxB6onQY0ipVyjVbOtwXifRxVu7/NzLEvSX3lj+FzHq
         qHVF4Aze3BeqyJpY+30BOyz9O3cKeMeTVRdO45so=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=FVCVqbMd_-HzSxj5j7YA:9
 a=Vm1BYxNBd15DAg0M:21 a=xFJIqMZrjgypuhHE:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 5/5] diff --color-moved: fix a memory leak
Date:   Thu,  4 Oct 2018 11:07:45 +0100
Message-Id: <20181004100745.4568-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004100745.4568-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <20181004100745.4568-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJrpvBDoyyRz2UNfWGAe7QHJkQo6tOP+Tv2ksOTAbTDMnE5qc2HLrRyEnUoQYGbzwLyc1nJLyN0TLeBqoxc3dm6I8tW8YSKvCLB+3Hwhxr3NwHfmA9Ec
 c/1RPNjEPQbm6ABxtJU1fhAGgd1E9pCEQA/zQgTatQSA5ekluG0wQFzC6dlP4zYdJu1faJ8miNTeFX67+dXcdmb6JKmXqctUfD3lu9g4WeoAh4sW727m3pAT
 DgNQELR8KRODSCFD85eQ7OgFb/ehuDYs10AQPAEL9c2Pxdk+t1Wal2Oi+ts8WiVCmGGCatHR8q3JvRtqo/lqtA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Free the hashmap items as well as the hashmap itself. This was found
with asan.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 69f6309db6..100d24b9c4 100644
--- a/diff.c
+++ b/diff.c
@@ -5768,8 +5768,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
 				dim_moved_lines(o);
 
-			hashmap_free(&add_lines, 0);
-			hashmap_free(&del_lines, 0);
+			hashmap_free(&add_lines, 1);
+			hashmap_free(&del_lines, 1);
 		}
 
 		for (i = 0; i < esm.nr; i++)
-- 
2.19.0

