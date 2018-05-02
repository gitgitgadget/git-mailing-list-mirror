Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4652A21847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeEBA1R (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37856 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753511AbeEBA1A (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:27:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B3E036046C;
        Wed,  2 May 2018 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220819;
        bh=pyqlJQGFubPK6DP1fI76k21mYRCGGBBxFmy+DWtPp+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AHhjQgdWOQwdMTr1e9mVy8DdbhNxIm4QydE5SDF04ZS3ELUJmDk3MS6ioNoHhdhuw
         dcktU8je/CluEdbySf36LhnXhVhqDO80Z/ekz1e2zaVGT8FMLnDpIjX8M9bqyW7x6f
         768dgCetBX4bjZqIUNsWK+2JsZkZn3i18qpGuuQ7rnY8yWebi0Nvcs3L7dKUjKJ4WP
         41F7iSPFxLEODfyTOnAR6fp8QsraX0kpX1KTFaVzQS8/zU755MexRqTp4sgS8FvUBZ
         SBffG1IPVK13rt45eu7O6l50/rTenjvJ0+GOq9hMw7LiNw5mKpzH/oXOq7qoMVIIeQ
         EFlutRRqVH+o4UAml1P8lgXRQoFtlhYOgFkuXX/FEssvZjKLk/C4a1Pp7ntVjeQfby
         YEeuEQ+75r0PGYbMRl8cYR9KTktDBrQfBhgaw7vJJatwsT0pCCxtPYT4Rqn9CD1KR2
         11g+B3Otaem3g8mhCOsiWx3b9goQq/VQxGJ0nPsWN/y5Uz6i8Qh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 36/42] cache-tree: use is_empty_tree_oid
Date:   Wed,  2 May 2018 00:26:04 +0000
Message-Id: <20180502002610.915892-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When comparing an object ID against that of the empty tree, use the
is_empty_tree_oid function to ensure that we abstract over the hash
algorithm properly.  In addition, this is more readable than a plain
oidcmp.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 8c7e1258a4..25663825b5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -385,7 +385,7 @@ static int update_one(struct cache_tree *it,
 		/*
 		 * "sub" can be an empty tree if all subentries are i-t-a.
 		 */
-		if (contains_ita && !oidcmp(oid, &empty_tree_oid))
+		if (contains_ita && is_empty_tree_oid(oid))
 			continue;
 
 		strbuf_grow(&buffer, entlen + 100);
