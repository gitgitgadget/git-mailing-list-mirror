Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CFE2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbdGMXtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:49:41 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59714 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752849AbdGMXth (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CFC4D280B5;
        Thu, 13 Jul 2017 23:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989775;
        bh=Wr9RDXqXvSXxj0+B9b5DlaL0u1PoY3rRPZJ4JnBcTTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfxSCB8s0cQ88fhvx81V1c54YT/p7Vvb6YvvxYPv0nPUkJiBol1rmoUFS9v0APsEh
         rRSl8etai+89DDTuUY7Vqr07k6GHaVwiLDQwb2Dy0MXLIidUfSkRJcrlFjxQdlqVk1
         6UXnP+7u+pgtbEZJLNGbiQeto7tohRUzMVSlW8OrmUTmweuqElmEkhEkcwFxjM8dFr
         d7+zsaEvprFh2EA9MxGp9Se52LySUHviy+pZDU+c2DOAE/cdE0WznrotWv4h6DC5RC
         EqxJ8MOnkYRxy+9KjDitVw6vtKk5uxwWtx8+ScahBRONsxxZBCOCVzd1RykiLTbTju
         w/+dyuJWu55J02Mm8i02NSccZFPoFqWxiMCNfXv82gUDX7U49B0KxAkB5zOetftCyz
         +ex9pUsMVDQpDre1bAlHlKJaTMsInCvraq1F4+dnh1McooeGUHpzm8dYaPFAxmUwjU
         3B1Fl0yAAv30y+nAGU6YgXxG2ugwg2X+7Pjxr2EhAvupK4amqCc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 08/13] builtin/unpack-file: convert to struct object_id
Date:   Thu, 13 Jul 2017 23:49:25 +0000
Message-Id: <20170713234930.949612-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/unpack-file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 73f1334191..281ca1db6c 100644
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
