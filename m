Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7AB02023D
	for <e@80x24.org>; Sat,  4 Mar 2017 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbdCDTgA (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 14:36:00 -0500
Received: from dalaran.tastycake.net ([212.13.201.165]:47393 "EHLO
        dalaran.tastycake.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbdCDTf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 14:35:59 -0500
Received: from [176.27.107.90] (helo=localhost.localdomain)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <markbt@efaref.net>)
        id 1ckFCw-0001xc-0d; Sat, 04 Mar 2017 19:19:10 +0000
From:   Mark Thomas <markbt@efaref.net>
To:     git@vger.kernel.org
Cc:     Mark Thomas <markbt@efaref.net>
Subject: [RFC 3/4] upload-pack: Send all commits if client requests on-demand
Date:   Sat,  4 Mar 2017 19:19:00 +0000
Message-Id: <20170304191901.9622-4-markbt@efaref.net>
X-Mailer: git-send-email 2.12.0.193.g9dc7f06
In-Reply-To: <20170304191901.9622-1-markbt@efaref.net>
References: <20170304191901.9622-1-markbt@efaref.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Mark Thomas <markbt@efaref.net>
---
 builtin/pack-objects.c | 26 ++++++++++++++++++++++++--
 list-objects.c         | 12 +++++++-----
 list-objects.h         | 13 ++++++++++++-
 object.h               |  1 +
 on_demand.c            | 26 ++++++++++++++++++++++++++
 on_demand.h            |  4 ++++
 upload-pack.c          |  8 +++++++-
 7 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f294dcf..c8b2503 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -24,6 +24,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "mru.h"
+#include "on_demand.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -77,6 +78,8 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static int send_all_commits;
+
 /*
  * stats
  */
@@ -2750,12 +2753,15 @@ static void record_recent_commit(struct commit *commit, void *data)
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
+	struct rev_info revs2;
 	char line[1000];
 	int flags = 0;
 
 	init_revisions(&revs, NULL);
+	init_revisions(&revs2, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
+	setup_revisions(ac, av, &revs2, NULL);
 
 	/* make sure shallows are read */
 	is_repository_shallow();
@@ -2776,7 +2782,10 @@ static void get_object_list(int ac, const char **av)
 				unsigned char sha1[20];
 				if (get_sha1_hex(line + 10, sha1))
 					die("not an SHA-1 '%s'", line + 10);
-				register_shallow(sha1);
+				if (send_all_commits)
+					register_on_demand_cutoff(sha1);
+				else
+					register_shallow(sha1);
 				use_bitmap_index = 0;
 				continue;
 			}
@@ -2784,6 +2793,8 @@ static void get_object_list(int ac, const char **av)
 		}
 		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", line);
+		if (handle_revision_arg(line, &revs2, flags, REVARG_CANNOT_BE_FILENAME))
+			die("bad revision '%s'", line);
 	}
 
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
@@ -2792,7 +2803,16 @@ static void get_object_list(int ac, const char **av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+
+	if (send_all_commits) {
+		revs2.include_check = on_demand_include_check;
+		traverse_commit_list(&revs2, on_demand_show_commit_tree, NULL,
+				     NULL);
+		reset_revision_walk();
+	}
+
+	traverse_commit_list_extended(&revs, show_commit, show_object,
+				      on_demand_show_tree_check, NULL);
 
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
@@ -2928,6 +2948,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+		OPT_BOOL(0, "send-all-commits", &send_all_commits,
+			 N_("send all commits for on-demand shallow fetches")),
 		OPT_END(),
 	};
 
