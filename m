Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FF01FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759437AbcLBUbf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 15:31:35 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36586 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbcLBUb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 15:31:29 -0500
Received: by mail-wm0-f44.google.com with SMTP id g23so27638187wme.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 12:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JbLvw3AszSNpFuWHxl9IsoJRWKfubz1lNTT4wVPVH2o=;
        b=Z0yorTx1qGD3T5351oMimz+eb0GArinlQnvR2V8cKo6PcZs3ujfcaRrlTHCAAnSJBm
         ppdRxc1e2pE0OAD1f0rQsbWhZxKTXz0vJHClfDcaOxKJRuJKADqCneKbzw9TdH/61Y86
         3WQxvInX9fH5N4JUHPYTKmqtJeJGVc0RcejVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JbLvw3AszSNpFuWHxl9IsoJRWKfubz1lNTT4wVPVH2o=;
        b=TH7359A+DPOW+AdsPgCkDCJi0H6mycxRrPbvhCQ6i5T88x9y8u5hVBRLlq+k+X9+6p
         1v5BDm07JFia6HHkDaB5eVspqGPEqQIeCeALuXd1ZUlDAIxohSYHhURaC5G4GAk4CYy1
         8AN5/V8dJgOBJyr5lO+UOSnsgtO5qA27Ah+UzVj7iWB5yel501HLmS3EOADRE2D5VxWN
         GchGLNDc9VykIhTCg6s74J4RObXRFYdgtY/G8copW/JqmmaqF2yNljRgcWEIZKH9AoOs
         d4nO1RXhBGjAvuH3Wk3vZF6UP7S+cH80GNS2HyNXFROxI0RS+ItiLp+sIDJjj/h/7y2p
         BG8A==
X-Gm-Message-State: AKaTC01QspErlcqmGeRNYGPDzlMU1TrMjckd+RTiYrRBRjy4ADDqLWOnc5LU/Q359cMs7w==
X-Received: by 10.28.98.66 with SMTP id w63mr4891461wmb.142.1480710687611;
        Fri, 02 Dec 2016 12:31:27 -0800 (PST)
Received: from lvps87-230-87-209.dedicated.hosteurope.de (wildmoose.dk. [87.230.87.209])
        by smtp.gmail.com with ESMTPSA id w79sm4938178wmw.0.2016.12.02.12.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 12:31:27 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 1/4] shallow.c: make paint_alloc slightly more robust
Date:   Fri,  2 Dec 2016 21:31:01 +0100
Message-Id: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have no idea if this is a real issue, but it's not obvious to me that
paint_alloc cannot be called with info->nr_bits greater than about
4M (\approx 8*COMMIT_SLAB_SIZE). In that case the new slab would be too
small. So just round up the allocation to the maximum of
COMMIT_SLAB_SIZE and size.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 shallow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index 4d0b005..e21534a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -445,11 +445,13 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	unsigned size = nr * sizeof(uint32_t);
 	void *p;
 	if (!info->slab_count || info->free + size > info->end) {
+		unsigned alloc_size = size < COMMIT_SLAB_SIZE ?
+			COMMIT_SLAB_SIZE : size;
 		info->slab_count++;
 		REALLOC_ARRAY(info->slab, info->slab_count);
-		info->free = xmalloc(COMMIT_SLAB_SIZE);
+		info->free = xmalloc(alloc_size);
 		info->slab[info->slab_count - 1] = info->free;
-		info->end = info->free + COMMIT_SLAB_SIZE;
+		info->end = info->free + alloc_size;
 	}
 	p = info->free;
 	info->free += size;
-- 
2.1.4

