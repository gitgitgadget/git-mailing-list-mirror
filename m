Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83C81F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBYVN2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33990 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751964AbeBYVMy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:54 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 888E960E59;
        Sun, 25 Feb 2018 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593174;
        bh=MqnbCGQHqIuno3Uk3pzIVZoIdDRLSfQmaLdWqU1N9a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tJYwaQLb53nt1jVmGUvSJzU2Y0ReyWM4EAmxz69SMTEkzBLid0bHtdk+zW8ldunUf
         Wm+c5NCJwjyCwWkdxx498QuD1Sv3V7sDeeqx1nPxOwjUykuQfdfBRj2wGNbNjJ6VOR
         7OIJHtw8C6rJwDMhuJJl/z5P/WdbNkXxHd6qusS4PrKK8rpBFB6UHxNzGG5NhHmwea
         34Hj2u6QZIwY72NiQO9Bu0q4gXoC1oArIOUDHzeSQVGc5Y+qHA0ycTSomaFltmj6Vf
         5vYBT4u6ZGMvzy9Mri7xAdZjGzFIhmkqi9wuX/rDPizGXgvDMWrwnFgzvZ6rMi9FZx
         A99qahWhEovAm3oeRpCzDFKNMaWLKfwRo9nJ2BCtnKT5Mg8tiGcLiV1xwB1CM4f8wZ
         2jWBO7wTDiz8ZOuefP7RcBHMpYvNodtXd/x5CRbZmtEwd8YV7XCnbxmLG34EpTFEn9
         EosWaB5Cb6MSezCRokmaL40/PHetsJTmOHHHsWSPEewPClm0hZW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 27/36] builtin/fmt-merge-msg: convert remaining code to object_id
Date:   Sun, 25 Feb 2018 21:12:03 +0000
Message-Id: <20180225211212.477570-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were using the util pointer, which is a pointer to void, as an
unsigned char pointer.  The pointer actually points to a struct
origin_data, which has a struct object_id as its first member, which in
turn has an unsigned char array as its first member, so this was valid.
Since we want to convert this to struct object_id, simply change the
pointer we're using.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fmt-merge-msg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 8e8a15ea4a..0bc0dda99c 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -485,10 +485,10 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 	struct strbuf tagbuf = STRBUF_INIT;
 
 	for (i = 0; i < origins.nr; i++) {
-		unsigned char *sha1 = origins.items[i].util;
+		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
 		unsigned long size, len;
-		char *buf = read_sha1_file(sha1, &type, &size);
+		char *buf = read_sha1_file(oid->hash, &type, &size);
 		struct strbuf sig = STRBUF_INIT;
 
 		if (!buf || type != OBJ_TAG)
