Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84F6C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A0360F3A
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 19:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349362AbhITTHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 15:07:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:50994 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388609AbhITTFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 15:05:39 -0400
Received: (qmail 2030 invoked by uid 109); 20 Sep 2021 19:04:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Sep 2021 19:04:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21322 invoked by uid 111); 20 Sep 2021 19:04:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 15:04:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 15:04:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] clone: handle unborn branch in bare repos
Message-ID: <YUjbKt0Hw0ieHcaN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning a repository with an unborn HEAD, we'll set the local HEAD
to match it only if the local repository is non-bare. This is
inconsistent with all other combinations:

  remote HEAD       | local repo | local HEAD
  -----------------------------------------------
  points to commit  | non-bare   | same as remote
  points to commit  | bare       | same as remote
  unborn            | non-bare   | same as remote
  unborn            | bare       | local default

So I don't think this is some clever or subtle behavior, but just a bug
in 4f37d45706 (clone: respect remote unborn HEAD, 2021-02-05). And it's
easy to see how we ended up there. Before that commit, the code to set
up the HEAD for an empty repo was guarded by "if (!option_bare)". That's
because the only thing it did was call install_branch_config(), and we
don't want to do so for a bare repository (unborn HEAD or not).

That commit put the handling of unborn HEADs into the same block, since
those also need to call install_branch_config(). But the unborn case has
an additional side effect of calling create_symref(), and we want that
to happen whether we are bare or not.

This patch just pulls all of the "figure out the default branch" code
out of the "!option_bare" block. Only the actual config installation is
kept there.

Note that this does mean we might allocate "ref" and not use it (if the
remote is empty but did not advertise an unborn HEAD). But that's not
really a big deal since this isn't a hot code path, and it keeps the
code simple. The alternative would be handling unborn_head_target
separately, but that gets confusing since its memory ownership is
tangled up with the "ref" variable.

There's just one new test, for the case we're fixing. The other ones in
the table are handled elsewhere (the unborn non-bare case just above,
and the actually-born cases in t5601, t5606, and t5609, as they do not
require v2's "unborn" protocol extension).

Signed-off-by: Jeff King <peff@peff.net>
---
There's a big reindented chunk here. Viewing the diff with "-w" or
"--color-moved-ws=ignore-space-change" makes it a lot easier to read.

I'm not opposed to reorganizing the code to get rid of the
sometimes-useless malloc. But I'd prefer to do it on top to keep this
functional change more obviously-correct.

 builtin/clone.c        | 33 +++++++++++++++++----------------
 t/t5702-protocol-v2.sh | 13 +++++++++++++
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b93bcd460e..6e821d6326 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1345,6 +1345,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			our_head_points_at = remote_head_points_at;
 	}
 	else {
+		const char *branch;
+		char *ref;
+
 		if (option_branch)
 			die(_("Remote branch %s not found in upstream %s"),
 					option_branch, remote_name);
@@ -1355,24 +1358,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head_points_at = NULL;
 		remote_head = NULL;
 		option_no_checkout = 1;
-		if (!option_bare) {
-			const char *branch;
-			char *ref;
-
-			if (transport_ls_refs_options.unborn_head_target &&
-			    skip_prefix(transport_ls_refs_options.unborn_head_target,
-					"refs/heads/", &branch)) {
-				ref = transport_ls_refs_options.unborn_head_target;
-				transport_ls_refs_options.unborn_head_target = NULL;
-				create_symref("HEAD", ref, reflog_msg.buf);
-			} else {
-				branch = git_default_branch_name(0);
-				ref = xstrfmt("refs/heads/%s", branch);
-			}
 
-			install_branch_config(0, branch, remote_name, ref);
-			free(ref);
+		if (transport_ls_refs_options.unborn_head_target &&
+		    skip_prefix(transport_ls_refs_options.unborn_head_target,
+				"refs/heads/", &branch)) {
+			ref = transport_ls_refs_options.unborn_head_target;
+			transport_ls_refs_options.unborn_head_target = NULL;
+			create_symref("HEAD", ref, reflog_msg.buf);
+		} else {
+			branch = git_default_branch_name(0);
+			ref = xstrfmt("refs/heads/%s", branch);
 		}
+
+		if (!option_bare)
+			install_branch_config(0, branch, remote_name, ref);
+
+		free(ref);
 	}
 
 	write_refspec_config(src_ref_prefix, our_head_points_at,
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d3687b1a2e..d527cf6c49 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -237,6 +237,19 @@ test_expect_success '...but not if explicitly forbidden by config' '
 	! grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
 '
 
+test_expect_success 'bare clone propagates empty default branch' '
+	test_when_finished "rm -rf file_empty_parent file_empty_child.git" &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone --bare \
+		"file://$(pwd)/file_empty_parent" file_empty_child.git &&
+	grep "refs/heads/mydefaultbranch" file_empty_child.git/HEAD
+'
+
 test_expect_success 'fetch with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.33.0.992.gccf01040e6
