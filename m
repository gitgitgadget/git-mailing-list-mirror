Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F6C1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfFTHlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:45314 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfFTHlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:19 -0400
Received: (qmail 16548 invoked by uid 109); 20 Jun 2019 07:41:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12807 invoked by uid 111); 20 Jun 2019 07:42:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:14 -0400
Date:   Thu, 20 Jun 2019 03:41:14 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/17] object: convert lookup_object() to use object_id
Message-ID: <20190620074114.GG3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers left of lookup_object() that aren't just passing us
the "hash" member of a "struct object_id". Let's take the whole struct,
which gets us closer to removing all raw sha1 variables.  It also
matches the existing conversions of lookup_blob(), etc.

The conversions of callers were done by hand, but they're all mechanical
one-liners.

Signed-off-by: Jeff King <peff@peff.net>
---
 blob.c                   |  2 +-
 builtin/fast-export.c    |  4 ++--
 builtin/fsck.c           |  6 +++---
 builtin/name-rev.c       |  3 +--
 builtin/prune.c          |  2 +-
 builtin/unpack-objects.c |  2 +-
 commit.c                 |  2 +-
 delta-islands.c          |  2 +-
 fetch-pack.c             | 12 ++++++------
 http-push.c              |  2 +-
 object.c                 | 12 ++++++------
 object.h                 |  2 +-
 reachable.c              |  4 ++--
 tag.c                    |  2 +-
 tree.c                   |  2 +-
 upload-pack.c            |  2 +-
 16 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/blob.c b/blob.c
index 342bdbb1bb..b9c7180b7c 100644
--- a/blob.c
+++ b/blob.c
@@ -7,7 +7,7 @@ const char *blob_type = "blob";
 
 struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(r, oid->hash);
+	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid->hash,
 				     alloc_blob_node(r));
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c22cef3b2f..f541f55d33 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -275,7 +275,7 @@ static void export_blob(const struct object_id *oid)
 	if (is_null_oid(oid))
 		return;
 
-	object = lookup_object(the_repository, oid->hash);
+	object = lookup_object(the_repository, oid);
 	if (object && object->flags & SHOWN)
 		return;
 
@@ -453,7 +453,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 						  &spec->oid));
 			else {
 				struct object *object = lookup_object(the_repository,
-								      spec->oid.hash);
+								      &spec->oid);
 				printf("M %06o :%d ", spec->mode,
 				       get_object_mark(object));
 			}
