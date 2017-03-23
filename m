Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6376C20958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935057AbdCWNri (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:47:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:29004 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755340AbdCWNrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:47:20 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 59CB984675;
        Thu, 23 Mar 2017 09:47:19 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 4/7] hashmap: document memihash_cont, hashmap_disallow_rehash api
Date:   Thu, 23 Mar 2017 13:47:02 +0000
Message-Id: <1490276825-41544-5-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Document memihash_cont() and hashmap_disallow_rehash()
in Documentation/technical/api-hashmap.txt.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-hashmap.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index a3f020c..ccc634b 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -21,6 +21,9 @@ that the hashmap is initialized. It may also be useful for statistical purposes
 `cmpfn` stores the comparison function specified in `hashmap_init()`. In
 advanced scenarios, it may be useful to change this, e.g. to switch between
 case-sensitive and case-insensitive lookup.
++
+When `disallow_rehash` is set, automatic rehashes are prevented during inserts
+and deletes.
 
 `struct hashmap_entry`::
 
@@ -57,6 +60,7 @@ Functions
 `unsigned int strihash(const char *buf)`::
 `unsigned int memhash(const void *buf, size_t len)`::
 `unsigned int memihash(const void *buf, size_t len)`::
+`unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len)`::
 
 	Ready-to-use hash functions for strings, using the FNV-1 algorithm (see
 	http://www.isthe.com/chongo/tech/comp/fnv).
@@ -65,6 +69,9 @@ Functions
 `memihash` operate on arbitrary-length memory.
 +
 `strihash` and `memihash` are case insensitive versions.
++
+`memihash_cont` is a variant of `memihash` that allows a computation to be
+continued with another chunk of data.
 
 `unsigned int sha1hash(const unsigned char *sha1)`::
 
@@ -184,6 +191,21 @@ passed to `hashmap_cmp_fn` to decide whether the entry matches the key.
 +
 Returns the removed entry, or NULL if not found.
 
+`void hashmap_disallow_rehash(struct hashmap *map, unsigned value)`::
+
+	Disallow/allow automatic rehashing of the hashmap during inserts
+	and deletes.
++
+This is useful if the caller knows that the hashmap will be accessed
+by multiple threads.
++
+The caller is still responsible for any necessary locking; this simply
+prevents unexpected rehashing.  The caller is also responsible for properly
+sizing the initial hashmap to ensure good performance.
++
+A call to allow rehashing does not force a rehash; that might happen
+with the next insert or delete.
+
 `void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter)`::
 `void *hashmap_iter_next(struct hashmap_iter *iter)`::
 `void *hashmap_iter_first(struct hashmap *map, struct hashmap_iter *iter)`::
-- 
2.7.4

