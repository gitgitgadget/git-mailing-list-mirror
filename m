Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B1F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfBLBX4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34346 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfBLBXl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:41 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C21B960E5C;
        Tue, 12 Feb 2019 01:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934620;
        bh=ziH3vD+j52i23ChYgEf+ntbHm11sJbqsLbaTMyUMFBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cYYbuhPoe4xBj9O1OAZrRx8LGRdVaB3lX25FihcVQ1VyNOxGfZdLWq6nXIxspzmw3
         Cdxs9UcqpW8vJvmbzTHQeC9N8XdsxReHJ9miG+mGQY6QK2JktdHICDfFQoM3JKILhn
         8ou/4NJcwlA/HvURNzrWH3g129pKxq0xlLFbzEHDAmvTHVeNo37JDBquLLAhY4Eifn
         K4G1WWqHh76ckzo3Cg3agcj5ottKZ1YPE3ROQsJ5YBn95+lx8U3bZ9wFX/khDc8idb
         Hc9Uw/IniTAZ/qqUFGMl9V4Ro0+cerOuaE4xCIzOU1VnE4T36MyzaDhyZJUPROHaWu
         xwmJfX8KzI4C9yrcLbEE8DwH18y8U+NQWnizP5LMSl+9zieq4Ym0SR/T6YmGNmVAJv
         Xjn5YnIOoLbMzfjcYuz+f6BEeDliWHCbf/DIw9DHroWhq9C37owNd0LRLFy8yapdLs
         Bka5vKskRoYeqOUToZv6Ij7sq3lfR48haywwo2L5/5xrsEJccO1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 24/31] archive-tar: make hash size independent
Date:   Tue, 12 Feb 2019 01:22:49 +0000
Message-Id: <20190212012256.1005924-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the tar generation code hash size independent by using
the_hash_algo.  Make the tar parsing code compute the header value based
on the hash algorithm in use. Update a variable name and switch to
hash_to_hex.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-tar.c               |  7 ++++---
 builtin/get-tar-commit-id.c | 11 +++++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 4aabd566fb..a5ba55c11e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -326,14 +326,15 @@ static int write_tar_entry(struct archiver_args *args,
 
 static void write_global_extended_header(struct archiver_args *args)
 {
-	const unsigned char *sha1 = args->commit_sha1;
+	const unsigned char *hash = args->commit_sha1;
 	struct strbuf ext_header = STRBUF_INIT;
 	struct ustar_header header;
 	unsigned int mode;
 
-	if (sha1)
+	if (hash)
 		strbuf_append_ext_header(&ext_header, "comment",
-					 sha1_to_hex(sha1), 40);
+					 hash_to_hex(hash),
+					 the_hash_algo->hexsz);
 	if (args->time > USTAR_MAX_MTIME) {
 		strbuf_append_ext_header_uint(&ext_header, "mtime",
 					      args->time);
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 2706fcfaf2..2760549e91 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "tar.h"
 #include "builtin.h"
+#include "strbuf.h"
 #include "quote.h"
 
 static const char builtin_get_tar_commit_id_usage[] =
@@ -21,6 +22,8 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	char *content = buffer + RECORDSIZE;
 	const char *comment;
 	ssize_t n;
+	char *hdrprefix;
+	int ret;
 
 	if (argc != 1)
 		usage(builtin_get_tar_commit_id_usage);
@@ -32,10 +35,14 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 		die_errno("git get-tar-commit-id: EOF before reading tar header");
 	if (header->typeflag[0] != 'g')
 		return 1;
-	if (!skip_prefix(content, "52 comment=", &comment))
+
+	hdrprefix = xstrfmt("%zu comment=", the_hash_algo->hexsz + strlen(" comment=") + 2 + 1);
+	ret = skip_prefix(content, hdrprefix, &comment);
+	free(hdrprefix);
+	if (!ret)
 		return 1;
 
-	if (write_in_full(1, comment, 41) < 0)
+	if (write_in_full(1, comment, the_hash_algo->hexsz + 1) < 0)
 		die_errno("git get-tar-commit-id: write error");
 
 	return 0;
