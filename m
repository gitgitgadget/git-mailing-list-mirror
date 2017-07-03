Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD7F201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbdGCS4H (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:56:07 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53000 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753469AbdGCSzy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 30E4D280B5;
        Mon,  3 Jul 2017 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108148;
        bh=q5F9K/PNZsfHoiJK/GTJv+aFHUtmdLbvb7jS25ndNyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tm/PEhyybYu2qLnXTbN4xbxyN3wRg3a6NNkFNw0+46StEtgikwQitjcBRPZ9wofms
         4hl7076duU4dIGPxlPX1iLH/Y3Q2TezWeG+0o54SXnVEXjDAKmrzOOiwWU6Wi8dmuA
         pW+zqJNt16WKXHL/JLmFpL/+mJIC2VzQeqgZwy/JSjX9s7KxDEdfTWrRdEvv8XDHGe
         0iBz23DyZu3NzblnbHQTGCpPMprnI8UD93kyMSrP1DWd893yDp88aRKXNm5rn6DZ7Y
         VK7nxZkvT2ZHL43rTjvttMmJe+3dB88Tik1rlX3LJHoVawdyrdkv7E9/cO042lmThW
         5pOckEh/YbvKkPJJekCJeLAfatq6cVWyxDqcklK3II92ohr7f/S59sbtT5NuY1kJai
         C/gDukmNuMAUhNS8WwjJ8Tc0a0IV+GU6FQrH9+RV8zXghINRDYo18ePF4AYfLaMRuR
         ne8Wlt+d2DNj1LJqIVp7eMz5lH1GA4RQuN3uvHPbt/TjzrPG1y1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 08/12] builtin/unpack-file: convert to struct object_id
Date:   Mon,  3 Jul 2017 18:55:29 +0000
Message-Id: <20170703185533.51530-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/unpack-file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 73f133419..281ca1db6 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,7 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 
-static char *create_temp_file(unsigned char *sha1)
+static char *create_temp_file(struct object_id *oid)
 {
 	static char path[50];
 	void *buf;
@@ -9,9 +9,9 @@ static char *create_temp_file(unsigned char *sha1)
 	unsigned long size;
 	int fd;
 
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf || type != OBJ_BLOB)
-		die("unable to read blob object %s", sha1_to_hex(sha1));
+		die("unable to read blob object %s", oid_to_hex(oid));
 
 	xsnprintf(path, sizeof(path), ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
@@ -23,15 +23,15 @@ static char *create_temp_file(unsigned char *sha1)
 
 int cmd_unpack_file(int argc, const char **argv, const char *prefix)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage("git unpack-file <sha1>");
-	if (get_sha1(argv[1], sha1))
+	if (get_oid(argv[1], &oid))
 		die("Not a valid object name %s", argv[1]);
 
 	git_config(git_default_config, NULL);
 
-	puts(create_temp_file(sha1));
+	puts(create_temp_file(&oid));
 	return 0;
 }
