Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD584C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 08:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiGFIDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiGFIDr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 04:03:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FEB266D
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 01:03:38 -0700 (PDT)
Received: (qmail 2308 invoked by uid 109); 6 Jul 2022 08:03:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 08:03:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18072 invoked by uid 111); 6 Jul 2022 08:03:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 04:03:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 04:03:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 3/3] clone: propagate empty remote HEAD even with other
 branches
Message-ID: <YsVB2eOMp5guQfVr@coredump.intra.peff.net>
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless "--branch" was given, clone generally tries to match the local
HEAD to the remote one. For most repositories, this is easy: the remote
tells us which branch HEAD was pointing to, and we call our local
checkout() function on that branch.

When cloning an empty repository, it's a little more tricky: we have
special code that checks the transport's "unborn" extension, or falls back
to our local idea of what the default branch should be. In either case,
we point the new HEAD to that, and set up the branch.* config.

But that leaves one case unhandled: when the remote repository _isn't_
empty, but its HEAD is unborn. The checkout() function is smart enough
to realize we didn't fetch the remote HEAD and it bails with a warning.
But we'll have ignored any information the remote gave us via the unborn
extension. This leads to nonsense outcomes:

  - If the remote has its HEAD pointing to an unborn "foo" and contains
    another branch "bar", cloning will get branch "bar" but leave the
    local HEAD pointing at "master" (or whatever our local default is),
    which is useless. The project does not use "master" as a branch.

  - Worse, if the other branch "bar" is instead called "master" (but
    again, the remote HEAD is not pointing to it), then we end up with a
    local unborn branch "master", which is not connected to the remote
    "master" (it shares no history, and there's no branch.* config).

Instead, we should try to use the remote's HEAD, even if its unborn, to
be consistent with the other cases.

Some notes on the implementation:

 - we don't emit any specific warning here, which is unlike the
   empty-repo case (which says "you appear to have cloned an empty
   reopsitory"). For non-bare clones, checkout() will issue a warning
   like:

     warning: remote HEAD refers to nonexistent ref, unable to checkout

   For a bare clone, it won't emit any warning at all (but will still
   set up HEAD appropriately). That's probably fine. There's no part of
   the operation we were unable to perform, so any "by the way, the
   remote HEAD wasn't there but we pointed our HEAD to it anyway"
   message would be purely informational. Though perhaps one could argue
   the same about the current "empty repository" message in a bare
   clone.

 - if the remote told us about its HEAD via the unborn extension, this
   is obviously the right thing to do. If they didn't, we'll fall back
   to our local default name. As the "unborn" extension was added in
   v2.31.0, we'd expect hosts which don't support it to become
   decreasingly common, and it may not be worth worrying too much about.
   But for the sake of completeness, here are some thoughts:

     - if the remote has a non-HEAD "master", we may still end up with a
       local "master" that isn't connected to it. This is because the
       "how to set local unborn HEAD" code is independent from the "did
       we find a remote HEAD we can checkout" code. This could be fixed,
       but I'm not sure it's worth caring too much about, since you'd
       have to really try hard to create such a situation.

     - if the remote has branches but doesn't tell us about its HEAD,
       we could pick one of those branches as our HEAD instead of
       whatever our local default is. This feels on-balance worse to me.
       While it might do the right thing in some cases (especially if
       there is only a single branch), it could certainly lead to
       surprising and unintuitive outcomes in others.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c        |  7 +++++--
 t/t5702-protocol-v2.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b7d3962c12..aa0729f62d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1298,9 +1298,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			if (!our_head_points_at)
 				die(_("Remote branch %s not found in upstream %s"),
 				    option_branch, remote_name);
-		}
-		else
+		} else {
 			our_head_points_at = remote_head_points_at;
+			if (!our_head_points_at)
+				setup_unborn_head(transport_ls_refs_options.unborn_head_target,
+						  reflog_msg.buf);
+		}
 	}
 	else {
 		if (option_branch)
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 00ce9aec23..822ca334c4 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -250,6 +250,44 @@ test_expect_success 'bare clone propagates empty default branch' '
 	grep "refs/heads/mydefaultbranch" file_empty_child.git/HEAD
 '
 
+test_expect_success 'clone propagates empty default branch from non-empty repo' '
+	test_when_finished "rm -rf file_empty_parent file_empty_child" &&
+
+	git init file_empty_parent &&
+	(
+		cd file_empty_parent &&
+		git checkout -b branchwithstuff &&
+		test_commit --no-tag stuff &&
+		git symbolic-ref HEAD refs/heads/mydefaultbranch
+	) &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_empty_parent" \
+		file_empty_child 2>stderr &&
+	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD &&
+	grep "warning: remote HEAD refers to nonexistent ref" stderr
+'
+
+test_expect_success 'bare clone propagates empty default branch from non-empty repo' '
+	test_when_finished "rm -rf file_empty_parent file_empty_child.git" &&
+
+	git init file_empty_parent &&
+	(
+		cd file_empty_parent &&
+		git checkout -b branchwithstuff &&
+		test_commit --no-tag stuff &&
+		git symbolic-ref HEAD refs/heads/mydefaultbranch
+	) &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone --bare "file://$(pwd)/file_empty_parent" \
+		file_empty_child.git 2>stderr &&
+	grep "refs/heads/mydefaultbranch" file_empty_child.git/HEAD &&
+	! grep "warning:" stderr
+'
+
 test_expect_success 'fetch with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.37.0.408.g2817302ee7
