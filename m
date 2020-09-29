Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD0C47423
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AF9207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="NJdWtB7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgI2QNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgI2QNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:21 -0400
X-Greylist: delayed 1154 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Sep 2020 09:13:21 PDT
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461EDC061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6SIbWqMd6ALJL15kcw4uSbQrAzA0tn0HFJx01+hXuaA=; b=NJdWtB7hUCJ69L1a5htaUNHH9r
        5rPK6gROy/FegIRFjr7O34XTu1qvArGNLfWioPuQCOI+I5sfwYaErRpVcNrzZAIdlHK0NA9HI0mSB
        ufX/6Os16hmoFiLrv5+DCUq48rSLz24x35XVh39WqeOjHdKCc9wLlwnypOH6/FWQ7cEk=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNHx8-0004AY-DU; Tue, 29 Sep 2020 15:54:06 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 4/7] refs: use correct repo in refs_peel_ref
Date:   Tue, 29 Sep 2020 16:53:47 +0100
Message-Id: <20200929155350.49066-5-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929155350.49066-1-andrew@adoakley.name>
References: <20200929155350.49066-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This required a few other functions to be updated to pass the corret
repo through.  If there is no repository, fail.

This change doesn't fix any known issue.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 builtin/fsck.c                   |  2 +-
 builtin/pack-objects.c           |  2 +-
 http-push.c                      |  2 +-
 object.c                         |  7 +++----
 object.h                         |  2 +-
 refs.c                           | 15 ++++++++++-----
 refs/packed-backend.c            |  5 +++--
 refs/ref-cache.c                 |  2 +-
 refs/refs-internal.h             |  4 +++-
 t/helper/test-example-decorate.c |  6 +++---
 t/helper/test-reach.c            |  2 +-
 tag.c                            |  4 ++--
 tag.h                            |  2 +-
 upload-pack.c                    |  2 +-
 walker.c                         |  3 ++-
 15 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fbf26cafcf..9ce450d372 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -745,7 +745,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 
 static void mark_object_for_connectivity(const struct object_id *oid)
 {
-	struct object *obj = lookup_unknown_object(oid);
+	struct object *obj = lookup_unknown_object(the_repository, oid);
 	obj->flags |= HAS_OBJ;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5617c01b5a..7ee63cb192 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3161,7 +3161,7 @@ static void add_objects_in_unpacked_packs(void)
 
 		for (i = 0; i < p->num_objects; i++) {
 			nth_packed_object_id(&oid, p, i);
-			o = lookup_unknown_object(&oid);
+			o = lookup_unknown_object(the_repository, &oid);
 			if (!(o->flags & OBJECT_ADDED))
 				mark_in_pack_object(o, p, &in_pack);
 			o->flags |= OBJECT_ADDED;
diff --git a/http-push.c b/http-push.c
index 6a4a43e07f..a9d1383165 100644
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
index 3257518656..a538d2dd77 100644
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
index 20b18805f0..8d6daf6df7 100644
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
index e62da6f2de..ceff6d2af5 100644
--- a/refs.c
+++ b/refs.c
@@ -336,12 +336,14 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 	return filter->fn(refname, oid, flags, filter->cb_data);
 }
 
-enum peel_status peel_object(const struct object_id *name, struct object_id *oid)
+enum peel_status peel_object(struct repository *repo,
+			     const struct object_id *name,
+			     struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(name);
+	struct object *o = lookup_unknown_object(repo, name);
 
 	if (o->type == OBJ_NONE) {
-		int type = oid_object_info(the_repository, name, NULL);
+		int type = oid_object_info(repo, name, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
 	}
@@ -349,7 +351,7 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 	if (o->type != OBJ_TAG)
 		return PEEL_NON_TAG;
 
-	o = deref_tag_noverify(o);
+	o = deref_tag_noverify(repo, o);
 	if (!o)
 		return PEEL_INVALID;
 
@@ -1903,7 +1905,10 @@ int refs_peel_ref(struct ref_store *refs, const char *refname,
 			       RESOLVE_REF_READING, &base, &flag))
 		return -1;
 
-	return peel_object(&base, oid);
+	if (!refs->repo)
+		return -1;
+
+	return peel_object(refs->repo, &base, oid);
 }
 
 int peel_ref(const char *refname, struct object_id *oid)
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 9743ee0155..0d598ee76c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -892,7 +892,7 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
 		return -1;
 	} else {
-		return !!peel_object(&iter->oid, peeled);
+		return !!peel_object(ref_iterator->repo, &iter->oid, peeled);
 	}
 }
 
