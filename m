Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC81C43461
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78516120E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhDMHQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:16:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:50766 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237707AbhDMHQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:16:57 -0400
Received: (qmail 28530 invoked by uid 109); 13 Apr 2021 07:16:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:16:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23019 invoked by uid 111); 13 Apr 2021 07:16:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:16:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:16:36 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] lookup_unknown_object(): take a repository argument
Message-ID: <YHVFVJXUbtZTgXeR@coredump.intra.peff.net>
References: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the other lookup_foo() functions take a repository argument, but
lookup_unknown_object() was never converted, and it uses the_repository
internally. Let's fix that.

We could leave a wrapper that uses the_repository, but there aren't that
many calls, so we'll just convert them all. I looked briefly at each
site to see if we had a repository struct (besides the_repository) we
could pass, but none of them do (so this conversion to pass
the_repository is a pure noop in each case, though it does take us one
step closer to eventually getting rid of the_repository).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c                   | 2 +-
 builtin/pack-objects.c           | 2 +-
 http-push.c                      | 2 +-
 object.c                         | 7 +++----
 object.h                         | 2 +-
 refs.c                           | 2 +-
 t/helper/test-example-decorate.c | 6 +++---
 upload-pack.c                    | 2 +-
 walker.c                         | 2 +-
 9 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 70ff95837a..e6a80e5404 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -725,7 +725,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 
 static void mark_object_for_connectivity(const struct object_id *oid)
 {
-	struct object *obj = lookup_unknown_object(oid);
+	struct object *obj = lookup_unknown_object(the_repository, oid);
 	obj->flags |= HAS_OBJ;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 525c2d8552..c1186f50a3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3386,7 +3386,7 @@ static void add_objects_in_unpacked_packs(void)
 
 		for (i = 0; i < p->num_objects; i++) {
 			nth_packed_object_id(&oid, p, i);
-			o = lookup_unknown_object(&oid);
+			o = lookup_unknown_object(the_repository, &oid);
 			if (!(o->flags & OBJECT_ADDED))
 				mark_in_pack_object(o, p, &in_pack);
 			o->flags |= OBJECT_ADDED;
diff --git a/http-push.c b/http-push.c
index b60d5fcc85..813123242e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1436,7 +1436,7 @@ static void one_remote_ref(const char *refname)
 	 * may be required for updating server info later.
 	 */
 	if (repo->can_update_info_refs && !has_object_file(&ref->old_oid)) {
-		obj = lookup_unknown_object(&ref->old_oid);
+		obj = lookup_unknown_object(the_repository, &ref->old_oid);
 		fprintf(stderr,	"  fetch %s for %s\n",
 			oid_to_hex(&ref->old_oid), refname);
 		add_fetch_request(obj);
diff --git a/object.c b/object.c
index 78343781ae..14188453c5 100644
--- a/object.c
+++ b/object.c
@@ -177,12 +177,11 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 }
 
-struct object *lookup_unknown_object(const struct object_id *oid)
+struct object *lookup_unknown_object(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid);
+	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		obj = create_object(the_repository, oid,
-				    alloc_object_node(the_repository));
+		obj = create_object(r, oid, alloc_object_node(r));
 	return obj;
 }
 
diff --git a/object.h b/object.h
index 59daadce21..87a6da47c8 100644
--- a/object.h
+++ b/object.h
@@ -145,7 +145,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
 struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
-struct object *lookup_unknown_object(const struct object_id *oid);
+struct object *lookup_unknown_object(struct repository *r, const struct object_id *oid);
 
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
diff --git a/refs.c b/refs.c
index 261fd82beb..1616c7554a 100644
--- a/refs.c
+++ b/refs.c
@@ -337,7 +337,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 
 enum peel_status peel_object(const struct object_id *name, struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(name);
+	struct object *o = lookup_unknown_object(the_repository, name);
 
 	if (o->type == OBJ_NONE) {
 		int type = oid_object_info(the_repository, name, NULL);
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index c8a1cde7d2..b9d1200eb9 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -26,8 +26,8 @@ int cmd__example_decorate(int argc, const char **argv)
 	 * Add 2 objects, one with a non-NULL decoration and one with a NULL
 	 * decoration.
 	 */
-	one = lookup_unknown_object(&one_oid);
-	two = lookup_unknown_object(&two_oid);
+	one = lookup_unknown_object(the_repository, &one_oid);
+	two = lookup_unknown_object(the_repository, &two_oid);
 	ret = add_decoration(&n, one, &decoration_a);
 	if (ret)
 		BUG("when adding a brand-new object, NULL should be returned");
@@ -56,7 +56,7 @@ int cmd__example_decorate(int argc, const char **argv)
 	ret = lookup_decoration(&n, two);
 	if (ret != &decoration_b)
 		BUG("lookup should return added declaration");
-	three = lookup_unknown_object(&three_oid);
+	three = lookup_unknown_object(the_repository, &three_oid);
 	ret = lookup_decoration(&n, three);
 	if (ret)
 		BUG("lookup for unknown object should return NULL");
diff --git a/upload-pack.c b/upload-pack.c
index e19583ae0f..5c1cd19612 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1153,7 +1153,7 @@ static void receive_needs(struct upload_pack_data *data,
 static int mark_our_ref(const char *refname, const char *refname_full,
 			const struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(oid);
+	struct object *o = lookup_unknown_object(the_repository, oid);
 
 	if (ref_is_hidden(refname, refname_full)) {
 		o->flags |= HIDDEN_REF;
diff --git a/walker.c b/walker.c
index 4984bf8b3d..c5e2921979 100644
--- a/walker.c
+++ b/walker.c
@@ -298,7 +298,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
 			goto done;
 		}
-		if (process(walker, lookup_unknown_object(&oids[i])))
+		if (process(walker, lookup_unknown_object(the_repository, &oids[i])))
 			goto done;
 	}
 
-- 
2.31.1.659.g9b9913af63

