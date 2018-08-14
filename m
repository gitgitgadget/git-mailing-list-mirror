Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB331F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeHNVJn (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:09:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728119AbeHNVJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:09:43 -0400
Received: (qmail 32079 invoked by uid 109); 14 Aug 2018 18:21:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 18:21:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24504 invoked by uid 111); 14 Aug 2018 18:21:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 14:21:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 14:21:18 -0400
Date:   Tue, 14 Aug 2018 14:21:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: [PATCH 4/4] for_each_*_object: move declarations to object-store.h
Message-ID: <20180814182118.GD26919@sigill.intra.peff.net>
References: <20180814181358.GA26391@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180814181358.GA26391@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The for_each_loose_object() and for_each_packed_object()
functions are meant to be part of a unified interface: they
use the same set of for_each_object_flags, and it's not
inconceivable that we might one day add a single
for_each_object() wrapper around them.

Let's put them together in a single file, so we can avoid
awkwardness like saying "the flags for this function are
over in cache.h". Moving the loose functions to packfile.h
is silly. Moving the packed functions to cache.h works, but
makes the "cache.h is a kitchen sink" problem worse. The
best place is the recently-created object-store.h, since
these are quite obviously related to object storage.

The for_each_*_in_objdir() functions do not use the same
flags, but they are logically part of the same interface as
for_each_loose_object(), and share callback signatures. So
we'll move those, as well, as they also make sense in
object-store.h.

Signed-off-by: Jeff King <peff@peff.net>
---
This patch also happens to be a nice showcase for --color-moved.

 builtin/prune-packed.c |  1 +
 cache.h                | 75 -----------------------------------
 object-store.h         | 90 ++++++++++++++++++++++++++++++++++++++++++
 packfile.h             | 20 ----------
 4 files changed, 91 insertions(+), 95 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 4ff525e50f..a9e7b552b9 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -3,6 +3,7 @@
 #include "progress.h"
 #include "parse-options.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static const char * const prune_packed_usage[] = {
 	N_("git prune-packed [-n | --dry-run] [-q | --quiet]"),
