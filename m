Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C77C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D45E6103B
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbhIXSsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:48:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:54680 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhIXSsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:48:11 -0400
Received: (qmail 19154 invoked by uid 109); 24 Sep 2021 18:46:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:46:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11209 invoked by uid 111); 24 Sep 2021 18:46:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:46:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:46:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 13/16] repack, prune: drop GIT_REF_PARANOIA settings
Message-ID: <YU4dDY5Pf1gBxI9G@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that GIT_REF_PARANOIA is the default, we don't need to selectively
enable it for destructive operations. In fact, it's harmful to do so,
because it overrides any GIT_REF_PARANOIA=0 setting that the user may
have provided (because they're trying to work around some corruption).

With these uses gone, we can further clean up the ref_paranoia global,
and make it a static variable inside the refs code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/prune.c  | 1 -
 builtin/repack.c | 3 ---
 cache.h          | 8 --------
 environment.c    | 1 -
 refs.c           | 2 ++
 5 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 02c6ab7cba..485c9a3c56 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -143,7 +143,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	expire = TIME_MAX;
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
-	ref_paranoia = 1;
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
diff --git a/builtin/repack.c b/builtin/repack.c
index c1a209013b..cb9f4bfed3 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -586,15 +586,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				strvec_pushf(&cmd.args,
 					     "--unpack-unreachable=%s",
 					     unpack_unreachable);
-				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
 			} else if (pack_everything & LOOSEN_UNREACHABLE) {
 				strvec_push(&cmd.args,
 					    "--unpack-unreachable");
 			} else if (keep_unreachable) {
 				strvec_push(&cmd.args, "--keep-unreachable");
 				strvec_push(&cmd.args, "--pack-loose-unreachable");
-			} else {
-				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
 			}
 		}
 	} else if (geometry) {
diff --git a/cache.h b/cache.h
index f6295f3b04..f445008895 100644
--- a/cache.h
+++ b/cache.h
@@ -994,14 +994,6 @@ extern const char *core_fsmonitor;
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 
-/*
- * Include broken refs in all ref iterations, which will
- * generally choke dangerous operations rather than letting
- * them silently proceed without taking the broken ref into
- * account.
- */
-extern int ref_paranoia;
-
 /*
  * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
  */
diff --git a/environment.c b/environment.c
index b4ba4fa22d..7923ab21dd 100644
--- a/environment.c
+++ b/environment.c
@@ -31,7 +31,6 @@ int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
-int ref_paranoia = -1;
 int repository_format_precious_objects;
 int repository_format_worktree_config;
 const char *git_commit_encoding;
diff --git a/refs.c b/refs.c
index ac19c689fa..d0f4e8726b 100644
--- a/refs.c
+++ b/refs.c
@@ -1419,6 +1419,8 @@ struct ref_iterator *refs_ref_iterator_begin(
 	struct ref_iterator *iter;
 
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
+		static int ref_paranoia = -1;
+
 		if (ref_paranoia < 0)
 			ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 1);
 		if (ref_paranoia) {
-- 
2.33.0.1071.gb37e412355

