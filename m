Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42B21FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 19:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbdAATTv (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 14:19:51 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53862 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932407AbdAATTq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2017 14:19:46 -0500
Received: from genre.crustytoothpaste.net (unknown [173.243.43.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 98D58280AC;
        Sun,  1 Jan 2017 19:19:45 +0000 (UTC)
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/17] sha1_file: introduce an nth_packed_object_oid function
Date:   Sun,  1 Jan 2017 19:18:44 +0000
Message-Id: <20170101191847.564741-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170101191847.564741-1-sandals@crustytoothpaste.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are places in the code where we would like to provide a struct
object_id *, yet read the hash directly from the pack.  Provide an
nth_packed_object_oid function that mirrors the nth_packed_object_sha1
function.

The required cast is questionable, but should be safe on all known
platforms.  The alternative of allocating an object as an intermediate
would be too inefficient and cause memory leaks.  If necessary, an
intermediate union could be used; this practice is allowed by GCC and
explicitly sanctioned by C11.  However, such a change will likely not be
necessary, and can be made if and when it is.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     |  1 +
 sha1_file.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index a50a61a19..b1ed1c7ae 100644
--- a/cache.h
+++ b/cache.h
@@ -1540,6 +1540,7 @@ extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
  * error.
  */
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
+extern const struct object_id *nth_packed_object_oid(struct packed_git *, uint32_t n);
 
 /*
  * Return the offset of the nth object within the specified packfile.
diff --git a/sha1_file.c b/sha1_file.c
index 117307185..d27d1521b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2608,6 +2608,12 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 	}
 }
 
+const struct object_id *nth_packed_object_oid(struct packed_git *p,
+					      uint32_t n)
+{
+	return (const struct object_id *)nth_packed_object_sha1(p, n);
+}
+
 void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 {
 	const unsigned char *ptr = vptr;
@@ -3768,13 +3774,13 @@ static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn c
 	int r = 0;
 
 	for (i = 0; i < p->num_objects; i++) {
-		const unsigned char *sha1 = nth_packed_object_sha1(p, i);
+		const struct object_id *oid = nth_packed_object_oid(p, i);
 
-		if (!sha1)
+		if (!oid)
 			return error("unable to get sha1 of object %u in %s",
 				     i, p->pack_name);
 
-		r = cb(sha1, p, i, data);
+		r = cb(oid->hash, p, i, data);
 		if (r)
 			break;
 	}
-- 
2.11.0

