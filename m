Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB9C677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBXGjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBXGjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAC861EF3
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:26 -0800 (PST)
Received: (qmail 3690 invoked by uid 109); 24 Feb 2023 06:39:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31116 invoked by uid 111); 24 Feb 2023 06:39:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:24 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/21] for_each_object: mark unused callback parameters
Message-ID: <Y/hbnCJmo9G+YqE6@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The for_each_{loose,packed}_object interface uses callback functions,
but not every callback needs all of the parameters. Mark the unused ones
to satisfy -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c      |  8 ++++----
 builtin/count-objects.c |  6 ++++--
 builtin/fsck.c          | 25 +++++++++++++------------
 builtin/gc.c            | 14 +++++++-------
 builtin/pack-objects.c  | 15 ++++++++-------
 builtin/prune.c         |  6 ++++--
 builtin/repack.c        |  5 +++--
 builtin/rev-list.c      |  3 ++-
 diagnose.c              |  3 ++-
 midx.c                  |  2 +-
 object-file.c           |  3 ++-
 packfile.c              |  4 ++--
 reachable.c             |  3 ++-
 revision.c              |  4 ++--
 14 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cc17635e76..0dec21c107 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -559,16 +559,16 @@ static int batch_object_cb(const struct object_id *oid, void *vdata)
 }
 
 static int collect_loose_object(const struct object_id *oid,
-				const char *path,
+				const char *path UNUSED,
 				void *data)
 {
 	oid_array_append(data, oid);
 	return 0;
 }
 
 static int collect_packed_object(const struct object_id *oid,
-				 struct packed_git *pack,
-				 uint32_t pos,
+				 struct packed_git *pack UNUSED,
+				 uint32_t pos UNUSED,
 				 void *data)
 {
 	oid_array_append(data, oid);
@@ -591,7 +591,7 @@ static int batch_unordered_object(const struct object_id *oid,
 }
 
 static int batch_unordered_loose(const struct object_id *oid,
-				 const char *path,
+				 const char *path UNUSED,
 				 void *data)
 {
 	return batch_unordered_object(oid, NULL, 0, data);
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 07b9419596..bb21bc43e4 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -57,7 +57,8 @@ static void loose_garbage(const char *path)
 		report_garbage(PACKDIR_FILE_GARBAGE, path);
 }
 
-static int count_loose(const struct object_id *oid, const char *path, void *data)
+static int count_loose(const struct object_id *oid, const char *path,
+		       void *data UNUSED)
 {
 	struct stat st;
 
@@ -72,7 +73,8 @@ static int count_loose(const struct object_id *oid, const char *path, void *data
 	return 0;
 }
 
-static int count_cruft(const char *basename, const char *path, void *data)
+static int count_cruft(const char *basename UNUSED, const char *path,
+		       void *data UNUSED)
 {
 	loose_garbage(path);
 	return 0;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d207bd909b..56aba054ed 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -233,17 +233,17 @@ static void mark_unreachable_referents(const struct object_id *oid)
 }
 
 static int mark_loose_unreachable_referents(const struct object_id *oid,
-					    const char *path,
-					    void *data)
+					    const char *path UNUSED,
+					    void *data UNUSED)
 {
 	mark_unreachable_referents(oid);
 	return 0;
 }
 
 static int mark_packed_unreachable_referents(const struct object_id *oid,
-					     struct packed_git *pack,
-					     uint32_t pos,
-					     void *data)
+					     struct packed_git *pack UNUSED,
+					     uint32_t pos UNUSED,
+					     void *data UNUSED)
 {
 	mark_unreachable_referents(oid);
 	return 0;
@@ -661,14 +661,15 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	return 0; /* keep checking other objects, even if we saw an error */
 }
 
-static int fsck_cruft(const char *basename, const char *path, void *data)
+static int fsck_cruft(const char *basename, const char *path,
+		      void *data UNUSED)
 {
 	if (!starts_with(basename, "tmp_obj_"))
 		fprintf_ln(stderr, _("bad sha1 file: %s"), path);
 	return 0;
 }
 
