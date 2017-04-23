Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D178207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162397AbdDWViX (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:38:23 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37638 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046202AbdDWVgu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0ECC0280E2;
        Sun, 23 Apr 2017 21:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983344;
        bh=JSDfhN51XhtAOEHu9ESHb+88s77u3tbWd+/FS1E56P0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWbOh1heSWZeyug0A+hvpyqScXDTlYUjafmqy/UFJJys1UgcEvZOX/bk/as39EhP4
         A5b498n+nsKcILJV1ZRvlGgLwr2E8kvgR5/PxEaQJfgepLXWvJejHKJrcSPLmWU9v4
         rUna3s+w5U088zbRRP3zuxNlE4hKxJn2oqJ7aoZmafJ4GT5BTdTWqcjg2I+Sz580n5
         GyhdeNrFXwoPrIyuhoJEh1nmoA6EXG3dFkb1/p5HlnMBm+xMAPEC3Z261VqK64fT7o
         CY5xyDPmId9UCQgsKexg7jDD+q3busi9ReDamNbvURupj0nPk3ev6MtOpV6gPAG5KS
         V2nFXck6vNpSGDpHTWHS9m81ob+waRLLYXy45sVJ7HA9eJv/PsEANbsnsVrHxV8KJC
         S02NuwbTEa8+4EVeJDA4BgBEAt4/MIsbO4fcKsy2ljoI3JVnIYNlhyUA51h/c4HN+v
         rqdn+TG6P2rwXV1oCtrSknbglSMRv6DbGBvZIriu/oIFcyFfCVc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 53/53] object: convert parse_object* to take struct object_id
Date:   Sun, 23 Apr 2017 21:34:53 +0000
Message-Id: <20170423213453.253425-54-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make parse_object, parse_object_or_die, and parse_object_buffer take a
pointer to struct object_id.  Remove the temporary variables inserted
earlier, since they are no longer necessary.  Transform all of the
callers using the following semantic patch:

@@
expression E1;
@@
- parse_object(E1.hash)
+ parse_object(&E1)

@@
expression E1;
@@
- parse_object(E1->hash)
+ parse_object(E1)

@@
expression E1, E2;
@@
- parse_object_or_die(E1.hash, E2)
+ parse_object_or_die(&E1, E2)

@@
expression E1, E2;
@@
- parse_object_or_die(E1->hash, E2)
+ parse_object_or_die(E1, E2)

@@
expression E1, E2, E3, E4, E5;
@@
- parse_object_buffer(E1.hash, E2, E3, E4, E5)
+ parse_object_buffer(&E1, E2, E3, E4, E5)

@@
expression E1, E2, E3, E4, E5;
@@
- parse_object_buffer(E1->hash, E2, E3, E4, E5)
+ parse_object_buffer(E1, E2, E3, E4, E5)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/diff-tree.c      |  2 +-
 builtin/diff.c           |  2 +-
 builtin/fast-export.c    |  4 ++--
 builtin/fmt-merge-msg.c  |  4 ++--
 builtin/fsck.c           |  8 ++++----
 builtin/grep.c           |  2 +-
 builtin/index-pack.c     |  3 ++-
 builtin/log.c            |  2 +-
 builtin/name-rev.c       |  6 +++---
 builtin/prune.c          |  3 ++-
 builtin/receive-pack.c   |  6 +++---
 builtin/reflog.c         |  2 +-
 builtin/rev-list.c       |  2 +-
 builtin/unpack-objects.c |  3 ++-
 bundle.c                 | 10 ++++++----
 commit.c                 |  4 ++--
 fetch-pack.c             | 14 +++++++-------
 fsck.c                   |  2 +-
 http-backend.c           |  2 +-
 http-push.c              |  4 ++--
 log-tree.c               |  6 +++---
 merge-recursive.c        |  2 +-
 object.c                 | 44 +++++++++++++++++++-------------------------
 object.h                 |  8 ++++----
 pack-bitmap.c            |  4 ++--
 pretty.c                 |  2 +-
 reachable.c              |  4 ++--
 ref-filter.c             |  4 ++--
 reflog-walk.c            |  4 ++--
 refs/files-backend.c     |  2 +-
 remote.c                 |  4 ++--
 revision.c               | 12 ++++++------
 server-info.c            |  2 +-
 sha1_name.c              | 14 +++++++-------
 tag.c                    |  4 ++--
 tree.c                   |  4 ++--
 upload-pack.c            |  8 ++++----
 walker.c                 |  2 +-
 38 files changed, 107 insertions(+), 108 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 95b8d1ba7..5ea1c1431 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -67,7 +67,7 @@ static int diff_tree_stdin(char *line)
 	line[len-1] = 0;
 	if (parse_oid_hex(line, &oid, &p))
 		return -1;
