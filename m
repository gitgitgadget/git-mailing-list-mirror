Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6051F859
	for <e@80x24.org>; Thu, 25 Aug 2016 23:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758675AbcHYXig (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 19:38:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:42011 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758773AbcHYXid (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 19:38:33 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP; 25 Aug 2016 16:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,578,1464678000"; 
   d="scan'208";a="161062160"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2016 16:32:45 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v11 1/8] cache: add empty_tree_oid object and helper function
Date:   Thu, 25 Aug 2016 16:32:36 -0700
Message-Id: <20160825233243.30700-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
In-Reply-To: <20160825233243.30700-1-jacob.e.keller@intel.com>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Similar to is_null_oid(), and is_empty_blob_sha1() add an
empty_tree_oid along with helper function is_empty_tree_oid(). For
completeness, also add an "is_empty_tree_sha1()",
"is_empty_blob_sha1()", "is_empty_tree_oid()" and "is_empty_blob_oid()"
helpers.

To ensure we only get one singleton, implement EMPTY_BLOB_SHA1_BIN as
simply getting the hash of empty_blob_oid structure.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 cache.h     | 25 +++++++++++++++++++++----
 sha1_file.c |  6 ++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index f30a4417efdf..70428e92d7ed 100644
--- a/cache.h
+++ b/cache.h
@@ -953,22 +953,39 @@ static inline void oidclr(struct object_id *oid)
 #define EMPTY_TREE_SHA1_BIN_LITERAL \
 	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
 	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
-#define EMPTY_TREE_SHA1_BIN \
-	 ((const unsigned char *) EMPTY_TREE_SHA1_BIN_LITERAL)
+extern const struct object_id empty_tree_oid;
+#define EMPTY_TREE_SHA1_BIN (empty_tree_oid.hash)
 
 #define EMPTY_BLOB_SHA1_HEX \
 	"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"
 #define EMPTY_BLOB_SHA1_BIN_LITERAL \
 	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
 	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
-#define EMPTY_BLOB_SHA1_BIN \
-	((const unsigned char *) EMPTY_BLOB_SHA1_BIN_LITERAL)
+extern const struct object_id empty_blob_oid;
+#define EMPTY_BLOB_SHA1_BIN (empty_blob_oid.hash)
+
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
 }
 
+static inline int is_empty_blob_oid(const struct object_id *oid)
+{
+	return !hashcmp(oid->hash, EMPTY_BLOB_SHA1_BIN);
+}
+
+static inline int is_empty_tree_sha1(const unsigned char *sha1)
+{
+	return !hashcmp(sha1, EMPTY_TREE_SHA1_BIN);
+}
+
+static inline int is_empty_tree_oid(const struct object_id *oid)
+{
+	return !hashcmp(oid->hash, EMPTY_TREE_SHA1_BIN);
+}
+
+
 int git_mkstemp(char *path, size_t n, const char *template);
 
 /* set default permissions by passing mode arguments to open(2) */
diff --git a/sha1_file.c b/sha1_file.c
index 1e23fc186a02..21cf923bcf1f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -38,6 +38,12 @@ static inline uintmax_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 const struct object_id null_oid;
+const struct object_id empty_tree_oid = {
+	EMPTY_TREE_SHA1_BIN_LITERAL
+};
+const struct object_id empty_blob_oid = {
+	EMPTY_BLOB_SHA1_BIN_LITERAL
+};
 
 /*
  * This is meant to hold a *small* number of objects that you would
-- 
2.10.0.rc0.259.g83512d9

