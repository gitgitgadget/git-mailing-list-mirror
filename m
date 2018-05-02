Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEB421847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeEBA0Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751925AbeEBA0V (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 14E496046C;
        Wed,  2 May 2018 00:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220780;
        bh=5ZAHH/0qwwkj2B1nXWi06LBiIwXQ1eFRQ4dxq31EL7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kxZwGwzx8UWoBHWjwA+FzpFvIVK8dq/nGIwmtGPMPTSwTrOz5Lo8h0GrZv/BzNnaq
         IEm4KJ2qe0oMp4sHncmaRQX88len4PS8nDZi2+omnvCXEP2FdH3TG6J7e5xR5tf1Qs
         AeGzIH/1LMz0nZrpEGWSq938YnIe/ADDP1nvFsih9aKZy/wp0JJ+BwHQF2WnROkcc+
         rludHyYL3Z33cbNLnmRy/o2iEUzZFulxbGyBGuarBe6T6DNXRoGumz3PQX4xDEQdlc
         Zwk7r9vlKabwuWxWwhNT3oruyKG59SdP8dLHfGZZY7KorLoruDJPIrLeB4l97WNb90
         zCB0baF9Vt6ipovgGPBuVUxOE3x8cCaDGdjL5oX8BBuFfTiQPcE9d/2Q6bEnQmDEo4
         fIlwMsRuqGR7h9LLrLv9PxRIN/YHqUEBWaq3ATbJXuzqvQhE9KWCq4VOi0h9gBZnm/
         8h4lNExF0XrNOS5mKUDPo1gk9bihRaaLSH3fTJ8pl/+U8hrWpPi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 01/42] cache: add a function to read an object ID from a buffer
Date:   Wed,  2 May 2018 00:25:29 +0000
Message-Id: <20180502002610.915892-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
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
index 77b7acebb6..af6693f352 100644
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
