Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1879E1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 02:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdBNCcg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 21:32:36 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50646 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751350AbdBNCcP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Feb 2017 21:32:15 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EF909280BB;
        Tue, 14 Feb 2017 02:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487039518;
        bh=yAyFYMvpKqUeSWgUlETPuU021mNmC9JqJ5H/LnKfgIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNeRgorrCBj7qX7ghnpRHXVfPzJ+212esWheGtObc3K870n1ijE9k6X44RKMiQNvx
         oX0RMh9BsgrrSElwZ5LxtQf2EgC6V5SKH56QopoPj71mfjXNNNyRtoQX0o6ZUzXlIa
         2KEMRHcf/3Lb+LG8c1uX2J9BbS4/xKPzCmy2BfsbAMhpNgnk9/alV+kwmFHDCnrSWn
         JHd0FTNBAqhexOg9Yj4pPEgn2F0LmET1ANjcFiE5kmkKIZgao45mn9GipqSewpk/6U
         6qz1VoIHuG16eiLegr4IyLw5PCwtxRm2AHgsD2dOmyjFRbgeGeEexb8FptmTeP//TS
         azKhkNQxlX0h8S32v2OPQNt3gW248IkJKwjSlBOxvrPnPFJZbUQj8Ivd0igItO3AZt
         uDAAShJ7rwpbO669DAD60hYcYV4iXzYUib1KY5p3YUT1F285IDVLpeyR9qwzqu/rU+
         MXETg3HecnEO0VUJYgtcsr0ckkMvUMOhOCLpG4oqdsmL14wLJg2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/19] hex: introduce parse_oid_hex
Date:   Tue, 14 Feb 2017 02:31:36 +0000
Message-Id: <20170214023141.842922-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170214023141.842922-1-sandals@crustytoothpaste.net>
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
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
 cache.h | 8 ++++++++
 hex.c   | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index 61fc86e6d7..5dc89a058c 100644
--- a/cache.h
+++ b/cache.h
@@ -1319,6 +1319,14 @@ extern char *oid_to_hex_r(char *out, const struct object_id *oid);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 
+/*
+ * Parse a hexadecimal object ID starting from hex, updating the pointer
+ * specified by p when parsing stops.  The resulting object ID is stored in oid.
+ * Returns 0 on success.  Parsing will stop on the first NUL or other invalid
+ * character.
+ */
+extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **p);
+
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
diff --git a/hex.c b/hex.c
index 845b01a874..54252b1445 100644
--- a/hex.c
+++ b/hex.c
@@ -53,6 +53,14 @@ int get_oid_hex(const char *hex, struct object_id *oid)
 	return get_sha1_hex(hex, oid->hash);
 }
 
+int parse_oid_hex(const char *hex, struct object_id *oid, const char **p)
+{
+	int ret = get_oid_hex(hex, oid);
+	if (!ret)
+		*p = hex + GIT_SHA1_HEXSZ;
+	return ret;
+}
+
 char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
 {
 	static const char hex[] = "0123456789abcdef";
-- 
2.11.0

