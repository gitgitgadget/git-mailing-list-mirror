Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869141F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392865AbfJRE5j (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:57:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730688AbfJRE5j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:57:39 -0400
Received: (qmail 9445 invoked by uid 109); 18 Oct 2019 04:57:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:57:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14234 invoked by uid 111); 18 Oct 2019 05:00:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:00:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:57:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/23] fsck: use oids rather than objects for object_name API
Message-ID: <20191018045737.GK17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't actually care about having object structs; we only need to look
up decorations by oid. Let's accept this more limited form, which will
give our callers more flexibility.

Note that the decoration API we rely on uses object structs itself (even
though it only looks at their oids). We can solve this by switching to
a kh_oid_map (we could also use the hashmap oidmap, but it's more
awkward for the simple case of just storing a void pointer).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 12 +++++-----
 fsck.c         | 61 ++++++++++++++++++++++++++++----------------------
 fsck.h         |  9 ++++----
 3 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 237643cc1d..66fa727c14 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -52,7 +52,7 @@ static int name_objects;
 
 static const char *describe_object(struct object *obj)
 {
-	return fsck_describe_object(&fsck_walk_options, obj);
+	return fsck_describe_object(&fsck_walk_options, &obj->oid);
 }
 
 static const char *printable_type(struct object *obj)
@@ -483,7 +483,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 		obj = lookup_object(the_repository, oid);
 		if (obj && (obj->flags & HAS_OBJ)) {
 			if (timestamp)
-				fsck_put_object_name(&fsck_walk_options, obj,
+				fsck_put_object_name(&fsck_walk_options, oid,
 						     "%s@{%"PRItime"}",
 						     refname, timestamp);
 			obj->flags |= USED;
@@ -550,7 +550,7 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	default_refs++;
 	obj->flags |= USED;
 	fsck_put_object_name(&fsck_walk_options,
-			     obj, "%s", refname);
+			     oid, "%s", refname);
 	mark_object_reachable(obj);
 
 	return 0;
@@ -724,7 +724,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 			return 1;
 		}
 		obj->flags |= USED;
-		fsck_put_object_name(&fsck_walk_options, obj, ":");
+		fsck_put_object_name(&fsck_walk_options, &it->oid, ":");
 		mark_object_reachable(obj);
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, _("non-tree in cache-tree"));
@@ -869,7 +869,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			}
 
 			obj->flags |= USED;
