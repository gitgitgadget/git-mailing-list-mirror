Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139EE39EF2C
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331759; cv=none; b=tVamFYEPpCcmwj9hx4J4aXhYzLkuhcOrTjjxkMTgIa8UQUkouSEUvCcBs802A+BdYCoK4KizjkkHxfJzGLmgsy+MEjWGuYJW7JARoRTYubPb6LfFCZx8GpTaESCTGCjjMqq5+en87vatOXBH3N4ZkHcNT+v/B2yfXEBpIDbH/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331759; c=relaxed/simple;
	bh=ZUDluvwZn5DD8n+EYcAtazvhaGUATXV75vup5Uv1cPk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9nX2WJKXw35pjdEAMJSvaQzZua+uGN9I0rO4YNRAs6GrUsNRGHw7MjmmRmyH3pdwjaASTzIqumKyoaPA5n28sU0EBQA4mrxQR88V0u4Yc8qetZ3tK2jjJuifALADtSUn6XS+ZeCY3TMm8E3x4uM/ZEumyvjlKXz6rtD3HEwQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B9i9Tqoh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B9i9Tqoh"
Received: (qmail 10105 invoked by uid 106); 2 Sep 2026 06:49:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZUDluvwZn5DD8n+EYcAtazvhaGUATXV75vup5Uv1cPk=; b=B9i9TqohY7802/Y+fDqg/eDyYWxPLdK8O98ku/lBoiFhYelOECi2OMN7Umn244/TTi9lPErNQPf8HtJEaJPOKKX6G2R4BTzphST72Z3KxMvYgXL8a3vMEvRirWEMhRNCxOQsZUecUl3+4pxneLEAhe5FGn42Tyjv+LS+IvvChlwjaMHlVzJFPdYXtWWziG/T9PzMWwlqLr6dATN+NSXOvOsdxWsJFRM8qJIUou24EYT929qqgoiouB/sU7tXaX819olFfBcDW4OMTZ5YBTtoZtsOw1k08PXiLQ4t9vsy7exssm4E+id2cUMpfPyQu1a0D+PvfybMFppaXkf/4yVsEw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 06:49:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 47249 invoked by uid 111); 2 Sep 2026 06:49:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 02:49:08 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 02:49:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: Re: [PATCH 1/2] repository: make repo_clear() idempotent
Message-ID: <20260902064907.GB47676@coredump.intra.peff.net>
References: <20260902055117.GA41587@coredump.intra.peff.net>
 <20260902055526.GA41747@coredump.intra.peff.net>
 <20260902062940.GA47676@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902062940.GA47676@coredump.intra.peff.net>

On Wed, Sep 02, 2026 at 02:29:40AM -0400, Jeff King wrote:

> I'm not sure how much it's worth untangling all of this, but probably
> not enough just to remove pointer indirection from repo->parsed_objects.

BTW, another curiosity: parsed_objects contains a pointer back to the
repo that contains it! What could it possibly depend on in the repo
itself?

As far as I can tell, the answer is nothing. We only ever access p->repo
in order to get to p->repo->parsed_objects, which will always be the
same as our original "p". There are some internal functions within
object.c which could be simplified by passing around the
parsed_object_pool directly.  But we also call lookup_commit() and a few
other public functions, all of which take a repository struct. Even
though they only use it to look at the parsed_objects field!

Structurally speaking these should be operating on a parsed_object_pool,
since that's all they need. But from the caller's point of view that is
just an implementation detail, and it is easier to pass in the whole
repository.

So we'd probably need to provide functions that operate directly on the
pool like:

  struct commit *lookup_commit_via_pool(struct parsed_object_pool *p,
                                        const struct object_id *oid);

and then maintain wrappers like:

  struct commit *lookup_commit(struct repository *r,
                               const struct object_id *oid)
  {
	return lookup_commit_via_pool(r->parsed_objects, oid);
  }

to avoid rewriting every caller with r->parsed_objects themselves.

The patch below illustrates the minimal change to drop the repo pointer
from parsed_object_pool. I think it more accurately represents the
actual dependencies of the data structures, but it's a fair bit of churn
for a minor amount of clarity. Probably not worth it.

---
 alloc.c  |  9 ++++--
 alloc.h  |  1 +
 commit.c | 20 +++++++++----
 commit.h |  3 ++
 object.c | 55 ++++++++++++++++++++---------------
 object.h |  3 +-
 6 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/alloc.c b/alloc.c
index 533a045c2a..e7fb90734b 100644
--- a/alloc.c
+++ b/alloc.c
@@ -121,9 +121,14 @@ void init_commit_node(struct commit *c)
 	c->index = alloc_commit_index();
 }
 
