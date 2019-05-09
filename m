Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6CC1F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEIV10 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:27:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:53654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726704AbfEIV10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:27:26 -0400
Received: (qmail 10011 invoked by uid 109); 9 May 2019 21:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:27:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6403 invoked by uid 111); 9 May 2019 21:28:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:28:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:27:24 -0400
Date:   Thu, 9 May 2019 17:27:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/14] cmd_{read,write}_tree: rename "unused" variable that
 is used
Message-ID: <20190509212724.GA15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "prefix" variable passed by git.c into the builtin cmd_read_tree()
and cmd_write_tree() functions is named "unused_prefix". But we do in
fact pass it to parse_options(), which may use the prefix to adjust any
filename options. Let's get rid of this confusing name.

However, we can't just call it "prefix". The reason these variables were
renamed in the first place is that they shadowed local variables named
"prefix", because these commands both take a "--prefix" option.

So let's rename the parameters, but try to reduce further confusion:

  1. In both cases we'll call them "cmd_prefix" to mark that they're
     part of the cmd_* interface.

  2. In cmd_write_tree(), we'll rename the local prefix variable to
     "tree_prefix" to make it more clear that we're talking about the
     prefix to be used for the tree we're writing.

  3. In cmd_read_tree(), the "prefix" local has since migrated into
     "struct unpack_trees_options". We'll leave that alone, as the
     context within the struct makes its meaning clear (we actually
     _could_ just call the parameter "prefix" now, but that invites
     confusion in the other direction).

Signed-off-by: Jeff King <peff@peff.net>
---
I kind of hate "cmd_prefix"; I was tempted to just call it "prefix" so
that all of the cmd_* functions were consistent, but I worried that it
really would get confused with the local variables (even if those
variables are renamed, as I do here).

 builtin/read-tree.c  |  4 ++--
 builtin/write-tree.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 5c9c082595..ca5e655d2f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -111,7 +111,7 @@ static int git_read_tree_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
+int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 {
 	int i, stage = 0;
 	struct object_id oid;
@@ -165,7 +165,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	git_config(git_read_tree_config, NULL);
 
-	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
+	argc = parse_options(argc, argv, cmd_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 3d46d22ee5..45d61707e7 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -16,16 +16,16 @@ static const char * const write_tree_usage[] = {
 	NULL
 };
 
-int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
+int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
 {
 	int flags = 0, ret;
-	const char *prefix = NULL;
+	const char *tree_prefix = NULL;
 	struct object_id oid;
 	const char *me = "git-write-tree";
 	struct option write_tree_options[] = {
 		OPT_BIT(0, "missing-ok", &flags, N_("allow missing objects"),
 			WRITE_TREE_MISSING_OK),
-		OPT_STRING(0, "prefix", &prefix, N_("<prefix>/"),
+		OPT_STRING(0, "prefix", &tree_prefix, N_("<prefix>/"),
 			   N_("write tree object for a subdirectory <prefix>")),
 		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
 		  N_("only useful for debugging"),
@@ -35,10 +35,10 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
+	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
-	ret = write_cache_as_tree(&oid, flags, prefix);
+	ret = write_cache_as_tree(&oid, flags, tree_prefix);
 	switch (ret) {
 	case 0:
 		printf("%s\n", oid_to_hex(&oid));
@@ -50,7 +50,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 		die("%s: error building trees", me);
 		break;
 	case WRITE_TREE_PREFIX_ERROR:
-		die("%s: prefix %s not found", me, prefix);
+		die("%s: prefix %s not found", me, tree_prefix);
 		break;
 	}
 	return ret;
-- 
2.21.0.1382.g4c6032d436

