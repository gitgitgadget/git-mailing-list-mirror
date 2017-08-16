Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327A41F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbdHPUQt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:49 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:48008 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752545AbdHPUQs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:48 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kA-0004LY-TO
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:46 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGe1v01u5BuuEg01wGfJh; Wed, 16 Aug 2017 22:16:39 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id B31FA45D4621; Wed, 16 Aug 2017 22:16:38 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 01/19] delta: fix enconding size larger than an "uint" can hold
Date:   Wed, 16 Aug 2017 22:16:13 +0200
Message-Id: <1502914591-26215-2-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

The current delta code produces incorrect pack objects for files > 4GB.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 diff-delta.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 3797ce6..db27c1a 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -319,7 +319,8 @@ create_delta(const struct delta_index *index,
 	     const void *trg_buf, unsigned long trg_size,
 	     unsigned long *delta_size, unsigned long max_size)
 {
-	unsigned int i, outpos, outsize, moff, msize, val;
+	unsigned int i, val;
+	size_t l, outpos, moff, outsize, msize;
 	int inscnt;
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
@@ -336,20 +337,20 @@ create_delta(const struct delta_index *index,
 		return NULL;
 
 	/* store reference buffer size */
-	i = index->src_size;
-	while (i >= 0x80) {
-		out[outpos++] = i | 0x80;
-		i >>= 7;
+	l = index->src_size;
+	while (l >= 0x80) {
+		out[outpos++] = l | 0x80;
+		l >>= 7;
 	}
-	out[outpos++] = i;
+	out[outpos++] = l;
 
 	/* store target buffer size */
-	i = trg_size;
-	while (i >= 0x80) {
-		out[outpos++] = i | 0x80;
-		i >>= 7;
+	l = trg_size;
+	while (l >= 0x80) {
+		out[outpos++] = l | 0x80;
+		l >>= 7;
 	}
-	out[outpos++] = i;
+	out[outpos++] = l;
 
 	ref_data = index->src_buf;
 	ref_top = ref_data + index->src_size;
-- 
2.1.4

