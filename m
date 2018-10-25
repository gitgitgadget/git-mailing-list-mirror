Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3FD1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 02:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeJYLK7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:10:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52348 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbeJYLK7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 07:10:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C1AC361B74;
        Thu, 25 Oct 2018 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540435216;
        bh=oJvQgvoTxof4lF82L/GM3/DdTPxmny0e8JzRlxvKggc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mWp77RmMYnvA0VmTtsdRzVMFSCtfHIHdWmRg+fE4pzu9BhlxRQt7mqnQaDwWZOXGA
         xa2LahAA3GAvwJWDY/pPiTFAb2hpyrpFPrcCEKksMZUDS9dbSh20AAbSYvplo1TeOF
         66OzOv3Ba32A95CmfsykerzA/ZJ373aXi7MKFXj7M/KC2YN0YZVtDqpWz0HEnlzPAZ
         vkjWsadT84XDdhIjOWv/lvS6Rm/iZS4grwwiApa1eFX6rl2Jmfo4w6PhaS7psyzFOw
         7OfUDslRN4gnp9P1E1gdVcoqCx9VwK/G7gQwNtaMKqyPznucAmvwRX/JThO7w9XaTs
         fOKEry6TY/Kgwa6BRRSczUUlFQZoCc6P0ywq2JlWMx0OPQgOTVk9eq5v8aB/CgSWXZ
         jvhkBavyj/IirUlXV/mbvJ9NONcLsWY6/vKECDemmZcVAxw845nHehtQEaq5JOFcyE
         HLAIdr5vqnR+BFT5Yp+sxcH/Nysa65+E7Qr0tTkpI8+42Zuj/4X
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 02/12] sha1-file: provide functions to look up hash algorithms
Date:   Thu, 25 Oct 2018 02:39:55 +0000
Message-Id: <20181025024005.154208-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181025024005.154208-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several ways we might refer to a hash algorithm: by name, such
as in the config file; by format ID, such as in a pack; or internally,
by a pointer to the hash_algos array.  Provide functions to look up hash
algorithms based on these various forms and return the internal constant
used for them.  If conversion to another form is necessary, this
internal constant can be used to look up the proper data in the
hash_algos array.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h      | 13 +++++++++++++
 sha1-file.c | 21 +++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/hash.h b/hash.h
index 7c8238bc2e..80881eea47 100644
--- a/hash.h
+++ b/hash.h
@@ -98,4 +98,17 @@ struct git_hash_algo {
 };
 extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
 
+/*
+ * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
+ * the name doesn't match a known algorithm.
+ */
+int hash_algo_by_name(const char *name);
+/* Identical, except based on the format ID. */
+int hash_algo_by_id(uint32_t format_id);
+/* Identical, except for a pointer to struct git_hash_algo. */
+static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
+{
+	return p - hash_algos;
+}
+
 #endif
diff --git a/sha1-file.c b/sha1-file.c
index 91311ebb3d..7e9dedc744 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -122,6 +122,27 @@ const char *empty_blob_oid_hex(void)
 	return oid_to_hex_r(buf, the_hash_algo->empty_blob);
 }
 
+int hash_algo_by_name(const char *name)
+{
+	int i;
+	if (!name)
+		return GIT_HASH_UNKNOWN;
+	for (i = 1; i < GIT_HASH_NALGOS; i++)
+		if (!strcmp(name, hash_algos[i].name))
+			return i;
+	return GIT_HASH_UNKNOWN;
+}
+
+int hash_algo_by_id(uint32_t format_id)
+{
+	int i;
+	for (i = 1; i < GIT_HASH_NALGOS; i++)
+		if (format_id == hash_algos[i].format_id)
+			return i;
+	return GIT_HASH_UNKNOWN;
+}
+
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
