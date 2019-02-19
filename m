Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A661F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfBSAFo (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:44 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34592 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732132AbfBSAFl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:41 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B284460733;
        Tue, 19 Feb 2019 00:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534740;
        bh=0VSFTKXt9Lnmv66qiQXTpzWoqzRxoIWldncO9AZh2jY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Xs5X8Qmdo7ajKMpE6iMwHqEaumr8NmtPcHONiy+8TpDF0FVrYFCB3/oHgYrUbmTd4
         HRkdnFc6ZalexHMPWruGLhoKqi0pRHhU4DDj0+DRXC1CHASZaL/dlDMs0iSqCm1/jW
         EjrNA4FiVz6W6PNIXC6uitlxNo5aBTfZPI6hJXmPqF1jumr27slGJL4dFRkfpfexYp
         XhhMDzCJNb7wtMN8VciAWyCWi5uLZA7oTUeRYtJvBDLb26AXlR+x1Arwd+NakjwWcO
         okrX6grJnsji7uEf3830bXwnp+JSwV1Rs4dNOqCtivU0XgG3BANEoMyf2wK6T63nIO
         qhmulPLxl7Qgy48m5av0yA9SUMIalHxCsDG6hDBiEkr0ryLhRUbjdznyJehjqHwWz9
         OQtQ1pMLaM7GywnMb0uEgDRNbvVvirrQJngQffr8jIzL7jGEY9ZdIIouvCSlr9QsgF
         gl5XL1sajdhfZ8NCWuUNb16uC6kThyByNNu6UhvbF/KlXS4V5qv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 02/35] khash: move oid hash table definition
Date:   Tue, 19 Feb 2019 00:04:53 +0000
Message-Id: <20190219000526.476553-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the oid khash table definition to khash.h and define a typedef for
it, similar to the one we have for unsigned char pointers. Define
variants that are maps as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 khash.h  | 18 ++++++++++++++++++
 oidset.h | 12 ------------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/khash.h b/khash.h
index 532109c87f..a09163b3e3 100644
--- a/khash.h
+++ b/khash.h
@@ -332,4 +332,22 @@ typedef kh_sha1_t khash_sha1;
 KHASH_INIT(sha1_pos, const unsigned char *, int, 1, sha1hash, __kh_oid_cmp)
 typedef kh_sha1_pos_t khash_sha1_pos;
 
+static inline unsigned int oid_hash(struct object_id oid)
+{
+	return sha1hash(oid.hash);
+}
+
+static inline int oid_equal(struct object_id a, struct object_id b)
+{
+	return oideq(&a, &b);
+}
+
+KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)
+
+KHASH_INIT(oid_map, struct object_id, void *, 1, oid_hash, oid_equal)
+typedef kh_oid_t khash_oid_map;
+
+KHASH_INIT(oid_pos, struct object_id, int, 1, oid_hash, oid_equal)
+typedef kh_oid_pos_t khash_oid_pos;
+
 #endif /* __AC_KHASH_H */
diff --git a/oidset.h b/oidset.h
index c9d0f6d3cc..14f18f791f 100644
--- a/oidset.h
+++ b/oidset.h
@@ -16,18 +16,6 @@
  *      table overhead.
  */
 
-static inline unsigned int oid_hash(struct object_id oid)
-{
-	return sha1hash(oid.hash);
-}
-
-static inline int oid_equal(struct object_id a, struct object_id b)
-{
-	return oideq(&a, &b);
-}
-
-KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)
-
 /**
  * A single oidset; should be zero-initialized (or use OIDSET_INIT).
  */
