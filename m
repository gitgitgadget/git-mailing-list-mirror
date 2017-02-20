Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC46201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 00:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdBTALL (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 19:11:11 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36300 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752022AbdBTAKy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Feb 2017 19:10:54 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 70B36280AE;
        Mon, 20 Feb 2017 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487549442;
        bh=HMwSYewjTFN1JL3O4PWnCPBdz55tuQcXw8SpF/hKfYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTxYz29hMAjfuWwxJdaQalcMI2WqQSST57dZldZDAI+3l1OzEZFlYm6AzVdlfOKGG
         YhVyIA4hJLCJbn515N+mI6uNfxwK0f175shs1hhHPGwsLcBFoJAbO+p4erFLWDWhxS
         K98EyOsaZGg1NFizAG7VXiyRflVGLxx8synx0aOVl6TjHXJ+r5BoFXMQRBdFw5WP5L
         gkHRtXQQE6zgqTOkXZ084yhw0oXorCJI1wP5iN/7X6U/CMIVcpGRJAfY+Vf2KCsYWB
         Pe/zxaO76OmxbysE8rDP6fsqq10cacOyCGWzuiBau97cfW1hBRUKCAlfUIPvcyHj4h
         v6D8jJS3euxHLj7CNCxD64IQQwmdFgE9iF9DKaLR5dP/AhGk+VTLY7WVjYNyxRa7Ad
         Qfw4XAv3dU03fMTsg/h5yEqnJ2XDD3XOmXxYJEnuwTd0O7y2HsiCWEO0CL/okMzY41
         m3efSOMuUnobiJ92oAQijSYAO85Kp0x1Uv0ip0qLPOYS5kjMuKk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 01/19] hex: introduce parse_oid_hex
Date:   Mon, 20 Feb 2017 00:10:13 +0000
Message-Id: <20170220001031.559931-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170220001031.559931-1-sandals@crustytoothpaste.net>
References: <20170220001031.559931-1-sandals@crustytoothpaste.net>
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

