Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B285207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754305AbdDZUVp (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:54335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936367AbdDZUVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:43 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MegeC-1dRlaV3Xey-00OExQ; Wed, 26
 Apr 2017 22:21:39 +0200
Date:   Wed, 26 Apr 2017 22:21:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 21/26] shallow: avoid memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <ecb1959172d0e3b5501af64879190808f513898a.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SkKxkxd5LWXP1eKLUv2K3ouYhXBaC0pwjah0xMVPc4iyaVWd9Ht
 jpwDO3/UN5fR4f1Ul7VdeJPhqygYz6gRbzOvwh/bd11OL59fYQfxZobxPQEJlLbidKaMfpJ
 sjeeWpKoKIHDILTzHSJC3pE1sdqdKnX/ZinNZLZxniowtbm5mMPUxMh9gcQgeyv0i9mAInR
 EKKqSWtx+WiX8krvbAqcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NybJJmm4ZZI=:CG61Cz8oa2aQYTvfUaTK4l
 XWHPlku4fTbPJpFHJIH+TXnXNjnvX0rfq2SSW9bvCUw5Pbc4PlDP8IgUQOgbqyyrEcDLxXb6p
 cjXJDYLBQlMb7dmftn0HKrDQQglqa+kzUdq7w4kGxPg1dkspSU2TG53ARsfGxNPaz9C/o+zMW
 VxSP7gKutX/n8YQE2MdsZH2U6dZwJ6eMkFVlOe0Fk1aJXZISvjZlyuoASuE0KONzkKsS0ZYgn
 3v+SYtpBChvuOA2qc2VM6Er20UafFjiOaFu5kP2mNOElwMFxEjEq4IgN94OleqzrM9E7PDzFj
 GC99y2/+7PMxkiXn7gO4hLzrezGfjk0MB4b/O/qUMQpyBLNb9BOtneASLVbM/2RaR/Xb4lpk5
 G8MOVwaM41WACOKLQiCw9SwRfUHQUYBTLF26wFbSudhgp2CoQ6o5Nl7+N0sHXBY+BCpfVp5Vr
 dNR4Zt8dgFhaux6gdb+JGrbElHJGZCX9T83CKBcKyTm+pkq19Hw0uoXr4UhQ3JnM5La8S3KZF
 RUftc0qndI1SAogneMqwQK/ohNEW3eReQL0ZfKcmiyFLT6xYcO0AzCEE4NaopYrJdwQ40QMPX
 Y+5ygSYAQGHTFFxaRlWHFBV3lWN/qk8T+yLL4ZrxcxbKz5ohYapqPupjyOzKGVdS2ysdExXb3
 1hI/YmwcXXTTw90NZzXRIIBaZ6Tb5WYRHJ6W/iYvNtTA3MN4Yeb3fndV3FOBCZcxuhzzN6YdZ
 uPZNwj/a020LXLrTPr5vmF2IShVzyBDQ7gRCrO2BlWDO87l9ARZ9c0ZMpPt39FjJ4g++jllaC
 1Tvin23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 shallow.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index 25b6db989bf..f9370961f99 100644
--- a/shallow.c
+++ b/shallow.c
@@ -473,11 +473,15 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	struct commit_list *head = NULL;
 	int bitmap_nr = (info->nr_bits + 31) / 32;
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
-	uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
-	uint32_t *bitmap = paint_alloc(info);
 	struct commit *c = lookup_commit_reference_gently(sha1, 1);
+	uint32_t *tmp; /* to be freed before return */
+	uint32_t *bitmap;
+
 	if (!c)
 		return;
+
+	tmp = xmalloc(bitmap_size);
+	bitmap = paint_alloc(info);
 	memset(bitmap, 0, bitmap_size);
 	bitmap[id / 32] |= (1U << (id % 32));
 	commit_list_insert(c, &head);
-- 
2.12.2.windows.2.800.gede8f145e06


