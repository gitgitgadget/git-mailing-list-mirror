Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7340A1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfBSAFw (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34626 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732178AbfBSAFt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:49 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 878E8603C6;
        Tue, 19 Feb 2019 00:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534747;
        bh=HMx0XwcuzIG10NLQ1Reh03cO6a4KnQFfr4gzx9GgN9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=S/MQuH4XeggU3eT71HskjjGNCl7zCTxqNYEHvDU71JnAaqPT/FZIxZV6fIOwwQOh0
         tBXZWiTdV2/hNp3Fa4cEvk2umaH6SWodJGYk4zbq9G/T7Cv+OiMOJsQSnf51I5Vuz8
         okdwv9o3SGjqFB6DE5VsZ8Bco9HfLvNdFcYvZbq40BpeHNI+JTlWWMtIG/Sb6JdooY
         cBK1U5QOq+pR5lqWWZzlM/KprnNdXW5hgMfjuEyv0NiMliUqwvW04b2zojGW8/TCGi
         +bbdPpHVDXEJchK/CzyaQ9VWPy2LOoGUB8ZTopvKz2pNI+yOYRG+2RVVgC+6OWv49F
         STEtwsjVO1ODTLClbPYoeTAVCjw9a0C4BflTbUdjqEUe2Y/Tsu6IFnlFA6UpjuWrd7
         dSMTmuTOAw0FbZTbLm0ReJ8YggStWdapH9lv6eg3YUMHwvnOnuYWHTg9guNGhoekpD
         qodFbmGHeaKDTH4eCymxjDzBOOLnaqirvymzXi1eRSAn8gIAdaO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 09/35] notes-merge: switch to use the_hash_algo
Date:   Tue, 19 Feb 2019 00:05:00 +0000
Message-Id: <20190219000526.476553-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch from using GIT_SHA1_HEXSZ to GIT_MAX_HEXSZ and the_hash_algo so
that the code works with any hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes-merge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 280aa8e6c1..2fe724f1cf 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -29,14 +29,14 @@ void init_notes_merge_options(struct repository *r,
 
 static int path_to_oid(const char *path, struct object_id *oid)
 {
-	char hex_oid[GIT_SHA1_HEXSZ];
+	char hex_oid[GIT_MAX_HEXSZ];
 	int i = 0;
-	while (*path && i < GIT_SHA1_HEXSZ) {
+	while (*path && i < the_hash_algo->hexsz) {
 		if (*path != '/')
 			hex_oid[i++] = *path;
 		path++;
 	}
-	if (*path || i != GIT_SHA1_HEXSZ)
+	if (*path || i != the_hash_algo->hexsz)
 		return -1;
 	return get_oid_hex(hex_oid, oid);
 }
