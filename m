Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E75AC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C6B2073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MQNTaNqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390505AbgEYUAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390453AbgEYT77 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B976C60D19;
        Mon, 25 May 2020 19:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436799;
        bh=wGkcIWlrzxwpvybjFe3BIl3Q7hJ8QqVrySX1zMLhLPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MQNTaNqHy+R4H7FLQuU5HC6oLYPoaCZFM3XHDO4Mj8fCLOC9Cm1MFxgttr2i+FKst
         VdeGiNIajYIUn1ZhybaAtUpxkWHDTlKmQuI5uKgTb2D/UGc7pQrqUlb+twTEdvHPmm
         gz4vn5DF5cObAXjF1GlWAFDahfDK15nKXA9qA6gzt6olhzFPtCRrsGLA2VRQXGrcC1
         NLhlRZ7YjTko2LM07I3t/HcZiVF/z7wmg4voKXWbaJsw3oKRAr54qrpQRyBwzRSiBK
         A/anQ3UYBEOXRe+W/MrQg/OYBtZCxchNkePWjdzLuQjXkSFa2O1SJsP3/6uC1wjHkb
         BGinibg/vtoXI3qfnbWKZcooDY/WGXRR9lstNkBnNYtBabAyMr4Icd+USRHlnlr4tp
         7am20RwnpA6QEH3tVFtlYpVlxPTSFvnDeTID2+fFf9TXRdR+WS4Omc1QCL12A7vKdy
         YWRyqhW/ZPUovX2aynfLYBmqY2BL/vPd4UiGOUfY1Ima/h+sy/F
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 37/44] remote-curl: avoid truncating refs with ls-remote
Date:   Mon, 25 May 2020 19:59:23 +0000
Message-Id: <20200525195930.309665-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally, the remote-curl transport helper is aware of the hash
algorithm we're using because we're in a repo with the appropriate hash
algorithm set. However, when using git ls-remote outside of a
repository, we won't have initialized the hash algorithm properly, so
use hash_to_hex_algop to print the ref corresponding to the algorithm
we've detected.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 617edfedf4..c077323008 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -548,7 +548,9 @@ static void output_refs(struct ref *refs)
 		if (posn->symref)
 			printf("@%s %s\n", posn->symref, posn->name);
 		else
-			printf("%s %s\n", oid_to_hex(&posn->old_oid), posn->name);
+			printf("%s %s\n", hash_to_hex_algop(posn->old_oid.hash,
+							    options.hash_algo),
+					  posn->name);
 	}
 	printf("\n");
 	fflush(stdout);
