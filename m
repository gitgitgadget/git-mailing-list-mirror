Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408DA201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbdBUXrq (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:47:46 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39782 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753427AbdBUXro (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 18:47:44 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 93AB0280AE;
        Tue, 21 Feb 2017 23:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487720861;
        bh=HMwSYewjTFN1JL3O4PWnCPBdz55tuQcXw8SpF/hKfYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/S+JlPMHc7+/D67TZ5aOVjMj5dFExNWoA30r1D8WTjbDKpODqGF6AhOmYu2WnYc7
         /UmSn0sau/0/K7ARUmZa6XZcB/kH3Lu097c5wftSHM72FWI6XIATC/c+wWCpt4JUT6
         c5vPf78ob8f6nwMq7Ioy/eGcq10rdrTGx8zdXKRfPpWCP2VXhR/k7kz+2w3KHtGtW0
         V2025AYIoA9dqiQmH6A9yPTzWRxV0XU+MKSbWT3Gk7MiFZjgB2/X7HQqd4PIqQdmYh
         mIgOuxq99eMvA1JCwa4o2uU/UQ6FJmfSDnT5YiokjK0GH6Ngk8XV10qUBrUm66x6dB
         jFSEp5Kxnk4UI6fWeLz5CoBPcd6Zsogbc/qZXSgDTKBiNnboxJU5aS4tnAeLDD9KoZ
         afQp0g2VxSxe2p0gg1KguS1YVqRBsv1DjZm5Mq4kN9jmgqLj+GAuMw+NL7ug84qp/2
         LntSy1I2CTzaAJuJLpJEJPuH44kC0ESmrYnVAlktUFatDGVr/s8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 01/19] hex: introduce parse_oid_hex
Date:   Tue, 21 Feb 2017 23:47:19 +0000
Message-Id: <20170221234737.894681-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170221234737.894681-1-sandals@crustytoothpaste.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a function, parse_oid_hex, which parses a hexadecimal object
ID and if successful, sets a pointer to just beyond the last character.
This allows for simpler, more robust parsing without needing to
hard-code integer values throughout the codebase.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 9 +++++++++
 hex.c   | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/cache.h b/cache.h
index 61fc86e6d7..e03a672d15 100644
--- a/cache.h
+++ b/cache.h
@@ -1319,6 +1319,15 @@ extern char *oid_to_hex_r(char *out, const struct object_id *oid);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 
+/*
+ * Parse a 40-character hexadecimal object ID starting from hex, updating the
+ * pointer specified by end when parsing stops.  The resulting object ID is
+ * stored in oid.  Returns 0 on success.  Parsing will stop on the first NUL or
+ * other invalid character.  end is only updated on success; otherwise, it is
+ * unmodified.
+ */
+extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
+
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
diff --git a/hex.c b/hex.c
index 845b01a874..eab7b626ee 100644
--- a/hex.c
+++ b/hex.c
@@ -53,6 +53,14 @@ int get_oid_hex(const char *hex, struct object_id *oid)
 	return get_sha1_hex(hex, oid->hash);
 }
 
+int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
+{
+	int ret = get_oid_hex(hex, oid);
+	if (!ret)
+		*end = hex + GIT_SHA1_HEXSZ;
+	return ret;
+}
+
 char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
 {
 	static const char hex[] = "0123456789abcdef";
-- 
2.11.0

