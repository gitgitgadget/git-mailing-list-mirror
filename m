Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277D220899
	for <e@80x24.org>; Thu, 10 Aug 2017 07:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdHJHPc (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 03:15:32 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:27109 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751418AbdHJHPb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Aug 2017 03:15:31 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dfhgo-0001sz-1I
        for git@vger.kernel.org; Thu, 10 Aug 2017 09:15:30 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id vKFN1v00x5BuuEg01KFPec; Thu, 10 Aug 2017 09:15:24 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 1210345D4512; Thu, 10 Aug 2017 09:15:21 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH V2 1/2] Fix delta integer overflows
Date:   Thu, 10 Aug 2017 09:01:01 +0200
Message-Id: <1502348462-4992-1-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

The current delta code produces incorrect pack objects for files > 4GB.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
For next.

 diff-delta.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 3797ce6..cd238c8 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -319,7 +319,9 @@ create_delta(const struct delta_index *index,
 	     const void *trg_buf, unsigned long trg_size,
 	     unsigned long *delta_size, unsigned long max_size)
 {
-	unsigned int i, outpos, outsize, moff, msize, val;
+	unsigned int i, val;
+	off_t outpos, moff;
+	size_t l, outsize, msize;
 	int inscnt;
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
@@ -336,20 +338,20 @@ create_delta(const struct delta_index *index,
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

