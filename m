Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A3B201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbdBRAH2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:07:28 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60048 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751371AbdBRAHE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 19:07:04 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9D5F9280B0;
        Sat, 18 Feb 2017 00:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487376422;
        bh=sbrXO9FkSyyUPd1wVmmIHyvjIDi2MKUL4/1/R07gjfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMbK8kcbv+QmHKOUO5xc8nil0lCiMm+JVgZezY92k1nsMwBxyYrYIjR+qp2m7f7jk
         AMc13ORZldFR10Z1BrzP7xtotO0nNcaiXU3ytNGDzMZkaf5/hS9eA+b7b9CZwXcZ8g
         mwl9KktxFR0DgU8nQrFX0Sa6RtWJgPTjRbNLbffEIkf9kNav+MNzv5tYlM4QU0FRYm
         HjeYcYo1W7WcvkpU4oMRKW+WWqBQ4FxKdGjuqKKWWUxfK4MZrB0tcSYB093OBJ8Lx3
         79kbpUhBiM+KsBp050SYLvSHo2GGXq1N7KjegIGCB3k4XqMu0HcibfwHCkeX4/Bfs/
         ftHuwFr1yXdIUayHeMdIOAaG8+UmycoytLif7sMzYkZ6aw07E3EFQNaQLkvN3DC2gC
         ui70mPdpds7vZLlurcL8ct+cI6B6f8nmWVDOniTvo/YVAj/Qn+z/GT2y+5PZNPNzwU
         CaH1qVYFbwOVzmzx9aErqxtQCkN3jpZ+aPK46eLPwy8s0fKoWvt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/19] sha1_file: introduce an nth_packed_object_oid function
Date:   Sat, 18 Feb 2017 00:06:49 +0000
Message-Id: <20170218000652.375129-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170218000652.375129-1-sandals@crustytoothpaste.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are places in the code where we would like to provide a struct
object_id *, yet read the hash directly from the pack.  Provide an
nth_packed_object_oid function that is similar to the
nth_packed_object_sha1 function.

In order to avoid a potentially invalid cast, nth_packed_object_oid
provides a variable into which to store the value, which it returns on
success; on error, it returns NULL, as nth_packed_object_sha1 does.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     |  6 ++++++
 sha1_file.c | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index e03a672d15..4f3bfc5ee7 100644
--- a/cache.h
+++ b/cache.h
@@ -1608,6 +1608,12 @@ extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
  * error.
  */
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
+/*
+ * Like nth_packed_object_oid, but write the data into the object specified by
+ * the the first argument.  Returns the first argument on success, and NULL on
+ * error.
+ */
+extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
 
 /*
  * Return the offset of the nth object within the specified packfile.
diff --git a/sha1_file.c b/sha1_file.c
index ec957db5e1..777b8e8eae 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2628,6 +2628,17 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 	}
 }
 
+const struct object_id *nth_packed_object_oid(struct object_id *oid,
+					      struct packed_git *p,
+					      uint32_t n)
+{
+	const unsigned char *hash = nth_packed_object_sha1(p, n);
+	if (!hash)
+		return NULL;
+	hashcpy(oid->hash, hash);
+	return oid;
+}
+
 void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 {
 	const unsigned char *ptr = vptr;
@@ -3788,13 +3799,13 @@ static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn c
 	int r = 0;
 
 	for (i = 0; i < p->num_objects; i++) {
-		const unsigned char *sha1 = nth_packed_object_sha1(p, i);
+		struct object_id oid;
 
-		if (!sha1)
+		if (!nth_packed_object_oid(&oid, p, i))
 			return error("unable to get sha1 of object %u in %s",
 				     i, p->pack_name);
 
-		r = cb(sha1, p, i, data);
+		r = cb(oid.hash, p, i, data);
 		if (r)
 			break;
 	}
-- 
2.11.0

