Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2481F453
	for <e@80x24.org>; Thu,  4 Oct 2018 10:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJDRAa (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 13:00:30 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:4945 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeJDRAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 13:00:30 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 80XsgfYebVlGZ80XzgOCEh; Thu, 04 Oct 2018 11:07:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538647676;
        bh=UDt6Rjt+tQ60LmE182FMLY9F+Hpe8jJtOIo0JDHGtXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=M2Rzw0FF5Fj+qCYoxhJtWJ3pCVsdoEGd0ov+Q2iJAEYGnXKtZ8ztPomncgAXschL/
         kanKT+UthYUnFObK0DoC4uT2NHtHYXrMgkqa2YajJlkCR71nyS0xTCo6R4/XaVuAkK
         DCOSA4HPtU2VpVcTYaAWEQJGGgnc46xqYF0LrwHw=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=EaTrdlfBmmo0FKB1FiUA:9 a=yDdr35DLH1FLnASs:21 a=zdHeXb6NyMOZg3aj:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/5] diff --color-moved-ws: fix a memory leak
Date:   Thu,  4 Oct 2018 11:07:43 +0100
Message-Id: <20181004100745.4568-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004100745.4568-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <20181004100745.4568-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAZx2l4lbTh1Jk2qF9SzuZyEifBkLZ6CfUvkg+MB72BJmQzzwpCb696/YgW4ZjnnDqnbkMzSPx9EIwV8DJjDhsyNvBHtyqExVHkP+L1mEaoEqYowghjd
 uZG0uWgqVWuAsb2C0fLlwEUAQc1iYl4QvaYLAkFCyVBdq/Kjq3yHW4vprqW1aONqwzJsQpPA8ec0OLYTd6WIKz+AhSSQd1TPrjW+uS25Mq7sh9jxp+cH/zfA
 NO6I1FytjgOBOZQZUkavm0awgLqcZhy7e6dzqMxSlSgOwMcgAf2k1d1sKh8oExu25KZ3tgPsccPA9nppyA4e5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Don't duplicate the indentation string if we're not going to use it.
This was found with asan.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    Changes since v1:
     - simplified code as suggested by Martin Ågren

 diff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index e492f8b74f..9bf41bad0d 100644
--- a/diff.c
+++ b/diff.c
@@ -786,10 +786,13 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	const struct emitted_diff_symbol *shorter = a->len > b->len ? b : a;
 	int d = longer->len - shorter->len;
 
+	if (strncmp(longer->line + d, shorter->line, shorter->len))
+		return 0;
+
 	out->string = xmemdupz(longer->line, d);
 	out->current_longer = (a == longer);
 
-	return !strncmp(longer->line + d, shorter->line, shorter->len);
+	return 1;
 }
 
 static int cmp_in_block_with_wsd(const struct diff_options *o,
-- 
2.19.0