-void *alloc_commit_node(struct repository *r)
+void *alloc_commit_node_via_pool(struct parsed_object_pool *p)
 {
-	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
+	struct commit *c = alloc_node(p->commit_state, sizeof(struct commit));
 	init_commit_node(c);
 	return c;
 }
+
+void *alloc_commit_node(struct repository *r)
+{
+	return alloc_commit_node_via_pool(r->parsed_objects);
+}
diff --git a/alloc.h b/alloc.h
index 87a47a9709..70c9c726c1 100644
--- a/alloc.h
+++ b/alloc.h
@@ -11,6 +11,7 @@ void *alloc_blob_node(struct repository *r);
 void *alloc_tree_node(struct repository *r);
 void init_commit_node(struct commit *c);
 void *alloc_commit_node(struct repository *r);
+void *alloc_commit_node_via_pool(struct parsed_object_pool *p);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
 
diff --git a/commit.c b/commit.c
index ad26f0b40a..407e11f00b 100644
--- a/commit.c
+++ b/commit.c
@@ -98,14 +98,19 @@ struct commit *lookup_commit_object(struct repository *r,
 
 }
 
-struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
+struct commit *lookup_commit_via_pool(struct parsed_object_pool *p, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(r, oid);
+	struct object *obj = lookup_object_via_pool(p, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_commit_node(r));
+		return create_object_via_pool(p, oid, alloc_commit_node_via_pool(p));
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
+{
+	return lookup_commit_via_pool(r->parsed_objects, oid);
+}
+
 struct commit *lookup_commit_reference_by_name(const char *name)
 {
 	return lookup_commit_reference_by_name_gently(name, 0);
@@ -206,9 +211,9 @@ int commit_graft_pos(struct repository *r, const struct object_id *oid)
 		       commit_graft_oid_access);
 }
 
-void unparse_commit(struct repository *r, const struct object_id *oid)
+void unparse_commit_via_pool(struct parsed_object_pool *p, const struct object_id *oid)
 {
-	struct commit *c = lookup_commit(r, oid);
+	struct commit *c = lookup_commit_via_pool(p, oid);
 
 	if (!c->object.parsed)
 		return;
@@ -217,6 +222,11 @@ void unparse_commit(struct repository *r, const struct object_id *oid)
 	c->object.parsed = 0;
 }
 
