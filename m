Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9CDC677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBXGjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBXGjf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83F61EF0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:23 -0800 (PST)
Received: (qmail 3687 invoked by uid 109); 24 Feb 2023 06:39:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31113 invoked by uid 111); 24 Feb 2023 06:39:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/21] list-objects: mark unused callback parameters
Message-ID: <Y/hbmh2jpj4OgWUN@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our graph-traversal functions take callbacks for showing commits and
objects, but not all callbacks need each parameter.  Likewise for the
similar traverse_bitmap_commit_list(), which has a different interface
but serves the same purpose. And the include_check mechanism, which
passes along a void pointer which is not always used.

Mark the unused ones to to make -Wunused-parameter happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 11 ++++++-----
 builtin/rev-list.c     | 10 +++++-----
 pack-bitmap.c          |  6 ++++--
 reachable.c            | 12 +++++++-----
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 74a167a180..fb92a9686b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1590,7 +1590,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 
 static int add_object_entry_from_bitmap(const struct object_id *oid,
 					enum object_type type,
-					int flags, uint32_t name_hash,
+					int flags UNUSED, uint32_t name_hash,
 					struct packed_git *pack, off_t offset)
 {
 	display_progress(progress_state, ++nr_seen);
@@ -3464,7 +3464,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 	return;
 }
 
-static void show_cruft_object(struct object *obj, const char *name, void *data)
+static void show_cruft_object(struct object *obj, const char *name, void *data UNUSED)
 {
 	/*
 	 * if we did not record it earlier, it's at least as old as our
@@ -3484,7 +3484,7 @@ static void show_cruft_commit(struct commit *commit, void *data)
 	show_cruft_object((struct object*)commit, NULL, data);
 }
 
-static int cruft_include_check_obj(struct object *obj, void *data)
+static int cruft_include_check_obj(struct object *obj, void *data UNUSED)
 {
 	return !has_object_kept_pack(&obj->oid, IN_CORE_KEEP_PACKS);
 }
@@ -3663,7 +3663,7 @@ static void read_object_list_from_stdin(void)
 	}
 }
 
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, void *data UNUSED)
 {
 	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0);
 
@@ -3674,7 +3674,8 @@ static void show_commit(struct commit *commit, void *data)
 		propagate_island_marks(commit);
 }
 
-static void show_object(struct object *obj, const char *name, void *data)
+static void show_object(struct object *obj, const char *name,
+			void *data UNUSED)
 {
 	add_preferred_base_object(name);
 	add_object_entry(&obj->oid, obj->type, name, 0);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d42db0b0cc..cceb5de975 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -362,11 +362,11 @@ static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 
 static int show_object_fast(
 	const struct object_id *oid,
-	enum object_type type,
-	int exclude,
-	uint32_t name_hash,
-	struct packed_git *found_pack,
-	off_t found_offset)
+	enum object_type type UNUSED,
+	int exclude UNUSED,
+	uint32_t name_hash UNUSED,
+	struct packed_git *found_pack UNUSED,
+	off_t found_offset UNUSED)
 {
 	fprintf(stdout, "%s\n", oid_to_hex(oid));
 	return 1;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d2a42abf28..c8994a0f00 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -951,7 +951,8 @@ static void show_object(struct object *object, const char *name, void *data_)
 	bitmap_set(data->base, bitmap_pos);
 }
 
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit UNUSED,
+			void *data UNUSED)
 {
 }
 
@@ -1940,7 +1941,8 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
 		    type_name(bitmap_type));
 }
 
-static void test_show_object(struct object *object, const char *name,
+static void test_show_object(struct object *object,
+			     const char *name UNUSED,
 			     void *data)
 {
 	struct bitmap_test_data *tdata = data;
diff --git a/reachable.c b/reachable.c
index aba63ebeb3..08f290c2be 100644
--- a/reachable.c
+++ b/reachable.c
@@ -48,7 +48,9 @@ static int add_one_ref(const char *path, const struct object_id *oid,
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
  */
-static void mark_object(struct object *obj, const char *name, void *data)
+static void mark_object(struct object *obj UNUSED,
+			const char *name UNUSED,
+			void *data)
 {
 	update_progress(data);
 }
@@ -202,10 +204,10 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 
 static int mark_object_seen(const struct object_id *oid,
 			     enum object_type type,
-			     int exclude,
-			     uint32_t name_hash,
-			     struct packed_git *found_pack,
-			     off_t found_offset)
+			     int exclude UNUSED,
+			     uint32_t name_hash UNUSED,
+			     struct packed_git *found_pack UNUSED,
+			     off_t found_offset UNUSED)
 {
 	struct object *obj = lookup_object_by_type(the_repository, oid, type);
 	if (!obj)
-- 
2.39.2.981.g6157336f25

