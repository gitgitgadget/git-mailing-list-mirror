Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC001F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfFXMRP (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:17:15 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.25.22]:39504 "EHLO
        mta2.cl.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFXMRP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:17:15 -0400
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta2.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-000VdC-RR; Mon, 24 Jun 2019 13:07:45 +0100
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-0007EW-PI; Mon, 24 Jun 2019 13:07:45 +0100
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH v3 3/5] repack: add --sparse and pass to pack-objects
Date:   Mon, 24 Jun 2019 13:07:09 +0100
Message-Id: <20190624120711.27744-4-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sparse connectivity algorithm saves a whole lot of time when there
are UNINTERESTING trees around.
---
 Documentation/git-repack.txt   | 4 ++++
 builtin/repack.c               | 5 +++++
 t/t5322-pack-objects-sparse.sh | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index aa0cc8bd44..836d81457a 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -165,6 +165,10 @@ depth is 4095.
 	Pass the `--delta-islands` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
+--sparse::
+	Pass the `--sparse` option to `git-pack-objects`; see
+	linkgit:git-pack-objects[1].
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index caca113927..4cfdd62bb8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -288,6 +288,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	int midx_cleared = 0;
 	struct pack_objects_args po_args = {NULL};
+	int sparse = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -326,6 +327,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
+		OPT_BOOL(0, "sparse", &sparse,
+			 N_("use the sparse reachability algorithm")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
 		OPT_END()
@@ -369,6 +372,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
+	if (sparse)
+		argv_array_push(&cmd.args, "--sparse");
 	if (repository_format_partial_clone)
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (write_bitmaps)
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 7124b5581a..66e133dcfe 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -133,4 +133,10 @@ test_expect_success 'pack.useSparse overridden' '
 	test_cmp required_objects.txt sparse_objects.txt
 '
 
+# repack --sparse invokes pack-objects --sparse
+test_expect_success 'repack --sparse and fsck' '
+	git repack -a --sparse &&
+	git fsck
+'
+
 test_done
-- 
2.17.1

