Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6371F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfEIV2x (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:28:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:53666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726946AbfEIV2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:28:53 -0400
Received: (qmail 10036 invoked by uid 109); 9 May 2019 21:28:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:28:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6437 invoked by uid 111); 9 May 2019 21:29:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:29:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:28:51 -0400
Date:   Thu, 9 May 2019 17:28:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/14] builtin: consistently pass cmd_* prefix to
 parse_options
Message-ID: <20190509212850.GC15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a builtin uses RUN_SETUP to request that git.c enter the repository
directory, we'll get passed in a "prefix" variable with the path to the
original directory.  It's important to pass this to parse_options(),
since we may use it to fix up relative OPT_FILENAME() options. Some
builtins don't bother; let's make sure we do so consistently.

There may not be any particular bugs fixed here; OPT_FILENAME is
actually pretty rare, and none of these commands use it directly.
However, this does future-proof us against somebody adding an option
that uses it and creating a subtle bug that only shows up when you're in
a subdirectory of the repository.

In some cases, like hash-object and upload-pack, we don't specify
RUN_SETUP, so we know the prefix will always be empty. It's still worth
passing the variable along to keep the idiom consistent across all
builtins (and of course it protects us if they ever _did_ switch to
using RUN_SETUP).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/column.c              | 2 +-
 builtin/hash-object.c         | 2 +-
 builtin/range-diff.c          | 2 +-
 builtin/rebase--interactive.c | 2 +-
 builtin/upload-pack.c         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/column.c b/builtin/column.c
index 5228ccf37a..e815e148aa 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -43,7 +43,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 
 	memset(&copts, 0, sizeof(copts));
 	copts.padding = 1;
-	argc = parse_options(argc, argv, "", options, builtin_column_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_column_usage, 0);
 	if (argc)
 		usage_with_options(builtin_column_usage, options);
 	if (real_command || command) {
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index e055c11103..640ef4ded5 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -108,7 +108,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	int i;
 	const char *errstr = NULL;
 
-	argc = parse_options(argc, argv, NULL, hash_object_options,
+	argc = parse_options(argc, argv, prefix, hash_object_options,
 			     hash_object_usage, 0);
 
 	if (flags & HASH_WRITE_OBJECT)
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 784bd19321..9202e75544 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -32,7 +32,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	repo_diff_setup(the_repository, &diffopt);
 
 	options = parse_options_concat(range_diff_options, diffopt.parseopts);
-	argc = parse_options(argc, argv, NULL, options,
+	argc = parse_options(argc, argv, prefix, options,
 			     builtin_range_diff_usage, 0);
 
 	diff_setup_done(&diffopt);
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 4535523bf5..72fd4b53a8 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -302,7 +302,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	if (argc == 1)
 		usage_with_options(builtin_rebase_interactive_usage, options);
 
-	argc = parse_options(argc, argv, NULL, options,
+	argc = parse_options(argc, argv, prefix, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
 	opts.gpg_sign = xstrdup_or_null(opts.gpg_sign);
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 42dc4da5a1..6da8fa2607 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -33,7 +33,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	packet_trace_identity("upload-pack");
 	read_replace_refs = 0;
 
-	argc = parse_options(argc, argv, NULL, options, upload_pack_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
 
 	if (argc != 1)
 		usage_with_options(upload_pack_usage, options);
-- 
2.21.0.1382.g4c6032d436

