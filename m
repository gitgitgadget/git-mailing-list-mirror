Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791AD1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932285AbeBSXAy (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:00:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33462 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932301AbeBSXAD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 18:00:03 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8CB8761373;
        Mon, 19 Feb 2018 23:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081202;
        bh=MqnbCGQHqIuno3Uk3pzIVZoIdDRLSfQmaLdWqU1N9a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TWgKUrow9H8eBpfytnCSoNmknjg0Ufj0x998wRb60HWsjV4/IO9fy0GndaNFVhH4o
         2g2xJVUKLPJQF/ecdzo/mLvplwSM6O5vNGeTlFrUfueluLw2DlW3VP2qlIdKROMiK0
         IUFRb3O+0v2sq5NrcG8M86g7hU00R9pXBcIJFF/kM7Wj5s6PQl43+CBRlSgGuknfxO
         2abiVUNOMB2HAVdK2uTNQ5mDCawDGKa3OcMMO0o3l55/OvuG5EwykN+zqgqPlmAaBj
         pDkzPMgp+8RsiDuEjaakgK6ZgP+lKQQAleWAfGaRbnvclYkvvb6mUcDWkmmjGtlE/H
         tt2CbwLv9Ni7gDuOfezGNjiJvPPnupvfK9zcgr5dBf1EmqDa+5I0epZNDzcbg9tGK1
         lM4/ADl84IrmXIBavJnzvZ2TUUb7dsbXX1vxv7b+BtWwdrj1O8Vs4hsfc1YOVwYydt
         T4KwMWxII52tmJdbqt6tysdWBHThQSW/dZoUE3BNw9N/S/0exj9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 27/36] builtin/fmt-merge-msg: convert remaining code to object_id
Date:   Mon, 19 Feb 2018 22:59:18 +0000
Message-Id: <20180219225927.386065-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
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
