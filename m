Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C37C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 08:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiGFIAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiGFIAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 04:00:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2922BE1
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 01:00:47 -0700 (PDT)
Received: (qmail 2294 invoked by uid 109); 6 Jul 2022 08:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 08:00:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18068 invoked by uid 111); 6 Jul 2022 08:00:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 04:00:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 04:00:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/3] clone: factor out unborn head setup into its own function
Message-ID: <YsVBLlpqqlRcrzv/@coredump.intra.peff.net>
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit pulls the handling of an empty repository's unborn head into
its own function. There's a similar case to handle in a non-empty
repository (i.e., where just HEAD is empty, but it has other branches).
The code isn't too long, but there's enough subtle policy logic that we
wouldn't want to cut-and-paste it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f596cedcf1..b7d3962c12 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -866,6 +866,26 @@ static int path_exists(const char *path)
 	return !stat(path, &sb);
 }
 
+static void setup_unborn_head(const char *target, const char *reflog_msg)
+{
+	const char *branch;
+	const char *ref;
+	char *ref_free = NULL;
+
+	if (target && skip_prefix(target, "refs/heads/", &branch)) {
+		ref = target;
+		create_symref("HEAD", ref, reflog_msg);
+	} else {
+		branch = git_default_branch_name(0);
+		ref_free = xstrfmt("refs/heads/%s", branch);
+		ref = ref_free;
+	}
+
+	if (!option_bare)
+		install_branch_config(0, branch, remote_name, ref);
+	free(ref_free);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -1283,10 +1303,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			our_head_points_at = remote_head_points_at;
 	}
 	else {
-		const char *branch;
-		const char *ref;
-		char *ref_free = NULL;
-
 		if (option_branch)
 			die(_("Remote branch %s not found in upstream %s"),
 					option_branch, remote_name);
@@ -1297,20 +1313,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 
-		if (transport_ls_refs_options.unborn_head_target &&
-		    skip_prefix(transport_ls_refs_options.unborn_head_target,
-				"refs/heads/", &branch)) {
-			ref = transport_ls_refs_options.unborn_head_target;
-			create_symref("HEAD", ref, reflog_msg.buf);
-		} else {
-			branch = git_default_branch_name(0);
-			ref_free = xstrfmt("refs/heads/%s", branch);
-			ref = ref_free;
-		}
-
-		if (!option_bare)
-			install_branch_config(0, branch, remote_name, ref);
-		free(ref_free);
+		setup_unborn_head(transport_ls_refs_options.unborn_head_target,
+				  reflog_msg.buf);
 	}
 
 	write_refspec_config(src_ref_prefix, our_head_points_at,
-- 
2.37.0.408.g2817302ee7

