Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0FD120966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbdCaBkk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:40 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59226 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935093AbdCaBkP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:15 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 08EDC280B3;
        Fri, 31 Mar 2017 01:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924414;
        bh=4/rCZbucrumdNoO0bsiSA+sJNFKr3uOoFHmNeT6ruAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwZrJ1r4vU0x6lRlYxQUti/XgJpELBvORwCf+H2rdarrA6LL32lu5sLXOn5UPleX9
         Qzm8PPHSHsT7YXrlDWsxoXX4Sfny03JH96NlfspiuFmr4LsSG97yKLSWvx2HYFV8b4
         CAEV/9qsCNPn5A5porsfowsWxmX5IIGUIjem5UTiIjCPyrUPHTfGTbrN2k121L6ZGW
         SB9K5bJBp4kJcKx3/pXRQpPPC2/J+C3SzyIuYxxGpZWeZevc/Pc4l4ALtwddH96OaZ
         div8Eer3LY1m3LJe9j+WtqRV1AABCb4/tpFAdoHRI3Mab8i0NVPL2YVI958pTdfDMN
         7MG4EZdF0Efhhj6+yoCCwW5/GqpI0AccoCoGoPzFgKxDOkY0f9/goomMfWmtuCcMVk
         iBsdyVcASPcCFFLEXPIjvyit78gR4LGpPMIlmC1m0BieB/9oax4KUsWPKgCLnN1CZ2
         +xytWtM06Q6+dnDKMVJeIT0RZ4icpyEsfQbmeo1uJOMZtIJyygr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/20] Convert sha1_array_lookup to take struct object_id
Date:   Fri, 31 Mar 2017 01:39:58 +0000
Message-Id: <20170331014001.953484-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this function by changing the declaration and definition and
applying the following semantic patch to update the callers:

@@
expression E1, E2;
@@
- sha1_array_lookup(E1, E2.hash)
+ sha1_array_lookup(E1, &E2)

@@
expression E1, E2;
@@
- sha1_array_lookup(E1, E2->hash)
+ sha1_array_lookup(E1, E2)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c                   | 7 +++----
 builtin/pack-objects.c     | 2 +-
 fsck.c                     | 2 +-
 ref-filter.c               | 4 ++--
 sha1-array.c               | 4 ++--
 sha1-array.h               | 2 +-
 t/helper/test-sha1-array.c | 2 +-
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index a25d008693..f193257509 100644
--- a/bisect.c
+++ b/bisect.c
@@ -499,8 +499,7 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	while (list) {
 		struct commit_list *next = list->next;
 		list->next = NULL;
-		if (0 <= sha1_array_lookup(&skipped_revs,
-					   list->item->object.oid.hash)) {
+		if (0 <= sha1_array_lookup(&skipped_revs, &list->item->object.oid)) {
 			if (skipped_first && !*skipped_first)
 				*skipped_first = 1;
 			/* Move current to tried list */
@@ -790,9 +789,9 @@ static void check_merge_bases(int no_checkout)
 		const struct object_id *mb = &result->item->object.oid;
 		if (!oidcmp(mb, current_bad_oid)) {
 			handle_bad_merge_base();
-		} else if (0 <= sha1_array_lookup(&good_revs, mb->hash)) {
+		} else if (0 <= sha1_array_lookup(&good_revs, mb)) {
 			continue;
-		} else if (0 <= sha1_array_lookup(&skipped_revs, mb->hash)) {
+		} else if (0 <= sha1_array_lookup(&skipped_revs, mb)) {
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dca1b68e69..028c7be9a2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2677,7 +2677,7 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
 		return 0;
 	if (mtime > unpack_unreachable_expiration)
 		return 0;
-	if (sha1_array_lookup(&recent_objects, oid->hash) >= 0)
+	if (sha1_array_lookup(&recent_objects, oid) >= 0)
 		return 0;
 	return 1;
 }
diff --git a/fsck.c b/fsck.c
index 6682de1de5..24daedd6cc 100644
--- a/fsck.c
+++ b/fsck.c
@@ -280,7 +280,7 @@ static int report(struct fsck_options *options, struct object *object,
 		return 0;
 
 	if (options->skiplist && object &&
-			sha1_array_lookup(options->skiplist, object->oid.hash) >= 0)
+			sha1_array_lookup(options->skiplist, &object->oid) >= 0)
 		return 0;
 
 	if (msg_type == FSCK_FATAL)
diff --git a/ref-filter.c b/ref-filter.c
index d3dcb53dd5..4ee7ebcda3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1684,14 +1684,14 @@ static const struct object_id *match_points_at(struct sha1_array *points_at,
 	const struct object_id *tagged_oid = NULL;
 	struct object *obj;
 
-	if (sha1_array_lookup(points_at, oid->hash) >= 0)
+	if (sha1_array_lookup(points_at, oid) >= 0)
 		return oid;
 	obj = parse_object(oid->hash);
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type == OBJ_TAG)
 		tagged_oid = &((struct tag *)obj)->tagged->oid;
-	if (tagged_oid && sha1_array_lookup(points_at, tagged_oid->hash) >= 0)
+	if (tagged_oid && sha1_array_lookup(points_at, tagged_oid) >= 0)
 		return tagged_oid;
 	return NULL;
 }
diff --git a/sha1-array.c b/sha1-array.c
index 26e596b264..1082b3dc11 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -26,11 +26,11 @@ static const unsigned char *sha1_access(size_t index, void *table)
 	return array[index].hash;
 }
 
-int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1)
+int sha1_array_lookup(struct sha1_array *array, const struct object_id *oid)
 {
 	if (!array->sorted)
 		sha1_array_sort(array);
-	return sha1_pos(sha1, array->oid, array->nr, sha1_access);
+	return sha1_pos(oid->hash, array->oid, array->nr, sha1_access);
 }
 
 void sha1_array_clear(struct sha1_array *array)
diff --git a/sha1-array.h b/sha1-array.h
index 4e60576a82..24347e7655 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -11,7 +11,7 @@ struct sha1_array {
 #define SHA1_ARRAY_INIT { NULL, 0, 0, 0 }
 
 void sha1_array_append(struct sha1_array *array, const struct object_id *oid);
-int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1);
+int sha1_array_lookup(struct sha1_array *array, const struct object_id *oid);
 void sha1_array_clear(struct sha1_array *array);
 
 typedef int (*for_each_sha1_fn)(const unsigned char sha1[20],
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index 181c36e0a5..3680511849 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -23,7 +23,7 @@ int cmd_main(int argc, const char **argv)
 		} else if (skip_prefix(line.buf, "lookup ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
-			printf("%d\n", sha1_array_lookup(&array, oid.hash));
+			printf("%d\n", sha1_array_lookup(&array, &oid));
 		} else if (!strcmp(line.buf, "clear"))
 			sha1_array_clear(&array);
 		else if (!strcmp(line.buf, "for_each_unique"))
