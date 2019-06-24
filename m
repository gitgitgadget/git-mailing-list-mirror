Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415A21F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfFXMRN (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:17:13 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.25.22]:55784 "EHLO
        mta2.cl.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFXMRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:17:13 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 08:17:13 EDT
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta2.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-000VdE-Rx; Mon, 24 Jun 2019 13:07:45 +0100
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-0007EZ-Pn; Mon, 24 Jun 2019 13:07:45 +0100
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH v3 4/5] repack: optionally assume transitive kept packs
Date:   Mon, 24 Jun 2019 13:07:10 +0100
Message-Id: <20190624120711.27744-5-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user is careful to mark .pack files as kept only when they refer
to (other) kept packs, then we can rely on this when walking the object
graph in subsequent repack operations and reduce the time and memory
spent building the object graph.

Towards that end, then, teach git repack to enumerate the COMMITs and
TREEs in kept packs and mark them as UNINTERESTING for pack-object's
operation.  Because this creates UNINTERESTING marks, we make repack's
--assume-pack-keep-transitive imply --sparse for pack-object to avoid
hauling the entire object graph into memory.

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
 Documentation/git-repack.txt | 21 +++++++++++++
 builtin/repack.c             | 57 ++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 2 deletions(-)

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
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 4cfdd62bb8..a2cd479686 100644
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
@@ -256,6 +258,30 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
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
 
@@ -287,6 +313,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
 	int midx_cleared = 0;
+	int assume_pack_keep_transitive = 0;
 	struct pack_objects_args po_args = {NULL};
 	int sparse = 0;
 
@@ -329,6 +356,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("repack objects in packs marked with .keep")),
 		OPT_BOOL(0, "sparse", &sparse,
 			 N_("use the sparse reachability algorithm")),
+		OPT_BOOL(0, "assume-pack-keep-transitive", &assume_pack_keep_transitive,
+				N_("assume kept packs reference only kept packs")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
 		OPT_END()
@@ -346,6 +375,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
+	if (assume_pack_keep_transitive) {
+		/* imply --honor-pack-keep */
+		pack_kept_objects = 0;
+	}
+
 	if (write_bitmaps < 0)
 		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
 				 is_bare_repository();
@@ -372,7 +406,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
-	if (sparse)
+	if (sparse || assume_pack_keep_transitive)
 		argv_array_push(&cmd.args, "--sparse");
 	if (repository_format_partial_clone)
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
@@ -407,12 +441,31 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
+		revs.sparse_tree_walk = !!(sparse || assume_pack_keep_transitive);
+		setup_revisions(sizeof(revargv)/sizeof(revargv[0]) - 1 , revargv, &revs, NULL);
+		if (prepare_revision_walk(&revs))
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

