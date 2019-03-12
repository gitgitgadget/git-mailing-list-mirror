Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B5520248
	for <e@80x24.org>; Tue, 12 Mar 2019 16:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCLQzX (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 12:55:23 -0400
Received: from avasout01.plus.net ([84.93.230.227]:37688 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 12:55:22 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 3kgOhGGF0cPek3kgQh1Xm9; Tue, 12 Mar 2019 16:55:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=R84t5+ZX c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8
 a=gsSJbodjM4KxypuKUVsA:9 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC/PATCH] packfile: use extra variable to clarify code in
 use_pack()
Message-ID: <e561b83f-cf1c-eef8-7651-8519ce105491@ramsayjones.plus.com>
Date:   Tue, 12 Mar 2019 16:55:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ1XDjQ7Fj9EXhxXwRyWt+5wCzW18PpaEnOptAnJuBexpuLTbZIZ8QnfclYLaBn8jfS+dixfCiOLGhyLojnh9W1q7jooytYcqoChUtUZ9lB5VIvHQCoI
 HwvLC+e5WYXqoy8fCVIWm5G7YKTUqLj3U/xmrPINuVemxpViCbqphGN/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

I recently tried (yet again) to tidy up some old branches. When I get
around to doing a 'git gc; git fsck' I always take a quick look at
the 'dangling' commits, just before a 'git gc --prune=now'.

I had no recollection of this commit, from last October, but a quick
look at the ML archive found this [1] discussion. I obviously thought
it was worth saving this thought of yours. ;-) So, having deleted this
already, I did a quick 'format-patch' to see if anyone thinks it is
worth applying.

[1] https://public-inbox.org/git/20181013024624.GB15595@sigill.intra.peff.net/#t

Thanks!

ATB,
Ramsay Jones


 packfile.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 013294aec7..2f81ec9345 100644
--- a/packfile.c
+++ b/packfile.c
@@ -588,6 +588,7 @@ unsigned char *use_pack(struct packed_git *p,
 		size_t *left)
 {
 	struct pack_window *win = *w_cursor;
+	size_t offset_in_window;
 
 	/* Since packfiles end in a hash of their content and it's
 	 * pointless to ask for an offset into the middle of that
@@ -649,10 +650,14 @@ unsigned char *use_pack(struct packed_git *p,
 		win->inuse_cnt++;
 		*w_cursor = win;
 	}
-	offset -= win->offset;
+	/*
+	 * We know this difference will fit in a size_t, because our mmap
+	 * window by definition can be no larger than a size_t.
+	 */
+	offset_in_window = xsize_t(offset - win->offset);
 	if (left)
-		*left = win->len - xsize_t(offset);
-	return win->base + offset;
+		*left = win->len - offset_in_window;
+	return win->base + offset_in_window;
 }
 
 void unuse_pack(struct pack_window **w_cursor)
-- 
2.21.0
