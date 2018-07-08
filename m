Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48CD41F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeGHXhZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54326 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933084AbeGHXg4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CE5976073F;
        Sun,  8 Jul 2018 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093016;
        bh=1f5XEZegPsdoKDv51stikjpS8jjzcl4+ST/yl36buOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AVpiBE89tPn9wwtm0qEZO4+0Jh25KxzeoDZWMZOLsIqjH4N4o8NFqIklihOzuwJgN
         ThHfPhww0Wzd4env5Wu/0F7H6+qoXC6WgvJ2h4tZUKX87rupPC1aVnUxAfNjP04Bqq
         lweTIelnhAx+5HOY7utR7zsOug3pNs+R43okFatSGHH2kOlDwUFnm7oj1LZi52GQa2
         SGWUMxVB63gI41xBWR5pC8zyXgtHI72DBtesh1dlNvCYxyxnJDIVtWxkWQ5lkGQ7co
         F7qP+JDa+WlxF5rIRDygjeO2TnRG9tdx3Av5uy0WJXiyTDE9FBsxX9InPP6kbC5OgK
         FJuyGyrpH+b0qPoqUTSX7pJxoZK291MZu4lZmWc8v7gOQyeBI9/Wcezgv67aYa5IoB
         eJldgjwYC01NcGFPeSd7WJnJ0FA54FZf6cucRIENwC6bVfOTeEqIglJnyU7ka3vnJS
         v84f2YBBCIsrwCle38d8OydEfbgAyTt2ghOH3py/gaZVhg0K0NA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/17] builtin/update-index: convert to using the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:30 +0000
Message-Id: <20180708233638.520172-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch from using GIT_SHA1_HEXSZ to the_hash_algo to make the parsing of
the index information hash independent.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/update-index.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a8709a26ec..031cef5229 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -492,6 +492,7 @@ static void update_one(const char *path)
 
 static void read_index_info(int nul_term_line)
 {
+	const int hexsz = the_hash_algo->hexsz;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf uq = STRBUF_INIT;
 	strbuf_getline_fn getline_fn;
@@ -529,7 +530,7 @@ static void read_index_info(int nul_term_line)
 		mode = ul;
 
 		tab = strchr(ptr, '\t');
-		if (!tab || tab - ptr < GIT_SHA1_HEXSZ + 1)
+		if (!tab || tab - ptr < hexsz + 1)
 			goto bad_line;
 
 		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
@@ -542,8 +543,8 @@ static void read_index_info(int nul_term_line)
 			ptr = tab + 1; /* point at the head of path */
 		}
 
-		if (get_oid_hex(tab - GIT_SHA1_HEXSZ, &oid) ||
-			tab[-(GIT_SHA1_HEXSZ + 1)] != ' ')
+		if (get_oid_hex(tab - hexsz, &oid) ||
+			tab[-(hexsz + 1)] != ' ')
 			goto bad_line;
 
 		path_name = ptr;
@@ -571,7 +572,7 @@ static void read_index_info(int nul_term_line)
 			 * ptr[-1] points at tab,
 			 * ptr[-41] is at the beginning of sha1
 			 */
-			ptr[-(GIT_SHA1_HEXSZ + 2)] = ptr[-1] = 0;
+			ptr[-(hexsz + 2)] = ptr[-1] = 0;
 			if (add_cacheinfo(mode, &oid, path_name, stage))
 				die("git update-index: unable to update %s",
 				    path_name);