@@ -1242,7 +1242,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 			i++;
 		} else {
 			struct object_id peeled;
-			int peel_error = peel_object(&update->new_oid,
+			int peel_error = peel_object(refs->base.repo,
+						     &update->new_oid,
 						     &peeled);
 
 			if (write_packed_entry(out, update->refname,
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 974d37ee79..fc54c4eae3 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -491,7 +491,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	return peel_object(ref_iterator->oid, peeled);
+	return peel_object(ref_iterator->repo, ref_iterator->oid, peeled);
 }
 
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9e9b2e8c76..b08fd7a247 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -102,7 +102,9 @@ enum peel_status {
  * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
  * and leave oid unchanged.
  */
-enum peel_status peel_object(const struct object_id *name, struct object_id *oid);
+enum peel_status peel_object(struct repository *repo,
+			     const struct object_id *name,
+			     struct object_id *oid);
 
 /**
  * Information needed for a single ref update. Set new_oid to the new
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
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 14a3655442..9bae4b0682 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -61,7 +61,7 @@ int cmd__reach(int ac, const char **av)
 			die("failed to resolve %s", buf.buf + 2);
 
 		orig = parse_object(r, &oid);
-		peeled = deref_tag_noverify(orig);
+		peeled = deref_tag_noverify(r, orig);
 
 		if (!peeled)
 			die("failed to load commit for input %s resulting in oid %s\n",
diff --git a/tag.c b/tag.c
index 1ed2684e45..1ba7fda738 100644
--- a/tag.c
+++ b/tag.c
@@ -86,10 +86,10 @@ struct object *deref_tag(struct repository *r, struct object *o, const char *war
 	return o;
 }
 
-struct object *deref_tag_noverify(struct object *o)
+struct object *deref_tag_noverify(struct repository *r, struct object *o)
 {
 	while (o && o->type == OBJ_TAG) {
-		o = parse_object(the_repository, &o->oid);
+		o = parse_object(r, &o->oid);
 		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged)
 			o = ((struct tag *)o)->tagged;
 		else
diff --git a/tag.h b/tag.h
index 3ce8e72192..c49d7c19ad 100644
--- a/tag.h
+++ b/tag.h
@@ -16,7 +16,7 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 int parse_tag(struct tag *item);
 void release_tag_memory(struct tag *t);
 struct object *deref_tag(struct repository *r, struct object *, const char *, int);
-struct object *deref_tag_noverify(struct object *);
+struct object *deref_tag_noverify(struct repository *r, struct object *);
 int gpg_verify_tag(const struct object_id *oid,
 		   const char *name_to_report, unsigned flags);
 struct object_id *get_tagged_oid(struct tag *tag);
diff --git a/upload-pack.c b/upload-pack.c
index 3b858eb457..ccbb8887b0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1149,7 +1149,7 @@ static void receive_needs(struct upload_pack_data *data,
 static int mark_our_ref(const char *refname, const char *refname_full,
 			const struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(oid);
+	struct object *o = lookup_unknown_object(the_repository, oid);
 
 	if (ref_is_hidden(refname, refname_full)) {
 		o->flags |= HIDDEN_REF;
diff --git a/walker.c b/walker.c
index 4984bf8b3d..2a5cc90418 100644
--- a/walker.c
+++ b/walker.c
@@ -298,7 +298,8 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
 			goto done;
 		}
-		if (process(walker, lookup_unknown_object(&oids[i])))
+		if (process(walker,
+			    lookup_unknown_object(the_repository, &oids[i])))
 			goto done;
 	}
 
-- 
2.26.2

