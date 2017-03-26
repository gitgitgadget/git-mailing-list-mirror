Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE1C20958
	for <e@80x24.org>; Sun, 26 Mar 2017 16:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdCZQCI (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 12:02:08 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58060 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751468AbdCZQCH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 12:02:07 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8C854280BE;
        Sun, 26 Mar 2017 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490544120;
        bh=muXS/VTgUYniBU/B61cVhFC39EMbQVb0Z2IDpuafE2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bk3k6SQReH7O83nLSrbIIg1npTxdYW/7GncIiaZoAV/8LO08YXvXr7kPaU6ET4ttu
         IDrNHUubc1z360S7+BdfUbBjfKFWLrhzqmapTLDt78pWvYsvPRdl7B/uL08isq8DoY
         zBXzL7QsZ1WzYJ4nl2shLxYOXHQi96+mxsbUuSbcHnftF3qI/Hauym6kCdvS0I7GEO
         CwOpCqx7JDW5nSsHHGlMPgFbek04qsY5VfJbHj+SB7zgGZAxPzZ8XoyRmVxURbExYM
         yg322SfCs9k15BT5UNPTNObNqHb9S04poVx3cMIifvXL4lauynXye3B3BRkGlAIJKy
         1brbat6HixvXQjp/u+WQYSe5dipsHea4PVTnFsUbLN6P0xxLYp6XnWVHIJy4JgIJmS
         NLw58nLmMEug5+MN4v+dfaG952izthVgvs6J5jwAQ73QCEdzvV66nbvaE3vh4BXqjk
         0yu/JMFMLRFUVjfnhHLy1Vv+AHYBlBvcukGRyp8VNwbXcFSqVm2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/21] Convert remaining callers of sha1_array_lookup to object_id
Date:   Sun, 26 Mar 2017 16:01:39 +0000
Message-Id: <20170326160143.769630-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326160143.769630-1-sandals@crustytoothpaste.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a very small number of callers which don't already use struct
object_id.  Convert them.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c               | 14 +++++++-------
 builtin/pack-objects.c | 16 ++++++++--------
 ref-filter.c           | 22 +++++++++++-----------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/bisect.c b/bisect.c
index 886e630884..a25d008693 100644
--- a/bisect.c
+++ b/bisect.c
@@ -754,9 +754,9 @@ static void handle_bad_merge_base(void)
 	exit(1);
 }
 
-static void handle_skipped_merge_base(const unsigned char *mb)
+static void handle_skipped_merge_base(const struct object_id *mb)
 {
-	char *mb_hex = sha1_to_hex(mb);
+	char *mb_hex = oid_to_hex(mb);
 	char *bad_hex = oid_to_hex(current_bad_oid);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
@@ -787,16 +787,16 @@ static void check_merge_bases(int no_checkout)
 	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
 
 	for (; result; result = result->next) {
-		const unsigned char *mb = result->item->object.oid.hash;
-		if (!hashcmp(mb, current_bad_oid->hash)) {
+		const struct object_id *mb = &result->item->object.oid;
+		if (!oidcmp(mb, current_bad_oid)) {
 			handle_bad_merge_base();
-		} else if (0 <= sha1_array_lookup(&good_revs, mb)) {
+		} else if (0 <= sha1_array_lookup(&good_revs, mb->hash)) {
 			continue;
-		} else if (0 <= sha1_array_lookup(&skipped_revs, mb)) {
+		} else if (0 <= sha1_array_lookup(&skipped_revs, mb->hash)) {
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			exit(bisect_checkout(mb, no_checkout));
+			exit(bisect_checkout(mb->hash, no_checkout));
 		}
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dfeacd5c37..dca1b68e69 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2670,14 +2670,14 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
  */
 static struct sha1_array recent_objects;
 
-static int loosened_object_can_be_discarded(const unsigned char *sha1,
+static int loosened_object_can_be_discarded(const struct object_id *oid,
 					    unsigned long mtime)
 {
 	if (!unpack_unreachable_expiration)
 		return 0;
 	if (mtime > unpack_unreachable_expiration)
 		return 0;
-	if (sha1_array_lookup(&recent_objects, sha1) >= 0)
+	if (sha1_array_lookup(&recent_objects, oid->hash) >= 0)
 		return 0;
 	return 1;
 }
@@ -2686,7 +2686,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 {
 	struct packed_git *p;
 	uint32_t i;
-	const unsigned char *sha1;
+	struct object_id oid;
 
 	for (p = packed_git; p; p = p->next) {
 		if (!p->pack_local || p->pack_keep)
@@ -2696,11 +2696,11 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 			die("cannot open pack index");
 
 		for (i = 0; i < p->num_objects; i++) {
-			sha1 = nth_packed_object_sha1(p, i);
-			if (!packlist_find(&to_pack, sha1, NULL) &&
-			    !has_sha1_pack_kept_or_nonlocal(sha1) &&
-			    !loosened_object_can_be_discarded(sha1, p->mtime))
-				if (force_object_loose(sha1, p->mtime))
+			nth_packed_object_oid(&oid, p, i);
+			if (!packlist_find(&to_pack, oid.hash, NULL) &&
+			    !has_sha1_pack_kept_or_nonlocal(oid.hash) &&
+			    !loosened_object_can_be_discarded(&oid, p->mtime))
+				if (force_object_loose(oid.hash, p->mtime))
 					die("unable to force loose object");
 		}
 	}
diff --git a/ref-filter.c b/ref-filter.c
index 9c82b5b9d6..d3dcb53dd5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1677,22 +1677,22 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
  * the need to parse the object via parse_object(). peel_ref() might be a
  * more efficient alternative to obtain the pointee.
  */
-static const unsigned char *match_points_at(struct sha1_array *points_at,
-					    const unsigned char *sha1,
-					    const char *refname)
+static const struct object_id *match_points_at(struct sha1_array *points_at,
+					       const struct object_id *oid,
+					       const char *refname)
 {
-	const unsigned char *tagged_sha1 = NULL;
+	const struct object_id *tagged_oid = NULL;
 	struct object *obj;
 
-	if (sha1_array_lookup(points_at, sha1) >= 0)
-		return sha1;
-	obj = parse_object(sha1);
+	if (sha1_array_lookup(points_at, oid->hash) >= 0)
+		return oid;
+	obj = parse_object(oid->hash);
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type == OBJ_TAG)
-		tagged_sha1 = ((struct tag *)obj)->tagged->oid.hash;
-	if (tagged_sha1 && sha1_array_lookup(points_at, tagged_sha1) >= 0)
-		return tagged_sha1;
+		tagged_oid = &((struct tag *)obj)->tagged->oid;
+	if (tagged_oid && sha1_array_lookup(points_at, tagged_oid->hash) >= 0)
+		return tagged_oid;
 	return NULL;
 }
 
@@ -1772,7 +1772,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	if (!filter_pattern_match(filter, refname))
 		return 0;
 
-	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
+	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid, refname))
 		return 0;
 
 	/*
