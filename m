Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0000C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19842081E
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="If9L+tlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAMMr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:47:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37772 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727331AbgAMMr7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:47:59 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 54CD9607F8
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919678;
        bh=cE5GdLcrDcM06Afus0NxdHX7CbdUI870YkIBxBqrlGk=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=If9L+tlXRBgb8vluc0W1dpWXa5SF1nkhoZ/G0g3eySwuzynENrnT+ed3qCMXf5yv1
         0+S8DtLE4Bht2216lOCZaDd4P1xOPOwm4T9l+LSPldcgjslOyEwC1X8gAAEe9rM4Ew
         JDTYRc/+3ZoaFSveXqn75WpesqV59/aDGLDoP0i9kTiKGOXrDryu1CWQMGXlJKqbV8
         y0NOWihe5FTdo4WjAIsuVvRax+4oLSgiPBOquggiOFolUgKFKwJz+xrbzDDOQYSgmY
         ksPhqUA0X5WRT+mMm/p4ZGgFb7YlIXRF6Edn5B9cUkQ4Ke64DSDn2OudrLTJnUoaHX
         Lvku1u+WsX0LR7lhQwrkZObWnl9RdqBPY3IOcRm7Vzuc95Hhvk07clT9xbKoMDLgnj
         yGBV22o6SP+jfU9AositRbu+9rEQ+g32fcWEVJUjg4ONnL1JBWq5ihvisQByFw8lb2
         os1S4wcrWHnAfJrQEWbyNsAbJ4Ph2ZgZG4fbOj0S4ISET2a0F96
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 02/22] hex: add functions to parse hex object IDs in any algorithm
Date:   Mon, 13 Jan 2020 12:47:09 +0000
Message-Id: <20200113124729.3684846-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some places where we need to parse a hex object ID in any
algorithm without knowing beforehand which algorithm is in use. An
example is when parsing fast-import marks.

Add a get_oid_hex_any to parse an object ID and return the algorithm it
belongs to, and additionally add parse_oid_hex_any which is the
equivalent change for parse_oid_hex. If the object is not parseable, we
return GIT_HASH_UNKNOWN.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 10 ++++++++++
 hex.c   | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/cache.h b/cache.h
index 493d57febe..6c094c3210 100644
--- a/cache.h
+++ b/cache.h
@@ -1522,6 +1522,16 @@ int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
 int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char **end,
 			const struct git_hash_algo *algo);
 
+
+/*
+ * These functions work like get_oid_hex and parse_oid_hex, but they will parse
+ * a hex value for any algorithm. The algorithm is detected based on the length
+ * and the algorithm in use is returned. If this is not a hex object ID in any
+ * algorithm, returns GIT_HASH_UNKNOWN.
+ */
+int get_oid_hex_any(const char *hex, struct object_id *oid);
+int parse_oid_hex_any(const char *hex, struct object_id *oid, const char **end);
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
diff --git a/hex.c b/hex.c
index 10e24dc2e4..da51e64929 100644
--- a/hex.c
+++ b/hex.c
@@ -72,6 +72,20 @@ int get_oid_hex_algop(const char *hex, struct object_id *oid,
 	return get_hash_hex_algop(hex, oid->hash, algop);
 }
 
+/*
+ * NOTE: This function relies on hash algorithms being in order from shortest
+ * length to longest length.
+ */
+int get_oid_hex_any(const char *hex, struct object_id *oid)
+{
+	int i;
+	for (i = GIT_HASH_NALGOS - 1; i > 0; i--) {
+		if (!get_hash_hex_algop(hex, oid->hash, &hash_algos[i]))
+			return i;
+	}
+	return GIT_HASH_UNKNOWN;
+}
+
 int get_oid_hex(const char *hex, struct object_id *oid)
 {
 	return get_oid_hex_algop(hex, oid, the_hash_algo);
@@ -87,6 +101,14 @@ int parse_oid_hex_algop(const char *hex, struct object_id *oid,
 	return ret;
 }
 
+int parse_oid_hex_any(const char *hex, struct object_id *oid, const char **end)
+{
+	int ret = get_oid_hex_any(hex, oid);
+	if (ret)
+		*end = hex + hash_algos[ret].hexsz;
+	return ret;
+}
+
 int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
 {
 	return parse_oid_hex_algop(hex, oid, end, the_hash_algo);
