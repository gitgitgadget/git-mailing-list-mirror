Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18699C388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEC720A8B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKMFHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 00:07:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:56912 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKMFHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 00:07:02 -0500
Received: (qmail 23764 invoked by uid 109); 13 Nov 2020 05:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 05:07:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6189 invoked by uid 111); 13 Nov 2020 05:07:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 00:07:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 00:07:01 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] use size_t to store pack .idx byte offsets
Message-ID: <20201113050701.GB744691@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113050631.GA744608@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We sometimes store the offset into a pack .idx file as an "unsigned
long", but the mmap'd size of a pack .idx file can exceed 4GB. This is
sufficient on LP64 systems like Linux, but will be too small on LLP64
systems like Windows, where "unsigned long" is still only 32 bits. Let's
use size_t, which is a better type for an offset into a memory buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-redundant.c | 6 +++---
 packfile.c               | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 178e3409b7..3e70f2a4c1 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -236,7 +236,7 @@ static struct pack_list * pack_list_difference(const struct pack_list *A,
 
 static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 {
-	unsigned long p1_off = 0, p2_off = 0, p1_step, p2_step;
+	size_t p1_off = 0, p2_off = 0, p1_step, p2_step;
 	const unsigned char *p1_base, *p2_base;
 	struct llist_item *p1_hint = NULL, *p2_hint = NULL;
 	const unsigned int hashsz = the_hash_algo->rawsz;
@@ -280,7 +280,7 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
 {
 	size_t ret = 0;
-	unsigned long p1_off = 0, p2_off = 0, p1_step, p2_step;
+	size_t p1_off = 0, p2_off = 0, p1_step, p2_step;
 	const unsigned char *p1_base, *p2_base;
 	const unsigned int hashsz = the_hash_algo->rawsz;
 
@@ -499,7 +499,7 @@ static void scan_alt_odb_packs(void)
 static struct pack_list * add_pack(struct packed_git *p)
 {
 	struct pack_list l;
-	unsigned long off = 0, step;
+	size_t off = 0, step;
 	const unsigned char *base;
 
 	if (!p->pack_local && !(alt_odb || verbose))
diff --git a/packfile.c b/packfile.c
index a72c2a261f..63fe9ee8be 100644
--- a/packfile.c
+++ b/packfile.c
@@ -164,8 +164,8 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		 * variable sized table containing 8-byte entries
 		 * for offsets larger than 2^31.
 		 */
-		unsigned long min_size = 8 + 4*256 + (size_t)nr*(hashsz + 4 + 4) + hashsz + hashsz;
-		unsigned long max_size = min_size;
+		size_t min_size = 8 + 4*256 + (size_t)nr*(hashsz + 4 + 4) + hashsz + hashsz;
+		size_t max_size = min_size;
 		if (nr)
 			max_size += ((size_t)nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size)
-- 
2.29.2.705.g306f91dc4e