diff --git a/cache.h b/cache.h
index 6d14702df2..aee36afa54 100644
--- a/cache.h
+++ b/cache.h
@@ -1575,81 +1575,6 @@ extern int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-/*
- * Iterate over the files in the loose-object parts of the object
- * directory "path", triggering the following callbacks:
- *
- *  - loose_object is called for each loose object we find.
- *
- *  - loose_cruft is called for any files that do not appear to be
- *    loose objects. Note that we only look in the loose object
- *    directories "objects/[0-9a-f]{2}/", so we will not report
- *    "objects/foobar" as cruft.
- *
- *  - loose_subdir is called for each top-level hashed subdirectory
- *    of the object directory (e.g., "$OBJDIR/f0"). It is called
- *    after the objects in the directory are processed.
- *
- * Any callback that is NULL will be ignored. Callbacks returning non-zero
- * will end the iteration.
- *
- * In the "buf" variant, "path" is a strbuf which will also be used as a
- * scratch buffer, but restored to its original contents before
- * the function returns.
- */
-typedef int each_loose_object_fn(const struct object_id *oid,
-				 const char *path,
-				 void *data);
-typedef int each_loose_cruft_fn(const char *basename,
-				const char *path,
-				void *data);
-typedef int each_loose_subdir_fn(unsigned int nr,
-				 const char *path,
-				 void *data);
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data);
-int for_each_loose_file_in_objdir(const char *path,
-				  each_loose_object_fn obj_cb,
-				  each_loose_cruft_fn cruft_cb,
-				  each_loose_subdir_fn subdir_cb,
-				  void *data);
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-				      each_loose_object_fn obj_cb,
-				      each_loose_cruft_fn cruft_cb,
-				      each_loose_subdir_fn subdir_cb,
-				      void *data);
-
-/*
- * Flags for for_each_*_object(), including for_each_loose below and
- * for_each_packed in packfile.h.
- */
-enum for_each_object_flags {
-	/* Iterate only over local objects, not alternates. */
-	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
-
-	/* Only iterate over packs obtained from the promisor remote. */
-	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
-
-	/*
-	 * Visit objects within a pack in packfile order rather than .idx order
-	 */
-	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
-};
-
-/*
- * Iterate over all accessible loose objects without respect to
- * reachability. By default, this includes both local and alternate objects.
- * The order in which objects are visited is unspecified.
- *
- * Any flags specific to packs are ignored.
- */
-int for_each_loose_object(each_loose_object_fn, void *,
-			  enum for_each_object_flags flags);
-
 /*
  * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
  * blobs. This has a difference only if extensions.partialClone is set.
diff --git a/object-store.h b/object-store.h
index e481f7ad41..162156f5dc 100644
--- a/object-store.h
+++ b/object-store.h
@@ -262,4 +262,94 @@ int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
 
+/*
+ * Iterate over the files in the loose-object parts of the object
+ * directory "path", triggering the following callbacks:
+ *
+ *  - loose_object is called for each loose object we find.
+ *
+ *  - loose_cruft is called for any files that do not appear to be
+ *    loose objects. Note that we only look in the loose object
+ *    directories "objects/[0-9a-f]{2}/", so we will not report
+ *    "objects/foobar" as cruft.
+ *
+ *  - loose_subdir is called for each top-level hashed subdirectory
+ *    of the object directory (e.g., "$OBJDIR/f0"). It is called
+ *    after the objects in the directory are processed.
+ *
+ * Any callback that is NULL will be ignored. Callbacks returning non-zero
+ * will end the iteration.
+ *
+ * In the "buf" variant, "path" is a strbuf which will also be used as a
+ * scratch buffer, but restored to its original contents before
+ * the function returns.
+ */
+typedef int each_loose_object_fn(const struct object_id *oid,
+				 const char *path,
+				 void *data);
+typedef int each_loose_cruft_fn(const char *basename,
+				const char *path,
+				void *data);
+typedef int each_loose_subdir_fn(unsigned int nr,
+				 const char *path,
+				 void *data);
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				struct strbuf *path,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data);
+int for_each_loose_file_in_objdir(const char *path,
+				  each_loose_object_fn obj_cb,
+				  each_loose_cruft_fn cruft_cb,
+				  each_loose_subdir_fn subdir_cb,
+				  void *data);
+int for_each_loose_file_in_objdir_buf(struct strbuf *path,
+				      each_loose_object_fn obj_cb,
+				      each_loose_cruft_fn cruft_cb,
+				      each_loose_subdir_fn subdir_cb,
+				      void *data);
+
+/* Flags for for_each_*_object() below. */
+enum for_each_object_flags {
+	/* Iterate only over local objects, not alternates. */
+	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
+
+	/* Only iterate over packs obtained from the promisor remote. */
+	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
+
+	/*
+	 * Visit objects within a pack in packfile order rather than .idx order
+	 */
+	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
+};
+
+/*
+ * Iterate over all accessible loose objects without respect to
+ * reachability. By default, this includes both local and alternate objects.
+ * The order in which objects are visited is unspecified.
+ *
+ * Any flags specific to packs are ignored.
+ */
+int for_each_loose_object(each_loose_object_fn, void *,
+			  enum for_each_object_flags flags);
+
+/*
+ * Iterate over all accessible packed objects without respect to reachability.
+ * By default, this includes both local and alternate packs.
+ *
+ * Note that some objects may appear twice if they are found in multiple packs.
+ * Each pack is visited in an unspecified order. By default, objects within a
+ * pack are visited in pack-idx order (i.e., sorted by oid).
+ */
+typedef int each_packed_object_fn(const struct object_id *oid,
+				  struct packed_git *pack,
+				  uint32_t pos,
+				  void *data);
+int for_each_object_in_pack(struct packed_git *p,
+			    each_packed_object_fn, void *data,
+			    enum for_each_object_flags flags);
+int for_each_packed_object(each_packed_object_fn, void *,
+			   enum for_each_object_flags flags);
+
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.h b/packfile.h
index 99411bdd85..d91e43fe73 100644
--- a/packfile.h
+++ b/packfile.h
@@ -148,26 +148,6 @@ extern int has_object_pack(const struct object_id *oid);
 
 extern int has_pack_index(const unsigned char *sha1);
 
-/*
- * Iterate over all accessible packed objects without respect to reachability.
- * By default, this includes both local and alternate packs.
- *
- * Note that some objects may appear twice if they are found in multiple packs.
- * Each pack is visited in an unspecified order. By default, objects within a
- * pack are visited in pack-idx order (i.e., sorted by oid).
- *
- * The list of flags can be found in cache.h.
- */
-typedef int each_packed_object_fn(const struct object_id *oid,
-				  struct packed_git *pack,
-				  uint32_t pos,
-				  void *data);
-int for_each_object_in_pack(struct packed_git *p,
-			    each_packed_object_fn, void *data,
-			    enum for_each_object_flags flags);
-int for_each_packed_object(each_packed_object_fn, void *,
-			   enum for_each_object_flags flags);
-
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
-- 
2.18.0.1066.g0d97f3a098
