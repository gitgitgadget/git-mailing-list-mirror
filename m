Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FF020C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbdLHP7N (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:59:13 -0500
Received: from siwi.pair.com ([209.68.5.199]:55821 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754461AbdLHP7J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:59:09 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8AD50844F1;
        Fri,  8 Dec 2017 10:59:08 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0E9B7844DE;
        Fri,  8 Dec 2017 10:59:07 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 03/16] gc: do not repack promisor packfiles
Date:   Fri,  8 Dec 2017 15:58:38 +0000
Message-Id: <20171208155851.855-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171208155851.855-1-git@jeffhostetler.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
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
 Documentation/git-pack-objects.txt | 11 ++++++++
 builtin/gc.c                       |  3 +++
 builtin/pack-objects.c             | 37 ++++++++++++++++++++++++--
 builtin/prune.c                    |  7 +++++
 builtin/repack.c                   |  8 ++++--
 t/t0410-partial-clone.sh           | 54 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index aa403d0..81bc490 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -255,6 +255,17 @@ a missing object is encountered.  This is the default action.
 The form '--missing=allow-any' will allow object traversal to continue
 if a missing object is encountered.  Missing objects will silently be
 omitted from the results.
++
+The form '--missing=allow-promisor' is like 'allow-any', but will only
+allow object traversal to continue for EXPECTED promisor missing objects.
+Unexpected missing object will raise an error.
+
+--exclude-promisor-objects::
+	Omit objects that are known to be in the promisor remote.  (This
+	option has the purpose of operating only on locally created objects,
+	so that when we repack, we still maintain a distinction between
+	locally created objects [without .promisor] and objects from the
+	promisor remote [with .promisor].)  This is used with partial clone.
 
 SEE ALSO
 --------
diff --git a/builtin/gc.c b/builtin/gc.c
index 3c5eae0..77fa720 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -458,6 +458,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			argv_array_push(&prune, prune_expire);
 			if (quiet)
 				argv_array_push(&prune, "--no-progress");
+			if (repository_format_partial_clone)
+				argv_array_push(&prune,
+						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
 				return error(FAILED_RUN, prune.argv[0]);
 		}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 45ad35d..f5fc401 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -75,6 +75,8 @@ static int use_bitmap_index = -1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
+static int exclude_promisor_objects;
+
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
 static unsigned long cache_max_small_delta_size = 1000;
@@ -84,8 +86,9 @@ static unsigned long window_memory_limit = 0;
 static struct list_objects_filter_options filter_options;
 
 enum missing_action {
-	MA_ERROR = 0,    /* fail if any missing objects are encountered */
-	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
+	MA_ERROR = 0,      /* fail if any missing objects are encountered */
+	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
+	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
 };
 static enum missing_action arg_missing_action;
 static show_object_fn fn_show_object;
@@ -2577,6 +2580,20 @@ static void show_object__ma_allow_any(struct object *obj, const char *name, void
 	show_object(obj, name, data);
 }
 
+static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *data)
+{
+	assert(arg_missing_action == MA_ALLOW_PROMISOR);
+
+	/*
+	 * Quietly ignore EXPECTED missing objects.  This avoids problems with
+	 * staging them now and getting an odd error later.
+	 */
+	if (!has_object_file(&obj->oid) && is_promisor_object(&obj->oid))
+		return;
+
+	show_object(obj, name, data);
+}
+
 static int option_parse_missing_action(const struct option *opt,
 				       const char *arg, int unset)
 {
@@ -2591,10 +2608,18 @@ static int option_parse_missing_action(const struct option *opt,
 
 	if (!strcmp(arg, "allow-any")) {
 		arg_missing_action = MA_ALLOW_ANY;
+		fetch_if_missing = 0;
 		fn_show_object = show_object__ma_allow_any;
 		return 0;
 	}
 
+	if (!strcmp(arg, "allow-promisor")) {
+		arg_missing_action = MA_ALLOW_PROMISOR;
+		fetch_if_missing = 0;
+		fn_show_object = show_object__ma_allow_promisor;
+		return 0;
+	}
+
 	die(_("invalid value for --missing"));
 	return 0;
 }
@@ -3008,6 +3033,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action },
+		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
+			 N_("do not pack objects in promisor packfiles")),
 		OPT_END(),
 	};
 
@@ -3053,6 +3080,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		argv_array_push(&rp, "--unpacked");
 	}
 
+	if (exclude_promisor_objects) {
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
index f17a68a..7bdb401 100644
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
@@ -232,6 +234,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
+	if (repository_format_partial_clone)
+		argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (window)
 		argv_array_pushf(&cmd.args, "--window=%s", window);
 	if (window_memory)
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 3ca6af5..cc18b75 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -10,14 +10,16 @@ delete_object () {
 
 pack_as_from_promisor () {
 	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
-	>repo/.git/objects/pack/pack-$HASH.promisor
+	>repo/.git/objects/pack/pack-$HASH.promisor &&
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
+	git -C repo config extensions.partialclone "arbitrary string" &&
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
+	git -C repo config extensions.partialclone "arbitrary string" &&
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
-- 
2.9.3

