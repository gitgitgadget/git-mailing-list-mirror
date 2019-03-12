Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878B020248
	for <e@80x24.org>; Tue, 12 Mar 2019 13:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfCLN0K (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:26:10 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.25.22]:45167 "EHLO
        mta2.cl.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfCLN0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:26:09 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 09:26:08 EDT
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta2.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h3hJ0-0002L3-Tc; Tue, 12 Mar 2019 13:18:54 +0000
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h3hJ7-0006o5-Lw; Tue, 12 Mar 2019 13:19:01 +0000
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH 3/4] repack: add --sparse and pass to pack-objects
Date:   Tue, 12 Mar 2019 13:18:57 +0000
Message-Id: <20190312131858.26115-4-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
References: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sparse connectivity algorithm saves a whole lot of time when there
are UNINTERESTING trees around.
---
 Documentation/git-repack.txt |  4 ++++
 builtin/repack.c             | 10 ++++++++++
 2 files changed, 14 insertions(+)

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
index 67f8978043..71e715b594 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -17,6 +17,7 @@ static int pack_kept_objects = -1;
 static int write_bitmaps;
 static int use_delta_islands;
 static char *packdir, *packtmp;
+static int sparse;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [<options>]"),
@@ -48,6 +49,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		use_delta_islands = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "pack.usesparse")) {
+		sparse = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -326,11 +331,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
+		OPT_BOOL(0, "sparse", &sparse,
+			 N_("use the sparse reachability algorithm")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
 		OPT_END()
 	};
 
+	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
 	git_config(repack_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
@@ -366,6 +374,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
+	if (sparse)
+		argv_array_push(&cmd.args, "--sparse");
 	if (repository_format_partial_clone)
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (write_bitmaps)
-- 
2.17.1

