Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB87A20248
	for <e@80x24.org>; Tue, 12 Mar 2019 13:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCLNhE (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:37:04 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.57]:38799 "EHLO mta1.cl.cam.ac.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfCLNhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:37:04 -0400
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta1.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h3hJ1-0002N3-Qd; Tue, 12 Mar 2019 13:18:55 +0000
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h3hJ8-0006o8-Ho; Tue, 12 Mar 2019 13:19:02 +0000
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH 4/4] repack: optionally assume transitive kept packs
Date:   Tue, 12 Mar 2019 13:18:58 +0000
Message-Id: <20190312131858.26115-5-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
References: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user is careful to mark .pack files as kept only when they refer
to (other) kept packs, then we can rely on this when walking the object
graph in subsequent repack operations and reduce the time and memory
spent building the object graph.

Towards that end, then, teach git repack to enumerate the non-BLOBs
objects (the tree and commits and tags) we're skipping because they're
in kept packs and mark them as UNINTERESTING for pack-object's
operation.  Because this creates UNINTERESTING marks, we make repack's
--assume-pack-keep-transitive imply --sparse for pack-object.

In testing with a 203GB repository with 80M objects, this amounts to
several gigabytes of memory and over ten minutes saved.  This machine
has 32G of RAM and the repository is on a fast SSD to speed testing.

All told, this test repository takes about 33 minutes elapsed (28
minutes in user code) and 3 GB of RAM to repack 12M objects occupying
33GB scattered across 477 pack files not marked as kept (the remainder
of the objects are spread across three kept pack files).  The time and
RAM usage with --assume-pack-keep-transitive should be dominated by
factors proportional to the size and number of un-kept objects.

Without these optimizations, it takes about 45 minutes (34 minutes in
user code) and 7 GB of RAM to compute the same pack file.  The extra
time and total memory use are expected to be proportional to the kept
packs' size, not the working set of the repack.  The time discrepancy
can be expected to be more dramatic when the repository is on spinning
rust rather than SSD.

Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>
---
 Documentation/git-gc.txt     |  5 ++++
 Documentation/git-repack.txt | 21 ++++++++++++++
 builtin/gc.c                 |  5 ++++
 builtin/repack.c             | 56 ++++++++++++++++++++++++++++++++++--
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a7c1b0f60e..7115564f7d 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -96,6 +96,11 @@ be performed as well.
 	`.keep` files are consolidated into a single pack. When this
 	option is used, `gc.bigPackThreshold` is ignored.
 
+--assume-pack-keep-transitive::
+	Pass the `--assume-pack-keep-transitive` option to `git-repack`;
+	see linkgit:git-repack[1].
+
+
 CONFIGURATION
 -------------
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 836d81457a..014812c4bb 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -169,6 +169,27 @@ depth is 4095.
 	Pass the `--sparse` option to `git-pack-objects`; see
 	linkgit:git-pack-objects[1].
 
+--assume-pack-keep-transitive::
+	This flag accelerates the search for objects to pack by assuming
+	that commit objects found in kept packfiles make reference only
+	to that or other kept packfiles.  This is very useful if, for
+	example, this repository periodically repacks all reachable objects
+	and marks the resulting pack file as kept.
+
+	Because this option may prevent git from descending into kept packs,
+	no objects inside kept packs will be available for delta processing.
+	One should therefore restrict the use of this option to situations
+	where delta processing is disabled or when relatively large amounts
+	of data are considered and the relative gain of a wider set of
+	possible delta base objects is reduced.
+
+	The simplest way to ensure transitivity of kept packs is to run `git
+	repack` with `-a` (or `-A`) and `-d` and mark all resulting packs as
+	kept, never removing the kept marker.  In practice, one may wish to
+	wait to mark packs as kept until they are sufficiently large
+	(reducing the number of pack files necessary for a given set of
+	objects) but not so large as to be unwieldy.
+
 Configuration
 -------------
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 020f725acc..1346afb3b1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -49,6 +49,7 @@ static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
+static int assume_pack_keep_transitive;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
 static struct argv_array reflog = ARGV_ARRAY_INIT;
@@ -526,6 +527,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
 			 N_("repack all other packs except the largest pack")),
+		OPT_BOOL(0, "assume-pack-keep-transitive", &assume_pack_keep_transitive,
+			 N_("assume kept packs reference only kept packs")),
 		OPT_END()
 	};
 
@@ -564,6 +567,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	}
 	if (quiet)
 		argv_array_push(&repack, "-q");
+	if (assume_pack_keep_transitive)
+		argv_array_push(&repack, "--assume-pack-keep-transitive");
 
 	if (auto_gc) {
 		/*
diff --git a/builtin/repack.c b/builtin/repack.c
index 71e715b594..b2b407d42c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -11,6 +11,8 @@
 #include "midx.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "revision.h"
+#include "list-objects.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -261,6 +263,30 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		die(_("could not finish pack-objects to repack promisor objects"));
 }
 
+static void apkt_show_commit(struct commit *commit, void *data)
+{
+	struct tree *tree;
+	struct pack_entry e;
+
+	if (!find_pack_entry(the_repository, &commit->object.oid, &e))
+		return;
+
+	if (!(e.p->pack_keep || e.p->pack_keep_in_core))
+		return;
+
+	tree = get_commit_tree(commit);
+	if (tree)
+		tree->object.flags |= UNINTERESTING;
+
+	write_oid(&commit->object.oid, e.p, 0, data);
+	write_oid(&tree->object.oid, NULL, 0, data);
+}
+
+static void apkt_show_object(struct object *obj, const char *name, void *data)
+{
+	return;
+}
+
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
 
@@ -292,6 +318,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
 	int midx_cleared = 0;
+	int assume_pack_keep_transitive = 0;
 	struct pack_objects_args po_args = {NULL};
 
 	struct option builtin_repack_options[] = {
@@ -333,6 +360,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("repack objects in packs marked with .keep")),
 		OPT_BOOL(0, "sparse", &sparse,
 			 N_("use the sparse reachability algorithm")),
+		OPT_BOOL(0, "assume-pack-keep-transitive", &assume_pack_keep_transitive,
+				N_("assume kept packs reference only kept packs")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
 		OPT_END()
@@ -351,6 +380,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
+	if (assume_pack_keep_transitive) {
+		/* imply --honor-pack-keep */
+		pack_kept_objects = 0;
+	}
+
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
@@ -374,7 +408,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
-	if (sparse)
+	if (sparse || assume_pack_keep_transitive)
 		argv_array_push(&cmd.args, "--sparse");
 	if (repository_format_partial_clone)
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
@@ -409,12 +443,30 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_push(&cmd.args, "--incremental");
 	}
 
-	cmd.no_stdin = 1;
+	cmd.in = -1;
+	cmd.no_stdin = !assume_pack_keep_transitive;
 
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
 
+	if (assume_pack_keep_transitive) {
+		struct rev_info revs;
+		const char *revargv[] = { "skip", "--all", "--reflog", "--indexed-objects", NULL };
+
+		repo_init_revisions(the_repository, &revs, NULL);
+		setup_revisions(sizeof(revargv)/sizeof(revargv[0]) - 1 , revargv, &revs, NULL);
+		if (prepare_revision_walk(&revs, sparse))
+			die("revision walk setup failed");
+
+		xwrite(cmd.in, "--not\n", 6);
+		traverse_commit_list(&revs, apkt_show_commit, apkt_show_object,
+				     &cmd);
+		xwrite(cmd.in, "--not\n", 6);
+
+		close(cmd.in);
+	}
+
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		if (line.len != the_hash_algo->hexsz)
-- 
2.17.1

