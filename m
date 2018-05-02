Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0992421847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeEBA1I (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37660 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753420AbeEBA0r (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C23C460B38;
        Wed,  2 May 2018 00:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220806;
        bh=+DHSPe8aAjf5H+Z0Ok+dMGiNcKg8VK5H3tE+gejeDMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=06rbRGpVHOJzg60XZRXg5W3fMnGxsAj5MXEi16psHbvjtikYMdnIRxUkNncPsKvp+
         Yyzk0lVMYVTc/CEJsfRHIPoBqLw2FN+6Q78mXMFPjvsP99qTjRp1LeZcnb1ke1z/4v
         I8aWD4OCgo5aG1yMoquhgA+aUjiOgMvgewunaHJAIyJZBE1eqPT3fXwaLVfQr4qC6S
         iUICCsNXwfBm2UYX4OntVf81XNfHocGadOwHS4TZSVmqR0Gr2BJgvNxr3jcJv+tpOT
         /w8FxU7NO4Ua9f1+lJ0CbwiMl5WcD0BJkWXHWwcz8VVwEw74MCWLODwrEMuNQlkP4D
         kc1e03DsW7zpNugUisPLv/+TXDXa5OvD1IFfPJxqnpnvPryEdR7M26qK208RsBv7aE
         EJEGgC5qiPZvqh3bfvXey7eMkoFRuaVINEnZTs5IcAitNXFQ5sdJLeUNSysyEP+Saz
         MMIYfnWC3186X5oZEjTf7lQrogMGrEoign/z2FCs7Uf1qHgpb2R
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 25/42] builtin/receive-pack: avoid hard-coded constants for push certs
Date:   Wed,  2 May 2018 00:25:53 +0000
Message-Id: <20180502002610.915892-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ macros instead of hard-coding
the constants 20 and 40.  Switch one use of 20 with a format specifier
for a hex value to use the hex constant instead, as the original appears
to have been a typo.

At this point, avoid converting the hard-coded use of SHA-1 to use
the_hash_algo.  SHA-1, even if not collision resistant, is secure in the
context in which it is used here, and the hash algorithm of the repo
need not match what is used here.  When we adopt a new hash algorithm,
we can simply adopt the new algorithm wholesale here, as the nonce is
opaque and its length and validity are entirely controlled by the
server.  Consequently, defer updating this code until that point.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4b68a28e92..6501d6b6cf 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -454,21 +454,21 @@ static void hmac_sha1(unsigned char *out,
 	/* RFC 2104 2. (6) & (7) */
 	git_SHA1_Init(&ctx);
 	git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
-	git_SHA1_Update(&ctx, out, 20);
+	git_SHA1_Update(&ctx, out, GIT_SHA1_RAWSZ);
 	git_SHA1_Final(out, &ctx);
 }
 
 static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 {
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 
 	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
 	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));;
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, 20, sha1_to_hex(sha1));
+	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, GIT_SHA1_HEXSZ, sha1_to_hex(sha1));
 	return strbuf_detach(&buf, NULL);
 }
 
