Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487D620966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935086AbdCaBkM (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:12 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59220 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935051AbdCaBkK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:10 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B506D280B4;
        Fri, 31 Mar 2017 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924408;
        bh=zvkmkfUTc0j6YYVM+gaT6z18h8Js9fJzY6HKNTikCyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNF9qS2kItUnbFATPIsMPv86Ozr9MZ+twfPRS1SJqEwkmVLLqbNmEEK+035/bUebu
         arBVTjQU1821Z0XZ8HoV2o9Ch45gF0ryKo7gLnAb9cp8EGDl5J3Ne9HTUuFO2gAM8B
         VcRnBnGoGnZWzZnwify04zVlvbOS4mHypYioIclIhmzAxRLePdSzQcmqt/7CpfYyzh
         FBmJQUcicxetDDg9a6PxtQ4xi1niUymJqinXV4fjYZfYs8yCZp+UAigeiwY4eUmtOI
         751oAP10VYjghudi6s7+w6hId62f1E6gamROhXoMhATt2O2X3peafCeYdZjcsqXObR
         D2JZd9VcyC99YE57n2HCnTZM+IBL2g0PaGafNKnOw/rwgBVoYPmTBOLMFSvuamnjyR
         NSw1RS2z7UNIql4rDLbepDsGPiyNTR3gH6yBuOZ+tOH8v6sSZd8U+++PoAymLiGujA
         rkk9c11L43goU6BlhPcEp00ZVsGDc1fUt5KpqoDPh0J7XvkLNAg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/20] fsck: convert init_skiplist to struct object_id
Date:   Fri, 31 Mar 2017 01:39:48 +0000
Message-Id: <20170331014001.953484-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
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
