Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C80C35674
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6B9206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GpG6ACaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgBVUSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39078 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgBVUSG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4AD68609CF
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402685;
        bh=pbkrr+zpuYkTNaZDFek8q56kXI4wbCmAsY2GK3L6G9g=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=GpG6ACaDrFqVOjMpdHCfqGVJiSO79bdvrghlcvsDtFA12SrTzGnVYuqoq8mTc87j6
         Cdd9HP/WHprpkA6skAJO5EWVdJxRQaP6LBJu3HRwFdxyDqcsli+c4KGFGXyhZHASfn
         /CGAbeNwvz1Yz7xEkoPfLQKhyrVLnDHbHjOeU5pVgFBi4B1bu4htv2UYAG4QyfXG66
         BTij9TxK4YVW36g9n63ptUW57Md1Ptw1ChGAolMMwq+8mKeR5Jq16V22tMOFM8+iSI
         37my/jwjcX4AgofO+So+kE93dX5NpxoXTQY0AZt+74wcNkR390ZeRp7u764pt+wotW
         YdonxO7Zl5p4XNoU30LjgpIe8kIVnCyvgRIjmX4fXQwQz2rVC4E0NBmcmeZ5DTg58p
         Wetyu2hbPscP6PTCjpDfi/0AhzgWHwsmDMBWM7T+d7uoKG9Ey/PfxHPo7hbR1QzNs8
         t4onhwb/dwNi+dIL2Zsf+3YXm12n3xGDiP+v+Kh1iu5ErAJKuPU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 04/24] hex: add functions to parse hex object IDs in any algorithm
Date:   Sat, 22 Feb 2020 20:17:29 +0000
Message-Id: <20200222201749.937983-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
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
index 4c9c21a11d..158d7ccfd8 100644
--- a/cache.h
+++ b/cache.h
@@ -1523,6 +1523,16 @@ int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
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
