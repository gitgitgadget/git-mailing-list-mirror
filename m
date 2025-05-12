Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4731E5705
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075956; cv=none; b=PUMxqGEYtXwgwysB73cG3DsB8kKNGFOx9WQQ9U34RA99uk8FKXPq1o+p+fSrFap4txD7DeV13WFTyEKbCp9kf8ImXMHgbCC0eJ4jFZJ0btGZH2tT9uBbtirAstdv7L69WP7wzJTBBXO0mnxJkVnekn1ZmTggUVUI8KEiujR9H+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075956; c=relaxed/simple;
	bh=NnisGZI8ufTapt+myjvHc2hTBUz1BCqsX+JVDxhWXMw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INgIAumzNCzc8bwGtMbOuDb0GEpnrfzI8iJVQywCei0lUpTFSY7V/En+S7BvuY44nsfDM9+hI8sJvgx/c5H8h64f2r3NbGJVdqqayjITsfMMo/lj2y/HedRkun/jYY2HlfKdwCmE4tdhKxgt0ltA31X/C74/gWLI+duFSdGWPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ElA0w+Bg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ElA0w+Bg"
Received: (qmail 3465 invoked by uid 109); 12 May 2025 18:52:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NnisGZI8ufTapt+myjvHc2hTBUz1BCqsX+JVDxhWXMw=; b=ElA0w+Bgmhh0knhFWefdkE7PDGrSonYqoO9xf19StHMeRB49Null0NabsOZWciihmkQdA6BDTWyJFqaiBmMXBDtz78vNaphbJwS4UcMjbKQXoh0LLRDRpoXtX58532xJvDPpqZvmqPzGiAM62xSCdsIl8UuMiIhFowPq/tyHCpfK+Rjeb07xUO95bcyYLvTY2XpE0lFKRvoBAKsKMHgigjEFfZ2+Kyb4ODN3rcHd8FcQm+2YmU5NqNZrcWGe+fqXjsOeoT6OryF63a1itnGecT/No/5hYcDuIg9g2TI90GOY4B5W8K5mkfSRN+jvYo+yVS831TuHZXd8KzDpLyQGCQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 18:52:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10360 invoked by uid 111); 12 May 2025 18:52:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 14:52:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 14:52:33 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/3] raw_object_store: drop extra pointer to replace_map
Message-ID: <20250512185233.GC1276214@coredump.intra.peff.net>
References: <20250512185006.GA1275914@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512185006.GA1275914@coredump.intra.peff.net>

We store the replacement data in an oidmap, which is itself a pointer in
the raw_object_store struct. But there's no need for an extra pointer
indirection here. It is always allocated and initialized along with the
containing struct, and we never check it for NULL-ness.

Let's embed the map directly in the struct, which is simpler and avoids
extra pointer chasing.

Signed-off-by: Jeff King <peff@peff.net>
---
This one may be more subjective, but IMHO it's good to avoid extra
pointers when we can.

 commit-graph.c   | 2 +-
 object-store.c   | 3 +--
 object-store.h   | 3 ++-
 replace-object.c | 8 +++-----
 replace-object.h | 2 +-
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1a74e1e1ba..4a6e34f8a0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -222,7 +222,7 @@ static int commit_graph_compatible(struct repository *r)
 
 	if (replace_refs_enabled(r)) {
 		prepare_replace_object(r);
-		if (oidmap_get_size(r->objects->replace_map))
+		if (oidmap_get_size(&r->objects->replace_map))
 			return 0;
 	}
 
diff --git a/object-store.c b/object-store.c
index bc24e80829..911bc7ff5f 100644
--- a/object-store.c
+++ b/object-store.c
@@ -1017,8 +1017,7 @@ void raw_object_store_clear(struct raw_object_store *o)
 {
 	FREE_AND_NULL(o->alternate_db);
 
-	oidmap_clear(o->replace_map, 1);
-	FREE_AND_NULL(o->replace_map);
+	oidmap_clear(&o->replace_map, 1);
 	pthread_mutex_destroy(&o->replace_mutex);
 
 	free_commit_graph(o->commit_graph);
diff --git a/object-store.h b/object-store.h
index 46961dc954..9f6f27c016 100644
--- a/object-store.h
+++ b/object-store.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "list.h"
 #include "oidset.h"
+#include "oidmap.h"
 #include "thread-utils.h"
 
 struct oidmap;
@@ -176,7 +177,7 @@ struct raw_object_store {
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).
 	 */
-	struct oidmap *replace_map;
+	struct oidmap replace_map;
 	unsigned replace_map_initialized : 1;
 	pthread_mutex_t replace_mutex; /* protect object replace functions */
 
diff --git a/replace-object.c b/replace-object.c
index 7b8a09b5cb..f8c5f68837 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -31,7 +31,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (oidmap_put(r->objects->replace_map, repl_obj))
+	if (oidmap_put(&r->objects->replace_map, repl_obj))
 		die(_("duplicate replace ref: %s"), refname);
 
 	return 0;
@@ -48,9 +48,7 @@ void prepare_replace_object(struct repository *r)
 		return;
 	}
 
-	r->objects->replace_map =
-		xmalloc(sizeof(*r->objects->replace_map));
-	oidmap_init(r->objects->replace_map, 0);
+	oidmap_init(&r->objects->replace_map, 0);
 
 	refs_for_each_replace_ref(get_main_ref_store(r),
 				  register_replace_ref, r);
@@ -80,7 +78,7 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 	/* Try to recursively replace the object */
 	while (depth-- > 0) {
 		struct replace_object *repl_obj =
-			oidmap_get(r->objects->replace_map, cur);
+			oidmap_get(&r->objects->replace_map, cur);
 		if (!repl_obj)
 			return cur;
 		cur = &repl_obj->replacement;
diff --git a/replace-object.h b/replace-object.h
index 4226376534..3052e96a62 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -47,7 +47,7 @@ static inline const struct object_id *lookup_replace_object(struct repository *r
 {
 	if (!replace_refs_enabled(r) ||
 	    (r->objects->replace_map_initialized &&
-	     oidmap_get_size(r->objects->replace_map) == 0))
+	     oidmap_get_size(&r->objects->replace_map) == 0))
 		return oid;
 	return do_lookup_replace_object(r, oid);
 }
-- 
2.49.0.821.gd3b3298025
