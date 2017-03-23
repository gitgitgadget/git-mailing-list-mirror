Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA4720958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755764AbdCWNrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:47:21 -0400
Received: from siwi.pair.com ([209.68.5.199]:28993 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752588AbdCWNrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:47:20 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 232058466D;
        Thu, 23 Mar 2017 09:47:19 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 2/7] hashmap: allow memihash computation to be continued
Date:   Thu, 23 Mar 2017 13:47:00 +0000
Message-Id: <1490276825-41544-3-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add variant of memihash() to allow the hash computation to
be continued.  There are times when we compute the hash on
a full path and then the hash on just the path to the parent
directory.  This can be expensive on large repositories.

With this, we can hash the parent directory first. And then
continue the computation to include the "/filename".

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 hashmap.c | 17 +++++++++++++++++
 hashmap.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hashmap.c b/hashmap.c
index b10b642..93793cb 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -50,6 +50,23 @@ unsigned int memihash(const void *buf, size_t len)
 	return hash;
 }
 
+/*
+ * Incoporate another chunk of data into a memihash
+ * computation.
+ */
+unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len)
+{
+	unsigned int hash = hash_seed;
+	unsigned char *ucbuf = (unsigned char *) buf;
+	while (len--) {
+		unsigned int c = *ucbuf++;
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
 #define HASHMAP_INITIAL_SIZE 64
 /* grow / shrink by 2^2 */
 #define HASHMAP_RESIZE_BITS 2
diff --git a/hashmap.h b/hashmap.h
index ab7958a..45eda69 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -12,6 +12,7 @@ extern unsigned int strhash(const char *buf);
 extern unsigned int strihash(const char *buf);
 extern unsigned int memhash(const void *buf, size_t len);
 extern unsigned int memihash(const void *buf, size_t len);
+extern unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
 
 static inline unsigned int sha1hash(const unsigned char *sha1)
 {
-- 
2.7.4

