Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2F821847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeEBA0u (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37660 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753414AbeEBA0j (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0FEB660B1A;
        Wed,  2 May 2018 00:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220798;
        bh=83hue5K2DLfQGc8Be/9db4q/wsZ2piD9eNo+3LdM4iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EdXyDX2d020fKDuQAN/pNlGDJ98v8+X3VQfxRG8cFi2OqNBzwhZCWN+My86keJWc3
         oXw6xpy1nsr67wmFqRecSzn67m/QodZp+Vdfdb8b3TNUmB8Jh733/16v2t+omjR/EA
         X3iOvuzUqWjwK4phQ3t7S16CHQZvmSMeci0qTvug+H6kGLrxmGPwccGc2kgedBMoaN
         WrO+1W+1ktmgQfOyAHFA/D9vH92fbSS4m7AoV3vu9Y0B1pewxrPi3hgO24dfyAN1+M
         eMphl+66cYMrt5JnXG73LaCs8/iHwyFpWKALmFkrp4RYyoCUHiuwCuKLE8kTfZWO67
         P8/LnJW1q8yvskHnTrfJgmfxnUC9CBud+KO7XEHcnudZToXEYyQukLiTVhLjhIWxQL
         O58oxoUG/7pb+td7v6bPSO9OBeEU4pgGt+Rgf6lztUNJ8zRNTsZsrcJmFypPOe9AY6
         aOQzOwjAh6tkpCVVEN8FpeHFYd7uIxbZ6Vgc9K8PART8znsxTnG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 18/42] index-pack: abstract away hash function constant
Date:   Wed,  2 May 2018 00:25:46 +0000
Message-Id: <20180502002610.915892-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for reading certain pack v2 offsets had a hard-coded 5
representing the number of uint32_t words that we needed to skip over.
Specify this value in terms of a value from the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 78e66b9986..9d6d19525a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1543,12 +1543,13 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 {
 	const uint32_t *idx1, *idx2;
 	uint32_t i;
+	const uint32_t hashwords = the_hash_algo->rawsz / sizeof(uint32_t);
 
 	/* The address of the 4-byte offset table */
 	idx1 = (((const uint32_t *)p->index_data)
 		+ 2 /* 8-byte header */
 		+ 256 /* fan out */
-		+ 5 * p->num_objects /* 20-byte SHA-1 table */
+		+ hashwords * p->num_objects /* object ID table */
 		+ p->num_objects /* CRC32 table */
 		);
 
