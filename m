Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6203F2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbdHGSKy (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:10:54 -0400
Received: from vie01a-dmta-pe04-3.mx.upcmail.net ([62.179.121.165]:64301 "EHLO
        vie01a-dmta-pe04-3.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751429AbdHGSKx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Aug 2017 14:10:53 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1demUN-00076v-E0
        for git@vger.kernel.org; Mon, 07 Aug 2017 20:10:51 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id uJAm1v01w5BuuEg01JAonr; Mon, 07 Aug 2017 20:10:48 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id B3B7945D4512; Mon,  7 Aug 2017 20:10:46 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH] Fix delta integer overflows
Date:   Mon,  7 Aug 2017 20:10:37 +0200
Message-Id: <1502129437-31226-1-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
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

Just pass any file > 4 GB to the delta-compression [by increasing the delta limits].
As file size, a truncated 32bit value will be encoded, leading to broken pack files.

diff --git a/diff-delta.c b/diff-delta.c
index 3797ce6..13e5a01 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -319,7 +319,8 @@ create_delta(const struct delta_index *index,
 	     const void *trg_buf, unsigned long trg_size,
 	     unsigned long *delta_size, unsigned long max_size)
 {
-	unsigned int i, outpos, outsize, moff, msize, val;
+	unsigned int i, val;
+	unsigned long l, outpos, outsize, moff, msize;
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

