Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD6A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeGPBxS (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58948 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbeGPBxS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 298C46077A;
        Mon, 16 Jul 2018 01:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704500;
        bh=Dh07yAP0S1WYJ5syUYfyivyovR7vMSPjpKYViBtKKXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hqPhVzcsoq8sBSd/r9CVdU9yzLnKt8M5TDOoqrXdf4OPZmwn9FeWp/df+5U6Hrzd7
         aG8pzPXrjK/UkWsAKi2dfLqmHYSY79X6voTcTIST/ebx1AUAFpmbwLjrndIc9NTZJW
         ihZIFypVnRY9BeCw20DlvYPsWKgPtg5uJU9In8i06o4ixxmCfTiqc6ZyQ3jfngNbQD
         tpow+3A7s0A9sMSy8qspExIKIi1Nuj3aXuXAUMDTiGJm4NMw6mMPtxe8gXS7yAwEBC
         RgR2biMhmygSOafHP12FYLLdzm31q7r1W+qErznWoNu9oXuRR7OfB5vc/vcIl2Lw23
         41ighu4E+JGVzAZQJq8kMJtl1D1lCdG6lEr5fW99L9F1BlT5JtC75GSe9GDev0A9XT
         7pPx7vE52H+ci9QxqW68r0ZYxO1lMFTsZ1rG+EEe4hwjuTyuC0vw+TlxcUc0Wm0ja9
         zqsHasInu6v1mgzmfMq9EZl+vLSRgVjcjbv8czXOLQiXLjpRBaw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 03/16] hex: switch to using the_hash_algo
Date:   Mon, 16 Jul 2018 01:27:55 +0000
Message-Id: <20180716012808.961328-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the GIT_SHA1_* constants, switch to using the_hash_algo
to convert object IDs to and from hex format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hex.c b/hex.c
index 8df2d63728..10af1a29e8 100644
--- a/hex.c
+++ b/hex.c
@@ -50,7 +50,7 @@ int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
 int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
-	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
+	for (i = 0; i < the_hash_algo->rawsz; i++) {
 		int val = hex2chr(hex);
 		if (val < 0)
 			return -1;
@@ -69,7 +69,7 @@ int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
 {
 	int ret = get_oid_hex(hex, oid);
 	if (!ret)
-		*end = hex + GIT_SHA1_HEXSZ;
+		*end = hex + the_hash_algo->hexsz;
 	return ret;
 }
 
@@ -79,7 +79,7 @@ char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
 	char *buf = buffer;
 	int i;
 
-	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
+	for (i = 0; i < the_hash_algo->rawsz; i++) {
 		unsigned int val = *sha1++;
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
