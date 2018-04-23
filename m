Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9681F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeDWXkz (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60722 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932780AbeDWXko (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3BB9F60CF1;
        Mon, 23 Apr 2018 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526842;
        bh=yDs8MQW6egNUwm662FX63DH13bfZboM12ojR3w4f1/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GnFry2q3X8Dkkk+J7gAOhnc7z2dnjZPZQSU6pi3P8Ir+cGbHTOnO5u5cI3CLgSKMT
         vFRnihQTGFwtUu3kk82OCrzItCNckETk5f1P3YJnS82h5H5NKGawpaAvWZBaxF4FPC
         pmeA1jmXGlZ1NYgi9gD4nSYP6WjSueJOejneYb8e17/5bp0GI1B3sB9bSVKSoBSjso
         WvLy9YtZ+ou/Z9hM4vTDi9dcJyRWPj3gnTlxvDOIecbaMd7IseJUIRvE74FYq9D83u
         iGve+cL6XA6H+xwnO7jvJ29UA619n8facOJAEWngunZBS/Lw9SxAqsdASbP/q0NnAe
         m1Gt2WqH0xJbtmpeLCVO51Zl/JjtKVzbbi5QBUynQaMYeNsu6GOJcVBr6eyMEG7e5k
         LZ6i5TrtSMudO88JwtVwdsoeeqlWD/xeH49M6ai+SgCu2cY+IJRZKkqc/sf8FkNgiq
         FuknuxzO/tKbOsObLAiHggRiN9ITAAp8DECAEdxL5BHyYOt5a63
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 34/41] sha1_file: convert cached object code to struct object_id
Date:   Mon, 23 Apr 2018 23:39:44 +0000
Message-Id: <20180423233951.276447-35-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
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
 sha1_file.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4328c61285..11c840f89c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -107,7 +107,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
  * application).
  */
 static struct cached_object {
-	unsigned char sha1[20];
+	struct object_id oid;
 	enum object_type type;
 	void *buf;
 	unsigned long size;
@@ -115,22 +115,22 @@ static struct cached_object {
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
@@ -1248,7 +1248,7 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 		oi = &blank_oi;
 
 	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
-		struct cached_object *co = find_cached_object(real->hash);
+		struct cached_object *co = find_cached_object(real);
 		if (co) {
 			if (oi->typep)
 				*(oi->typep) = co->type;
@@ -1357,7 +1357,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	struct cached_object *co;
 
 	hash_object_file(buf, len, type_name(type), oid);
-	if (has_sha1_file(oid->hash) || find_cached_object(oid->hash))
+	if (has_sha1_file(oid->hash) || find_cached_object(oid))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
@@ -1365,7 +1365,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	co->type = type;
 	co->buf = xmalloc(len);
 	memcpy(co->buf, buf, len);
-	hashcpy(co->sha1, oid->hash);
+	oidcpy(&co->oid, oid);
 	return 0;
 }
 