-static int fsck_subdir(unsigned int nr, const char *path, void *data)
+static int fsck_subdir(unsigned int nr, const char *path UNUSED, void *data)
 {
 	struct for_each_loose_cb *cb_data = data;
 	struct progress *progress = cb_data->progress;
@@ -803,17 +804,17 @@ static void mark_object_for_connectivity(const struct object_id *oid)
 }
 
 static int mark_loose_for_connectivity(const struct object_id *oid,
-				       const char *path,
-				       void *data)
+				       const char *path UNUSED,
+				       void *data UNUSED)
 {
 	mark_object_for_connectivity(oid);
 	return 0;
 }
 
 static int mark_packed_for_connectivity(const struct object_id *oid,
-					struct packed_git *pack,
-					uint32_t pos,
-					void *data)
+					struct packed_git *pack UNUSED,
+					uint32_t pos UNUSED,
+					void *data UNUSED)
 {
 	mark_object_for_connectivity(oid);
 	return 0;
diff --git a/builtin/gc.c b/builtin/gc.c
index 02455fdcd7..4486438624 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -976,9 +976,9 @@ struct write_loose_object_data {
 
 static int loose_object_auto_limit = 100;
 
-static int loose_object_count(const struct object_id *oid,
-			       const char *path,
-			       void *data)
+static int loose_object_count(const struct object_id *oid UNUSED,
+			      const char *path UNUSED,
+			      void *data)
 {
 	int *count = (int*)data;
 	if (++(*count) >= loose_object_auto_limit)
@@ -1003,15 +1003,15 @@ static int loose_object_auto_condition(void)
 					     NULL, NULL, &count);
 }
 
-static int bail_on_loose(const struct object_id *oid,
-			 const char *path,
-			 void *data)
+static int bail_on_loose(const struct object_id *oid UNUSED,
+			 const char *path UNUSED,
+			 void *data UNUSED)
 {
 	return 1;
 }
 
 static int write_loose_object_to_stdin(const struct object_id *oid,
-				       const char *path,
+				       const char *path UNUSED,
 				       void *data)
 {
 	struct write_loose_object_data *d = (struct write_loose_object_data *)data;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fb92a9686b..d7eebeb6eb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3260,13 +3260,14 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	return 0;
 }
 
-static void show_commit_pack_hint(struct commit *commit, void *_data)
+static void show_commit_pack_hint(struct commit *commit UNUSED,
+				  void *data UNUSED)
 {
 	/* nothing to do; commits don't have a namehash */
 }
 
 static void show_object_pack_hint(struct object *object, const char *name,
-				  void *_data)
+				  void *data UNUSED)
 {
 	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
 	if (!oe)
@@ -3762,7 +3763,7 @@ static void show_edge(struct commit *commit)
 static int add_object_in_unpacked_pack(const struct object_id *oid,
 				       struct packed_git *pack,
 				       uint32_t pos,
-				       void *_data)
+				       void *data UNUSED)
 {
 	if (cruft) {
 		off_t offset;
@@ -3796,7 +3797,7 @@ static void add_objects_in_unpacked_packs(void)
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,
-			    void *data)
+			    void *data UNUSED)
 {
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
@@ -3947,13 +3948,13 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 }
 
 static void record_recent_object(struct object *obj,
-				 const char *name,
-				 void *data)
+				 const char *name UNUSED,
+				 void *data UNUSED)
 {
 	oid_array_append(&recent_objects, &obj->oid);
 }
 
-static void record_recent_commit(struct commit *commit, void *data)
+static void record_recent_commit(struct commit *commit, void *data UNUSED)
 {
 	oid_array_append(&recent_objects, &commit->object.oid);
 }
diff --git a/builtin/prune.c b/builtin/prune.c
index 2719220108..4580890393 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -98,7 +98,8 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	return 0;
 }
 
-static int prune_cruft(const char *basename, const char *path, void *data)
+static int prune_cruft(const char *basename, const char *path,
+		       void *data UNUSED)
 {
 	if (starts_with(basename, "tmp_obj_"))
 		prune_tmp_file(path);
@@ -107,7 +108,8 @@ static int prune_cruft(const char *basename, const char *path, void *data)
 	return 0;
 }
 
