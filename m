Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6512047F
	for <e@80x24.org>; Tue,  8 Aug 2017 06:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbdHHGUy (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 02:20:54 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:60791 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751868AbdHHGUy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Aug 2017 02:20:54 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dexsp-0007rS-Ng
        for git@vger.kernel.org; Tue, 08 Aug 2017 08:20:51 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id uWLn1v01v5BuuEg01WLphJ; Tue, 08 Aug 2017 08:20:49 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 8836245D4512; Tue,  8 Aug 2017 08:20:47 +0200 (CEST)
Date:   Tue, 8 Aug 2017 08:20:47 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
Message-ID: <20170808062047.GA4091@mail.zuhause>
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause>
 <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1708072136290.4271@virtualbox>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1708072136290.4271@virtualbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2017 at 09:39:12PM +0200, Johannes Schindelin wrote:
> If you want to work on data in memory, then size_t is the appropriate data
> type. We already use it elsewhere. Let's use it here, too, without the
> intermediate bump from the incorrect `int` to the equally incorrect
> `long`.

I disagree with "We already use it elsewhere.". The whole delta code uses "unsigned long" -
look at delta.h. Look at unpack-objects.c. Or cache.h. Or pack-objects.c. Or index-pack.c.

Other possible cases:
git grep "unsigned long" |grep size

So the codebase still suggests, that "unsigned long" is the data type for storing object sizes.

I would be fine with resubmitting a patch using size_t/off_t for the touched parts - changing the whole
core code is a too invasive change for a bug fix.

Regards,
Martin

--u3/rZRmxL6MmkK24
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Fix-delta-integer-overflows.patch"

From d97a7810ff679dd939972c151bcf23c122cdc570 Mon Sep 17 00:00:00 2001
From: Martin Koegler <martin.koegler@chello.at>
Date: Mon, 7 Aug 2017 20:00:30 +0200
Subject: [PATCH] Fix delta integer overflows

The current delta code produces incorrect pack objects for files > 4GB.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
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


--u3/rZRmxL6MmkK24--