-			fsck_put_object_name(&fsck_walk_options, obj,
+			fsck_put_object_name(&fsck_walk_options, &oid,
 					     "%s", arg);
 			mark_object_reachable(obj);
 			continue;
@@ -906,7 +906,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 			obj = &blob->object;
 			obj->flags |= USED;
-			fsck_put_object_name(&fsck_walk_options, obj,
+			fsck_put_object_name(&fsck_walk_options, &obj->oid,
 					     ":%s", active_cache[i]->name);
 			mark_object_reachable(obj);
 		}
diff --git a/fsck.c b/fsck.c
index b0c4de67c9..124c0184d4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -315,48 +315,56 @@ static int report(struct fsck_options *options, struct object *object,
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
-		options->object_names = xcalloc(1, sizeof(struct decoration));
+		options->object_names = kh_init_oid_map();
 }
 
-const char *fsck_get_object_name(struct fsck_options *options, struct object *obj)
+const char *fsck_get_object_name(struct fsck_options *options,
+				 const struct object_id *oid)
 {
+	khiter_t pos;
 	if (!options->object_names)
 		return NULL;
-	return lookup_decoration(options->object_names, obj);
+	pos = kh_get_oid_map(options->object_names, *oid);
+	if (pos >= kh_end(options->object_names))
+		return NULL;
+	return kh_value(options->object_names, pos);
 }
 
-void fsck_put_object_name(struct fsck_options *options, struct object *obj,
+void fsck_put_object_name(struct fsck_options *options,
+			  const struct object_id *oid,
 			  const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf buf = STRBUF_INIT;
-	char *existing;
+	khiter_t pos;
+	int hashret;
 
 	if (!options->object_names)
 		return;
-	existing = lookup_decoration(options->object_names, obj);
-	if (existing)
+
+	pos = kh_put_oid_map(options->object_names, *oid, &hashret);
+	if (!hashret)
 		return;
 	va_start(ap, fmt);
 	strbuf_vaddf(&buf, fmt, ap);
-	add_decoration(options->object_names, obj, strbuf_detach(&buf, NULL));
+	kh_value(options->object_names, pos) = strbuf_detach(&buf, NULL);
 	va_end(ap);
 }
 
 const char *fsck_describe_object(struct fsck_options *options,
-				 struct object *obj)
+				 const struct object_id *oid)
 {
 	static struct strbuf bufs[] = {
 		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	static int b = 0;
 	struct strbuf *buf;
-	const char *name = fsck_get_object_name(options, obj);
+	const char *name = fsck_get_object_name(options, oid);
 
 	buf = bufs + b;
 	b = (b + 1) % ARRAY_SIZE(bufs);
 	strbuf_reset(buf);
-	strbuf_addstr(buf, oid_to_hex(&obj->oid));
+	strbuf_addstr(buf, oid_to_hex(oid));
 	if (name)
 		strbuf_addf(buf, " (%s)", name);
 
@@ -373,7 +381,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 	if (parse_tree(tree))
 		return -1;
 
-	name = fsck_get_object_name(options, &tree->object);
+	name = fsck_get_object_name(options, &tree->object.oid);
 	if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
 		return -1;
 	while (tree_entry_gently(&desc, &entry)) {
@@ -386,20 +394,20 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		if (S_ISDIR(entry.mode)) {
 			obj = (struct object *)lookup_tree(the_repository, &entry.oid);
 			if (name && obj)
-				fsck_put_object_name(options, obj, "%s%s/",
+				fsck_put_object_name(options, &entry.oid, "%s%s/",
 						     name, entry.path);
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
 			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
 			if (name && obj)
-				fsck_put_object_name(options, obj, "%s%s",
+				fsck_put_object_name(options, &entry.oid, "%s%s",
 						     name, entry.path);
 			result = options->walk(obj, OBJ_BLOB, data, options);
 		}
 		else {
 			result = error("in tree %s: entry %s has bad mode %.6o",
-				       fsck_describe_object(options, &tree->object),
+				       fsck_describe_object(options, &tree->object.oid),
 				       entry.path, entry.mode);
 		}
 		if (result < 0)
@@ -421,9 +429,9 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	if (parse_commit(commit))
 		return -1;
 
-	name = fsck_get_object_name(options, &commit->object);
+	name = fsck_get_object_name(options, &commit->object.oid);
 	if (name)
-		fsck_put_object_name(options, &get_commit_tree(commit)->object,
+		fsck_put_object_name(options, get_commit_tree_oid(commit),
 				     "%s:", name);
 
 	result = options->walk((struct object *)get_commit_tree(commit),
@@ -452,18 +460,17 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 
 	while (parents) {
 		if (name) {
-			struct object *obj = &parents->item->object;
+			struct object_id *oid = &parents->item->object.oid;
 
 			if (counter++)
-				fsck_put_object_name(options, obj, "%s^%d",
+				fsck_put_object_name(options, oid, "%s^%d",
 						     name, counter);
 			else if (generation > 0)
-				fsck_put_object_name(options, obj, "%.*s~%d",
+				fsck_put_object_name(options, oid, "%.*s~%d",
 						     name_prefix_len, name,
 						     generation + 1);
 			else
-				fsck_put_object_name(options, obj, "%s^",
-						     name);
+				fsck_put_object_name(options, oid, "%s^", name);
 		}
 		result = options->walk((struct object *)parents->item, OBJ_COMMIT, data, options);
 		if (result < 0)
@@ -477,12 +484,12 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 
 static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *options)
 {
-	const char *name = fsck_get_object_name(options, &tag->object);
+	const char *name = fsck_get_object_name(options, &tag->object.oid);
 
 	if (parse_tag(tag))
 		return -1;
 	if (name)
-		fsck_put_object_name(options, tag->tagged, "%s", name);
+		fsck_put_object_name(options, &tag->tagged->oid, "%s", name);
 	return options->walk(tag->tagged, OBJ_ANY, data, options);
 }
 
@@ -505,7 +512,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 		return fsck_walk_tag((struct tag *)obj, data, options);
 	default:
 		error("Unknown object type for %s",
-		      fsck_describe_object(options, obj));
+		      fsck_describe_object(options, &obj->oid));
 		return -1;
 	}
 }
@@ -979,10 +986,10 @@ int fsck_error_function(struct fsck_options *o,
 	struct object *obj, int msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
-		warning("object %s: %s", fsck_describe_object(o, obj), message);
+		warning("object %s: %s", fsck_describe_object(o, &obj->oid), message);
 		return 0;
 	}
-	error("object %s: %s", fsck_describe_object(o, obj), message);
+	error("object %s: %s", fsck_describe_object(o, &obj->oid), message);
 	return 1;
 }
 
diff --git a/fsck.h b/fsck.h
index f6f0c40060..4397cab20f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -38,7 +38,7 @@ struct fsck_options {
 	unsigned strict:1;
 	int *msg_type;
 	struct oidset skiplist;
-	struct decoration *object_names;
+	kh_oid_map_t *object_names;
 };
 
 #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
@@ -84,11 +84,12 @@ int fsck_finish(struct fsck_options *options);
  */
 void fsck_enable_object_names(struct fsck_options *options);
 const char *fsck_get_object_name(struct fsck_options *options,
-				 struct object *obj);
+				 const struct object_id *oid);
 __attribute__((format (printf,3,4)))
-void fsck_put_object_name(struct fsck_options *options, struct object *obj,
+void fsck_put_object_name(struct fsck_options *options,
+			  const struct object_id *oid,
 			  const char *fmt, ...);
 const char *fsck_describe_object(struct fsck_options *options,
-				 struct object *obj);
+				 const struct object_id *oid);
 
 #endif
-- 
2.23.0.1228.gee29b05929

