Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CE81F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeH2ExX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbeH2ExX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:23 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9EA7F6075D
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504347;
        bh=jCdz7BFPy2ADLkwspAhxCopvTtQ2IIcET7ZDX3F0vVY=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=vU6z3FiuVx/OTTPFK9QNTczdHFGnWhzRN0q5D3wVUQWrUSKtr0grfp3u31gMqPA3d
         I8Aym3OVorXTWMMa1mb1msC29PUlLGT4l23ZB4tjxPfsYqfgELFjhxlE3M8JSa2B4e
         e/i68sauxguTOBDDFbvj3xC+VcziMJeB6r51haqyUmddWDxwvXJpM7XelDLy28KAWV
         YSz6fK5Wokz8940re9uG6ZHP1NhQtWrNsVvyjpuhoAlbnnBFLXi3F68J1ykrjgQJFR
         rQdnhfRodx4zjRNf6WMBoAxltnKYzzbPb+3EdfPMPYCl3/fHDeY3E/Yr3ykb97dsLK
         823y2M4LJi8W0gwy3PgKWclTw8KuvgwQUBvpMWw8OMXtx8DpxALRCNZdjiD5arMplf
         hnfWTCyoDQPS4SLHnhxmn5LAtok9UPxhf9T7WYhyVWNzk2KRqw1k5e5BrZ0kMCifVe
         QsPIvtuCBQ9g9r7LfBd7b3Kq9NpPxH0F8AE067Qs4nPL34C3RWV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 02/12] sha1-file: provide functions to look up hash algorithms
Date:   Wed, 29 Aug 2018 00:58:47 +0000
Message-Id: <20180829005857.980820-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005857.980820-1-sandals@crustytoothpaste.net>
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
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
index 7c8238bc2e..90f4344619 100644
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
+inline int hash_algo_by_ptr(const struct git_hash_algo *p)
+{
+	return p - hash_algos;
+}
+
 #endif
diff --git a/sha1-file.c b/sha1-file.c
index 5223e3d1ce..f6976b179f 100644
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
