Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C4520958
	for <e@80x24.org>; Sun, 26 Mar 2017 16:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdCZQCE (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 12:02:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58062 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751389AbdCZQCA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 12:02:00 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A97C5280B5;
        Sun, 26 Mar 2017 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490544115;
        bh=zvkmkfUTc0j6YYVM+gaT6z18h8Js9fJzY6HKNTikCyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hP6FaT/Y1WfQJlbcZGytrxV2hnoWdMjgor/fso+ZG1Opy2elRM7qOzW8XWy//sRds
         jsVZ9pAiwAefjqTvWHInUAwVFW9hw/ScLK4F5qMt475VH+92i7QUJLYjPBFDlVAR3O
         VnOUrbNqdoj+qP/tKXYsOmR1nTl0gdQsUE+IDiczlBFqjxPkpxZS1FVS0CICmCOO24
         GihUHlwmAIyACkZyNppifSSDtrGnH4moPHJyQBvxEFeGiIKtanCECgAWBmzghVxwgh
         mBvaTsd12Tnb+vT9zOHsGdcvTlpVsc66Yk+6LZRR1JU5WTBWxthlVjuuVMmEQLxMdo
         /qUrmuQeLvC2t7FjkLNHdcBP5mG3KJiFoqYqnkz21IH9RmflV3CUyF4pxYqH3UFJ9I
         ogvJUUA6fsrTYW2tr3yPI4ytE9xpQ+XlTHJncN1/hMYf93T6m1y/gx2AggEFrURnR7
         3tnpH/QXbP4H76rdE7FbOAfN4MYylGvQPnTIUBy5F8Y1ECNosyg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/21] fsck: convert init_skiplist to struct object_id
Date:   Sun, 26 Mar 2017 16:01:30 +0000
Message-Id: <20170326160143.769630-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326160143.769630-1-sandals@crustytoothpaste.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert a hardcoded constant buffer size to a use of GIT_MAX_HEXSZ, and
use parse_oid_hex to reduce the dependency on the size of the hash.
This function is a caller of sha1_array_append, which will be converted
later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fsck.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index 939792752b..aff4ae6fd4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -134,8 +134,8 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 {
 	static struct sha1_array skiplist = SHA1_ARRAY_INIT;
 	int sorted, fd;
-	char buffer[41];
-	unsigned char sha1[20];
+	char buffer[GIT_MAX_HEXSZ + 1];
+	struct object_id oid;
 
 	if (options->skiplist)
 		sorted = options->skiplist->sorted;
@@ -148,17 +148,18 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 	if (fd < 0)
 		die("Could not open skip list: %s", path);
 	for (;;) {
+		const char *p;
 		int result = read_in_full(fd, buffer, sizeof(buffer));
 		if (result < 0)
 			die_errno("Could not read '%s'", path);
 		if (!result)
 			break;
-		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
+		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n')
 			die("Invalid SHA-1: %s", buffer);
-		sha1_array_append(&skiplist, sha1);
+		sha1_array_append(&skiplist, oid.hash);
 		if (sorted && skiplist.nr > 1 &&
 				hashcmp(skiplist.sha1[skiplist.nr - 2],
-					sha1) > 0)
+					oid.hash) > 0)
 			sorted = 0;
 	}
 	close(fd);
