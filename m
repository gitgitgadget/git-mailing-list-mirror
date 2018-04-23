Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CB11F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeDWXkl (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60610 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932731AbeDWXk2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AC34360B1A;
        Mon, 23 Apr 2018 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526828;
        bh=GNP3rWqMWPl+KLOQP0HDGIXtKJZtTr9KO+folzQo2BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HtUr6q0L9qzss6weFylBhaFvsm4X/G0atuno4KmB49p8ry8e02yZvENCQspoB8aIH
         PABDSawqSzNkDzVhb50jfooMHhBvFqvajrr9Z2xTXinzsHTLm5t1zJzX2NYApK1CJw
         is7AyXpU7oDK2TgjRRSqtpgoyg+K/+73p5jXMs9qg4BJpOag5qT8VbBX2zQy0pd9kz
         QdxezSGMx+FfvSODqVBz7/UI/1WeXDRuSY7zM02L4+JExdBFLvz/nezZ3agdX8Hcyf
         dfF0aa2lfCzVy5rBShKXtmXrJcqvNC2RfRCpe35U9PKoNU5W94cVbeR2kybfUupIBK
         Ly+C6Rv/Ee/5lc0KoCocMdFo8ObxQHdMVgT+rPZFl9NYUJkud4NhU4MkBVNyQCizfp
         aAv0XZ4PneqY889eNIuZyStHDhVL5YdH7fGtnat8UE2kFUtpp/tZPZ3GR6oGFUae1Z
         MzxVwKkCYnIxjturwwCaLJDEC9XZGbiiQmUlGwYTgxzAfeFRego
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 21/41] http: eliminate hard-coded constants
Date:   Mon, 23 Apr 2018 23:39:31 +0000
Message-Id: <20180423233951.276447-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the_hash_algo to find the right size for parsing pack names.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 3034d10b68..ec70676748 100644
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
@@ -2063,11 +2064,11 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
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
 				i += 51;
 				break;
