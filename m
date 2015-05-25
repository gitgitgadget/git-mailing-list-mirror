From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 02/56] each_ref_fn: change to take an object_id parameter
Date: Mon, 25 May 2015 18:38:28 +0000
Message-ID: <1432579162-411464-3-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKy-0002Ab-BB
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbbEYSmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50587 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751250AbbEYSkG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:06 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CE88F28093;
	Mon, 25 May 2015 18:40:03 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269906>

From: Michael Haggerty <mhagger@alum.mit.edu>

Change typedef each_ref_fn to take a "const struct object_id *oid"
parameter instead of "const unsigned char *sha1".

To aid this transition, implement an adapter that can be used to wrap
old-style functions matching the old typedef, which is now called
"each_ref_sha1_fn"), and make such functions callable via the new
interface. This requires the old function and its cb_data to be
wrapped in a "struct each_ref_fn_sha1_adapter", and that object to be
used as the cb_data for an adapter function, each_ref_fn_adapter().

This is an enormous diff, but most of it consists of simple,
mechanical changes to the sites that call any of the "for_each_ref"
family of functions. Subsequent to this change, the call sites can be
rewritten one by one to use the new interface.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/api-ref-iteration.txt |  2 +-
 bisect.c                                      |  5 +++-
 builtin/branch.c                              |  4 ++-
 builtin/checkout.c                            |  4 ++-
 builtin/describe.c                            |  4 ++-
 builtin/fetch.c                               |  8 +++--
 builtin/for-each-ref.c                        |  4 ++-
 builtin/fsck.c                                |  9 ++++--
 builtin/name-rev.c                            |  4 ++-
 builtin/pack-objects.c                        | 12 ++++++--
 builtin/receive-pack.c                        |  5 +++-
 builtin/reflog.c                              |  9 ++++--
 builtin/remote.c                              | 13 +++++++--
 builtin/replace.c                             |  4 ++-
 builtin/rev-parse.c                           | 33 ++++++++++++---------
 builtin/show-branch.c                         | 15 ++++++++--
 builtin/show-ref.c                            | 11 +++++--
 builtin/tag.c                                 |  4 ++-
 fetch-pack.c                                  | 17 ++++++++---
 help.c                                        |  4 ++-
 http-backend.c                                |  9 ++++--
 log-tree.c                                    |  7 +++--
 notes.c                                       |  5 +++-
 reachable.c                                   |  6 ++--
 refs.c                                        | 42 +++++++++++++++++----------
 refs.h                                        | 13 ++++++++-
 remote.c                                      | 10 +++++--
 replace_object.c                              |  4 ++-
 revision.c                                    | 33 +++++++++++++++++----
 server-info.c                                 |  5 +++-
 sha1_name.c                                   |  5 +++-
 shallow.c                                     | 19 ++++++++----
 submodule.c                                   | 15 ++++++++--
 transport.c                                   |  5 +++-
 upload-pack.c                                 | 18 ++++++++----
 walker.c                                      |  5 +++-
 36 files changed, 275 insertions(+), 97 deletions(-)

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index 02adfd4..37379d8 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -6,7 +6,7 @@ Iteration of refs is done by using an iterate function which will call a
 callback function for every ref. The callback function has this
 signature:
 
