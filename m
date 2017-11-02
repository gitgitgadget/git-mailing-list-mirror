Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE0220281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964874AbdKBUVT (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:21:19 -0400
Received: from siwi.pair.com ([209.68.5.199]:36108 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964870AbdKBUVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:21:16 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 31F72845A8;
        Thu,  2 Nov 2017 16:21:16 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5E97D845A5;
        Thu,  2 Nov 2017 16:21:15 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 8/9] sha1_file: support lazily fetching missing objects
Date:   Thu,  2 Nov 2017 20:20:51 +0000
Message-Id: <20171102202052.58762-9-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102202052.58762-1-git@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach sha1_file to fetch objects from the remote configured in
extensions.partialcloneremote whenever an object is requested but missing.

The fetching of objects can be suppressed through a global variable.
This is used by fsck and index-pack.

However, by default, such fetching is not suppressed. This is meant as a
temporary measure to ensure that all Git commands work in such a
situation. Future patches will update some commands to either tolerate
missing objects (without fetching them) or be more efficient in fetching
them.

In order to determine the code changes in sha1_file.c necessary, I
investigated the following:
 (1) functions in sha1_file.c that take in a hash, without the user
     regarding how the object is stored (loose or packed)
 (2) functions in packfile.c (because I need to check callers that know
     about the loose/packed distinction and operate on both differently,
     and ensure that they can handle the concept of objects that are
     neither loose nor packed)

(1) is handled by the modification to sha1_object_info_extended().

For (2), I looked at for_each_packed_object and others.  For
for_each_packed_object, the callers either already work or are fixed in
this patch:
 - reachable - only to find recent objects
 - builtin/fsck - already knows about missing objects
 - builtin/cat-file - warning message added in this commit

Callers of the other functions do not need to be changed:
 - parse_pack_index
   - http - indirectly from http_get_info_packs
   - find_pack_entry_one
     - this searches a single pack that is provided as an argument; the
       caller already knows (through other means) that the sought object
       is in a specific pack
 - find_sha1_pack
   - fast-import - appears to be an optimization to not store a file if
     it is already in a pack
   - http-walker - to search through a struct alt_base
   - http-push - to search through remote packs
 - has_sha1_pack
   - builtin/fsck - already knows about promisor objects
   - builtin/count-objects - informational purposes only (check if loose
     object is also packed)
   - builtin/prune-packed - check if object to be pruned is packed (if
     not, don't prune it)
   - revision - used to exclude packed objects if requested by user
   - diff - just for optimization

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/cat-file.c       |   3 +
 builtin/fetch-pack.c     |   2 +
 builtin/fsck.c           |   3 +
 builtin/index-pack.c     |   6 ++
 builtin/rev-list.c       |  35 +++++++++--
 cache.h                  |   8 +++
 fetch-object.c           |   3 +
 list-objects.c           |   8 ++-
 object.c                 |   2 +-
 revision.c               |  32 +++++++++-
 revision.h               |   5 +-
 sha1_file.c              |  39 ++++++++----
 t/t0410-partial-clone.sh | 152 +++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 277 insertions(+), 21 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd..ba77b73 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -13,6 +13,7 @@
 #include "tree-walk.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "partial-clone-utils.h"
 
 struct batch_options {
 	int enabled;
@@ -475,6 +476,8 @@ static int batch_objects(struct batch_options *opt)
 
 		for_each_loose_object(batch_loose_object, &sa, 0);
 		for_each_packed_object(batch_packed_object, &sa, 0);
+		if (is_partial_clone_registered())
+			warning("This repository has partial clone enabled. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9f303cf..9a7ebf6 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -53,6 +53,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
+	fetch_if_missing = 0;
+
 	packet_trace_identity("fetch-pack");
 
 	memset(&args, 0, sizeof(args));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 578a7c8..3b76c0e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -678,6 +678,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	int i;
 	struct alternate_object_database *alt;
 
+	/* fsck knows how to handle missing promisor objects */
+	fetch_if_missing = 0;
+
 	errors_found = 0;
 	check_replace_refs = 0;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 24c2f05..a0a35e6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1657,6 +1657,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
 
+	/*
+	 * index-pack never needs to fetch missing objects, since it only
+	 * accesses the repo to do hash collision checks
+	 */
+	fetch_if_missing = 0;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index cc9fa40..21f0b4c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -15,6 +15,7 @@
 #include "progress.h"
 #include "reflog-walk.h"
 #include "oidset.h"
+#include "packfile.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -60,6 +61,7 @@ static unsigned progress_counter;
 static struct list_objects_filter_options filter_options;
 static struct oidset missing_objects;
 static struct oidset omitted_objects;
+static int arg_exclude_promisor_objects;
 static int arg_print_missing;
 static int arg_print_omitted;
 static int arg_ignore_missing;
@@ -190,27 +192,39 @@ static void finish_commit(struct commit *commit, void *data)
 	free_commit_buffer(commit);
 }
 
-static void finish_object(struct object *obj, const char *name, void *cb_data)
+static int finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
 	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
+		/*
+		 * If "--exclude-promisor-objects", we try to dynamically
+		 * fetch missing objects.  Whether we tried or not, we do
+		 * not have the object.  We can then either print, ignore,
+		 * or conditionally ignore them.
+		 */
 		if (arg_print_missing) {
 			oidset_insert(&missing_objects, &obj->oid);
-			return;
+			return 1;
 		}
 		if (arg_ignore_missing)
-			return;
+			return 1;
+
+		if (arg_exclude_promisor_objects &&
+		    is_promisor_object(&obj->oid))
+			return 1;
 
 		die("missing blob object '%s'", oid_to_hex(&obj->oid));
 	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
 		parse_object(&obj->oid);
+	return 0;
 }
 
 static void show_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	finish_object(obj, name, cb_data);
+	if (finish_object(obj, name, cb_data))
+		return;
 	display_progress(progress, ++progress_counter);
 	if (info->flags & REV_LIST_QUIET)
 		return;
@@ -307,6 +321,19 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+
+	/*
+	 * Scan the argument list before invoking setup_revisions(), so that we
+	 * know if fetch_if_missing needs to be set to 0.
+	 */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--exclude-promisor-objects")) {
+			fetch_if_missing = 0;
+			arg_exclude_promisor_objects = 1;
+			break;
+		}
+	}
+
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	memset(&info, 0, sizeof(info));
diff --git a/cache.h b/cache.h
index 5f84103..360ff9e 100644
--- a/cache.h
+++ b/cache.h
@@ -1729,6 +1729,14 @@ struct object_info {
 #define OBJECT_INFO_QUICK 8
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
+/*
+ * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
+ * blobs. This has a difference only if is_partial_clone_registered() is true.
+ *
+ * Its default value is 1.
+ */
+extern int fetch_if_missing;
+
 /* Dumb servers support */
 extern int update_server_info(int);
 
diff --git a/fetch-object.c b/fetch-object.c
index f89dbba..369b61c 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -9,7 +9,9 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 	struct remote *remote;
 	struct transport *transport;
 	struct ref *ref;
+	int original_fetch_if_missing = fetch_if_missing;
 
+	fetch_if_missing = 0;
 	remote = remote_get(remote_name);
 	if (!remote->url[0])
 		die(_("Remote with no URL"));
@@ -20,4 +22,5 @@ void fetch_object(const char *remote_name, const unsigned char *sha1)
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_HAVES, "1");
 	transport_fetch_refs(transport, ref);