diff --git a/list-objects.c b/list-objects.c
index f3ca6aa..2607549 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -183,10 +183,11 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-void traverse_commit_list(struct rev_info *revs,
-			  show_commit_fn show_commit,
-			  show_object_fn show_object,
-			  void *data)
+void traverse_commit_list_extended(struct rev_info *revs,
+				   show_commit_fn show_commit,
+				   show_object_fn show_object,
+				   show_tree_check_fn show_tree_check,
+				   void *data)
 {
 	int i;
 	struct commit *commit;
@@ -198,7 +199,8 @@ void traverse_commit_list(struct rev_info *revs,
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
-		if (commit->tree)
+		if (show_object && commit->tree &&
+		    (!show_tree_check || show_tree_check(commit, data)))
 			add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
 	}
diff --git a/list-objects.h b/list-objects.h
index 0cebf85..e80dc8c 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -3,7 +3,18 @@
 
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const char *, void *);
-void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
+typedef int (*show_tree_check_fn)(struct commit *, void *);
+void traverse_commit_list_extended(struct rev_info *, show_commit_fn,
+				   show_object_fn, show_tree_check_fn, void *);
+
+inline void traverse_commit_list(struct rev_info *revs,
+				 show_commit_fn show_commit,
+				 show_object_fn show_object,
+				 void *data)
+{
+	traverse_commit_list_extended(revs, show_commit, show_object, NULL,
+				      data);
+}
 
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
diff --git a/object.h b/object.h
index f52957d..25177fd 100644
--- a/object.h
+++ b/object.h
@@ -38,6 +38,7 @@ struct object_array {
  * http-push.c:                            16-----19
  * commit.c:                               16-----19
  * sha1_name.c:                                     20
+ * on_demand.c:                                       21-22
  */
 #define FLAG_BITS  27
 
diff --git a/on_demand.c b/on_demand.c
index a0aaf18..c72d7a5 100644
--- a/on_demand.c
+++ b/on_demand.c
@@ -155,3 +155,29 @@ int object_info_on_demand(const unsigned char *sha1, struct object_info *oi)
 	die("git on-demand: protocol error, "
 	    "unexpected response: '%s'", line);
 }
+
+#define ON_DEMAND_CUTOFF	(1u << 21)
+#define ON_DEMAND_SHOW_TREE	(1u << 22)
+
+void register_on_demand_cutoff(const unsigned char *sha1)
+{
+	struct commit *commit = lookup_commit(sha1);
+	if (commit)
+		commit->object.flags |= ON_DEMAND_CUTOFF;
+}
+
+int on_demand_include_check(struct commit *commit, void *data)
+{
+	return !(commit->object.flags & ON_DEMAND_CUTOFF);
+}
+
+void on_demand_show_commit_tree(struct commit *commit, void *data)
+{
+	commit->object.flags |= ON_DEMAND_SHOW_TREE;
+}
+
+int on_demand_show_tree_check(struct commit *commit, void *data)
+{
+	return !!(commit->object.flags &
+		  (ON_DEMAND_SHOW_TREE|ON_DEMAND_CUTOFF));
+}
diff --git a/on_demand.h b/on_demand.h
index 09a8072..7bbb523 100644
--- a/on_demand.h
+++ b/on_demand.h
@@ -4,5 +4,9 @@
 void *read_remote_on_demand(const unsigned char *sha1, enum object_type *type,
 			    unsigned long *size);
 int object_info_on_demand(const unsigned char *sha1, struct object_info *oi);
+void register_on_demand_cutoff(const unsigned char *sha1);
+int on_demand_include_check(struct commit *commit, void *data);
+void on_demand_show_commit_tree(struct commit *commit, void *data);
+int on_demand_show_tree_check(struct commit *commit, void *data);
 
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 7597ba3..1b552b4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -42,6 +42,7 @@ static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
+static int send_all_commits;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
@@ -130,6 +131,8 @@ static void create_pack_file(void)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
+	if (send_all_commits)
+		argv_array_push(&pack_objects.args, "--send-all-commits");
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
@@ -820,6 +823,8 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
+		if (parse_feature_request(features, "on-demand"))
+			send_all_commits = 1;
 
 		o = parse_object(sha1_buf);
 		if (!o)
@@ -924,7 +929,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
-		" deepen-relative no-progress include-tag multi_ack_detailed";
+		" deepen-relative no-progress include-tag multi_ack_detailed"
+		" on-demand";
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 
-- 
2.7.4