-	int handle_one_ref(const char *refname, const unsigned char *sha1,
+	int handle_one_ref(const char *refname, const struct object_id *oid,
 			   int flags, void *cb_data);
 
 There are different kinds of iterate functions which all take a
diff --git a/bisect.c b/bisect.c
index 10f5e57..0848d91 100644
--- a/bisect.c
+++ b/bisect.c
@@ -417,7 +417,10 @@ static int register_ref(const char *refname, const unsigned char *sha1,
 
 static int read_bisect_refs(void)
 {
-	return for_each_ref_in("refs/bisect/", register_ref, NULL);
+	struct each_ref_fn_sha1_adapter wrapped_register_ref =
+		{register_ref, NULL};
+
+	return for_each_ref_in("refs/bisect/", each_ref_fn_adapter, &wrapped_register_ref);
 }
 
 static void read_bisect_paths(struct argv_array *array)
diff --git a/builtin/branch.c b/builtin/branch.c
index 9cbab18..b27adcb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -631,6 +631,8 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	int i;
 	struct append_ref_cb cb;
 	struct ref_list ref_list;
+	struct each_ref_fn_sha1_adapter wrapped_append_ref =
+		{append_ref, &cb};
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
@@ -642,7 +644,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	cb.ref_list = &ref_list;
 	cb.pattern = pattern;
 	cb.ret = 0;
-	for_each_rawref(append_ref, &cb);
+	for_each_rawref(each_ref_fn_adapter, &wrapped_append_ref);
 	if (merge_filter != NO_FILTER) {
 		struct commit *filter;
 		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2f92328..9416aa2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -784,6 +784,8 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	struct rev_info revs;
 	struct object *object = &old->object;
 	struct object_array refs;
+	struct each_ref_fn_sha1_adapter wrapped_add_pending_uninteresting_ref =
+		{add_pending_uninteresting_ref, &revs};
 
 	init_revisions(&revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
@@ -791,7 +793,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	object->flags &= ~UNINTERESTING;
 	add_pending_object(&revs, object, sha1_to_hex(object->sha1));
 
-	for_each_ref(add_pending_uninteresting_ref, &revs);
+	for_each_ref(each_ref_fn_adapter, &wrapped_add_pending_uninteresting_ref);
 	add_pending_sha1(&revs, "HEAD", new->object.sha1, UNINTERESTING);
 
 	refs = revs.pending;
diff --git a/builtin/describe.c b/builtin/describe.c
index e00a75b..7d0c855 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -413,6 +413,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
 		OPT_END(),
 	};
+	struct each_ref_fn_sha1_adapter wrapped_get_name =
+		{get_name, NULL};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
@@ -451,7 +453,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	}
 
 	hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, 0);
-	for_each_rawref(get_name, NULL);
+	for_each_rawref(each_ref_fn_adapter, &wrapped_get_name);
 	if (!names.size && !always)
 		die(_("No names found, cannot describe anything."));
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7910419..4878c3d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -208,8 +208,10 @@ static void find_non_local_tags(struct transport *transport,
 	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
+	struct each_ref_fn_sha1_adapter wrapped_add_existing =
+		{add_existing, &existing_refs};
 
-	for_each_ref(add_existing, &existing_refs);
+	for_each_ref(each_ref_fn_adapter, &wrapped_add_existing);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
@@ -884,8 +886,10 @@ static int do_fetch(struct transport *transport,
 	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
+	struct each_ref_fn_sha1_adapter wrapped_add_existing =
+		{add_existing, &existing_refs};
 
-	for_each_ref(add_existing, &existing_refs);
+	for_each_ref(each_ref_fn_adapter, &wrapped_add_existing);
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 83f9cf9..caccd93 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1072,6 +1072,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int maxcount = 0, quote_style = 0;
 	struct refinfo **refs;
 	struct grab_ref_cbdata cbdata;
+	struct each_ref_fn_sha1_adapter wrapped_grab_single_ref =
+		{grab_single_ref, &cbdata};
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -1111,7 +1113,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern = argv;
-	for_each_rawref(grab_single_ref, &cbdata);
+	for_each_rawref(each_ref_fn_adapter, &wrapped_grab_single_ref);
 	refs = cbdata.grab_array;
 	num_refs = cbdata.grab_cnt;
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4783896..48d0c2e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -504,11 +504,16 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 
 static void get_default_heads(void)
 {
+	struct each_ref_fn_sha1_adapter wrapped_fsck_handle_ref =
+		{fsck_handle_ref, NULL};
+	struct each_ref_fn_sha1_adapter wrapped_fsck_handle_reflog =
+		{fsck_handle_reflog, NULL};
+
 	if (head_points_at && !is_null_sha1(head_sha1))
 		fsck_handle_ref("HEAD", head_sha1, 0, NULL);
-	for_each_rawref(fsck_handle_ref, NULL);
+	for_each_rawref(each_ref_fn_adapter, &wrapped_fsck_handle_ref);
 	if (include_reflogs)
-		for_each_reflog(fsck_handle_reflog, NULL);
+		for_each_reflog(each_ref_fn_adapter, &wrapped_fsck_handle_reflog);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 9736d44..41bdf0a 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -305,6 +305,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	struct object_array revs = OBJECT_ARRAY_INIT;
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, NULL };
+	struct each_ref_fn_sha1_adapter wrapped_name_ref =
+		{name_ref, &data};
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -377,7 +379,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	if (cutoff)
 		cutoff = cutoff - CUTOFF_DATE_SLOP;
-	for_each_ref(name_ref, &data);
+	for_each_ref(each_ref_fn_adapter, &wrapped_name_ref);
 
 	if (transform_stdin) {
 		char buffer[2048];
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c067107..81f0e57 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -626,6 +626,8 @@ static struct object_entry **compute_write_order(void)
 
 	struct object_entry **wo = xmalloc(to_pack.nr_objects * sizeof(*wo));
 	struct object_entry *objects = to_pack.objects;
+	struct each_ref_fn_sha1_adapter wrapped_mark_tagged =
+		{mark_tagged, NULL};
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		objects[i].tagged = 0;
@@ -651,7 +653,7 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * Mark objects that are at the tip of tags.
 	 */
-	for_each_tag_ref(mark_tagged, NULL);
+	for_each_tag_ref(each_ref_fn_adapter, &wrapped_mark_tagged);
 
 	/*
 	 * Give the objects in the original recency order until
@@ -2784,8 +2786,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		argv_array_clear(&rp);
 	}
 	cleanup_preferred_base();
-	if (include_tag && nr_result)
-		for_each_ref(add_ref_tag, NULL);
+	if (include_tag && nr_result) {
+		struct each_ref_fn_sha1_adapter wrapped_add_ref_tag =
+			{add_ref_tag, NULL};
+
+		for_each_ref(each_ref_fn_adapter, &wrapped_add_ref_tag);
+	}
 	stop_progress(&progress_state);
 
 	if (non_empty && !nr_result)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d2ec52b..12ecacd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -228,10 +228,13 @@ static void collect_one_alternate_ref(const struct ref *ref, void *data)
 static void write_head_info(void)
 {
 	struct sha1_array sa = SHA1_ARRAY_INIT;
+	struct each_ref_fn_sha1_adapter wrapped_show_ref_cb =
+		{show_ref_cb, NULL};
+
 	for_each_alternate_ref(collect_one_alternate_ref, &sa);
 	sha1_array_for_each_unique(&sa, show_one_alternate_sha1, NULL);
 	sha1_array_clear(&sa);
-	for_each_ref(show_ref_cb, NULL);
+	for_each_ref(each_ref_fn_adapter, &wrapped_show_ref_cb);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 8182b64..1163dd6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -352,7 +352,10 @@ static void reflog_expiry_prepare(const char *refname,
 	if (cb->unreachable_expire_kind != UE_ALWAYS) {
 		if (cb->unreachable_expire_kind == UE_HEAD) {
 			struct commit_list *elem;
-			for_each_ref(push_tip_to_list, &cb->tips);
+			struct each_ref_fn_sha1_adapter wrapped_push_tip_to_list =
+				{push_tip_to_list, &cb->tips};
+
+			for_each_ref(each_ref_fn_adapter, &wrapped_push_tip_to_list);
 			for (elem = cb->tips; elem; elem = elem->next)
 				commit_list_insert(elem->item, &cb->mark_list);
 		} else {
@@ -588,9 +591,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	if (do_all) {
 		struct collect_reflog_cb collected;
 		int i;
+		struct each_ref_fn_sha1_adapter wrapped_collect_reflog =
+			{collect_reflog, &collected};
 
 		memset(&collected, 0, sizeof(collected));
-		for_each_reflog(collect_reflog, &collected);
+		for_each_reflog(each_ref_fn_adapter, &wrapped_collect_reflog);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
diff --git a/builtin/remote.c b/builtin/remote.c
index ad57fc9..27a611b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -623,6 +623,8 @@ static int mv(int argc, const char **argv)
 	struct string_list remote_branches = STRING_LIST_INIT_NODUP;
 	struct rename_info rename;
 	int i, refspec_updated = 0;
+	struct each_ref_fn_sha1_adapter wrapped_read_remote_branches =
+		{read_remote_branches, &rename};
 
 	if (argc != 3)
 		usage_with_options(builtin_remote_rename_usage, options);
@@ -700,7 +702,7 @@ static int mv(int argc, const char **argv)
 	 * First remove symrefs, then rename the rest, finally create
 	 * the new symrefs.
 	 */
-	for_each_ref(read_remote_branches, &rename);
+	for_each_ref(each_ref_fn_adapter, &wrapped_read_remote_branches);
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 		int flag = 0;
@@ -781,6 +783,8 @@ static int rm(int argc, const char **argv)
 	struct string_list skipped = STRING_LIST_INIT_DUP;
 	struct branches_for_remote cb_data;
 	int i, result;
+	struct each_ref_fn_sha1_adapter wrapped_add_branch_for_removal =
+		{add_branch_for_removal, &cb_data};
 
 	memset(&cb_data, 0, sizeof(cb_data));
 	cb_data.branches = &branches;
@@ -821,7 +825,7 @@ static int rm(int argc, const char **argv)
 	 * refs, which are invalidated when deleting a branch.
 	 */
 	cb_data.remote = remote;
-	result = for_each_ref(add_branch_for_removal, &cb_data);
+	result = for_each_ref(each_ref_fn_adapter, &wrapped_add_branch_for_removal);
 	strbuf_release(&buf);
 
 	if (!result)
@@ -910,7 +914,10 @@ static int get_remote_ref_states(const char *name,
 		if (query & GET_PUSH_REF_STATES)
 			get_push_ref_states(remote_refs, states);
 	} else {
-		for_each_ref(append_ref_to_tracked_list, states);
+		struct each_ref_fn_sha1_adapter wrapped_append_ref_to_tracked_list =
+			{append_ref_to_tracked_list, states};
+
+		for_each_ref(each_ref_fn_adapter, &wrapped_append_ref_to_tracked_list);
 		string_list_sort(&states->tracked);
 		get_push_ref_states_noquery(states);
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 54bf01a..bcf1508 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -66,6 +66,8 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 static int list_replace_refs(const char *pattern, const char *format)
 {
 	struct show_data data;
+	struct each_ref_fn_sha1_adapter wrapped_show_reference =
+		{show_reference, (void *) &data};
 
 	if (pattern == NULL)
 		pattern = "*";
@@ -82,7 +84,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 		    "valid formats are 'short', 'medium' and 'long'\n",
 		    format);
 
-	for_each_replace_ref(show_reference, (void *) &data);
+	for_each_replace_ref(each_ref_fn_adapter, &wrapped_show_reference);
 
 	return 0;
 }
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4d10dd9..e75ce75 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -511,6 +511,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	unsigned int flags = 0;
 	const char *name = NULL;
 	struct object_context unused;
+	struct each_ref_fn_sha1_adapter wrapped_show_reference =
+		{show_reference, NULL};
+	struct each_ref_fn_sha1_adapter wrapped_anti_reference =
+		{anti_reference, NULL};
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -652,7 +656,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				for_each_ref(show_reference, NULL);
+				for_each_ref(each_ref_fn_adapter, &wrapped_show_reference);
 				continue;
 			}
 			if (starts_with(arg, "--disambiguate=")) {
@@ -660,45 +664,48 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
-				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
+				for_each_ref_in("refs/bisect/bad",
+						each_ref_fn_adapter, &wrapped_show_reference);
+				for_each_ref_in("refs/bisect/good",
+						each_ref_fn_adapter, &wrapped_anti_reference);
 				continue;
 			}
 			if (starts_with(arg, "--branches=")) {
-				for_each_glob_ref_in(show_reference, arg + 11,
-					"refs/heads/", NULL);
+				for_each_glob_ref_in(each_ref_fn_adapter, arg + 11,
+					"refs/heads/", &wrapped_show_reference);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
-				for_each_branch_ref(show_reference, NULL);
+				for_each_branch_ref(each_ref_fn_adapter, &wrapped_show_reference);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--tags=")) {
-				for_each_glob_ref_in(show_reference, arg + 7,
-					"refs/tags/", NULL);
+				for_each_glob_ref_in(each_ref_fn_adapter, arg + 7,
+					"refs/tags/", &wrapped_show_reference);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
-				for_each_tag_ref(show_reference, NULL);
+				for_each_tag_ref(each_ref_fn_adapter, &wrapped_show_reference);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--glob=")) {
-				for_each_glob_ref(show_reference, arg + 7, NULL);
+				for_each_glob_ref(each_ref_fn_adapter, arg + 7,
+						  &wrapped_show_reference);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--remotes=")) {
-				for_each_glob_ref_in(show_reference, arg + 10,
-					"refs/remotes/", NULL);
+				for_each_glob_ref_in(each_ref_fn_adapter, arg + 10,
+					"refs/remotes/", &wrapped_show_reference);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
-				for_each_remote_ref(show_reference, NULL);
+				for_each_remote_ref(each_ref_fn_adapter, &wrapped_show_reference);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e69fb7c..cf918f4 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -466,12 +466,18 @@ static void snarf_refs(int head, int remotes)
 {
 	if (head) {
 		int orig_cnt = ref_name_cnt;
-		for_each_ref(append_head_ref, NULL);
+		struct each_ref_fn_sha1_adapter wrapped_append_head_ref =
+			{append_head_ref, NULL};
+
+		for_each_ref(each_ref_fn_adapter, &wrapped_append_head_ref);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 	if (remotes) {
 		int orig_cnt = ref_name_cnt;
-		for_each_ref(append_remote_ref, NULL);
+		struct each_ref_fn_sha1_adapter wrapped_append_remote_ref =
+			{append_remote_ref, NULL};
+
+		for_each_ref(each_ref_fn_adapter, &wrapped_append_remote_ref);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 }
@@ -538,9 +544,12 @@ static void append_one_rev(const char *av)
 	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
 		/* glob style match */
 		int saved_matches = ref_name_cnt;
+		struct each_ref_fn_sha1_adapter wrapped_append_matching_ref =
+			{append_matching_ref, NULL};
+
 		match_ref_pattern = av;
 		match_ref_slash = count_slash(av);
-		for_each_ref(append_matching_ref, NULL);
+		for_each_ref(each_ref_fn_adapter, &wrapped_append_matching_ref);
 		if (saved_matches == ref_name_cnt &&
 		    ref_name_cnt < MAX_REVS)
 			error("no matching refs with %s", av);
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index afb1030..8e25536 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -109,8 +109,10 @@ static int exclude_existing(const char *match)
 	static struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	char buf[1024];
 	int matchlen = match ? strlen(match) : 0;
+	struct each_ref_fn_sha1_adapter wrapped_add_existing =
+		{add_existing, &existing_refs};
 
-	for_each_ref(add_existing, &existing_refs);
+	for_each_ref(each_ref_fn_adapter, &wrapped_add_existing);
 	while (fgets(buf, sizeof(buf), stdin)) {
 		char *ref;
 		int len = strlen(buf);
@@ -191,6 +193,9 @@ static const struct option show_ref_options[] = {
 
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
+	struct each_ref_fn_sha1_adapter wrapped_show_ref =
+		{show_ref, NULL};
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(show_ref_usage, show_ref_options);
 
@@ -225,8 +230,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_head)
-		head_ref(show_ref, NULL);
-	for_each_ref(show_ref, NULL);
+		head_ref(each_ref_fn_adapter, &wrapped_show_ref);
+	for_each_ref(each_ref_fn_adapter, &wrapped_show_ref);
 	if (!found_match) {
 		if (verify && !quiet)
 			die("No match");
diff --git a/builtin/tag.c b/builtin/tag.c
index 6f07ac6..7d8cd8c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -260,6 +260,8 @@ static int list_tags(const char **patterns, int lines,
 		     struct commit_list *with_commit, int sort)
 {
 	struct tag_filter filter;
+	struct each_ref_fn_sha1_adapter wrapped_show_reference =
+		{show_reference, (void *)&filter};
 
 	filter.patterns = patterns;
 	filter.lines = lines;
@@ -268,7 +270,7 @@ static int list_tags(const char **patterns, int lines,
 	memset(&filter.tags, 0, sizeof(filter.tags));
 	filter.tags.strdup_strings = 1;
 
-	for_each_tag_ref(show_reference, (void *) &filter);
+	for_each_tag_ref(each_ref_fn_adapter, &wrapped_show_reference);
 	if (sort) {
 		int i;
 		if ((sort & SORT_MASK) == VERCMP_SORT)
diff --git a/fetch-pack.c b/fetch-pack.c
index 48526aa..5380b1b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -256,14 +256,20 @@ static int find_common(struct fetch_pack_args *args,
 	int got_ready = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
+	struct each_ref_fn_sha1_adapter wrapped_rev_list_insert_ref =
+		{rev_list_insert_ref, NULL};
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die("--stateless-rpc requires multi_ack_detailed");
-	if (marked)
-		for_each_ref(clear_marks, NULL);
+	if (marked) {
+		struct each_ref_fn_sha1_adapter wrapped_clear_marks =
+			{clear_marks, NULL};
+
+		for_each_ref(each_ref_fn_adapter, &wrapped_clear_marks);
+	}
 	marked = 1;
 
-	for_each_ref(rev_list_insert_ref, NULL);
+	for_each_ref(each_ref_fn_adapter, &wrapped_rev_list_insert_ref);
 	for_each_alternate_ref(insert_one_alternate_ref, NULL);
 
 	fetching = 0;
@@ -599,7 +605,10 @@ static int everything_local(struct fetch_pack_args *args,
 	}
 
 	if (!args->depth) {
-		for_each_ref(mark_complete, NULL);
+		struct each_ref_fn_sha1_adapter wrapped_mark_complete =
+			{mark_complete, NULL};
+
+		for_each_ref(each_ref_fn_adapter, &wrapped_mark_complete);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
 		commit_list_sort_by_date(&complete);
 		if (cutoff)
diff --git a/help.c b/help.c
index 2072a87..f813093 100644
--- a/help.c
+++ b/help.c
@@ -425,10 +425,12 @@ static struct string_list guess_refs(const char *ref)
 {
 	struct similar_ref_cb ref_cb;
 	struct string_list similar_refs = STRING_LIST_INIT_NODUP;
+	struct each_ref_fn_sha1_adapter wrapped_append_similar_ref =
+		{append_similar_ref, &ref_cb};
 
 	ref_cb.base_ref = ref;
 	ref_cb.similar_refs = &similar_refs;
-	for_each_ref(append_similar_ref, &ref_cb);
+	for_each_ref(each_ref_fn_adapter, &wrapped_append_similar_ref);
 	return similar_refs;
 }
 
diff --git a/http-backend.c b/http-backend.c
index b6c0484..e4f3de3 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -395,8 +395,11 @@ static void get_info_refs(char *arg)
 		run_service(argv);
 
 	} else {
+		struct each_ref_fn_sha1_adapter wrapped_show_text_ref =
+			{show_text_ref, &buf};
+
 		select_getanyfile();
-		for_each_namespaced_ref(show_text_ref, &buf);
+		for_each_namespaced_ref(each_ref_fn_adapter, &wrapped_show_text_ref);
 		send_strbuf("text/plain", &buf);
 	}
 	strbuf_release(&buf);
@@ -425,9 +428,11 @@ static int show_head_ref(const char *refname, const unsigned char *sha1,
 static void get_head(char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct each_ref_fn_sha1_adapter wrapped_show_head_ref =
+		{show_head_ref, &buf};
 
 	select_getanyfile();
-	head_ref_namespaced(show_head_ref, &buf);
+	head_ref_namespaced(each_ref_fn_adapter, &wrapped_show_head_ref);
 	send_strbuf("text/plain", &buf);
 	strbuf_release(&buf);
 }
diff --git a/log-tree.c b/log-tree.c
index 8dba7be..1a0e170 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -149,10 +149,13 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 void load_ref_decorations(int flags)
 {
 	if (!decoration_loaded) {
+		struct each_ref_fn_sha1_adapter wrapped_add_ref_decoration =
+			{add_ref_decoration, NULL};
+
 		decoration_loaded = 1;
 		decoration_flags = flags;
-		for_each_ref(add_ref_decoration, NULL);
-		head_ref(add_ref_decoration, NULL);
+		for_each_ref(each_ref_fn_adapter, &wrapped_add_ref_decoration);
+		head_ref(each_ref_fn_adapter, &wrapped_add_ref_decoration);
 		for_each_commit_graft(add_graft_decoration, NULL);
 	}
 }
diff --git a/notes.c b/notes.c
index 2be4d7f..baa1c41 100644
--- a/notes.c
+++ b/notes.c
@@ -932,9 +932,12 @@ static int string_list_add_one_ref(const char *refname, const unsigned char *sha
  */
 void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 {
+	struct each_ref_fn_sha1_adapter wrapped_string_list_add_one_ref =
+		{string_list_add_one_ref, list};
+
 	assert(list->strdup_strings);
 	if (has_glob_specials(glob)) {
-		for_each_glob_ref(string_list_add_one_ref, glob, list);
+		for_each_glob_ref(each_ref_fn_adapter, glob, &wrapped_string_list_add_one_ref);
 	} else {
 		unsigned char sha1[20];
 		if (get_sha1(glob, sha1))
diff --git a/reachable.c b/reachable.c
index 69fa685..acac86a 100644
--- a/reachable.c
+++ b/reachable.c
@@ -155,6 +155,8 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    struct progress *progress)
 {
 	struct connectivity_progress cp;
+	struct each_ref_fn_sha1_adapter wrapped_add_one_ref =
+		{add_one_ref, revs};
 
 	/*
 	 * Set up revision parsing, and mark us as being interested
@@ -168,10 +170,10 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	add_index_objects_to_pending(revs, 0);
 
 	/* Add all external refs */
-	for_each_ref(add_one_ref, revs);
+	for_each_ref(each_ref_fn_adapter, &wrapped_add_one_ref);
 
 	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref, revs);
+	head_ref(each_ref_fn_adapter, &wrapped_add_one_ref);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/refs.c b/refs.c
index 9ca4651..43dce01 100644
--- a/refs.c
+++ b/refs.c
@@ -722,7 +722,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	/* Store the old value, in case this is a recursive call: */
 	old_current_ref = current_ref;
 	current_ref = entry;
-	retval = data->fn(entry->name + data->trim, entry->u.value.oid.hash,
+	retval = data->fn(entry->name + data->trim, &entry->u.value.oid,
 			  entry->flag, data->cb_data);
 	current_ref = old_current_ref;
 	return retval;
@@ -1756,13 +1756,14 @@ int ref_exists(const char *refname)
 	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
 }
 
-static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
-		       void *data)
+static int filter_refs(const char *refname, const struct object_id *oid,
+		       int flags, void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
+
 	if (wildmatch(filter->pattern, refname, 0, NULL))
 		return 0;
-	return filter->fn(refname, sha1, flags, filter->cb_data);
+	return filter->fn(refname, oid, flags, filter->cb_data);
 }
 
 enum peel_status {
@@ -1897,7 +1898,7 @@ struct warn_if_dangling_data {
 	const char *msg_fmt;
 };
 
-static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
+static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
 				   int flags, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
@@ -2027,18 +2028,18 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	int flag;
 
 	if (submodule) {
-		if (resolve_gitlink_ref(submodule, "HEAD", sha1) == 0)
-			return fn("HEAD", sha1, 0, cb_data);
+		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
+			return fn("HEAD", &oid, 0, cb_data);
 
 		return 0;
 	}
 
-	if (!read_ref_full("HEAD", RESOLVE_REF_READING, sha1, &flag))
-		return fn("HEAD", sha1, flag, cb_data);
+	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
 }
@@ -2113,12 +2114,12 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, sha1, &flag))
-		ret = fn(buf.buf, sha1, flag, cb_data);
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
+		ret = fn(buf.buf, &oid, flag, cb_data);
 	strbuf_release(&buf);
 
 	return ret;
@@ -2175,6 +2176,14 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
+int each_ref_fn_adapter(const char *refname,
+			const struct object_id *oid, int flags, void *cb_data)
+{
+	struct each_ref_fn_sha1_adapter *cb = cb_data;
+
+	return cb->original_fn(refname, oid->hash, flags, cb->original_cb_data);
+}
+
 const char *prettify_refname(const char *name)
 {
 	return name + (
@@ -3616,11 +3625,12 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 				strbuf_addch(name, '/');
 				retval = do_for_each_reflog(name, fn, cb_data);
 			} else {
-				unsigned char sha1[20];
-				if (read_ref_full(name->buf, 0, sha1, NULL))
+				struct object_id oid;
+
+				if (read_ref_full(name->buf, 0, oid.hash, NULL))
 					retval = error("bad ref for %s", name->buf);
 				else
-					retval = fn(name->buf, sha1, 0, cb_data);
+					retval = fn(name->buf, &oid, 0, cb_data);
 			}
 			if (retval)
 				break;
diff --git a/refs.h b/refs.h
index 6d7d9b4..4042109 100644
--- a/refs.h
+++ b/refs.h
@@ -67,7 +67,18 @@ struct ref_transaction;
  * single callback invocation.
  */
 typedef int each_ref_fn(const char *refname,
-			const unsigned char *sha1, int flags, void *cb_data);
+			const struct object_id *oid, int flags, void *cb_data);
+
+typedef int each_ref_sha1_fn(const char *refname,
+			     const unsigned char *sha1, int flags, void *cb_data);
+
+struct each_ref_fn_sha1_adapter {
+	each_ref_sha1_fn *original_fn;
+	void *original_cb_data;
+};
+
+extern int each_ref_fn_adapter(const char *refname,
+			       const struct object_id *oid, int flags, void *cb_data);
 
 /*
  * The following functions invoke the specified callback function for
diff --git a/remote.c b/remote.c
index 68901b0..6d66ec1 100644
--- a/remote.c
+++ b/remote.c
@@ -2046,7 +2046,10 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 struct ref *get_local_heads(void)
 {
 	struct ref *local_refs = NULL, **local_tail = &local_refs;
-	for_each_ref(one_local_ref, &local_tail);
+	struct each_ref_fn_sha1_adapter wrapped_one_local_ref =
+		{one_local_ref, &local_tail};
+
+	for_each_ref(each_ref_fn_adapter, &wrapped_one_local_ref);
 	return local_refs;
 }
 
@@ -2141,6 +2144,9 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
+	struct each_ref_fn_sha1_adapter wrapped_get_stale_heads_cb =
+		{get_stale_heads_cb, &info};
+
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
 	info.refs = refs;
@@ -2148,7 +2154,7 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	for (ref = fetch_map; ref; ref = ref->next)
 		string_list_append(&ref_names, ref->name);
 	string_list_sort(&ref_names);
-	for_each_ref(get_stale_heads_cb, &info);
+	for_each_ref(each_ref_fn_adapter, &wrapped_get_stale_heads_cb);
 	string_list_clear(&ref_names, 0);
 	return stale_refs;
 }
diff --git a/replace_object.c b/replace_object.c
index 0ab2dc1..a8a2da9 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -80,11 +80,13 @@ static int register_replace_ref(const char *refname,
 static void prepare_replace_object(void)
 {
 	static int replace_object_prepared;
+	struct each_ref_fn_sha1_adapter wrapped_register_replace_ref =
+		{register_replace_ref, NULL};
 
 	if (replace_object_prepared)
 		return;
 
-	for_each_replace_ref(register_replace_ref, NULL);
+	for_each_replace_ref(each_ref_fn_adapter, &wrapped_register_replace_ref);
 	replace_object_prepared = 1;
 	if (!replace_object_nr)
 		check_replace_refs = 0;
diff --git a/revision.c b/revision.c
index 7ddbaa0..93b23a6 100644
--- a/revision.c
+++ b/revision.c
@@ -1261,8 +1261,11 @@ static void handle_refs(const char *submodule, struct rev_info *revs, unsigned f
 		int (*for_each)(const char *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
+	struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
+		{handle_one_ref, &cb};
+
 	init_all_refs_cb(&cb, revs, flags);
-	for_each(submodule, handle_one_ref, &cb);
+	for_each(submodule, each_ref_fn_adapter, &wrapped_handle_one_ref);
 }
 
 static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
@@ -1304,9 +1307,12 @@ static int handle_one_reflog(const char *path, const unsigned char *sha1, int fl
 void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 {
 	struct all_refs_cb cb;
+	struct each_ref_fn_sha1_adapter wrapped_handle_one_reflog =
+		{handle_one_reflog, &cb};
+
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	for_each_reflog(handle_one_reflog, &cb);
+	for_each_reflog(each_ref_fn_adapter, &wrapped_handle_one_reflog);
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
@@ -2120,8 +2126,11 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
+		struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
+			{handle_one_ref, &cb};
+
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref(handle_one_ref, optarg, &cb);
+		for_each_glob_ref(each_ref_fn_adapter, optarg, &wrapped_handle_one_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
@@ -2129,18 +2138,30 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		return argcount;
 	} else if (starts_with(arg, "--branches=")) {
 		struct all_refs_cb cb;
+		struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
+			{handle_one_ref, &cb};
+
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+		for_each_glob_ref_in(each_ref_fn_adapter, arg + 11, "refs/heads/",
+				     &wrapped_handle_one_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (starts_with(arg, "--tags=")) {
 		struct all_refs_cb cb;
+		struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
+			{handle_one_ref, &cb};
+
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+		for_each_glob_ref_in(each_ref_fn_adapter, arg + 7, "refs/tags/",
+				     &wrapped_handle_one_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (starts_with(arg, "--remotes=")) {
 		struct all_refs_cb cb;
+		struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
+			{handle_one_ref, &cb};
+
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+		for_each_glob_ref_in(each_ref_fn_adapter, arg + 10, "refs/remotes/",
+				     &wrapped_handle_one_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
diff --git a/server-info.c b/server-info.c
index 34b0253..317dda8 100644
--- a/server-info.c
+++ b/server-info.c
@@ -69,7 +69,10 @@ static int add_info_ref(const char *path, const unsigned char *sha1, int flag, v
 
 static int generate_info_refs(FILE *fp)
 {
-	return for_each_ref(add_info_ref, fp);
+	struct each_ref_fn_sha1_adapter wrapped_add_info_ref =
+		{add_info_ref, fp};
+
+	return for_each_ref(each_ref_fn_adapter, &wrapped_add_info_ref);
 }
 
 static int update_info_refs(int force)
diff --git a/sha1_name.c b/sha1_name.c
index 6d10f05..1aad0a322 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1371,7 +1371,10 @@ static int get_sha1_with_context_1(const char *name,
 		int pos;
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
 			struct commit_list *list = NULL;
-			for_each_ref(handle_one_ref, &list);
+			struct each_ref_fn_sha1_adapter wrapped_handle_one_ref =
+				{handle_one_ref, &list};
+
+			for_each_ref(each_ref_fn_adapter, &wrapped_handle_one_ref);
 			commit_list_sort_by_date(&list);
 			return get_sha1_oneline(name + 2, sha1, list);
 		}
diff --git a/shallow.c b/shallow.c
index d08d264..9488edc 100644
--- a/shallow.c
+++ b/shallow.c
@@ -512,6 +512,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	unsigned int i, nr;
 	int *shallow, nr_shallow = 0;
 	struct paint_info pi;
+	struct each_ref_fn_sha1_adapter wrapped_mark_uninteresting =
+		{mark_uninteresting, NULL};
 
 	trace_printf_key(&trace_shallow, "shallow: assign_shallow_commits_to_refs\n");
 	shallow = xmalloc(sizeof(*shallow) * (info->nr_ours + info->nr_theirs));
@@ -542,8 +544,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	 * connect to old refs. If not (e.g. force ref updates) it'll
 	 * have to go down to the current shallow commits.
 	 */
-	head_ref(mark_uninteresting, NULL);
-	for_each_ref(mark_uninteresting, NULL);
+	head_ref(each_ref_fn_adapter, &wrapped_mark_uninteresting);
+	for_each_ref(each_ref_fn_adapter, &wrapped_mark_uninteresting);
 
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i = 0; i < nr_shallow; i++) {
@@ -618,6 +620,8 @@ static void post_assign_shallow(struct shallow_info *info,
 	int dst, i, j;
 	int bitmap_nr = (info->ref->nr + 31) / 32;
 	struct commit_array ca;
+	struct each_ref_fn_sha1_adapter wrapped_add_ref =
+		{add_ref, &ca};
 
 	trace_printf_key(&trace_shallow, "shallow: post_assign_shallow\n");
 	if (ref_status)
@@ -641,8 +645,8 @@ static void post_assign_shallow(struct shallow_info *info,
 	info->nr_theirs = dst;
 
 	memset(&ca, 0, sizeof(ca));
-	head_ref(add_ref, &ca);
-	for_each_ref(add_ref, &ca);
+	head_ref(each_ref_fn_adapter, &wrapped_add_ref);
+	for_each_ref(each_ref_fn_adapter, &wrapped_add_ref);
 
 	/* Remove unreachable shallow commits from "ours" */
 	for (i = dst = 0; i < info->nr_ours; i++) {
@@ -674,9 +678,12 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 
 		if (!si->commits) {
 			struct commit_array ca;
+			struct each_ref_fn_sha1_adapter wrapped_add_ref =
+				{add_ref, &ca};
+
 			memset(&ca, 0, sizeof(ca));
-			head_ref(add_ref, &ca);
-			for_each_ref(add_ref, &ca);
+			head_ref(each_ref_fn_adapter, &wrapped_add_ref);
+			for_each_ref(each_ref_fn_adapter, &wrapped_add_ref);
 			si->commits = ca.commits;
 			si->nr_commits = ca.nr;
 		}
diff --git a/submodule.c b/submodule.c
index d491e6a..f0f34b6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -429,10 +429,13 @@ static int has_remote(const char *refname, const unsigned char *sha1, int flags,
 
 static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
 {
+	struct each_ref_fn_sha1_adapter wrapped_has_remote =
+		{has_remote, NULL};
+
 	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
 		return 0;
 
-	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
+	if (for_each_remote_ref_submodule(path, each_ref_fn_adapter, &wrapped_has_remote) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
 		struct strbuf buf = STRBUF_INIT;
@@ -519,10 +522,13 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
 
 static int push_submodule(const char *path)
 {
+	struct each_ref_fn_sha1_adapter wrapped_has_remote =
+		{has_remote, NULL};
+
 	if (add_submodule_odb(path))
 		return 1;
 
-	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
+	if (for_each_remote_ref_submodule(path, each_ref_fn_adapter, &wrapped_has_remote) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		const char *argv[] = {"push", NULL};
 
@@ -626,7 +632,10 @@ static int add_sha1_to_array(const char *ref, const unsigned char *sha1,
 void check_for_new_submodule_commits(unsigned char new_sha1[20])
 {
 	if (!initialized_fetch_ref_tips) {
-		for_each_ref(add_sha1_to_array, &ref_tips_before_fetch);
+		struct each_ref_fn_sha1_adapter wrapped_add_sha1_to_array =
+			{add_sha1_to_array, &ref_tips_before_fetch};
+
+		for_each_ref(each_ref_fn_adapter, &wrapped_add_sha1_to_array);
 		initialized_fetch_ref_tips = 1;
 	}
 
diff --git a/transport.c b/transport.c
index f080e93..58cb9ed 100644
--- a/transport.c
+++ b/transport.c
@@ -363,7 +363,10 @@ static int rsync_transport_push(struct transport *transport,
 	strbuf_addch(&temp_dir, '/');
 
 	if (flags & TRANSPORT_PUSH_ALL) {
-		if (for_each_ref(write_one_ref, &temp_dir))
+		struct each_ref_fn_sha1_adapter wrapped_write_one_ref =
+			{write_one_ref, &temp_dir};
+
+		if (for_each_ref(each_ref_fn_adapter, &wrapped_write_one_ref))
 			return -1;
 	} else if (write_refs_to_temp_dir(&temp_dir, refspec_nr, refspec))
 		return -1;
diff --git a/upload-pack.c b/upload-pack.c
index 745fda8..52fab23 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -761,18 +761,26 @@ static int find_symref(const char *refname, const unsigned char *sha1, int flag,
 static void upload_pack(void)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
+	struct each_ref_fn_sha1_adapter wrapped_find_symref =
+		{find_symref, &symref};
 
-	head_ref_namespaced(find_symref, &symref);
+	head_ref_namespaced(each_ref_fn_adapter, &wrapped_find_symref);
 
 	if (advertise_refs || !stateless_rpc) {
+		struct each_ref_fn_sha1_adapter wrapped_send_ref =
+			{send_ref, &symref};
+
 		reset_timeout();
-		head_ref_namespaced(send_ref, &symref);
-		for_each_namespaced_ref(send_ref, &symref);
+		head_ref_namespaced(each_ref_fn_adapter, &wrapped_send_ref);
+		for_each_namespaced_ref(each_ref_fn_adapter, &wrapped_send_ref);
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-		head_ref_namespaced(check_ref, NULL);
-		for_each_namespaced_ref(check_ref, NULL);
+		struct each_ref_fn_sha1_adapter wrapped_check_ref =
+			{check_ref, NULL};
+
+		head_ref_namespaced(each_ref_fn_adapter, &wrapped_check_ref);
+		for_each_namespaced_ref(each_ref_fn_adapter, &wrapped_check_ref);
 	}
 	string_list_clear(&symref, 1);
 	if (advertise_refs)
diff --git a/walker.c b/walker.c
index 58ffeca..bb2e0b9 100644
--- a/walker.c
+++ b/walker.c
@@ -269,7 +269,10 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	}
 
 	if (!walker->get_recover) {
-		for_each_ref(mark_complete, NULL);
+		struct each_ref_fn_sha1_adapter wrapped_mark_complete =
+			{mark_complete, NULL};
+
+		for_each_ref(each_ref_fn_adapter, &wrapped_mark_complete);
 		commit_list_sort_by_date(&complete);
 	}
 
-- 
2.4.0