-static int prune_subdir(unsigned int nr, const char *path, void *data)
+static int prune_subdir(unsigned int nr UNUSED, const char *path,
+			void *data UNUSED)
 {
 	if (!show_only)
 		rmdir(path);
diff --git a/builtin/repack.c b/builtin/repack.c
index f649379531..36b511c564 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -182,8 +182,9 @@ static void prepare_pack_objects(struct child_process *cmd,
  * Write oid to the given struct child_process's stdin, starting it first if
  * necessary.
  */
-static int write_oid(const struct object_id *oid, struct packed_git *pack,
-		     uint32_t pos, void *data)
+static int write_oid(const struct object_id *oid,
+		     struct packed_git *pack UNUSED,
+		     uint32_t pos UNUSED, void *data)
 {
 	struct child_process *cmd = data;
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index cceb5de975..888ad6b5c0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -257,7 +257,8 @@ static inline void finish_object__ma(struct object *obj)
 	}
 }
 
-static int finish_object(struct object *obj, const char *name, void *cb_data)
+static int finish_object(struct object *obj, const char *name UNUSED,
+			 void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
 	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
diff --git a/diagnose.c b/diagnose.c
index 8f26569896..e7c42b3a71 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -43,7 +43,8 @@ int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
 	return error(_("invalid --%s value '%s'"), opt->long_name, arg);
 }
 
-static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
+static void dir_file_stats_objects(const char *full_path,
+				   size_t full_path_len UNUSED,
 				   const char *file_name, void *data)
 {
 	struct strbuf *buf = data;
diff --git a/midx.c b/midx.c
index 7cfad04a24..d761cc50bd 100644
--- a/midx.c
+++ b/midx.c
@@ -1607,7 +1607,7 @@ struct clear_midx_data {
 	const char *ext;
 };
 
-static void clear_midx_file_ext(const char *full_path, size_t full_path_len,
+static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUSED,
 				const char *file_name, void *_data)
 {
 	struct clear_midx_data *data = _data;
diff --git a/object-file.c b/object-file.c
index 939865c1ae..389d452e48 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2644,7 +2644,8 @@ int for_each_loose_object(each_loose_object_fn cb, void *data,
 	return 0;
 }
 
-static int append_loose_object(const struct object_id *oid, const char *path,
+static int append_loose_object(const struct object_id *oid,
+			       const char *path UNUSED,
 			       void *data)
 {
 	oidtree_insert(data, oid);
diff --git a/packfile.c b/packfile.c
index 79e21ab18e..4dc0e15aa5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2204,8 +2204,8 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 }
 
 static int add_promisor_object(const struct object_id *oid,
-			       struct packed_git *pack,
-			       uint32_t pos,
+			       struct packed_git *pack UNUSED,
+			       uint32_t pos UNUSED,
 			       void *set_)
 {
 	struct oidset *set = set_;
diff --git a/reachable.c b/reachable.c
index 08f290c2be..0afe80c203 100644
--- a/reachable.c
+++ b/reachable.c
@@ -154,7 +154,8 @@ static int add_recent_loose(const struct object_id *oid,
 }
 
 static int add_recent_packed(const struct object_id *oid,
-			     struct packed_git *p, uint32_t pos,
+			     struct packed_git *p,
+			     uint32_t pos,
 			     void *data)
 {
 	struct object *obj;
diff --git a/revision.c b/revision.c
index 4a24fc3fcd..65fca1ed6c 100644
--- a/revision.c
+++ b/revision.c
@@ -3440,8 +3440,8 @@ void reset_revision_walk(void)
 }
 
 static int mark_uninteresting(const struct object_id *oid,
-			      struct packed_git *pack,
-			      uint32_t pos,
+			      struct packed_git *pack UNUSED,
+			      uint32_t pos UNUSED,
 			      void *cb)
 {
 	struct rev_info *revs = cb;
-- 
2.39.2.981.g6157336f25

