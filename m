Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE44C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiGGX7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiGGX7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:59:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14DB1C12B
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:59:36 -0700 (PDT)
Received: (qmail 7004 invoked by uid 109); 7 Jul 2022 23:59:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 23:59:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5914 invoked by uid 111); 7 Jul 2022 23:59:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 19:59:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 19:59:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 3/3] clone: use remote branch if it matches default HEAD
Message-ID: <YsdzZxS48u8sk9QD@coredump.intra.peff.net>
References: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usually clone tries to use the same local HEAD as the remote (unless the
user has given --branch explicitly). Even if the remote HEAD is detached
or unborn, we can detect those situations with modern versions of Git.
If the remote is too old to support the "unborn" extension (or it has
been disabled via config), then we can't know the name of the remote's
unborn HEAD, and we fall back whatever the local default branch name is
configured to be.

But that leads to one weird corner case. It's rare because it needs a
number of factors:

  - the remote has an unborn HEAD

  - the remote is too old to support "unborn", or has disabled it

  - the remote has another branch "foo"

  - the local default branch name is "foo"

In that case you end up with a local clone on an unborn "foo" branch,
disconnected completely from the remote's "foo". This is rare in
practice, but the result is quite confusing.

When choosing "foo", we can double check whether the remote has such a
name, and if so, start our local "foo" at the same spot, rather than
making it unborn.

Note that this causes a test failure in t5605, which is cloning from a
bundle that doesn't contain HEAD (so it behaves like a remote that
doesn't support "unborn"), but has a single "main" branch. That test
expects that we end up in the weird "unborn main" case, where we don't
actually check out the remote branch of the same name. Even though we
have to update the test, this seems like an argument in favor of this
patch: checking out main is what I'd expect from such a bundle.

So this patch updates the test for the new behavior and adds an adjacent
one that checks what the original was going for: if there's no HEAD and
the bundle _doesn't_ have a branch that matches our local default name,
then we end up with nothing checked out.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c        | 17 ++++++++++++++---
 t/t5605-clone-local.sh | 16 +++++++++++++---
 t/t5702-protocol-v2.sh | 21 +++++++++++++++++++++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f9b850e59c..0912d268a1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1290,8 +1290,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			option_no_checkout = 1;
 		}
 
-		our_head_points_at = NULL;
-
 		if (transport_ls_refs_options.unborn_head_target &&
 		    skip_prefix(transport_ls_refs_options.unborn_head_target,
 				"refs/heads/", &branch)) {
@@ -1303,7 +1301,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			ref = ref_free;
 		}
 
-		if (!option_bare)
+		/*
+		 * We may have selected a local default branch name "foo",
+		 * and even though the remote's HEAD does not point there,
+		 * it may still have a "foo" branch. If so, set it up so
+		 * that we can follow the usual checkout code later.
+		 *
+		 * Note that for an empty repo we'll already have set
+		 * option_no_checkout above, which would work against us here.
+		 * But for an empty repo, find_remote_branch() can never find
+		 * a match.
+		 */
+		our_head_points_at = find_remote_branch(mapped_refs, branch);
+
+		if (!option_bare && !our_head_points_at)
 			install_branch_config(0, branch, remote_name, ref);
 		free(ref_free);
 	}
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 21ab619283..38b850c10e 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -21,7 +21,9 @@ test_expect_success 'preparing origin repository' '
 	git bundle create b2.bundle main &&
 	mkdir dir &&
 	cp b1.bundle dir/b3 &&
-	cp b1.bundle b4
+	cp b1.bundle b4 &&
+	git branch not-main main &&
+	git bundle create b5.bundle not-main
 '
 
 test_expect_success 'local clone without .git suffix' '
@@ -83,11 +85,19 @@ test_expect_success 'bundle clone from b4.bundle that does not exist' '
 	test_must_fail git clone b4.bundle bb
 '
 
-test_expect_success 'bundle clone with nonexistent HEAD' '
+test_expect_success 'bundle clone with nonexistent HEAD (match default)' '
 	git clone b2.bundle b2 &&
 	(cd b2 &&
 	git fetch &&
-	test_must_fail git rev-parse --verify refs/heads/main)
+	git rev-parse --verify refs/heads/main)
+'
+
+test_expect_success 'bundle clone with nonexistent HEAD (no match default)' '
+	git clone b5.bundle b5 &&
+	(cd b5 &&
+	git fetch &&
+	test_must_fail git rev-parse --verify refs/heads/main &&
+	test_must_fail git rev-parse --verify refs/heads/not-main)
 '
 
 test_expect_success 'clone empty repository' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2b3a78b842..5d42a355a8 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -288,6 +288,27 @@ test_expect_success 'bare clone propagates unborn HEAD from non-empty repo' '
 	! grep "warning:" stderr
 '
 
+test_expect_success 'defaulted HEAD uses remote branch if available' '
+	test_when_finished "rm -rf file_unborn_parent file_unborn_child" &&
+
+	git init file_unborn_parent &&
+	(
+		cd file_unborn_parent &&
+		git config lsrefs.unborn ignore &&
+		git checkout -b branchwithstuff &&
+		test_commit --no-tag stuff &&
+		git symbolic-ref HEAD refs/heads/mydefaultbranch
+	) &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=branchwithstuff -c protocol.version=2 \
+		clone "file://$(pwd)/file_unborn_parent" \
+		file_unborn_child 2>stderr &&
+	grep "refs/heads/branchwithstuff" file_unborn_child/.git/HEAD &&
+	test_path_is_file file_unborn_child/stuff.t &&
+	! grep "warning:" stderr
+'
+
 test_expect_success 'fetch with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.37.0.424.g982e2d45d0