-	obj = parse_object(oid.hash);
+	obj = parse_object(&oid);
 	if (!obj)
 		return -1;
 	if (obj->type == OBJ_COMMIT)
diff --git a/builtin/diff.c b/builtin/diff.c
index 895f92897..8c03ddaf5 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -395,7 +395,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		const char *name = entry->name;
 		int flags = (obj->flags & UNINTERESTING);
 		if (!obj->parsed)
-			obj = parse_object(obj->oid.hash);
+			obj = parse_object(&obj->oid);
 		obj = deref_tag(obj, NULL, 0);
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ae36b14db..969550531 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -240,7 +240,7 @@ static void export_blob(const struct object_id *oid)
 			die ("Could not read blob %s", oid_to_hex(oid));
 		if (check_sha1_signature(oid->hash, buf, size, typename(type)) < 0)
 			die("sha1 mismatch in blob %s", oid_to_hex(oid));
-		object = parse_object_buffer(oid->hash, type, size, buf, &eaten);
+		object = parse_object_buffer(oid, type, size, buf, &eaten);
 	}
 
 	if (!object)
@@ -777,7 +777,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 
 		/* handle nested tags */
 		while (tag && tag->object.type == OBJ_TAG) {
-			parse_object(tag->object.oid.hash);
+			parse_object(&tag->object.oid);
 			string_list_append(&extra_refs, full_name)->util = tag;
 			tag = (struct tag *)tag->tagged;
 		}
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 91dd753dd..70137b0b7 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -341,7 +341,7 @@ static void shortlog(const char *name,
 	const struct object_id *oid = &origin_data->oid;
 	int limit = opts->shortlog_len;
 
-	branch = deref_tag(parse_object(oid->hash), oid_to_hex(oid), GIT_SHA1_HEXSZ);
+	branch = deref_tag(parse_object(oid), oid_to_hex(oid), GIT_SHA1_HEXSZ);
 	if (!branch || branch->type != OBJ_COMMIT)
 		return;
 
@@ -559,7 +559,7 @@ static void find_merge_parents(struct merge_parents *result,
 		 * "name" here and we do not want to contaminate its
 		 * util field yet.
 		 */
-		obj = parse_object(oid.hash);
+		obj = parse_object(&oid);
 		parent = (struct commit *)peel_to_type(NULL, 0, obj, OBJ_COMMIT);
 		if (!parent)
 			continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 359d61de0..40bf88943 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -385,7 +385,7 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 	 * verify_packfile(), data_valid variable for details.
 	 */
 	struct object *obj;
-	obj = parse_object_buffer(oid->hash, type, size, buffer, eaten);
+	obj = parse_object_buffer(oid, type, size, buffer, eaten);
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
 		return error("%s: object corrupt or missing", oid_to_hex(oid));
@@ -444,7 +444,7 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 {
 	struct object *obj;
 
-	obj = parse_object(oid->hash);
+	obj = parse_object(oid);
 	if (!obj) {
 		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
@@ -506,7 +506,7 @@ static struct object *parse_loose_object(const struct object_id *oid,
 	if (!contents && type != OBJ_BLOB)
 		die("BUG: read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(oid->hash, type, size, contents, &eaten);
+	obj = parse_object_buffer(oid, type, size, contents, &eaten);
 
 	if (!eaten)
 		free(contents);
@@ -599,7 +599,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 		fprintf(stderr, "Checking cache tree\n");
 
 	if (0 <= it->entry_count) {
-		struct object *obj = parse_object(it->oid.hash);
+		struct object *obj = parse_object(&it->oid);
 		if (!obj) {
 			error("%s: invalid sha1 pointer in cache-tree",
 			      oid_to_hex(&it->oid));
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ffb5b4e8..e64e14e94 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1196,7 +1196,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		object = parse_object_or_die(oid.hash, arg);
+		object = parse_object_or_die(&oid, arg);
 		if (!seen_dashdash)
 			verify_non_filename(prefix, arg);
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b75133f62..04b9dcaf0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -845,7 +845,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			 * we do not need to free the memory here, as the
 			 * buf is deleted by the caller.
 			 */
-			obj = parse_object_buffer(oid->hash, type, size, buf, &eaten);
+			obj = parse_object_buffer(oid, type, size, buf,
+						  &eaten);
 			if (!obj)
 				die(_("invalid %s"), typename(type));
 			if (do_fsck_object &&
diff --git a/builtin/log.c b/builtin/log.c
index d8b56ea41..8dd4e3dae 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -596,7 +596,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 1;
 			if (ret)
 				break;
-			o = parse_object(t->tagged->oid.hash);
+			o = parse_object(&t->tagged->oid);
 			if (!o)
 				ret = error(_("Could not read object %s"),
 					    oid_to_hex(&t->tagged->oid));
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 00760ecc6..f06261cad 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -142,7 +142,7 @@ static int tipcmp(const void *a_, const void *b_)
 
 static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
 {
-	struct object *o = parse_object(oid->hash);
+	struct object *o = parse_object(oid);
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
@@ -200,7 +200,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
-		o = parse_object(t->tagged->oid.hash);
+		o = parse_object(&t->tagged->oid);
 		deref = 1;
 		taggerdate = t->date;
 	}
@@ -385,7 +385,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 
 		commit = NULL;
-		object = parse_object(oid.hash);
+		object = parse_object(&oid);
 		if (object) {
 			struct object *peeled = deref_tag(object, *argv, 0);
 			if (peeled && peeled->type == OBJ_COMMIT)
diff --git a/builtin/prune.c b/builtin/prune.c
index 96dca7d58..536366056 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -127,7 +127,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		const char *name = *argv++;
 
 		if (!get_oid(name, &oid)) {
-			struct object *object = parse_object_or_die(oid.hash, name);
+			struct object *object = parse_object_or_die(&oid,
+								    name);
 			add_pending_object(&revs, object, "");
 		}
 		else
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 38e5164f6..471b83fcb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1059,8 +1059,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
 
-		old_object = parse_object(old_oid->hash);
-		new_object = parse_object(new_oid->hash);
+		old_object = parse_object(old_oid);
+		new_object = parse_object(new_oid);
 
 		if (!old_object || !new_object ||
 		    old_object->type != OBJ_COMMIT ||
@@ -1083,7 +1083,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 	if (is_null_oid(new_oid)) {
 		struct strbuf err = STRBUF_INIT;
-		if (!parse_object(old_oid->hash)) {
+		if (!parse_object(old_oid)) {
 			old_oid = NULL;
 			if (ref_exists(name)) {
 				rp_warning("Allowing deletion of corrupt ref.");
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7e89e84dc..8f3f1bd99 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -126,7 +126,7 @@ static int commit_is_complete(struct commit *commit)
 		struct commit_list *parent;
 
 		c = (struct commit *)study.objects[--study.nr].item;
-		if (!c->object.parsed && !parse_object(c->object.oid.hash))
+		if (!c->object.parsed && !parse_object(&c->object.oid))
 			c->object.flags |= INCOMPLETE;
 
 		if (c->object.flags & INCOMPLETE) {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bcf77f0b8..1ddfca32b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -181,7 +181,7 @@ static void finish_object(struct object *obj, const char *name, void *cb_data)
 	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
 		die("missing blob object '%s'", oid_to_hex(&obj->oid));
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
-		parse_object(obj->oid.hash);
+		parse_object(&obj->oid);
 }
 
 static void show_object(struct object *obj, const char *name, void *cb_data)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 7d5efa2b3..8bc999776 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -260,7 +260,8 @@ static void write_object(unsigned nr, enum object_type type,
 		int eaten;
 		hash_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash);
 		added_object(nr, type, buf, size);
-		obj = parse_object_buffer(obj_list[nr].oid.hash, type, size, buf, &eaten);
+		obj = parse_object_buffer(&obj_list[nr].oid, type, size, buf,
+					  &eaten);
 		if (!obj)
 			die("invalid %s", typename(type));
 		add_object_buffer(obj, buf, size);
diff --git a/bundle.c b/bundle.c
index 3386dba3b..f4abac467 100644
--- a/bundle.c
+++ b/bundle.c
@@ -142,7 +142,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	init_revisions(&revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(e->oid.hash);
+		struct object *o = parse_object(&e->oid);
 		if (o) {
 			o->flags |= PREREQ_MARK;
 			add_pending_object(&revs, o, e->name);
@@ -290,12 +290,14 @@ static int compute_and_write_prerequisites(int bundle_fd,
 		if (buf.len > 0 && buf.buf[0] == '-') {
 			write_or_die(bundle_fd, buf.buf, buf.len);
 			if (!get_oid_hex(buf.buf + 1, &oid)) {
-				struct object *object = parse_object_or_die(oid.hash, buf.buf);
+				struct object *object = parse_object_or_die(&oid,
+									    buf.buf);
 				object->flags |= UNINTERESTING;
 				add_pending_object(revs, object, buf.buf);
 			}
 		} else if (!get_oid_hex(buf.buf, &oid)) {
-			struct object *object = parse_object_or_die(oid.hash, buf.buf);
+			struct object *object = parse_object_or_die(&oid,
+								    buf.buf);
 			object->flags |= SHOWN;
 		}
 	}
@@ -379,7 +381,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 				 * end up triggering "empty bundle"
 				 * error.
 				 */
-				obj = parse_object_or_die(oid.hash, e->name);
+				obj = parse_object_or_die(&oid, e->name);
 				obj->flags |= SHOWN;
 				add_pending_object(revs, obj, e->name);
 			}
diff --git a/commit.c b/commit.c
index 8004008bc..424237a8e 100644
--- a/commit.c
+++ b/commit.c
@@ -21,7 +21,7 @@ const char *commit_type = "commit";
 struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 					      int quiet)
 {
-	struct object *obj = deref_tag(parse_object(oid->hash), NULL, 0);
+	struct object *obj = deref_tag(parse_object(oid), NULL, 0);
 
 	if (!obj)
 		return NULL;
@@ -1589,7 +1589,7 @@ struct commit *get_merge_parent(const char *name)
 	struct object_id oid;
 	if (get_sha1(name, oid.hash))
 		return NULL;
-	obj = parse_object(oid.hash);
+	obj = parse_object(&oid);
 	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
 	if (commit && !commit->util)
 		set_merge_remote_desc(commit, name, obj);
diff --git a/fetch-pack.c b/fetch-pack.c
index ab767503b..9026ad95a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -78,7 +78,7 @@ static void cache_one_alternate(const char *refname,
 				void *vcache)
 {
 	struct alternate_object_cache *cache = vcache;
-	struct object *obj = parse_object(oid->hash);
+	struct object *obj = parse_object(oid);
 
 	if (!obj || (obj->flags & ALTERNATE))
 		return;
@@ -120,7 +120,7 @@ static void rev_list_push(struct commit *commit, int mark)
 
 static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 {
-	struct object *o = deref_tag(parse_object(oid->hash), refname, 0);
+	struct object *o = deref_tag(parse_object(oid), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		rev_list_push((struct commit *)o, SEEN);
@@ -137,7 +137,7 @@ static int rev_list_insert_ref_oid(const char *refname, const struct object_id *
 static int clear_marks(const char *refname, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(oid->hash), refname, 0);
+	struct object *o = deref_tag(parse_object(oid), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
@@ -424,7 +424,7 @@ static int find_common(struct fetch_pack_args *args,
 				if (!lookup_object(oid.hash))
 					die(_("object not found: %s"), line);
 				/* make sure that it is parsed as shallow */
-				if (!parse_object(oid.hash))
+				if (!parse_object(&oid))
 					die(_("error in object: %s"), line);
 				if (unregister_shallow(&oid))
 					die(_("no shallow found: %s"), line);
@@ -555,14 +555,14 @@ static struct commit_list *complete;
 
 static int mark_complete(const struct object_id *oid)
 {
-	struct object *o = parse_object(oid->hash);
+	struct object *o = parse_object(oid);
 
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
 		o->flags |= COMPLETE;
-		o = parse_object(t->tagged->oid.hash);
+		o = parse_object(&t->tagged->oid);
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
@@ -679,7 +679,7 @@ static int everything_local(struct fetch_pack_args *args,
 		if (!has_object_file(&ref->old_oid))
 			continue;
 
-		o = parse_object(ref->old_oid.hash);
+		o = parse_object(&ref->old_oid);
 		if (!o)
 			continue;
 
diff --git a/fsck.c b/fsck.c
index ee5224aea..90857e122 100644
--- a/fsck.c
+++ b/fsck.c
@@ -461,7 +461,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 		return -1;
 
 	if (obj->type == OBJ_NONE)
-		parse_object(obj->oid.hash);
+		parse_object(&obj->oid);
 
 	switch (obj->type) {
 	case OBJ_BLOB:
diff --git a/http-backend.c b/http-backend.c
index eef0a361f..766381332 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -431,7 +431,7 @@ static int show_text_ref(const char *name, const struct object_id *oid,
 {
 	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
-	struct object *o = parse_object(oid->hash);
+	struct object *o = parse_object(oid);
 	if (!o)
 		return 0;
 
diff --git a/http-push.c b/http-push.c
index 4e7bd9e42..67c4d4b47 100644
--- a/http-push.c
+++ b/http-push.c
@@ -724,7 +724,7 @@ static void one_remote_object(const struct object_id *oid)
 
 	obj = lookup_object(oid->hash);
 	if (!obj)
-		obj = parse_object(oid->hash);
+		obj = parse_object(oid);
 
 	/* Ignore remote objects that don't exist locally */
 	if (!obj)
@@ -1462,7 +1462,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 		return;
 	}
 
-	o = parse_object(ref->old_oid.hash);
+	o = parse_object(&ref->old_oid);
 	if (!o) {
 		fprintf(stderr,
 			"Unable to parse object %s for remote ref %s\n",
diff --git a/log-tree.c b/log-tree.c
index 6532c892c..a4ec11c2b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -105,13 +105,13 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			warning("invalid replace ref %s", refname);
 			return 0;
 		}
-		obj = parse_object(original_oid.hash);
+		obj = parse_object(&original_oid);
 		if (obj)
 			add_name_decoration(DECORATION_GRAFTED, "replaced", obj);
 		return 0;
 	}
 
-	obj = parse_object(oid->hash);
+	obj = parse_object(oid);
 	if (!obj)
 		return 0;
 
@@ -132,7 +132,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		if (!obj)
 			break;
 		if (!obj->parsed)
-			parse_object(obj->oid.hash);
+			parse_object(&obj->oid);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 92e0a63dc..ae5238d82 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2103,7 +2103,7 @@ static struct commit *get_ref(const struct object_id *oid, const char *name)
 {
 	struct object *object;
 
-	object = deref_tag(parse_object(oid->hash), name, strlen(name));
+	object = deref_tag(parse_object(oid), name, strlen(name));
 	if (!object)
 		return NULL;
 	if (object->type == OBJ_TREE)
diff --git a/object.c b/object.c
index dd4d3a1ea..06ba3a11d 100644
--- a/object.c
+++ b/object.c
@@ -180,24 +180,21 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	return obj;
 }
 
-struct object *parse_object_buffer(const unsigned char *sha1, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
-	struct object_id oid;
 	struct object *obj;
 	*eaten_p = 0;
 
-	hashcpy(oid.hash, sha1);
-
 	obj = NULL;
 	if (type == OBJ_BLOB) {
-		struct blob *blob = lookup_blob(&oid);
+		struct blob *blob = lookup_blob(oid);
 		if (blob) {
 			if (parse_blob_buffer(blob, buffer, size))
 				return NULL;
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
-		struct tree *tree = lookup_tree(&oid);
+		struct tree *tree = lookup_tree(oid);
 		if (tree) {
 			obj = &tree->object;
 			if (!tree->buffer)
@@ -209,7 +206,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(&oid);
+		struct commit *commit = lookup_commit(oid);
 		if (commit) {
 			if (parse_commit_buffer(commit, buffer, size))
 				return NULL;
@@ -220,57 +217,54 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			obj = &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(&oid);
+		struct tag *tag = lookup_tag(oid);
 		if (tag) {
 			if (parse_tag_buffer(tag, buffer, size))
 			       return NULL;
 			obj = &tag->object;
 		}
 	} else {
-		warning("object %s has unknown type id %d", sha1_to_hex(sha1), type);
+		warning("object %s has unknown type id %d", oid_to_hex(oid), type);
 		obj = NULL;
 	}
 	return obj;
 }
 
-struct object *parse_object_or_die(const unsigned char *sha1,
+struct object *parse_object_or_die(const struct object_id *oid,
 				   const char *name)
 {
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(oid);
 	if (o)
 		return o;
 
-	die(_("unable to parse object: %s"), name ? name : sha1_to_hex(sha1));
+	die(_("unable to parse object: %s"), name ? name : oid_to_hex(oid));
 }
 
-struct object *parse_object(const unsigned char *sha1)
+struct object *parse_object(const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	const unsigned char *repl = lookup_replace_object(sha1);
+	const unsigned char *repl = lookup_replace_object(oid->hash);
 	void *buffer;
 	struct object *obj;
-	struct object_id oid;
 
-	hashcpy(oid.hash, sha1);
-
-	obj = lookup_object(oid.hash);
+	obj = lookup_object(oid->hash);
 	if (obj && obj->parsed)
 		return obj;
 
 	if ((obj && obj->type == OBJ_BLOB) ||
-	    (!obj && has_sha1_file(sha1) &&
-	     sha1_object_info(sha1, NULL) == OBJ_BLOB)) {
+	    (!obj && has_object_file(oid) &&
+	     sha1_object_info(oid->hash, NULL) == OBJ_BLOB)) {
 		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
-			error("sha1 mismatch %s", sha1_to_hex(repl));
+			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(&oid), NULL, 0);
-		return lookup_object(sha1);
+		parse_blob_buffer(lookup_blob(oid), NULL, 0);
+		return lookup_object(oid->hash);
 	}
 
-	buffer = read_sha1_file(sha1, &type, &size);
+	buffer = read_sha1_file(oid->hash, &type, &size);
 	if (buffer) {
 		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
@@ -278,7 +272,7 @@ struct object *parse_object(const unsigned char *sha1)
 			return NULL;
 		}
 
-		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
+		obj = parse_object_buffer(oid, type, size, buffer, &eaten);
 		if (!eaten)
 			free(buffer);
 		return obj;
diff --git a/object.h b/object.h
index f52957dcb..33e5cc994 100644
--- a/object.h
+++ b/object.h
@@ -89,20 +89,20 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet);
  *
  * Returns NULL if the object is missing or corrupt.
  */
-struct object *parse_object(const unsigned char *sha1);
+struct object *parse_object(const struct object_id *oid);
 
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
  * "name" parameter is not NULL, it is included in the error message
- * (otherwise, the sha1 hex is given).
+ * (otherwise, the hex object ID is given).
  */
-struct object *parse_object_or_die(const unsigned char *sha1, const char *name);
+struct object *parse_object_or_die(const struct object_id *oid, const char *name);
 
 /* Given the result of read_sha1_file(), returns the object after
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(const unsigned char *sha1, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 39bcc1684..a3ac3dccd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -673,7 +673,7 @@ int prepare_bitmap_walk(struct rev_info *revs)
 		struct object *object = pending_e[i].item;
 
 		if (object->type == OBJ_NONE)
-			parse_object_or_die(object->oid.hash, NULL);
+			parse_object_or_die(&object->oid, NULL);
 
 		while (object->type == OBJ_TAG) {
 			struct tag *tag = (struct tag *) object;
@@ -685,7 +685,7 @@ int prepare_bitmap_walk(struct rev_info *revs)
 
 			if (!tag->tagged)
 				die("bad tag");
-			object = parse_object_or_die(tag->tagged->oid.hash, NULL);
+			object = parse_object_or_die(&tag->tagged->oid, NULL);
 		}
 
 		if (object->flags & UNINTERESTING)
diff --git a/pretty.c b/pretty.c
index d0f86f5d8..c4a0ace34 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1137,7 +1137,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	/* these depend on the commit */
 	if (!commit->object.parsed)
-		parse_object(commit->object.oid.hash);
+		parse_object(&commit->object.oid);
 
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
diff --git a/reachable.c b/reachable.c
index 3bbc84417..69ca176f6 100644
--- a/reachable.c
+++ b/reachable.c
@@ -33,7 +33,7 @@ static int add_one_ref(const char *path, const struct object_id *oid,
 		return 0;
 	}
 
-	object = parse_object_or_die(oid->hash, path);
+	object = parse_object_or_die(oid, path);
 	add_pending_object(revs, object, "");
 
 	return 0;
@@ -82,7 +82,7 @@ static void add_recent_object(const struct object_id *oid,
 	switch (type) {
 	case OBJ_TAG:
 	case OBJ_COMMIT:
-		obj = parse_object_or_die(oid->hash, NULL);
+		obj = parse_object_or_die(oid, NULL);
 		break;
 	case OBJ_TREE:
 		obj = (struct object *)lookup_tree(oid);
diff --git a/ref-filter.c b/ref-filter.c
index 56fc990a5..3f7cf71b5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -683,7 +683,7 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
 	void *buf = read_sha1_file(oid->hash, &type, sz);
 
 	if (buf)
-		*obj = parse_object_buffer(oid->hash, type, *sz, buf, eaten);
+		*obj = parse_object_buffer(oid, type, *sz, buf, eaten);
 	else
 		*obj = NULL;
 	return buf;
@@ -1687,7 +1687,7 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 
 	if (oid_array_lookup(points_at, oid) >= 0)
 		return oid;
-	obj = parse_object(oid->hash);
+	obj = parse_object(oid);
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type == OBJ_TAG)
diff --git a/reflog-walk.c b/reflog-walk.c
index c8fdf051d..110e18f1f 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -238,13 +238,13 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	do {
 		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 		commit_reflog->recno--;
-		logobj = parse_object(reflog->ooid.hash);
+		logobj = parse_object(&reflog->ooid);
 	} while (commit_reflog->recno && (logobj && logobj->type != OBJ_COMMIT));
 
 	if (!logobj && commit_reflog->recno >= 0 && is_null_oid(&reflog->ooid)) {
 		/* a root commit, but there are still more entries to show */
 		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
-		logobj = parse_object(reflog->noid.hash);
+		logobj = parse_object(&reflog->noid);
 	}
 
 	if (!logobj || logobj->type != OBJ_COMMIT) {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 171a157f7..96e791676 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2980,7 +2980,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	struct object *o;
 	int fd;
 
-	o = parse_object(oid->hash);
+	o = parse_object(oid);
 	if (!o) {
 		strbuf_addf(err,
 			    "trying to write ref '%s' with nonexistent object %s",
diff --git a/remote.c b/remote.c
index bf9a47d95..38ca1353b 100644
--- a/remote.c
+++ b/remote.c
@@ -1954,12 +1954,12 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	 * Both new and old must be commit-ish and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
-	o = deref_tag(parse_object(old_oid->hash), NULL, 0);
+	o = deref_tag(parse_object(old_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	old = (struct commit *) o;
 
-	o = deref_tag(parse_object(new_oid->hash), NULL, 0);
+	o = deref_tag(parse_object(new_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	new = (struct commit *) o;
diff --git a/revision.c b/revision.c
index 80f74bb7b..64e67e017 100644
--- a/revision.c
+++ b/revision.c
@@ -181,7 +181,7 @@ void add_head_to_pending(struct rev_info *revs)
 	struct object *obj;
 	if (get_oid("HEAD", &oid))
 		return;
-	obj = parse_object(oid.hash);
+	obj = parse_object(&oid);
 	if (!obj)
 		return;
 	add_pending_object(revs, obj, "HEAD");
@@ -193,7 +193,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	object = parse_object(oid->hash);
+	object = parse_object(oid);
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
@@ -228,7 +228,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			add_pending_object(revs, object, tag->tag);
 		if (!tag->tagged)
 			die("bad tag");
-		object = parse_object(tag->tagged->oid.hash);
+		object = parse_object(&tag->tagged->oid);
 		if (!object) {
 			if (flags & UNINTERESTING)
 				return NULL;
@@ -1200,7 +1200,7 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	if (!is_null_oid(oid)) {
-		struct object *o = parse_object(oid->hash);
+		struct object *o = parse_object(oid);
 		if (o) {
 			o->flags |= cb->all_flags;
 			/* ??? CMDLINEFLAGS ??? */
@@ -1479,8 +1479,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				verify_non_filename(revs->prefix, arg);
 			}
 
-			a_obj = parse_object(from_oid.hash);
-			b_obj = parse_object(oid.hash);
+			a_obj = parse_object(&from_oid);
+			b_obj = parse_object(&oid);
 			if (!a_obj || !b_obj) {
 			missing:
 				if (revs->ignore_missing)
diff --git a/server-info.c b/server-info.c
index 7bc4e75d2..7f75229bd 100644
--- a/server-info.c
+++ b/server-info.c
@@ -51,7 +51,7 @@ static int add_info_ref(const char *path, const struct object_id *oid,
 			int flag, void *cb_data)
 {
 	FILE *fp = cb_data;
-	struct object *o = parse_object(oid->hash);
+	struct object *o = parse_object(oid);
 	if (!o)
 		return -1;
 
diff --git a/sha1_name.c b/sha1_name.c
index 72e72ab9a..de8278530 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -241,7 +241,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(oid->hash), NULL, 0);
+	obj = deref_tag(parse_object(oid), NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
@@ -265,7 +265,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(oid->hash), NULL, 0);
+	obj = deref_tag(parse_object(oid), NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
@@ -776,7 +776,7 @@ struct object *peel_to_type(const char *name, int namelen,
 	if (name && !namelen)
 		namelen = strlen(name);
 	while (1) {
-		if (!o || (!o->parsed && !parse_object(o->oid.hash)))
+		if (!o || (!o->parsed && !parse_object(&o->oid)))
 			return NULL;
 		if (expected_type == OBJ_ANY || o->type == expected_type)
 			return o;
@@ -849,12 +849,12 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 	if (get_sha1_1(name, sp - name - 2, outer.hash, lookup_flags))
 		return -1;
 
-	o = parse_object(outer.hash);
+	o = parse_object(&outer);
 	if (!o)
 		return -1;
 	if (!expected_type) {
 		o = deref_tag(o, name, sp - name - 2);
-		if (!o || (!o->parsed && !parse_object(o->oid.hash)))
+		if (!o || (!o->parsed && !parse_object(&o->oid)))
 			return -1;
 		hashcpy(sha1, o->oid.hash);
 		return 0;
@@ -981,7 +981,7 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct commit_list **list = cb_data;
-	struct object *object = parse_object(oid->hash);
+	struct object *object = parse_object(oid);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
@@ -1027,7 +1027,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 		int matches;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		if (!parse_object(commit->object.oid.hash))
+		if (!parse_object(&commit->object.oid))
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
diff --git a/tag.c b/tag.c
index 571798519..eb7b146f4 100644
--- a/tag.c
+++ b/tag.c
@@ -66,7 +66,7 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
-			o = parse_object(((struct tag *)o)->tagged->oid.hash);
+			o = parse_object(&((struct tag *)o)->tagged->oid);
 		else
 			o = NULL;
 	if (!o && warn) {
@@ -80,7 +80,7 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 struct object *deref_tag_noverify(struct object *o)
 {
 	while (o && o->type == OBJ_TAG) {
-		o = parse_object(o->oid.hash);
+		o = parse_object(&o->oid);
 		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged)
 			o = ((struct tag *)o)->tagged;
 		else
diff --git a/tree.c b/tree.c
index 9adcd8bd4..603b29ee8 100644
--- a/tree.c
+++ b/tree.c
@@ -234,7 +234,7 @@ void free_tree_buffer(struct tree *tree)
 
 struct tree *parse_tree_indirect(const struct object_id *oid)
 {
-	struct object *obj = parse_object(oid->hash);
+	struct object *obj = parse_object(oid);
 	do {
 		if (!obj)
 			return NULL;
@@ -247,6 +247,6 @@ struct tree *parse_tree_indirect(const struct object_id *oid)
 		else
 			return NULL;
 		if (!obj->parsed)
-			parse_object(obj->oid.hash);
+			parse_object(&obj->oid);
 	} while (1);
 }
diff --git a/upload-pack.c b/upload-pack.c
index 5b9d21089..8619ec435 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -296,7 +296,7 @@ static int got_oid(const char *hex, struct object_id *oid)
 	if (!has_object_file(oid))
 		return -1;
 
-	o = parse_object(oid->hash);
+	o = parse_object(oid);
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
 	if (o->type == OBJ_COMMIT) {
@@ -334,7 +334,7 @@ static int reachable(struct commit *want)
 			break;
 		}
 		if (!commit->object.parsed)
-			parse_object(commit->object.oid.hash);
+			parse_object(&commit->object.oid);
 		if (commit->object.flags & REACHABLE)
 			continue;
 		commit->object.flags |= REACHABLE;
@@ -755,7 +755,7 @@ static void receive_needs(void)
 			struct object *object;
 			if (get_oid_hex(arg, &oid))
 				die("invalid shallow line: %s", line);
-			object = parse_object(oid.hash);
+			object = parse_object(&oid);
 			if (!object)
 				continue;
 			if (object->type != OBJ_COMMIT)
@@ -821,7 +821,7 @@ static void receive_needs(void)
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
 
-		o = parse_object(oid_buf.hash);
+		o = parse_object(&oid_buf);
 		if (!o) {
 			packet_write_fmt(1,
 					 "ERR upload-pack: not our ref %s",
diff --git a/walker.c b/walker.c
index eae9fb974..274f1a493 100644
--- a/walker.c
+++ b/walker.c
@@ -180,7 +180,7 @@ static int loop(struct walker *walker)
 			}
 		}
 		if (!obj->type)
-			parse_object(obj->oid.hash);
+			parse_object(&obj->oid);
 		if (process_object(walker, obj))
 			return -1;
 	}
