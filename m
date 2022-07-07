Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF218C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiGGX5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiGGX5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:57:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2E6D57F
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:57:46 -0700 (PDT)
Received: (qmail 6973 invoked by uid 109); 7 Jul 2022 23:57:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 23:57:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5908 invoked by uid 111); 7 Jul 2022 23:57:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 19:57:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 19:57:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 2/3] clone: propagate empty remote HEAD even with other
 branches
Message-ID: <Ysdy+STDIhCZU05+@coredump.intra.peff.net>
References: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
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

The reason this case was missed is that cmd_clone() handles empty and
non-empty repositories on two different sides of a conditional:

  if (we have any refs) {
      fetch refs;
      check for --branch;
      otherwise, try to point our head at remote head;
      otherwise, our head is NULL;
  } else {
      check for --branch;
      otherwise, try to use "unborn" extension;
      otherwise, fall back to our default name name;
  }

So the smallest change would be to repeat the "unborn" logic at the end
of the first block. But we can note some other overlaps and
inconsistencies:

  - both sides have to handle --branch (though note that it's always an
    error for the empty repo case, since an empty repo by definition
    does not have a matching branch)

  - the fall back to the default name is much more explicit in the
    empty-repo case. The non-empty case eventually ends up bailing
    from checkout() with a warning, which produces a similar result, but
    fails to set up the branch config we do in the empty case.

So let's pull the HEAD setup out of this conditional entirely. This
de-duplicates some of the code and the result is easy to follow, because
helper functions like find_ref_by_name() do the right thing even in the
empty-repo case (i.e., by returning NULL).

There are two subtleties:

  - for a remote with a detached HEAD, it will advertise an oid for HEAD
    (which we store in our "remote_head" variable), but we won't find a
    matching refname (so our "remote_head_points_at" is NULL). In this
    case we make a local detached HEAD to match. Right now this happens
    implicitly by reaching update_head() with a non-NULL remote_head
    (since we skip all of the unborn-fallback). We'll now need to
    account for it explicitly before doing the fallback.

  - for an empty repo, we issue a warning to the user that they've
    cloned an empty repo. The text of that warning doesn't make sense
    for a non-empty repo with an unborn HEAD, so we'll have to
    differentiate the two cases there. We could just use different text,
    but instead let's allow the code to continue down to checkout(),
    which will issue an appropriate warning, like:

      remote HEAD refers to nonexistent ref, unable to checkout

    Continuing down to checkout() will make it easier to do more fixes
    on top (see below).

Note that this patch fixes the case where the other side reports an
unborn head to us using the protocol extension. It _doesn't_ fix the
case where the other side doesn't tell us, we locally guess "master",
and the other side happens to have a "master" which its HEAD doesn't
point. But it doesn't make anything worse there, and it should actually
make it easier to fix that problem on top.

Signed-off-by: Jeff King <peff@peff.net>
---
Rewritten in v2 to extract more of the logic. Bigger diff, but I think
the end result is good. Try reading with "-w", as well.

 builtin/clone.c        | 39 +++++++++++++++++----------------------
 t/t5702-protocol-v2.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f596cedcf1..f9b850e59c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1266,36 +1266,31 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			if (transport_fetch_refs(transport, mapped_refs))
 				die(_("remote transport reported error"));
 		}
+	}
 
-		remote_head = find_ref_by_name(refs, "HEAD");
-		remote_head_points_at =
-			guess_remote_head(remote_head, mapped_refs, 0);
-
-		if (option_branch) {
-			our_head_points_at =
-				find_remote_branch(mapped_refs, option_branch);
+	remote_head = find_ref_by_name(refs, "HEAD");
+	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
 
-			if (!our_head_points_at)
-				die(_("Remote branch %s not found in upstream %s"),
-				    option_branch, remote_name);
-		}
-		else
-			our_head_points_at = remote_head_points_at;
-	}
-	else {
+	if (option_branch) {
+		our_head_points_at = find_remote_branch(mapped_refs, option_branch);
+		if (!our_head_points_at)
+			die(_("Remote branch %s not found in upstream %s"),
+			    option_branch, remote_name);
+	} else if (remote_head_points_at) {
+		our_head_points_at = remote_head_points_at;
+	} else if (remote_head) {
+		our_head_points_at = NULL;
+	} else {
 		const char *branch;
 		const char *ref;
 		char *ref_free = NULL;
 
-		if (option_branch)
-			die(_("Remote branch %s not found in upstream %s"),
-					option_branch, remote_name);
+		if (!mapped_refs) {
+			warning(_("You appear to have cloned an empty repository."));
+			option_no_checkout = 1;
+		}
 
-		warning(_("You appear to have cloned an empty repository."));
 		our_head_points_at = NULL;
-		remote_head_points_at = NULL;
-		remote_head = NULL;
-		option_no_checkout = 1;
 
 		if (transport_ls_refs_options.unborn_head_target &&
 		    skip_prefix(transport_ls_refs_options.unborn_head_target,
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 00ce9aec23..2b3a78b842 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -250,6 +250,44 @@ test_expect_success 'bare clone propagates empty default branch' '
 	grep "refs/heads/mydefaultbranch" file_empty_child.git/HEAD
 '
 
+test_expect_success 'clone propagates unborn HEAD from non-empty repo' '
+	test_when_finished "rm -rf file_unborn_parent file_unborn_child" &&
+
+	git init file_unborn_parent &&
+	(
+		cd file_unborn_parent &&
+		git checkout -b branchwithstuff &&
+		test_commit --no-tag stuff &&
+		git symbolic-ref HEAD refs/heads/mydefaultbranch
+	) &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_unborn_parent" \
+		file_unborn_child 2>stderr &&
+	grep "refs/heads/mydefaultbranch" file_unborn_child/.git/HEAD &&
+	grep "warning: remote HEAD refers to nonexistent ref" stderr
+'
+
+test_expect_success 'bare clone propagates unborn HEAD from non-empty repo' '
+	test_when_finished "rm -rf file_unborn_parent file_unborn_child.git" &&
+
+	git init file_unborn_parent &&
+	(
+		cd file_unborn_parent &&
+		git checkout -b branchwithstuff &&
+		test_commit --no-tag stuff &&
+		git symbolic-ref HEAD refs/heads/mydefaultbranch
+	) &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone --bare "file://$(pwd)/file_unborn_parent" \
+		file_unborn_child.git 2>stderr &&
+	grep "refs/heads/mydefaultbranch" file_unborn_child.git/HEAD &&
+	! grep "warning:" stderr
+'
+
 test_expect_success 'fetch with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.37.0.424.g982e2d45d0