+void unparse_commit(struct repository *repo, const struct object_id *oid)
+{
+	unparse_commit_via_pool(repo->parsed_objects, oid);
+}
+
 int register_commit_graft(struct repository *r, struct commit_graft *graft,
 			  int ignore_dups)
 {
diff --git a/commit.h b/commit.h
index 1061ed791b..972db23558 100644
--- a/commit.h
+++ b/commit.h
@@ -76,6 +76,8 @@ struct commit *lookup_commit_object(struct repository *r, const struct object_id
  * "oid" is not in the object cache.
  */
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
+struct commit *lookup_commit_via_pool(struct parsed_object_pool *pool,
+				      const struct object_id *oid);
 struct commit *lookup_commit_reference(struct repository *r,
 				       const struct object_id *oid);
 struct commit *lookup_commit_reference_gently(struct repository *r,
@@ -104,6 +106,7 @@ static inline int repo_parse_commit(struct repository *r, struct commit *item)
 }
 
 void unparse_commit(struct repository *r, const struct object_id *oid);
+void unparse_commit_via_pool(struct parsed_object_pool *p, const struct object_id *oid);
 
 static inline int repo_parse_commit_no_graph(struct repository *r,
 					     struct commit *commit)
diff --git a/object.c b/object.c
index 97f7fc0e87..c6b0815240 100644
--- a/object.c
+++ b/object.c
@@ -89,20 +89,20 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
  * Look up the record for the given sha1 in the hash map stored in
  * obj_hash.  Return NULL if it was not found.
  */
-struct object *lookup_object(struct repository *r, const struct object_id *oid)
+struct object *lookup_object_via_pool(struct parsed_object_pool *p, const struct object_id *oid)
 {
 	unsigned int i, first;
 	struct object *obj;
 
-	if (!r->parsed_objects->obj_hash)
+	if (!p->obj_hash)
 		return NULL;
 
-	first = i = hash_obj(oid, r->parsed_objects->obj_hash_size);
-	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
+	first = i = hash_obj(oid, p->obj_hash_size);
+	while ((obj = p->obj_hash[i]) != NULL) {
 		if (oideq(oid, &obj->oid))
 			break;
 		i++;
-		if (i == r->parsed_objects->obj_hash_size)
+		if (i == p->obj_hash_size)
 			i = 0;
 	}
 	if (obj && i != first) {
@@ -111,57 +111,66 @@ struct object *lookup_object(struct repository *r, const struct object_id *oid)
 		 * that we do not need to walk the hash table the next
 		 * time we look for it.
 		 */
-		SWAP(r->parsed_objects->obj_hash[i],
-		     r->parsed_objects->obj_hash[first]);
+		SWAP(p->obj_hash[i],
+		     p->obj_hash[first]);
 	}
 	return obj;
 }
 
+struct object *lookup_object(struct repository *r, const struct object_id *oid)
+{
+	return lookup_object_via_pool(r->parsed_objects, oid);
+}
+
 /*
  * Increase the size of the hash map stored in obj_hash to the next
  * power of 2 (but at least 32).  Copy the existing values to the new
  * hash map.
  */
-static void grow_object_hash(struct repository *r)
+static void grow_object_hash(struct parsed_object_pool *p)
 {
 	int i;
 	/*
 	 * Note that this size must always be power-of-2 to match hash_obj
 	 * above.
 	 */
-	int new_hash_size = r->parsed_objects->obj_hash_size < 32 ? 32 : 2 * r->parsed_objects->obj_hash_size;
+	int new_hash_size = p->obj_hash_size < 32 ? 32 : 2 * p->obj_hash_size;
 	struct object **new_hash;
 
 	CALLOC_ARRAY(new_hash, new_hash_size);
-	for (i = 0; i < r->parsed_objects->obj_hash_size; i++) {
-		struct object *obj = r->parsed_objects->obj_hash[i];
+	for (i = 0; i < p->obj_hash_size; i++) {
+		struct object *obj = p->obj_hash[i];
 
 		if (!obj)
 			continue;
 		insert_obj_hash(obj, new_hash, new_hash_size);
 	}
-	free(r->parsed_objects->obj_hash);
-	r->parsed_objects->obj_hash = new_hash;
-	r->parsed_objects->obj_hash_size = new_hash_size;
+	free(p->obj_hash);
+	p->obj_hash = new_hash;
+	p->obj_hash_size = new_hash_size;
 }
 
-void *create_object(struct repository *r, const struct object_id *oid, void *o)
+void *create_object_via_pool(struct parsed_object_pool *p, const struct object_id *oid, void *o)
 {
 	struct object *obj = o;
 
 	obj->parsed = 0;
 	obj->flags = 0;
 	oidcpy(&obj->oid, oid);
 
-	if (r->parsed_objects->obj_hash_size - 1 <= r->parsed_objects->nr_objs * 2)
-		grow_object_hash(r);
+	if (p->obj_hash_size - 1 <= p->nr_objs * 2)
+		grow_object_hash(p);
 
-	insert_obj_hash(obj, r->parsed_objects->obj_hash,
-			r->parsed_objects->obj_hash_size);
-	r->parsed_objects->nr_objs++;
+	insert_obj_hash(obj, p->obj_hash, p->obj_hash_size);
+	p->nr_objs++;
 	return obj;
 }
 
+void *create_object(struct repository *r, const struct object_id *oid, void *o)
+{
+	return create_object_via_pool(r->parsed_objects, oid, o);
+}
+
 void *object_as_type(struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
@@ -551,12 +560,12 @@ void repo_clear_commit_marks(struct repository *r, unsigned int flags)
 	}
 }
 
-struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
+struct parsed_object_pool *parsed_object_pool_new(struct repository *repo
+						  UNUSED)
 {
 	struct parsed_object_pool *o = xmalloc(sizeof(*o));
 	memset(o, 0, sizeof(*o));
 
-	o->repo = repo;
 	o->blob_state = alloc_state_alloc();
 	o->tree_state = alloc_state_alloc();
 	o->commit_state = alloc_state_alloc();
@@ -573,7 +582,7 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 void parsed_object_pool_reset_commit_grafts(struct parsed_object_pool *o)
 {
 	for (int i = 0; i < o->grafts_nr; i++) {
-		unparse_commit(o->repo, &o->grafts[i]->oid);
+		unparse_commit_via_pool(o, &o->grafts[i]->oid);
 		free(o->grafts[i]);
 	}
 	o->grafts_nr = 0;
diff --git a/object.h b/object.h
index 8fb03ff90a..2bab336913 100644
--- a/object.h
+++ b/object.h
@@ -7,7 +7,6 @@ struct buffer_slab;
 struct repository;
 
 struct parsed_object_pool {
-	struct repository *repo;
 	struct object **obj_hash;
 	int nr_objs, obj_hash_size;
 
@@ -191,8 +190,10 @@ struct object *get_indexed_object(const struct repository *repo,
  * by calling parse_object() on them.
  */
 struct object *lookup_object(struct repository *r, const struct object_id *oid);
+struct object *lookup_object_via_pool(struct parsed_object_pool *p, const struct object_id *oid);
 
 void *create_object(struct repository *r, const struct object_id *oid, void *obj);
+void *create_object_via_pool(struct parsed_object_pool *p, const struct object_id *oid, void *obj);
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
