Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBE51F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeBYVM4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33982 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751817AbeBYVMu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:50 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9D80160E59;
        Sun, 25 Feb 2018 21:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593169;
        bh=Kv4Wg04z3kdhCq1T65QkhWJj8U9NF3wOfO/1+ErKJIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wGTtZ2Vn0C0pD+jpIHV0StTFb+JKTTz4T1ymip+P1Ra4gV3ojSoBuJM/moZ7AezOq
         uFhtzMe8HovcsBigk1QLkVg1OCFyw/I6qPTT7j1DlouW8+vfFeHHmhk2i5/rDivvX9
         l+OXS2c0CZMlwOeJJnnGqHvsrBeYeMLReWfiS1OwlIQAPNBeTwrutRUpq3INZu5J0o
         uLDZf2EqvSF/p8IsmJPSHpRCHxZUvz0euE2XACUuUyMM+7sYub2isBRAFn3yA+z84W
         0rbnETmqcLEnTfPyLyQqZEpT25oEZpV0AWtsd6o9xqFvCcCRGgZsb2SFPSwlIMEk9D
         86GZ7Ys/7dQlW98JjPXe1jjcLrXoPY/kNH+hH+MFZPo1fJBelKKUlgo/MUqLlT96fy
         7nZ1fOTqHwcvXckzbqpTGp4YEBEI54rJQM8v28Rq0+/oExwf32j5VfOFBMvD7SbFfR
         i3vfG6tBetiJMZ46dtTbBm7f7lwiCliMCe/Jg0QjhFCkYhG73cb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 23/36] sha1_file: convert retry_bad_packed_offset to struct object_id
Date:   Sun, 25 Feb 2018 21:11:59 +0000
Message-Id: <20180225211212.477570-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7dbe8739d1..954e1fca11 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1095,13 +1095,13 @@ static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
-	const unsigned char *sha1;
+	struct object_id oid;
 	revidx = find_pack_revindex(p, obj_offset);
 	if (!revidx)
 		return OBJ_BAD;
-	sha1 = nth_packed_object_sha1(p, revidx->nr);
-	mark_bad_packed_object(p, sha1);
-	type = sha1_object_info(sha1, NULL);
+	nth_packed_object_oid(&oid, p, revidx->nr);
+	mark_bad_packed_object(p, oid.hash);
+	type = sha1_object_info(oid.hash, NULL);
 	if (type <= OBJ_NONE)
 		return OBJ_BAD;
 	return type;