diff --git a/builtin/fsck.c b/builtin/fsck.c
index e422c82465..18403a94fa 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -238,7 +238,7 @@ static int mark_used(struct object *obj, int type, void *data, struct fsck_optio
 static void mark_unreachable_referents(const struct object_id *oid)
 {
 	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(the_repository, oid);
 
 	if (!obj || !(obj->flags & HAS_OBJ))
 		return; /* not part of our original set */
@@ -497,7 +497,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 	struct object *obj;
 
 	if (!is_null_oid(oid)) {
-		obj = lookup_object(the_repository, oid->hash);
+		obj = lookup_object(the_repository, oid);
 		if (obj && (obj->flags & HAS_OBJ)) {
 			if (timestamp && name_objects)
 				add_decoration(fsck_walk_options.object_names,
@@ -879,7 +879,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		struct object_id oid;
 		if (!get_oid(arg, &oid)) {
 			struct object *obj = lookup_object(the_repository,
-							   oid.hash);
+							   &oid);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
 				if (is_promisor_object(&oid))
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 16df43473a..c785fe16ba 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -378,8 +378,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 			*(p+1) = 0;
 			if (!get_oid(p - (hexsz - 1), &oid)) {
 				struct object *o =
-					lookup_object(the_repository,
-						      oid.hash);
+					lookup_object(the_repository, &oid);
 				if (o)
 					name = get_rev_name(o, &buf);
 			}
diff --git a/builtin/prune.c b/builtin/prune.c
index 97613eccb5..2b76872ad2 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -53,7 +53,7 @@ static int is_object_reachable(const struct object_id *oid,
 
 	perform_reachability_traversal(revs);
 
-	obj = lookup_object(the_repository, oid->hash);
+	obj = lookup_object(the_repository, oid);
 	return obj && (obj->flags & SEEN);
 }
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 80478808b3..a87a4bfd2c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -332,7 +332,7 @@ static int resolve_against_held(unsigned nr, const struct object_id *base,
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
-	obj = lookup_object(the_repository, base->hash);
+	obj = lookup_object(the_repository, base);
 	if (!obj)
 		return 0;
 	obj_buffer = lookup_object_buffer(obj);
diff --git a/commit.c b/commit.c
index 8fa1883c61..f47c75afae 100644
--- a/commit.c
+++ b/commit.c
@@ -57,7 +57,7 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(r, oid->hash);
+	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid->hash,
 				     alloc_commit_node(r));
diff --git a/delta-islands.c b/delta-islands.c
index 2186bd0738..5f3ab914f5 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -296,7 +296,7 @@ void resolve_tree_islands(struct repository *r,
 			if (S_ISGITLINK(entry.mode))
 				continue;
 
-			obj = lookup_object(r, entry.oid.hash);
+			obj = lookup_object(r, &entry.oid);
 			if (!obj)
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 1c10f54e78..07bc48a1a5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -286,7 +286,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		 * we cannot trust the object flags).
 		 */
 		if (!args->no_dependents &&
-		    ((o = lookup_object(the_repository, remote->hash)) != NULL) &&
+		    ((o = lookup_object(the_repository, remote)) != NULL) &&
 				(o->flags & COMPLETE)) {
 			continue;
 		}
@@ -364,7 +364,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			if (skip_prefix(reader.line, "unshallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
 					die(_("invalid unshallow line: %s"), reader.line);
-				if (!lookup_object(the_repository, oid.hash))
+				if (!lookup_object(the_repository, &oid))
 					die(_("object not found: %s"), reader.line);
 				/* make sure that it is parsed as shallow */
 				if (!parse_object(the_repository, &oid))
@@ -707,7 +707,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o = deref_tag(the_repository,
 					     lookup_object(the_repository,
-					     ref->old_oid.hash),
+					     &ref->old_oid),
 					     NULL, 0);
 
 		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
@@ -734,7 +734,7 @@ static int everything_local(struct fetch_pack_args *args,
 		const struct object_id *remote = &ref->old_oid;
 		struct object *o;
 
-		o = lookup_object(the_repository, remote->hash);
+		o = lookup_object(the_repository, remote);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
 			print_verbose(args, "want %s (%s)", oid_to_hex(remote),
@@ -1048,7 +1048,7 @@ static void add_wants(int no_dependents, const struct ref *wants, struct strbuf
 		 * we cannot trust the object flags).
 		 */
 		if (!no_dependents &&
-		    ((o = lookup_object(the_repository, remote->hash)) != NULL) &&
+		    ((o = lookup_object(the_repository, remote)) != NULL) &&
 		    (o->flags & COMPLETE)) {
 			continue;
 		}
@@ -1275,7 +1275,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		if (skip_prefix(reader->line, "unshallow ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die(_("invalid unshallow line: %s"), reader->line);
-			if (!lookup_object(the_repository, oid.hash))
+			if (!lookup_object(the_repository, &oid))
 				die(_("object not found: %s"), reader->line);
 			/* make sure that it is parsed as shallow */
 			if (!parse_object(the_repository, &oid))
diff --git a/http-push.c b/http-push.c
index 96a98e1e61..0353f9f514 100644
--- a/http-push.c
+++ b/http-push.c
@@ -723,7 +723,7 @@ static void one_remote_object(const struct object_id *oid)
 {
 	struct object *obj;
 
-	obj = lookup_object(the_repository, oid->hash);
+	obj = lookup_object(the_repository, oid);
 	if (!obj)
 		obj = parse_object(the_repository, oid);
 
diff --git a/object.c b/object.c
index d5b1d8daaf..34c1d0dc8f 100644
--- a/object.c
+++ b/object.c
@@ -85,7 +85,7 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
  * Look up the record for the given sha1 in the hash map stored in
  * obj_hash.  Return NULL if it was not found.
  */
-struct object *lookup_object(struct repository *r, const unsigned char *sha1)
+struct object *lookup_object(struct repository *r, const struct object_id *oid)
 {
 	unsigned int i, first;
 	struct object *obj;
@@ -93,9 +93,9 @@ struct object *lookup_object(struct repository *r, const unsigned char *sha1)
 	if (!r->parsed_objects->obj_hash)
 		return NULL;
 
-	first = i = hash_obj(sha1, r->parsed_objects->obj_hash_size);
+	first = i = hash_obj(oid->hash, r->parsed_objects->obj_hash_size);
 	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
-		if (hasheq(sha1, obj->oid.hash))
+		if (oideq(oid, &obj->oid))
 			break;
 		i++;
 		if (i == r->parsed_objects->obj_hash_size)
@@ -180,7 +180,7 @@ void *object_as_type(struct repository *r, struct object *obj, enum object_type
 
 struct object *lookup_unknown_object(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(the_repository, oid);
 	if (!obj)
 		obj = create_object(the_repository, oid->hash,
 				    alloc_object_node(the_repository));
@@ -256,7 +256,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	void *buffer;
 	struct object *obj;
 
-	obj = lookup_object(r, oid->hash);
+	obj = lookup_object(r, oid);
 	if (obj && obj->parsed)
 		return obj;
 
@@ -268,7 +268,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 			return NULL;
 		}
 		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
-		return lookup_object(r, oid->hash);
+		return lookup_object(r, oid);
 	}
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
diff --git a/object.h b/object.h
index 5e0ccfe0e4..47301186a4 100644
--- a/object.h
+++ b/object.h
@@ -116,7 +116,7 @@ struct object *get_indexed_object(unsigned int);
  * half-initialised objects, the caller is expected to initialize them
  * by calling parse_object() on them.
  */
-struct object *lookup_object(struct repository *r, const unsigned char *sha1);
+struct object *lookup_object(struct repository *r, const struct object_id *oid);
 
 void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
diff --git a/reachable.c b/reachable.c
index 0d00a91de4..8f50235b28 100644
--- a/reachable.c
+++ b/reachable.c
@@ -109,7 +109,7 @@ static int add_recent_loose(const struct object_id *oid,
 			    const char *path, void *data)
 {
 	struct stat st;
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(the_repository, oid);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
@@ -134,7 +134,7 @@ static int add_recent_packed(const struct object_id *oid,
 			     struct packed_git *p, uint32_t pos,
 			     void *data)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(the_repository, oid);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
diff --git a/tag.c b/tag.c
index 7445b8f6ea..3ae00ba1ab 100644
--- a/tag.c
+++ b/tag.c
@@ -100,7 +100,7 @@ struct object *deref_tag_noverify(struct object *o)
 
 struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(r, oid->hash);
+	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid->hash,
 				     alloc_tag_node(r));
diff --git a/tree.c b/tree.c
index f416afc57d..0ebb8c5b02 100644
--- a/tree.c
+++ b/tree.c
@@ -197,7 +197,7 @@ int read_tree(struct repository *r, struct tree *tree, int stage,
 
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(r, oid->hash);
+	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid->hash,
 				     alloc_tree_node(r));
diff --git a/upload-pack.c b/upload-pack.c
index ecc19641fe..a0f170b5b5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -534,7 +534,7 @@ static int get_reachable_list(struct object_array *src,
 		if (parse_oid_hex(namebuf, &oid, &p) || *p != '\n')
 			break;
 
-		o = lookup_object(the_repository, oid.hash);
+		o = lookup_object(the_repository, &oid);
 		if (o && o->type == OBJ_COMMIT) {
 			o->flags &= ~TMP_MARK;
 		}
-- 
2.22.0.732.g5402924b4b

