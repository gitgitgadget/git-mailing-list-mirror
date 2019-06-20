Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223611F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfFTHlN (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:45300 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfFTHlN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:13 -0400
Received: (qmail 16526 invoked by uid 109); 20 Jun 2019 07:41:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12785 invoked by uid 111); 20 Jun 2019 07:42:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:10 -0400
Date:   Thu, 20 Jun 2019 03:41:10 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/17] object: convert lookup_unknown_object() to use
 object_id
Message-ID: <20190620074110.GF3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers left of lookup_unknown_object() that aren't just
passing us the "hash" member of a "struct object_id". Let's take the
whole struct, which gets us closer to removing all raw sha1 variables.
It also matches the existing conversions of lookup_blob(), etc.

The conversions of callers were done by hand, but they're all mechanical
one-liners.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c                   | 2 +-
 builtin/pack-objects.c           | 2 +-
 fsck.c                           | 2 +-
 http-push.c                      | 2 +-
 object.c                         | 6 +++---
 object.h                         | 2 +-
 refs.c                           | 2 +-
 t/helper/test-example-decorate.c | 6 +++---
 upload-pack.c                    | 2 +-
 walker.c                         | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d26fb0a044..e422c82465 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -756,7 +756,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 
 static void mark_object_for_connectivity(const struct object_id *oid)
 {
-	struct object *obj = lookup_unknown_object(oid->hash);
+	struct object *obj = lookup_unknown_object(oid);
 	obj->flags |= HAS_OBJ;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c95693fd4b..3e8467aa23 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2923,7 +2923,7 @@ static void add_objects_in_unpacked_packs(void)
 
 		for (i = 0; i < p->num_objects; i++) {
 			nth_packed_object_oid(&oid, p, i);
-			o = lookup_unknown_object(oid.hash);
+			o = lookup_unknown_object(&oid);
 			if (!(o->flags & OBJECT_ADDED))
 				mark_in_pack_object(o, p, &in_pack);
 			o->flags |= OBJECT_ADDED;
diff --git a/fsck.c b/fsck.c
index 4703f55561..117c4a978f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1092,7 +1092,7 @@ int fsck_finish(struct fsck_options *options)
 
 		blob = lookup_blob(the_repository, oid);
 		if (!blob) {
-			struct object *obj = lookup_unknown_object(oid->hash);
+			struct object *obj = lookup_unknown_object(oid);
 			ret |= report(options, obj,
 				      FSCK_MSG_GITMODULES_BLOB,
 				      "non-blob found at .gitmodules");
diff --git a/http-push.c b/http-push.c
index e36561a6db..96a98e1e61 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1432,7 +1432,7 @@ static void one_remote_ref(const char *refname)
 	 * may be required for updating server info later.
 	 */
 	if (repo->can_update_info_refs && !has_object_file(&ref->old_oid)) {
-		obj = lookup_unknown_object(ref->old_oid.hash);
+		obj = lookup_unknown_object(&ref->old_oid);
 		fprintf(stderr,	"  fetch %s for %s\n",
 			oid_to_hex(&ref->old_oid), refname);
 		add_fetch_request(obj);
diff --git a/object.c b/object.c
index e81d47a79c..d5b1d8daaf 100644
--- a/object.c
+++ b/object.c
@@ -178,11 +178,11 @@ void *object_as_type(struct repository *r, struct object *obj, enum object_type
 	}
 }
 
-struct object *lookup_unknown_object(const unsigned char *sha1)
+struct object *lookup_unknown_object(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, sha1);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
-		obj = create_object(the_repository, sha1,
+		obj = create_object(the_repository, oid->hash,
 				    alloc_object_node(the_repository));
 	return obj;
 }
diff --git a/object.h b/object.h
index 4526979ccf..5e0ccfe0e4 100644
--- a/object.h
+++ b/object.h
@@ -143,7 +143,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
 struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
-struct object *lookup_unknown_object(const unsigned  char *sha1);
+struct object *lookup_unknown_object(const struct object_id *oid);
 
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
diff --git a/refs.c b/refs.c
index b8a8430c96..cd297ee4bd 100644
--- a/refs.c
+++ b/refs.c
@@ -379,7 +379,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 
 enum peel_status peel_object(const struct object_id *name, struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(name->hash);
+	struct object *o = lookup_unknown_object(name);
 
 	if (o->type == OBJ_NONE) {
 		int type = oid_object_info(the_repository, name, NULL);
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index a20a6161e4..c8a1cde7d2 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -26,8 +26,8 @@ int cmd__example_decorate(int argc, const char **argv)
 	 * Add 2 objects, one with a non-NULL decoration and one with a NULL
 	 * decoration.
 	 */
-	one = lookup_unknown_object(one_oid.hash);
-	two = lookup_unknown_object(two_oid.hash);
+	one = lookup_unknown_object(&one_oid);
+	two = lookup_unknown_object(&two_oid);
 	ret = add_decoration(&n, one, &decoration_a);
 	if (ret)
 		BUG("when adding a brand-new object, NULL should be returned");
@@ -56,7 +56,7 @@ int cmd__example_decorate(int argc, const char **argv)
 	ret = lookup_decoration(&n, two);
 	if (ret != &decoration_b)
 		BUG("lookup should return added declaration");
-	three = lookup_unknown_object(three_oid.hash);
+	three = lookup_unknown_object(&three_oid);
 	ret = lookup_decoration(&n, three);
 	if (ret)
 		BUG("lookup for unknown object should return NULL");
diff --git a/upload-pack.c b/upload-pack.c
index d9a62adef0..ecc19641fe 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -960,7 +960,7 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
 static int mark_our_ref(const char *refname, const char *refname_full,
 			const struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(oid->hash);
+	struct object *o = lookup_unknown_object(oid);
 
 	if (ref_is_hidden(refname, refname_full)) {
 		o->flags |= HIDDEN_REF;
diff --git a/walker.c b/walker.c
index d74ae59c77..06cd2bd569 100644
--- a/walker.c
+++ b/walker.c
@@ -285,7 +285,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
 			goto done;
 		}
-		if (process(walker, lookup_unknown_object(oids[i].hash)))
+		if (process(walker, lookup_unknown_object(&oids[i])))
 			goto done;
 	}
 
-- 
2.22.0.732.g5402924b4b

