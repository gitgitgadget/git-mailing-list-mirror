Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B5B1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeCLC2r (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34426 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932615AbeCLC2p (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B6E6610DF;
        Mon, 12 Mar 2018 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821723;
        bh=MqnbCGQHqIuno3Uk3pzIVZoIdDRLSfQmaLdWqU1N9a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZEgyR4GDrXlxIeL41bm5xDL5DUsJ7YaLNgwLVKMhlgIDbuEB0dH9t2iU73o0KcZp/
         IAKmJMBAQAtAWxha8u54rKq/GQeLX+YP6GcD8rU2wSDf+kHTC9rInB0BKqCxb4Vf6h
         r/Mavx9wGlg7t1weXiXc/5ulLC9ZZZpdaKzJSiX8woHYu05PNmCAUcf2wAfWQ7f6OC
         P0m22COK20W1Wwy2AF1ocWUFIbMLtJhVIDkU3ZipdqzvZkMuhx6PGTf03LERKirSt6
         /jRzz6GjcG+CaXpQb89oDnrIUFfNwlDfUauWD6xkpafc+Q1pJKUkSjtzzoaty6WWel
         mRM7jvIoBdhtZAH2MWC2wcM8nKLu79EUs9dr6DzaV7uU4najKey/melWEnG4IIxXBm
         loT530J0UDGV93/xldUytj0/579ghN46dTVb4nNwIPrWH2l506yYCZGSuLqxbAe3xP
         5f2aSorvZ/Q9F3wDa7TP09lYSZ9w3YrLGGOe1Op/ZxGrla6z8vz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 27/36] builtin/fmt-merge-msg: convert remaining code to object_id
Date:   Mon, 12 Mar 2018 02:27:47 +0000
Message-Id: <20180312022756.483934-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
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
