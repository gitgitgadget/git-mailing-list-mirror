Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BE9C001E0
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 22:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGaWsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGaWsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 18:48:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2731BCF
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 15:48:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C8541ACBBB;
        Mon, 31 Jul 2023 18:44:23 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=c9PvQDag02zrKQkRZZwvSwlRH
        UsAW/GiYiOQ/ADJD88=; b=de9850q++k52b3t8Jc/UfpfmUJZXlSt26cQYlo6w8
        vRQRkILuLugjxOOF1QUDbJoVUKyppqJQxG52lqIVTBUCAnuXowRwvhZt85P3uIrj
        LSEDH+7NnFt8xuvc8Sl+gDuLSRQIqHEcqpZAgZgKaRbGVk0yTtjq8JygBxvYjJaZ
        fY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 355C31ACBBA;
        Mon, 31 Jul 2023 18:44:23 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97CC11ACBB9;
        Mon, 31 Jul 2023 18:44:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] checkout/restore: refuse unmerging paths unless checking out of the index
Date:   Mon, 31 Jul 2023 15:44:07 -0700
Message-ID: <20230731224409.4181277-6-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-478-gee48e70a82
In-Reply-To: <20230731224409.4181277-1-gitster@pobox.com>
References: <20230731224409.4181277-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: CB1DE21C-2FF3-11EE-BFDE-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
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
 Documentation/git-checkout.txt | 9 ++++++---
 Documentation/git-restore.txt  | 4 ++++
 builtin/checkout.c             | 9 +++++++++
 t/t2070-restore.sh             | 7 +++++--
 t/t7201-co.sh                  | 5 +++++
 5 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.=
txt
index 4af0904f47..a30e3ebc51 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -12,8 +12,10 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-po=
int>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish>]=
 [--] <pathspec>...
-'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish>]=
 --pathspec-from-file=3D<file> [--pathspec-file-nul]
+'git checkout' [-f] <tree-ish> [--] <pathspec>...
+'git checkout' [-f] <tree-ish> --pathspec-from-file=3D<file> [--pathspec=
-file-nul]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [--] <pathsp=
ec>...
+'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] --pathspec-f=
rom-file=3D<file> [--pathspec-file-nul]
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
=20
 DESCRIPTION
@@ -260,7 +262,8 @@ and mark the resolved paths with `git add` (or `git r=
m` if the merge
 should result in deletion of the path).
 +
 When checking out paths from the index, this option lets you recreate
-the conflicted merge in the specified paths.
+the conflicted merge in the specified paths.  This option cannot be
+used when checking out paths from a tree-ish.
 +
 When switching branches with `--merge`, staged changes may be lost.
=20
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.tx=
t
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
=20
 --conflict=3D<style>::
 	The same as `--merge` option above, but changes the way the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 715eeb5048..b8dfba57c6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -520,6 +520,15 @@ static int checkout_paths(const struct checkout_opts=
 *opts,
 			    "--merge", "--conflict", "--staged");
 	}
=20
+	/*
+	 * recreating unmerged index entries and writing out data from
+	 * unmerged index entries would make no sense when checking out
+	 * of a tree-ish.
+	 */
+	if ((opts->merge || opts->writeout_stage) && opts->source_tree)
+		die(_("'%s', '%s', or '%s' cannot be used when checking out of a tree"=
),
+		    "--merge", "--ours", "--theirs");
+
 	if (opts->patch_mode) {
 		enum add_p_mode patch_mode;
 		const char *rev =3D new_branch_info->name;
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index c5d19dd973..fd775807e7 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -137,11 +137,14 @@ test_expect_success 'restore --staged invalidates c=
ache tree for deletions' '
 	test_must_fail git rev-parse HEAD:new1
 '
=20
-test_expect_success 'restore with merge options rejects --staged' '
+test_expect_success 'restore with merge options are incompatible with ce=
rtain options' '
 	for opts in \
 		"--staged --ours" \
 		"--staged --theirs" \
 		"--staged --merge" \
+		"--source=3DHEAD --ours" \
+		"--source=3DHEAD --theirs" \
+		"--source=3DHEAD --merge" \
 		"--staged --conflict=3Ddiff3" \
 		"--staged --worktree --ours" \
 		"--staged --worktree --theirs" \
@@ -149,7 +152,7 @@ test_expect_success 'restore with merge options rejec=
ts --staged' '
 		"--staged --worktree --conflict=3Dzdiff3"
 	do
 		test_must_fail git restore $opts . 2>err &&
-		grep "cannot be used with --staged" err || return
+		grep "cannot be used" err || return
 	done
 '
=20
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 61ad47b0c1..23d4dadbcc 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -497,6 +497,11 @@ test_expect_success 'checkout unmerged stage' '
 	test ztheirside =3D "z$(cat file)"
 '
=20
+test_expect_success 'checkout path with --merge from tree-ish is a no-no=
' '
+	setup_conflicting_index &&
+	test_must_fail git checkout -m HEAD -- file
+'
+
 test_expect_success 'checkout with --merge' '
 	setup_conflicting_index &&
 	echo "none of the above" >sample &&
--=20
2.41.0-478-gee48e70a82

