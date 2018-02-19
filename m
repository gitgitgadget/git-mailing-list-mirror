Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497891F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932305AbeBSXAD (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:00:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33438 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932285AbeBSW77 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1CA9F60D8D;
        Mon, 19 Feb 2018 22:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081198;
        bh=FVDPo28uGaDPLoIaKCyup4xi+a6Ff07Q4saUgposbpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nJXIABTvWf8g+tAtDJKvfHLxNf5wa0i/vwdLV+9H+yWXh03DcXRmIkbxEHGgb61Kl
         x+/6ajdlL1VhMqb8bfcnfVNH4+9kLxGr7W2m1jlW3/XOyAyyQ6oR2r0pUymyx6OXX0
         zdl6h88cB/Se3oJDRvLQ+LXUSH9mqPcIZM1PQieu2MOlXwIGi3Rc8kv5PEAc06XTrb
         HIR0JeoZ3WOoWwJWz2UJpKOj4gFv55m+yDfQq42c8SWD8t4tZxbf21zvL74PiKgN+M
         yFXhjW8sEbeBHoRqHUIsLzEFFLDMwqlFUUVeuqUAw6QzA2B9a+kY18JoI2eIHkZJzE
         wFWieMHfgAFTEhetuSXouIjtc1tj5CwR26gY+YV2E/WsE+P3WHJZFu7p8wKdlkhIfr
         PuOTNjpbAbirl46jeNYiQ6HKepYu7r7COPNQd3F7hvHX9bU+Rm/mZjsdmLtFbdLdkn
         oMm1UnCxYlSczD3MS4jQyvQgP9EzXmCZWnIzna+zp1Thdzbj189
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 24/36] packfile: convert unpack_entry to struct object_id
Date:   Mon, 19 Feb 2018 22:59:15 +0000
Message-Id: <20180219225927.386065-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert unpack_entry and read_object to use struct object_id.
---
 packfile.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index bfa6438b4e..ed7b342ebf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1452,7 +1452,7 @@ struct unpack_entry_stack_ent {
 	unsigned long size;
 };
 
-static void *read_object(const unsigned char *sha1, enum object_type *type,
+static void *read_object(const struct object_id *oid, enum object_type *type,
 			 unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1461,7 +1461,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (sha1_object_info_extended(sha1, &oi, 0) < 0)
+	if (sha1_object_info_extended(oid->hash, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1501,11 +1501,11 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
 			off_t len = revidx[1].offset - obj_offset;
 			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
-				const unsigned char *sha1 =
-					nth_packed_object_sha1(p, revidx->nr);
+				struct object_id oid;
+				nth_packed_object_oid(&oid, p, revidx->nr);
 				error("bad packed object CRC for %s",
-				      sha1_to_hex(sha1));
-				mark_bad_packed_object(p, sha1);
+				      oid_to_hex(&oid));
+				mark_bad_packed_object(p, oid.hash);
 				data = NULL;
 				goto out;
 			}
@@ -1588,16 +1588,16 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 			 * of a corrupted pack, and is better than failing outright.
 			 */
 			struct revindex_entry *revidx;
-			const unsigned char *base_sha1;
+			struct object_id base_oid;
 			revidx = find_pack_revindex(p, obj_offset);
 			if (revidx) {
-				base_sha1 = nth_packed_object_sha1(p, revidx->nr);
+				nth_packed_object_oid(&base_oid, p, revidx->nr);
 				error("failed to read delta base object %s"
 				      " at offset %"PRIuMAX" from %s",
-				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
+				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
 				      p->pack_name);
-				mark_bad_packed_object(p, base_sha1);
-				base = read_object(base_sha1, &type, &base_size);
+				mark_bad_packed_object(p, base_oid.hash);
+				base = read_object(&base_oid, &type, &base_size);
 				external_base = base;
 			}
 		}
