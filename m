Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB041F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932682AbeDWXkI (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60468 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932665AbeDWXkE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 71FDC6099D;
        Mon, 23 Apr 2018 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526800;
        bh=VllE7CuHfFpy7F8zKYudJL0wSMRJ3A4P64TdaGMikYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HiidAza5faPlSdiYvaz2jVVf3rOtoYfynEBCDpdWj4Yo28XfIbs0k/YUsu1x+2/vO
         y/Ym+p7wYf0LbuZJcRDBwutpjcy3t2yqbbvOJJUtTwY5kMyMx75l/2xOVGm8MlWRUQ
         eikyg+PFEnQfMwcLvM8bwEGkDJu0vO7gIOI1ac+bM58APTSX19JJUFKMbhjcjt1bpt
         ZQvG7TPePIDM3ZK5dKJCP2wiGngqeBxJreBX1XsjC6GpH1woRugMiVeX54QCM/8UZx
         Yn/zpOmZbn310Ukh8broa7O6/BQWwTPNhn1aZaw9Cagh2vcdoLfvVLpuRV5u1L+i2X
         S/5tNjlDizksX9ca5KoeVwKTvdPjBXe5yxaDqXS8WWWeBAfFLtweciCAIyUskOE70v
         UxvzoMFqTgQ6WEF5xvBJy6S2BcxzQTjBOQOpQ2A7xlgsnF/8oxtPwI6GtuDkiiu2cf
         24eQLqtvYICIVg1rvil4kYwwRdK6i5F2M2py/awybxoQQHkORXs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/41] cache: add a function to read an object ID from a buffer
Date:   Mon, 23 Apr 2018 23:39:11 +0000
Message-Id: <20180423233951.276447-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In various places throughout the codebase, we need to read data into a
struct object_id from a pack or other unsigned char buffer.  Add an
inline function that does this based on the current hash algorithm in
use, and use it in several places.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache-tree.c   | 2 +-
 cache.h        | 5 +++++
 resolve-undo.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 6a555f4d43..8c7e1258a4 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -523,7 +523,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	if (0 <= it->entry_count) {
 		if (size < rawsz)
 			goto free_return;
-		memcpy(it->oid.hash, (const unsigned char*)buf, rawsz);
+		oidread(&it->oid, (const unsigned char *)buf);
 		buf += rawsz;
 		size -= rawsz;
 	}
diff --git a/cache.h b/cache.h
index bbaf5c349a..4bca177cf3 100644
--- a/cache.h
+++ b/cache.h
@@ -1008,6 +1008,11 @@ static inline void oidclr(struct object_id *oid)
 	memset(oid->hash, 0, GIT_MAX_RAWSZ);
 }
 
+static inline void oidread(struct object_id *oid, const unsigned char *hash)
+{
+	memcpy(oid->hash, hash, the_hash_algo->rawsz);
+}
+
 
 #define EMPTY_TREE_SHA1_HEX \
 	"4b825dc642cb6eb9a060e54bf8d69288fbee4904"
diff --git a/resolve-undo.c b/resolve-undo.c
index aed95b4b35..fc5b3b83d9 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -90,7 +90,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 				continue;
 			if (size < rawsz)
 				goto error;
-			memcpy(ui->oid[i].hash, (const unsigned char *)data, rawsz);
+			oidread(&ui->oid[i], (const unsigned char *)data);
 			size -= rawsz;
 			data += rawsz;
 		}
