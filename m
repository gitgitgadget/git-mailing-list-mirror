Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7098C1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBLBXe (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbfBLBX3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:29 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E44360898;
        Tue, 12 Feb 2019 01:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934607;
        bh=41e+mPmFDq+zgs24fej382Kgg/rdvHZ54iDFuzriLR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KtBjUpPjF8QfTKtYn8hZ7eVRquefVC/NsoFnwB7BN9Tr64A+ChtmQKCVX2WDQd4Ne
         +rIoImGrWGAXPQKDm3NrwNe5jggSsbh5Pw9ZXvwsyp9sKwucsIfq67+LmsitkxOWpq
         Ewz/dzJ8J1Tcru+TxPLqsUuooI4mgsV8kdnz6YGzM3mTzKecXIfyLriyD79xkAq7pn
         T9RARuGkBmb4TkLZs5hGeQ/dYNVGOBcOy8qN2S8w1j4Db76JkquM7EUZf8cy15bDbO
         L9r+sYC6zoaOh8izv/ooUZOtxj6STfkAyOJRDun7L4sJ/LX4Tt+ItGISWK0JnsIbJ2
         deLMFTZhwEE66+TlP4lHjhHxyx4JJZIcIYNz71iFh4OWt4kdvvH/hTJ5oasef8bRxt
         +UYY2/t+Z7HZ7lZ4otJhH0MfQrSZc+YlGlo/g4hzyNqOrrOGsMRv+LPPKxaqySEr6b
         2DIxR+y0h40zRs2j9YJXiXfdKEXCSSQNg5iJmm/G5O51JTtSLh1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 13/31] fast-import: replace sha1_to_hex
Date:   Tue, 12 Feb 2019 01:22:38 +0000
Message-Id: <20190212012256.1005924-14-sandals@crustytoothpaste.net>
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

Replace the uses of sha1_to_hex in this function with hash_to_hex to
allow the use of SHA-256 as well.  Rename a variable since it is no
longer limited to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index eba8c8c919..3d6e2bfa4d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2945,7 +2945,7 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 	return e;
 }
 
-static void print_ls(int mode, const unsigned char *sha1, const char *path)
+static void print_ls(int mode, const unsigned char *hash, const char *path)
 {
 	static struct strbuf line = STRBUF_INIT;
 
@@ -2965,7 +2965,7 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 		/* mode SP type SP object_name TAB path LF */
 		strbuf_reset(&line);
 		strbuf_addf(&line, "%06o %s %s\t",
-				mode & ~NO_DELTA, type, sha1_to_hex(sha1));
+				mode & ~NO_DELTA, type, hash_to_hex(hash));
 		quote_c_style(path, &line, NULL, 0);
 		strbuf_addch(&line, '\n');
 	}
