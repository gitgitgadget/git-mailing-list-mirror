Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B80221847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeEBA1K (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37824 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753389AbeEBA07 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5070860B38;
        Wed,  2 May 2018 00:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220817;
        bh=NeHhEIVarEF8elo5Gs2hdL/4ZqNWbvWrwr2x+W6iWoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Z/5C/uHV3GwHvUVP3fdLcy9kcMv9almXjX6ERTwC5gXmO5g/gTBNmuUC2IWXFtvej
         Z/QK4GgqPYAI5KixtH3SB4ySq34+N6TecTVFxRaxFDJikAgH0ILTX3g6B7uPJm2ZdQ
         nPnILg2ouEOnz+VEBx9oD0mjTSJ41DRAtCIXq/1efpN0XSuSAn2o/UPzHXGi7DsC4i
         zl2xEWQi3b0dR/Yu0yD2u/SMhCsnch0kD2QkMhUbXAhTatrl7FWqcNZjoNVZUpS74H
         Yz3Nrtlok4IrCCP03ciEyEM98LSXrSoq4mjpRAV9DSJ9+ctHJbef0E75ORuflrYF/b
         gLqXwg52yJUaN1TIhfK3hEiB7WxD0e76q/zT/Qd4L1RPXblDRlLJAVrAjpNWxaZmOd
         gVDsnPptuvEUHmZekfnZN/oBZyuRfkH+sJwOHg43mrWoGHc+Kokh6dumV7hmxe8qyD
         kw3HoNIb7wu6i33ygpczzQ+Nm3zkdcE4VvDz9IHL1PMJ1fxFw3O
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 35/42] sha1_file: convert cached object code to struct object_id
Date:   Wed,  2 May 2018 00:26:03 +0000
Message-Id: <20180502002610.915892-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the code that looks up cached objects to use struct object_id.
Adjust the lookup for empty trees to use the_hash_algo.  Note that we
don't need to be concerned about the hard-coded object ID in the
empty_tree object since we never use it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-file.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 11598b43eb..4acbf8ee08 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -119,7 +119,7 @@ const char *empty_blob_oid_hex(void)
  * application).
  */
 static struct cached_object {
-	unsigned char sha1[20];
+	struct object_id oid;
 	enum object_type type;
 	void *buf;
 	unsigned long size;
@@ -127,22 +127,22 @@ static struct cached_object {
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
-	EMPTY_TREE_SHA1_BIN_LITERAL,
+	{ EMPTY_TREE_SHA1_BIN_LITERAL },
 	OBJ_TREE,
 	"",
 	0
 };
 
-static struct cached_object *find_cached_object(const unsigned char *sha1)
+static struct cached_object *find_cached_object(const struct object_id *oid)
 {
 	int i;
 	struct cached_object *co = cached_objects;
 
 	for (i = 0; i < cached_object_nr; i++, co++) {
-		if (!hashcmp(co->sha1, sha1))
+		if (!oidcmp(&co->oid, oid))
 			return co;
 	}
-	if (!hashcmp(sha1, empty_tree.sha1))
+	if (!oidcmp(oid, the_hash_algo->empty_tree))
 		return &empty_tree;
 	return NULL;
 }
@@ -1260,7 +1260,7 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 		oi = &blank_oi;
 
 	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
-		struct cached_object *co = find_cached_object(real->hash);
+		struct cached_object *co = find_cached_object(real);
 		if (co) {
 			if (oi->typep)
 				*(oi->typep) = co->type;
@@ -1369,7 +1369,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	struct cached_object *co;
 
 	hash_object_file(buf, len, type_name(type), oid);
-	if (has_sha1_file(oid->hash) || find_cached_object(oid->hash))
+	if (has_sha1_file(oid->hash) || find_cached_object(oid))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
@@ -1377,7 +1377,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	co->type = type;
 	co->buf = xmalloc(len);
 	memcpy(co->buf, buf, len);
-	hashcpy(co->sha1, oid->hash);
+	oidcpy(&co->oid, oid);
 	return 0;
 }
 
