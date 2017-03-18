Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52CDF2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdCRVbJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:31:09 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46188 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751251AbdCRVbI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:31:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C4FC1280B4;
        Sat, 18 Mar 2017 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872001;
        bh=zvkmkfUTc0j6YYVM+gaT6z18h8Js9fJzY6HKNTikCyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOqpwaPnjifSAC0POJJ+bcGpdC9A9PcZYFn5ere3mWwm5D3xl5iZD081S23NXp1WJ
         6aNEx6Q/H4FZz5mlOQ/cxv4IpNOgPSbvxCHOX0XdWS0hT4y7XI7Iht4czTcwGcRW53
         IX+GlDaedSgy2XUQdSy0E3AllituiMTW3S04h/m6D1q7NIhznU0KK7K51LXzoRwFnW
         ZLbt2IKxpwGTmAnG+b1fziRtTU+VNniC+31BMUShQfxCDnd8FMNQVbRF5fLufglbWb
         mSz3mCz8pWcTgTVijBIOF5SDqrsWdWeEPljp5LqUqWVZHinCxV6B1swkviN1jCrVU+
         e2d6omtz7vmoJaH1OvQdY5bcJn1CehVs9iMVWq7ZggoBsHp/W5eNicHe3LNsIxP972
         Yw+Z0byM3oXWwdSZY3Out4fmjdP34CkvNofmNpM5ZrEbasnI7aPql6sjZxM9Vt3f7Z
         izcyekY5X9nugR6Ux3UQeg9EpeZFxSOPe3L0FEv6wtAN7DZeayf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/20] fsck: convert init_skiplist to struct object_id
Date:   Sat, 18 Mar 2017 21:19:41 +0000
Message-Id: <20170318211954.564030-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
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
