Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED981C43460
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C605C611CA
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhDJPWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58518 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234768AbhDJPWv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 10FC060790;
        Sat, 10 Apr 2021 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068156;
        bh=IHd1nof/YW/R9WMalCpXSBUaTj6ofYzcMNCUwVNuRoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=aYCKdixQriVUIz2nHpc8HxEEkf5aMB6gY39gJzYTKHKB2/3G0C2DdNdYtHwd52wbL
         bzU2bYdI0P78EjVcDTY7JdhQZX3KyaL+ApcLNa+JNZ4mtAn69AQS5E6GBRLegVpDN+
         N+WHU6W9b1V6JJGfR7xFkZHgceyxAYURO6mBNQE52+fArbGQizeuDoVZsKTIHk+bpj
         mGlkiv957zzEP3IEJ+ggwOwLIhwhTAeCCCzKo35U9gml62Ne0rU0s9k60C5BiIzabf
         sXaimxE0alelBW6xDLNtRwZy5tkIm1vE7cZZ2oh0PIRy98Q3Ndd+i5k0sY9Cf+imyx
         /+HG92yEaiGAN4jz4qo22J09tQsiHuGNjU91PnH3cEJiCkhpmKNT07g6EdMe2kYJIG
         dipLrqNi3FQClvcYkv+aEa+77L99NICy1v2QGksF9l34KyablAjH3xJTVubZRZyM4k
         uH2Wj/gB5CzNj/rMwiWIFFY9KZqEbY9Xrc4V57BSixcGS/auAJC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 11/15] builtin/show-index: set the algorithm for object IDs
Date:   Sat, 10 Apr 2021 15:21:36 +0000
Message-Id: <20210410152140.3525040-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In most cases, when we load the hash of an object into a struct
object_id, we load it using one of the oid* or *_oid_hex functions.
However, for git show-index, we read it in directly using fread.  As a
consequence, set the algorithm correctly so the objects can be used
correctly both now and in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 8106b03a6b..0e0b9fb95b 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -71,9 +71,11 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 			uint32_t off;
 		} *entries;
 		ALLOC_ARRAY(entries, nr);
-		for (i = 0; i < nr; i++)
+		for (i = 0; i < nr; i++) {
 			if (fread(entries[i].oid.hash, hashsz, 1, stdin) != 1)
 				die("unable to read sha1 %u/%u", i, nr);
+			entries[i].oid.algo = hash_algo_by_ptr(the_hash_algo);
+		}
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].crc, 4, 1, stdin) != 1)
 				die("unable to read crc %u/%u", i, nr);
