Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58D81F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeBYVMw (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33938 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751928AbeBYVMn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:43 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 99D9F60E4F;
        Sun, 25 Feb 2018 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593162;
        bh=moz7LrlWxTo0NW+jhuZ7DAHz8noxUp2oJxvCnXhu3P0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0C882W6T1ErtEqIamIuSxK8oxChrA5MjYE9Q7GNL1FH0T4eodi6VEnsVmZQpdMnrh
         HkEpMKOMYJpvWPdKKdo20gioy6RtbAxPrq14Tv8gMXACdjl4r8rD7KINoidMsaknl4
         kadywzIoF7RBkPigqsfIu+jXaeSHh21mGeL3H51lFvcyU1uYOXqOg+BMOJ/S0QbqMl
         gsZPeeVtUY86w7yU2jzy6mLPKceHTJ+I+oj576Crsu6MjN7S92mzfAkfq9UWz8ZArl
         jBnCVga4CKNJCV+1bwFGfqzv5VGgJF2r2clFx/Lh6GIyJx52fKsjaR+PClPmNPp4WZ
         ijVTaNkb11qcI50Dr/OomLssBTchHuSeutphvIW6jHELBvn8lqtnBZwz/y6QSzRer5
         Voqg4pzHjVFZKFW01OkM5k+NUTPonMH/rl0QjO4NAD6QFsedTpDJjwYAnIO0SGi6NV
         Jfbg8BbJMbV7MdP48Ja0hELKnB9TBEyU+Im3ZRr9YuAS5rwkSUU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 17/36] builtin/index-pack: convert struct ref_delta_entry to object_id
Date:   Sun, 25 Feb 2018 21:11:53 +0000
Message-Id: <20180225211212.477570-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this struct to use a member of type object_id.  Convert various
static functions as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7e3e1a461c..5c7ab47c36 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -58,7 +58,7 @@ struct ofs_delta_entry {
 };
 
 struct ref_delta_entry {
-	unsigned char sha1[20];
+	struct object_id oid;
 	int obj_no;
 };
 
@@ -671,18 +671,18 @@ static void find_ofs_delta_children(off_t offset,
 	*last_index = last;
 }
 
-static int compare_ref_delta_bases(const unsigned char *sha1,
-				   const unsigned char *sha2,
+static int compare_ref_delta_bases(const struct object_id *oid1,
+				   const struct object_id *oid2,
 				   enum object_type type1,
 				   enum object_type type2)
 {
 	int cmp = type1 - type2;
 	if (cmp)
 		return cmp;
-	return hashcmp(sha1, sha2);
+	return oidcmp(oid1, oid2);
 }
 
-static int find_ref_delta(const unsigned char *sha1, enum object_type type)
+static int find_ref_delta(const struct object_id *oid, enum object_type type)
 {
 	int first = 0, last = nr_ref_deltas;
 
@@ -691,7 +691,7 @@ static int find_ref_delta(const unsigned char *sha1, enum object_type type)
 		struct ref_delta_entry *delta = &ref_deltas[next];
 		int cmp;
 
-		cmp = compare_ref_delta_bases(sha1, delta->sha1,
+		cmp = compare_ref_delta_bases(oid, &delta->oid,
 					      type, objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
@@ -704,11 +704,11 @@ static int find_ref_delta(const unsigned char *sha1, enum object_type type)
 	return -first-1;
 }
 
-static void find_ref_delta_children(const unsigned char *sha1,
+static void find_ref_delta_children(const struct object_id *oid,
 				    int *first_index, int *last_index,
 				    enum object_type type)
 {
-	int first = find_ref_delta(sha1, type);
+	int first = find_ref_delta(oid, type);
 	int last = first;
 	int end = nr_ref_deltas - 1;
 
@@ -717,9 +717,9 @@ static void find_ref_delta_children(const unsigned char *sha1,
 		*last_index = -1;
 		return;
 	}
-	while (first > 0 && !hashcmp(ref_deltas[first - 1].sha1, sha1))
+	while (first > 0 && !oidcmp(&ref_deltas[first - 1].oid, oid))
 		--first;
-	while (last < end && !hashcmp(ref_deltas[last + 1].sha1, sha1))
+	while (last < end && !oidcmp(&ref_deltas[last + 1].oid, oid))
 		++last;
 	*first_index = first;
 	*last_index = last;
@@ -991,7 +991,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
 	if (base->ref_last == -1 && base->ofs_last == -1) {
-		find_ref_delta_children(base->obj->idx.oid.hash,
+		find_ref_delta_children(&base->obj->idx.oid,
 					&base->ref_first, &base->ref_last,
 					OBJ_REF_DELTA);
 
@@ -1075,7 +1075,7 @@ static int compare_ref_delta_entry(const void *a, const void *b)
 	const struct ref_delta_entry *delta_a = a;
 	const struct ref_delta_entry *delta_b = b;
 
-	return hashcmp(delta_a->sha1, delta_b->sha1);
+	return oidcmp(&delta_a->oid, &delta_b->oid);
 }
 
 static void resolve_base(struct object_entry *obj)
@@ -1141,7 +1141,7 @@ static void parse_pack_objects(unsigned char *hash)
 			ofs_delta++;
 		} else if (obj->type == OBJ_REF_DELTA) {
 			ALLOC_GROW(ref_deltas, nr_ref_deltas + 1, ref_deltas_alloc);
-			hashcpy(ref_deltas[nr_ref_deltas].sha1, ref_delta_oid.hash);
+			oidcpy(&ref_deltas[nr_ref_deltas].oid, &ref_delta_oid);
 			ref_deltas[nr_ref_deltas].obj_no = i;
 			nr_ref_deltas++;
 		} else if (!data) {
@@ -1373,14 +1373,14 @@ static void fix_unresolved_deltas(struct hashfile *f)
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		base_obj->data = read_sha1_file(d->sha1, &type, &base_obj->size);
+		base_obj->data = read_sha1_file(d->oid.hash, &type, &base_obj->size);
 		if (!base_obj->data)
 			continue;
 
-		if (check_sha1_signature(d->sha1, base_obj->data,
+		if (check_sha1_signature(d->oid.hash, base_obj->data,
 				base_obj->size, typename(type)))
-			die(_("local object %s is corrupt"), sha1_to_hex(d->sha1));
-		base_obj->obj = append_obj_to_pack(f, d->sha1,
+			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
+		base_obj->obj = append_obj_to_pack(f, d->oid.hash,
 					base_obj->data, base_obj->size, type);
 		find_unresolved_deltas(base_obj);
 		display_progress(progress, nr_resolved_deltas);
