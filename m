Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D61C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjC1U5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjC1U5V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:57:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2D35B5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:57:05 -0700 (PDT)
Received: (qmail 2313 invoked by uid 109); 28 Mar 2023 20:57:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:57:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2245 invoked by uid 111); 28 Mar 2023 20:57:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:57:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:57:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] mark "argv" as unused when we check argc
Message-ID: <20230328205704.GE1754055@coredump.intra.peff.net>
References: <20230328205253.GA1753925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328205253.GA1753925@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few commands don't take any options at all, and confirm this by
checking argc. After that they have no need to look at argv, but we're
still stuck with it by convention. Let's annotate these cases so that
the compiler doesn't complain with -Wunused-parameter.

Note that in scalar and get-tar-commit-id, we're forced to keep argv by
calling convention (the functions must match cmd_main() and builtin
cmd_foo() conventions, respectively). In diff, these are subcommand
modes that we call individually, so we _could_ just drop the argv
parameters entirely. But it's weird to pass argc without argv, and it
implies that the caller knows that the subcommands aren't interested in
further arguments. It's less confusing to just keep them and silence the
compiler warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c              | 6 +++---
 builtin/get-tar-commit-id.c | 2 +-
 scalar.c                    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 26f1e532c66..bc9da7bcb60 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -74,7 +74,7 @@ static void stuff_change(struct diff_options *opt,
 }
 
 static int builtin_diff_b_f(struct rev_info *revs,
-			    int argc, const char **argv,
+			    int argc, const char **argv UNUSED,
 			    struct object_array_entry **blob)
 {
 	/* Blob vs file in the working tree*/
@@ -109,7 +109,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
 }
 
 static int builtin_diff_blobs(struct rev_info *revs,
-			      int argc, const char **argv,
+			      int argc, const char **argv UNUSED,
 			      struct object_array_entry **blob)
 {
 	const unsigned mode = canon_mode(S_IFREG | 0644);
@@ -209,7 +209,7 @@ static int builtin_diff_tree(struct rev_info *revs,
 }
 
 static int builtin_diff_combined(struct rev_info *revs,
-				 int argc, const char **argv,
+				 int argc, const char **argv UNUSED,
 				 struct object_array_entry *ent,
 				 int ents, int first_non_parent)
 {
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 8f8f2ac3e68..4324d39fb49 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -14,7 +14,7 @@ static const char builtin_get_tar_commit_id_usage[] =
 #define RECORDSIZE	(512)
 #define HEADERSIZE (2 * RECORDSIZE)
 
-int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
+int cmd_get_tar_commit_id(int argc, const char **argv UNUSED, const char *prefix)
 {
 	char buffer[HEADERSIZE];
 	struct ustar_header *header = (struct ustar_header *)buffer;
diff --git a/scalar.c b/scalar.c
index ca19b95ce46..c7b8c16c8ee 100644
--- a/scalar.c
+++ b/scalar.c
@@ -563,7 +563,7 @@ static int cmd_diagnose(int argc, const char **argv)
 	return res;
 }
 
-static int cmd_list(int argc, const char **argv)
+static int cmd_list(int argc, const char **argv UNUSED)
 {
 	if (argc != 1)
 		die(_("`scalar list` does not take arguments"));
-- 
2.40.0.675.gb17cd5d94c8

