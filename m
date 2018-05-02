Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB8021847
	for <e@80x24.org>; Wed,  2 May 2018 00:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbeEBA2F (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:28:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37660 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753438AbeEBA0n (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A29D060B3B;
        Wed,  2 May 2018 00:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220802;
        bh=O97ovEQfJda5+CtJR0vs5YYmrvr2nG9KVoZooBCE70I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HQnVOA2CT1A7qxBQ9qnIE6slwa5PZHWKZY1ZRWKIbD/DFDtjJTuIJMsIUIyFIpH9D
         C9iIenG8Fqie3Np6VsAfLSARvIXVPp2kvfUX18GEQiMi7anIPhncd5Zn26FJNrejIT
         NT7wfTYGcVZ+7A8bpCsSZs5/i3/DtTrHRaJYS+68dq9fH7w3AeES5+fCrhhfM/kr4R
         Bcrm1hd0pVs70N4e6ZOxQzqIn3ddEV4+39B2ziOKvNfZcVpygPBOTv1G2ZyhqVPRCt
         fnBUs8prBTYSh0cHwWma/fpNx8ucVOfnOE8y2+/IUqfN2II+6erfitMr9CVtLENBMd
         deFNUzobHTozIQc9F0JUlm91ptOlJfb3pAv/4HUDUpxYOhiwNgHbPQJqzZmYhqHgwk
         91tBDsL8zd/M9ti9W0soTf/D39DvjnageZ9FzcGp9AJV2GgRN7bTbyGHcws4fL7LWD
         kzXuPROfoL0sMf7A/+ne3o/FkdtES/84M9gXThtMSvcOJbfwVyk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 21/42] http: eliminate hard-coded constants
Date:   Wed,  2 May 2018 00:25:49 +0000
Message-Id: <20180502002610.915892-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the_hash_algo to find the right size for parsing pack names.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 3034d10b68..312a5e1833 100644
--- a/http.c
+++ b/http.c
@@ -2047,7 +2047,8 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 	int ret = 0, i = 0;
 	char *url, *data;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char sha1[20];
+	unsigned char hash[GIT_MAX_RAWSZ];
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	end_url_with_slash(&buf, base_url);
 	strbuf_addstr(&buf, "objects/info/packs");
@@ -2063,13 +2064,13 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 		switch (data[i]) {
 		case 'P':
 			i++;
-			if (i + 52 <= buf.len &&
+			if (i + hexsz + 12 <= buf.len &&
 			    starts_with(data + i, " pack-") &&
-			    starts_with(data + i + 46, ".pack\n")) {
-				get_sha1_hex(data + i + 6, sha1);
-				fetch_and_setup_pack_index(packs_head, sha1,
+			    starts_with(data + i + hexsz + 6, ".pack\n")) {
+				get_sha1_hex(data + i + 6, hash);
+				fetch_and_setup_pack_index(packs_head, hash,
 						      base_url);
-				i += 51;
+				i += hexsz + 11;
 				break;
 			}
 		default:
