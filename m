Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF98C83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbjHaGVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbjHaGVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:21:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BA0CD6
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:21:01 -0700 (PDT)
Received: (qmail 21157 invoked by uid 109); 31 Aug 2023 06:21:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:21:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3004 invoked by uid 111); 31 Aug 2023 06:21:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:21:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:21:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/10] add core.maxTreeDepth config
Message-ID: <20230831062100.GE3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our tree traversal algorithms use recursion to visit sub-trees.
For pathologically large trees, this can cause us to run out of stack
space and abort in an uncontrolled way. Let's put our own limit here so
that we can fail gracefully rather than segfaulting.

In similar cases where we recursed along the commit graph, we rewrote
the algorithms to avoid recursion and keep any stack data on the heap.
But the commit graph is meant to grow without bound, whereas it's not an
imposition to put a limit on the maximum size of tree we'll handle.

And this has a bonus side effect: coupled with a limit on individual
tree entry names, this limits the total size of a path we may encounter.
This gives us an extra protection against code handling long path names
which may suffer from integer overflows in the size (which could then be
exploited by malicious trees).

The default of 4096 is set to be much longer than anybody would care
about in the real world. Even with single-letter interior tree names
(like "a/b/c"), such a path is at least 8191 bytes. While most operating
systems will let you create such a path incrementally, trying to
reference the whole thing in a system call (as Git would do when
actually trying to access it) will result in ENAMETOOLONG. Coupled with
the recent fsck.largePathname warning, the maximum total pathname Git
will handle is (by default) 16MB.

This config option doesn't do anything yet; future patches will convert
various algorithms to respect the limit.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/core.txt | 6 ++++++
 config.c                      | 5 +++++
 environment.c                 | 1 +
 environment.h                 | 1 +
 4 files changed, 13 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index dfbdaf00b8..0e8c2832bf 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -736,3 +736,9 @@ core.abbrev::
 	If set to "no", no abbreviation is made and the object names
 	are shown in their full length.
 	The minimum length is 4.
+
+core.maxTreeDepth::
+	The maximum depth Git is willing to recurse while traversing a
+	tree (e.g., "a/b/cde/f" has a depth of 4). This is a fail-safe
+	to allow Git to abort cleanly, and should not generally need to
+	be adjusted. The default is 4096.
diff --git a/config.c b/config.c
index 3846a37be9..2ea39295cd 100644
--- a/config.c
+++ b/config.c
@@ -1801,6 +1801,11 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.maxtreedepth")) {
+		max_allowed_tree_depth = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, ctx, cb);
 }
diff --git a/environment.c b/environment.c
index f98d76f080..8e25b5ef02 100644
--- a/environment.c
+++ b/environment.c
@@ -81,6 +81,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
+int max_allowed_tree_depth = 4096;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/environment.h b/environment.h
index c5377473c6..e5351c9dd9 100644
--- a/environment.h
+++ b/environment.h
@@ -132,6 +132,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
+extern int max_allowed_tree_depth;
 
 /*
  * Accessors for the core.sharedrepository config which lazy-load the value
-- 
2.42.0.561.gaa987ecc69

