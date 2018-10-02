Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501161F453
	for <e@80x24.org>; Tue,  2 Oct 2018 17:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJCAkK (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 20:40:10 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:33180 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeJCAkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 20:40:10 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 7OtMgc0MNVlGZ7OtTgNKnm; Tue, 02 Oct 2018 18:55:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538502935;
        bh=P8ag5AEiZh28d5NxVOMvXDZYkQho8WHJqYyAxTCDpzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=PZUZ6uQleFncW8Fb80uCPntOMNATyxfhCu7diTaIkzCPoCidXOcSqrT6wgXGyMhUO
         NW2yHjJq2DJpldXE3rb3XfS55R96/V8bQBQCPx5BBZiml3IRjDXG9tSkRC9l2pKObS
         uSS7bbheWCgxBHP1k1r9FCfPVUIVVmSg7PLxgwbI=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=zrg1TGVO0JqqeQklKD4A:9
 a=z_d1wuQn5cqjXh0E:21 a=0UEQN__nQJZCTTcb:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/5] diff --color-moved-ws: fix out of bounds string access
Date:   Tue,  2 Oct 2018 18:55:11 +0100
Message-Id: <20181002175514.31495-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002175514.31495-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGVJQQjfhe11d9fwYfDRpENNcIPzjlWxScSxj0hevRKAcdI3nhuAEc0U8J0z5+Ghtue3dia8vqOrr0XEYlHTF3tqnwG+rd2oqAJ9I7M4PCRBHD9FC7h3
 9o0mhU41f4M34eLofPw4AaLtdS6yQHbbTbimITa4CQKJwaOvyD5hCw8AGX38oZUXaNU3YIWCN+bBaAN5juCr4j5Cjxh71RCXbAvWN3W9os6vphqfRCSUaRoy
 BzZFYS8o8DZf+SPDEg2vON2MgK4VhGcuERbuKyIR0ZWoNP3mHrRKrXNPPNm7Xdya
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
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 5a08d64497..0096bdc339 100644
--- a/diff.c
+++ b/diff.c
@@ -841,7 +841,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 		al -= wslen;
 	}
 
-	if (strcmp(a, c))
+	if (al < 0 || al != cl || memcmp(a, c, al))
 		return 1;
 
 	return 0;
-- 
2.19.0

