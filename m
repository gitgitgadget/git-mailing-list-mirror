Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AC11F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfHRUFq (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57950 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbfHRUFf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3501D60745;
        Sun, 18 Aug 2019 20:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158734;
        bh=xP48SyKW1icnWdBFj8Yns9F9h6R8g8uZ4exKyORwwTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BzRiSAl2O/olI2w1GRPRYPOaxSu9yqu3c3Ae7goKeUwtrb467q3zz6Uh0Ceq94Btv
         dbuG53rNzdfhiHmMDuZIujoPB4Jxa81jxeB7F/TNvYROEpUqXa9iy4TDhcWWFPIkOv
         dMLGTHgADWh5S7b3YjKaAl1WvHnirHIIVgdFk816Do8lxEWl4f7ZoIVDSZ0VXzxCsJ
         dY+DOctPhoLq7M+bbGvNI8xms1zFP3V/4Z+SlWEYlEv0zVE8s3oXehUGTJ4jlbrXax
         hAEkA6BauCc+Gx6IAiU/zfbt+7UvxYxSHQW7F30vCdgVwIEiKaPpg3ekdbcW3UUE44
         jnlJrf/ELrSYuK2CJR38ndOGLFVpsmFMXiA7H1Vnnjqs4rkIE5cKOYXHNVRxR6qqqF
         FLB7uGTl92zCpG+h46e8l+8oOZBvAQUgUMzP3fIxvMt9sFnDtlFK+r2KOLc4ACDFnx
         D3kTEdKhSgS3JSFkd84mMJnSZiwygnv7FkieKlYdLNnZehcG+Va
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 06/26] builtin/rev-parse: switch to use the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:07 +0000
Message-Id: <20190818200427.870753-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch several hard-coded uses of the constant 40 to references to
the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/rev-parse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index f8bbe6d47e..308c67e4fc 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -593,6 +593,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	const char *name = NULL;
 	struct object_context unused;
 	struct strbuf buf = STRBUF_INIT;
+	const int hexsz = the_hash_algo->hexsz;
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -730,8 +731,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				abbrev = strtoul(arg, NULL, 10);
 				if (abbrev < MINIMUM_ABBREV)
 					abbrev = MINIMUM_ABBREV;
-				else if (40 <= abbrev)
-					abbrev = 40;
+				else if (hexsz <= abbrev)
+					abbrev = hexsz;
 				continue;
 			}
 			if (!strcmp(arg, "--sq")) {
