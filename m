Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D46320281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964876AbdKBUVX (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:21:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:36115 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964858AbdKBUVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:21:18 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DEAB2845A7;
        Thu,  2 Nov 2017 16:21:17 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0BE9C845A5;
        Thu,  2 Nov 2017 16:21:16 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 9/9] gc: do not repack promisor packfiles
Date:   Thu,  2 Nov 2017 20:20:52 +0000
Message-Id: <20171102202052.58762-10-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102202052.58762-1-git@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach gc to stop traversal at promisor objects, and to leave promisor
packfiles alone. This has the effect of only repacking non-promisor
packfiles, and preserves the distinction between promisor packfiles and
non-promisor packfiles.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-pack-objects.txt |  4 +++
 builtin/gc.c                       |  4 +++
 builtin/pack-objects.c             | 14 ++++++++++
 builtin/prune.c                    |  7 +++++
 builtin/repack.c                   | 12 +++++++--
 t/t0410-partial-clone.sh           | 54 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 6786351..ee462c6 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -246,6 +246,10 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	Ignore missing objects without error.  This may be used with
 	or without and of the above filtering.
 
+--exclude-promisor-objects::
+	Silently omit referenced but missing objects from the packfile.
+	This is used with partial clone.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/gc.c b/builtin/gc.c
index 3c5eae0..a17806a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,7 @@
 #include "argv-array.h"
 #include "commit.h"
 #include "packfile.h"
+#include "partial-clone-utils.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -458,6 +459,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			argv_array_push(&prune, prune_expire);
 			if (quiet)
 				argv_array_push(&prune, "--no-progress");
+			if (is_partial_clone_registered())
+				argv_array_push(&prune,
+						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
 				return error(FAILED_RUN, prune.argv[0]);
 		}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e16722f..957e459 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -83,6 +83,7 @@ static unsigned long window_memory_limit = 0;
 
 static struct list_objects_filter_options filter_options;
 static int arg_ignore_missing;
+static int arg_exclude_promisor_objects;
 
 /*
  * stats
@@ -2561,6 +2562,11 @@ static void show_object(struct object *obj, const char *name, void *data)
 	if (arg_ignore_missing && !has_object_file(&obj->oid))
 		return;
 
+	if (arg_exclude_promisor_objects &&
+	    !has_object_file(&obj->oid) &&
+	    is_promisor_object(&obj->oid))
+		return;
+
 	add_preferred_base_object(name);
 	add_object_entry(obj->oid.hash, obj->type, name, 0);
 	obj->flags |= OBJECT_ADDED;
@@ -2972,6 +2978,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_BOOL(0, "filter-ignore-missing", &arg_ignore_missing,
 			 N_("ignore and omit missing objects from packfile")),
+		OPT_BOOL(0, "exclude-promisor-objects", &arg_exclude_promisor_objects,
+			 N_("do not pack objects in promisor packfiles")),
 		OPT_END(),
 	};
 
@@ -3017,6 +3025,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		argv_array_push(&rp, "--unpacked");
 	}
 
+	if (arg_exclude_promisor_objects) {
+		use_internal_rev_list = 1;
+		fetch_if_missing = 0;
+		argv_array_push(&rp, "--exclude-promisor-objects");
+	}
+
 	if (!reuse_object)
 		reuse_delta = 0;
 	if (pack_compression_level == -1)
diff --git a/builtin/prune.c b/builtin/prune.c
index cddabf2..be34645 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -101,12 +101,15 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct progress *progress = NULL;
+	int exclude_promisor_objects = 0;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned objects")),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("expire objects older than <time>")),
+		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
+			 N_("limit traversal to objects outside promisor packfiles")),
 		OPT_END()
 	};
 	char *s;
@@ -139,6 +142,10 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		show_progress = isatty(2);
 	if (show_progress)
 		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	if (exclude_promisor_objects) {
+		fetch_if_missing = 0;
+		revs.exclude_promisor_objects = 1;
+	}
 
 	mark_reachable_objects(&revs, 1, expire, progress);
 	stop_progress(&progress);
diff --git a/builtin/repack.c b/builtin/repack.c
index f17a68a..a5a7977 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -83,7 +83,8 @@ static void remove_pack_on_signal(int signo)
 
 /*
  * Adds all packs hex strings to the fname list, which do not
- * have a corresponding .keep file.
+ * have a corresponding .keep or .promisor file. These packs are not to
+ * be kept if we are going to pack everything into one file.
  */
 static void get_non_kept_pack_filenames(struct string_list *fname_list)
 {
@@ -101,7 +102,8 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 
 		fname = xmemdupz(e->d_name, len);
 
-		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
+		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)) &&
+		    !file_exists(mkpath("%s/%s.promisor", packdir, fname)))
 			string_list_append_nodup(fname_list, fname);
 		else
 			free(fname);
@@ -232,6 +234,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
+
+	/*
+	 * TODO Should this be if (is_partial_clone_registered()) ...
+	 */
+	argv_array_push(&cmd.args, "--exclude-promisor-objects");
+
 	if (window)
 		argv_array_pushf(&cmd.args, "--window=%s", window);
 	if (window_memory)
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 59de768..7ddcb4c 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -11,13 +11,15 @@ delete_object () {
 pack_as_from_promisor () {
 	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
 	>repo/.git/objects/pack/pack-$HASH.promisor
+	echo $HASH
 }
 
 promise_and_delete () {
 	HASH=$(git -C repo rev-parse "$1") &&
 	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
 	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
-	git -C repo tag -d my_annotated_tag &&
+	# tag -d prints a message to stdout, so redirect it
+	git -C repo tag -d my_annotated_tag >/dev/null &&
 	delete_object repo "$HASH"
 }
 
@@ -261,6 +263,54 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
 '
 
+test_expect_success 'gc does not repack promisor objects' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
+	HASH=$(printf "$TREE_HASH\n" | pack_as_from_promisor) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo gc &&
+
+	# Ensure that the promisor packfile still exists, and remove it
+	test -e repo/.git/objects/pack/pack-$HASH.pack &&
+	rm repo/.git/objects/pack/pack-$HASH.* &&
+
+	# Ensure that the single other pack contains the commit, but not the tree
+	ls repo/.git/objects/pack/pack-*.pack >packlist &&
+	test_line_count = 1 packlist &&
+	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
+	grep "$(git -C repo rev-parse HEAD)" out &&
+	! grep "$TREE_HASH" out
+'
+
+test_expect_success 'gc stops traversal when a missing but promised object is reached' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
+	HASH=$(promise_and_delete $TREE_HASH) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo gc &&
+
+	# Ensure that the promisor packfile still exists, and remove it
+	test -e repo/.git/objects/pack/pack-$HASH.pack &&
+	rm repo/.git/objects/pack/pack-$HASH.* &&
+
+	# Ensure that the single other pack contains the commit, but not the tree
+	ls repo/.git/objects/pack/pack-*.pack >packlist &&
+	test_line_count = 1 packlist &&
+	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
+	grep "$(git -C repo rev-parse HEAD)" out &&
+	! grep "$TREE_HASH" out
+'
+
 LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
@@ -277,7 +327,7 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	rm -rf repo/.git/objects/* &&
 
 	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialcloneremoteremote "origin" &&
+	git -C repo config extensions.partialcloneremote "origin" &&
 	git -C repo cat-file -p "$HASH" &&
 
 	# Ensure that the .promisor file is written, and check that its
-- 
2.9.3

