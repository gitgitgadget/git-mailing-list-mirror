Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECB2EB64DD
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 22:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjG1WGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjG1WGc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 18:06:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8284D2D73
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 15:06:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10D122BBDD;
        Fri, 28 Jul 2023 18:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=H
        9BzX582P3+8SmHGECQJVmL+eUXwdPuYn2G+kcpNS8k=; b=AZ956dppP5NzffNhS
        yzxKGg0HsqKXQgtnbO0JSBuGX0xvH3yxVMxlH29cFXtXc0LGE1JWvVUfyioJafMs
        HpMH4qFDgU5t6g2QhQwicj0HeSxZFQI8WgnIAVotgcZkG24Hmb2O7xoA+JIzyJ4Z
        vb9DnbssTklCzvhCSjQLc/7LIE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 097DF2BBDC;
        Fri, 28 Jul 2023 18:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8FD182BBDB;
        Fri, 28 Jul 2023 18:06:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] checkout/restore: refuse unmerging paths unless
 checking out of the index
Date:   Fri, 28 Jul 2023 15:06:26 -0700
Message-ID: <xmqqedkr4rod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFDA638A-2D92-11EE-B23D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recreating unmerged index entries using resolve-undo data,
recreating conflicted working tree files using unmerged index
entries, and writing data out of unmerged index entries, make
sense only when we are checking paths out of the index and not when
we are checking paths out of a tree-ish.

Add an extra check to make sure "--merge" and "--ours/--theirs"
options are rejected when checking out from a tree-ish, update the
document (especially the SYNOPSIS section) to highlight that they
are incompatible, and add a few tests to make sure the combination
fails.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We do have proper description of the --merge option in
   Documentation/git-checkout.txt to cover the operation in both
   modes of "checkout" (i.e. checking out a branch vs checking out
   paths), but the parse_options help text only talks about the one
   that happens when checking out a branch.  We might want to do
   something about it, but I am not sure what the right phrase
   should be.  The options[] array there is created by concatenating
   common ones, switch-related ones, and restore-related ones, and
   ideally how the option works in each mode should be decribed in
   the latter two, but we cannot have duplicate entries in the
   resulting options[] array, of course, so such an approach would
   not work well.

 Documentation/git-checkout.txt | 9 ++++++---
 Documentation/git-restore.txt  | 4 ++++
 builtin/checkout.c             | 9 +++++++++
 t/t2070-restore.sh             | 7 +++++--
 t/t7201-co.sh                  | 5 +++++
 5 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4af0904f47..a30e3ebc51 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -12,8 +12,10 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
+'git checkout' [-f] <tree-ish> [--] <pathspec>...
+'git checkout' [-f] <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
@@ -260,7 +262,8 @@ and mark the resolved paths with `git add` (or `git rm` if the merge
 should result in deletion of the path).
 +
 When checking out paths from the index, this option lets you recreate
-the conflicted merge in the specified paths.
+the conflicted merge in the specified paths.  This option cannot be
+used when checking out paths from a tree-ish.
 +
 When switching branches with `--merge`, staged changes may be lost.
 
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5964810caa..c70444705b 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -78,6 +78,8 @@ all modified paths.
 --theirs::
 	When restoring files in the working tree from the index, use
 	stage #2 ('ours') or #3 ('theirs') for unmerged paths.
+	This option cannot be used when checking out paths from a
+	tree-ish (i.e. with the `--source` option).
 +
 Note that during `git rebase` and `git pull --rebase`, 'ours' and
 'theirs' may appear swapped. See the explanation of the same options
@@ -87,6 +89,8 @@ in linkgit:git-checkout[1] for details.
 --merge::
 	When restoring files on the working tree from the index,
 	recreate the conflicted merge in the unmerged paths.
+	This option cannot be used when checking out paths from a
+	tree-ish (i.e. with the `--source` option).
 
 --conflict=<style>::
 	The same as `--merge` option above, but changes the way the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 715eeb5048..b8dfba57c6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -520,6 +520,15 @@ static int checkout_paths(const struct checkout_opts *opts,
 			    "--merge", "--conflict", "--staged");
 	}
 
+	/*
+	 * recreating unmerged index entries and writing out data from
+	 * unmerged index entries would make no sense when checking out
+	 * of a tree-ish.
+	 */
+	if ((opts->merge || opts->writeout_stage) && opts->source_tree)
+		die(_("'%s', '%s', or '%s' cannot be used when checking out of a tree"),
+		    "--merge", "--ours", "--theirs");
+
 	if (opts->patch_mode) {
 		enum add_p_mode patch_mode;
 		const char *rev = new_branch_info->name;
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index c5d19dd973..fd775807e7 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -137,11 +137,14 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
 	test_must_fail git rev-parse HEAD:new1
 '
 
-test_expect_success 'restore with merge options rejects --staged' '
+test_expect_success 'restore with merge options are incompatible with certain options' '
 	for opts in \
 		"--staged --ours" \
 		"--staged --theirs" \
 		"--staged --merge" \
+		"--source=HEAD --ours" \
+		"--source=HEAD --theirs" \
+		"--source=HEAD --merge" \
 		"--staged --conflict=diff3" \
 		"--staged --worktree --ours" \
 		"--staged --worktree --theirs" \
@@ -149,7 +152,7 @@ test_expect_success 'restore with merge options rejects --staged' '
 		"--staged --worktree --conflict=zdiff3"
 	do
 		test_must_fail git restore $opts . 2>err &&
-		grep "cannot be used with --staged" err || return
+		grep "cannot be used" err || return
 	done
 '
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 61ad47b0c1..23d4dadbcc 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -497,6 +497,11 @@ test_expect_success 'checkout unmerged stage' '
 	test ztheirside = "z$(cat file)"
 '
 
+test_expect_success 'checkout path with --merge from tree-ish is a no-no' '
+	setup_conflicting_index &&
+	test_must_fail git checkout -m HEAD -- file
+'
+
 test_expect_success 'checkout with --merge' '
 	setup_conflicting_index &&
 	echo "none of the above" >sample &&
-- 
2.41.0-478-gee48e70a82