+	fetch_if_missing = original_fetch_if_missing;
 }
diff --git a/list-objects.c b/list-objects.c
index 848b040..5390a74 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -9,6 +9,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "packfile.h"
 
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
@@ -90,6 +91,8 @@ static void process_tree(struct rev_info *revs,
 	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
 		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
+	int gently = revs->ignore_missing_links ||
+		revs->exclude_promisor_objects;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_SHOW;
 
 	if (!revs->tree_objects)
@@ -98,9 +101,12 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, revs->ignore_missing_links) < 0) {
+	if (parse_tree_gently(tree, gently) < 0) {
 		if (revs->ignore_missing_links)
 			return;
+		if (revs->exclude_promisor_objects &&
+		    is_promisor_object(&obj->oid))
+			return;
 		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
diff --git a/object.c b/object.c
index b9a4a0e..4c222d6 100644
--- a/object.c
+++ b/object.c
@@ -252,7 +252,7 @@ struct object *parse_object(const struct object_id *oid)
 	if (obj && obj->parsed)
 		return obj;
 
-	if ((obj && obj->type == OBJ_BLOB) ||
+	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
 	    (!obj && has_object_file(oid) &&
 	     sha1_object_info(oid->hash, NULL) == OBJ_BLOB)) {
 		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
diff --git a/revision.c b/revision.c
index d167223..85265a4 100644
--- a/revision.c
+++ b/revision.c
@@ -198,6 +198,8 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
+		if (revs->exclude_promisor_objects && is_promisor_object(oid))
+			return NULL;
 		die("bad object %s", name);
 	}
 	object->flags |= flags;
@@ -791,8 +793,17 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
 
-		if (parse_commit_gently(p, revs->ignore_missing_links) < 0)
+		int gently = revs->ignore_missing_links ||
+			revs->exclude_promisor_objects;
+		if (parse_commit_gently(p, gently) < 0) {
+			if (revs->exclude_promisor_objects &&
+			    is_promisor_object(&p->object.oid)) {
+				if (revs->first_parent_only)
+					break;
+				continue;
+			}
 			return -1;
+		}
 		if (revs->show_source && !p->util)
 			p->util = commit->util;
 		p->object.flags |= left_flag;
@@ -2088,6 +2099,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
+	}else if (!strcmp(arg, "--exclude-promisor-objects")) {
+		if (fetch_if_missing)
+			die("BUG: --exclude-promisor-objects can only be used when fetch_if_missing is 0");
+		revs->exclude_promisor_objects = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
@@ -2830,6 +2845,16 @@ void reset_revision_walk(void)
 	clear_object_flags(SEEN | ADDED | SHOWN);
 }
 
+static int mark_uninteresting(const struct object_id *oid,
+			      struct packed_git *pack,
+			      uint32_t pos,
+			      void *unused)
+{
+	struct object *o = parse_object(oid);
+	o->flags |= UNINTERESTING | SEEN;
+	return 0;
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -2858,6 +2883,11 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
+	if (revs->exclude_promisor_objects) {
+		for_each_packed_object(mark_uninteresting, NULL,
+				       FOR_EACH_OBJECT_PROMISOR_ONLY);
+	}
+
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
diff --git a/revision.h b/revision.h
index 5476120..5f9a49c 100644
--- a/revision.h
+++ b/revision.h
@@ -121,7 +121,10 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
-			line_level_traverse:1;
+			line_level_traverse:1,
+
+			/* for internal use only */
+			exclude_promisor_objects:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
diff --git a/sha1_file.c b/sha1_file.c
index 10c3a00..88e92aa 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -29,6 +29,8 @@
 #include "mergesort.h"
 #include "quote.h"
 #include "packfile.h"
+#include "fetch-object.h"
+#include "partial-clone-utils.h"
 
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
@@ -1144,6 +1146,8 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return (status < 0) ? status : 0;
 }
 
+int fetch_if_missing = 1;
+
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
@@ -1152,6 +1156,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
+	int already_retried = 0;
 
 	if (!oi)
 		oi = &blank_oi;
@@ -1176,28 +1181,36 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
-	if (!find_pack_entry(real, &e)) {
-		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
-			return 0;
+retry:
+	if (find_pack_entry(real, &e))
+		goto found_packed;
 
-		/* Not a loose object; someone else may have just packed it. */
-		if (flags & OBJECT_INFO_QUICK) {
-			return -1;
-		} else {
-			reprepare_packed_git();
-			if (!find_pack_entry(real, &e))
-				return -1;
-		}
+	/* Most likely it's a loose object. */
+	if (!sha1_loose_object_info(real, oi, flags))
+		return 0;
+
+	/* Not a loose object; someone else may have just packed it. */
+	reprepare_packed_git();
+	if (find_pack_entry(real, &e))
+		goto found_packed;
+
+	/* Check if it is a missing object */
+	if (fetch_if_missing && repository_format_partial_clone_remote &&
+	    !already_retried) {
+		fetch_object(repository_format_partial_clone_remote, real);
+		already_retried = 1;
+		goto retry;
 	}
 
+	return -1;
+
+found_packed:
 	if (oi == &blank_oi)
 		/*
 		 * We know that the caller doesn't actually need the
 		 * information below, so return early.
 		 */
 		return 0;
-
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 002e071..59de768 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -138,4 +138,156 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
 	git -C repo fsck "$A"
 '
 
+test_expect_success 'fetching of missing objects' '
+	rm -rf repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	HASH=$(git -C repo rev-parse foo) &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "origin" &&
+	git -C repo cat-file -p "$HASH" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH"
+'
+
+test_expect_success 'rev-list stops traversal at missing and promised commit' '
+		     rm -rf repo &&
+		     test_create_repo repo &&
+		     test_commit -C repo foo &&
+		     test_commit -C repo bar &&
+
+	FOO=$(git -C repo rev-parse foo) &&
+	promise_and_delete "$FOO" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
+	grep $(git -C repo rev-parse bar) out &&
+	! grep $FOO out
+'
+
+test_expect_success 'rev-list stops traversal at missing and promised tree' '
+		     rm -rf repo &&
+		     test_create_repo repo &&
+		     test_commit -C repo foo &&
+		     mkdir repo/a_dir &&
+		     echo something >repo/a_dir/something &&
+		     git -C repo add a_dir/something &&
+		     git -C repo commit -m bar &&
+
+	# foo^{tree} (tree referenced from commit)
+	TREE=$(git -C repo rev-parse foo^{tree}) &&
+
+	# a tree referenced by HEAD^{tree} (tree referenced from tree)
+	TREE2=$(git -C repo ls-tree HEAD^{tree} | grep " tree " | head -1 | cut -b13-52) &&
+
+	promise_and_delete "$TREE" &&
+	promise_and_delete "$TREE2" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	grep $(git -C repo rev-parse foo) out &&
+	! grep $TREE out &&
+	grep $(git -C repo rev-parse HEAD) out &&
+	! grep $TREE2 out
+'
+
+test_expect_success 'rev-list stops traversal at missing and promised blob' '
+		     rm -rf repo &&
+		     test_create_repo repo &&
+		     echo something >repo/something &&
+		     git -C repo add something &&
+		     git -C repo commit -m foo &&
+
+	BLOB=$(git -C repo hash-object -w something) &&
+	promise_and_delete "$BLOB" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	grep $(git -C repo rev-parse HEAD) out &&
+	! grep $BLOB out
+'
+
+test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob' '
+		     rm -rf repo &&
+		     test_create_repo repo &&
+		     test_commit -C repo foo &&
+		     test_commit -C repo bar &&
+		     test_commit -C repo baz &&
+
+	COMMIT=$(git -C repo rev-parse foo) &&
+	TREE=$(git -C repo rev-parse bar^{tree}) &&
+	BLOB=$(git hash-object repo/baz.t) &&
+	printf "%s\n%s\n%s\n" $COMMIT $TREE $BLOB | pack_as_from_promisor &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	! grep $COMMIT out &&
+	! grep $TREE out &&
+	! grep $BLOB out &&
+	grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
+'
+
+test_expect_success 'rev-list accepts missing and promised objects on command line' '
+		     rm -rf repo &&
+		     test_create_repo repo &&
+		     test_commit -C repo foo &&
+		     test_commit -C repo bar &&
+		     test_commit -C repo baz &&
+
+	COMMIT=$(git -C repo rev-parse foo) &&
+	TREE=$(git -C repo rev-parse bar^{tree}) &&
+	BLOB=$(git hash-object repo/baz.t) &&
+
+	promise_and_delete $COMMIT &&
+	promise_and_delete $TREE &&
+	promise_and_delete $BLOB &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
+'
+
+LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fetching of missing objects from an HTTP server' '
+	rm -rf repo &&
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	git -C "$SERVER" repack -a -d --write-bitmap-index &&
+
+	git clone $HTTPD_URL/smart/server repo &&
+	HASH=$(git -C repo rev-parse foo) &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremoteremote "origin" &&
+	git -C repo cat-file -p "$HASH" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH"
+'
+
+stop_httpd
+
 test_done
-- 
2.9.3

