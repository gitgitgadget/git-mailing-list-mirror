Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wA7vDjUP"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8A1BF
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 22:00:33 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C03C1C4E00;
	Thu, 23 Nov 2023 01:00:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jnK2wDec/pdROAP+0f85Z/yqbStW4qS668WOVu
	mY/Kk=; b=wA7vDjUPJAUy7rkiZVjcVrCCvxUbUS4eMgqgzQr2Pdgdei0DKycJqR
	ezCEpE7On766wQwF7wiTKQwQ/Hw2h2OcnzI5NK8XCiu8f3hd81DrBIGbySfFEdpy
	EJ1H1vxUpOdYqEKd/KHX9MmWOf48vK1YNE/gL+byqH15EJIYHdL8Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 139BD1C4DFF;
	Thu, 23 Nov 2023 01:00:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 644391C4DFE;
	Thu, 23 Nov 2023 01:00:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Willem Verstraeten <willem.verstraeten@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a branch
 used elsewhere
In-Reply-To: <xmqqv89tau3r.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 Nov 2023 14:58:48 +0900")
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
	<xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g>
Date: Thu, 23 Nov 2023 15:00:31 +0900
Message-ID: <xmqqpm01au0w.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C9EB926-89C5-11EE-8456-25B3960A682E-77302942!pb-smtp2.pobox.com

"git checkout -B <branch> [<start-point>]", being a "forced" version
of "-b", switches to the <branch>, after optionally resetting its
tip to the <start-point>, even if the <branch> is in use in another
worktree, which is somewhat unexpected.

Protect the <branch> using the same logic that forbids "git checkout
<branch>" from touching a branch that is in use elsewhere.

This is a breaking change that may deserve backward compatibliity
warning in the Release Notes.  The "--ignore-other-worktrees" option
can be used as an escape hatch if the finger memory of existing
users depend on the current behaviour of "-B".

Reported-by: Willem Verstraeten <willem.verstraeten@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The documentation might also need updates, but I didn't look at.

 builtin/checkout.c      | 7 +++++++
 t/t2060-switch.sh       | 2 ++
 t/t2400-worktree-add.sh | 8 ++++++++
 3 files changed, 17 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b4ab972c5a..8a8ad23e98 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1600,6 +1600,13 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch)
 		die_if_switching_to_a_branch_in_use(opts, new_branch_info->path);
 
+	/* "git checkout -B <branch>" */
+	if (opts->new_branch_force) {
+		char *full_ref = xstrfmt("refs/heads/%s", opts->new_branch);
+		die_if_switching_to_a_branch_in_use(opts, full_ref);
+		free(full_ref);
+	}
+
 	if (!new_branch_info->commit && opts->new_branch) {
 		struct object_id rev;
 		int flag;
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index e247a4735b..c91c4db936 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -170,8 +170,10 @@ test_expect_success 'switch back when temporarily detached and checked out elsew
 	# we test in both worktrees to ensure that works
 	# as expected with "first" and "next" worktrees
 	test_must_fail git -C wt1 switch shared &&
+	test_must_fail git -C wt1 switch -C shared &&
 	git -C wt1 switch --ignore-other-worktrees shared &&
 	test_must_fail git -C wt2 switch shared &&
+	test_must_fail git -C wt2 switch -C shared &&
 	git -C wt2 switch --ignore-other-worktrees shared
 '
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index df4aff7825..bbcb2d3419 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -126,6 +126,14 @@ test_expect_success 'die the same branch is already checked out' '
 	)
 '
 
+test_expect_success 'refuse to reset a branch in use elsewhere' '
+	(
+		cd here &&
+		test_must_fail git checkout -B newmain 2>actual &&
+		grep "already used by worktree at" actual
+	)
+'
+
 test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
 	head=$(git -C there rev-parse --git-path HEAD) &&
 	ref=$(git -C there symbolic-ref HEAD) &&
-- 
2.43.0

