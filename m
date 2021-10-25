Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E00C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8B661076
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhJYVKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhJYVKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:10:37 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B6C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:08:14 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bm16so258504qkb.11
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iUVD6hHDdhuW7GCZsG8dJPuJ1N22bIudQXJ3zUJff3M=;
        b=BoA1ep6Uv0lotKuBbZGSpkQbg6NOBblUR669GZ0OtQwlvdcFBX2eiAMU412BL6I2zn
         xKoesn9ja9PqW/FnqrhEAzoJjZrJAfE2jdf2KS4GRg2PW6s0omoUm38udJmdshWFPKmU
         LqqHMHN8GfY9ufUvN7ytFwojaE/l25hogsebz48g2Jn5ji39CecuEBLOw34Xr+jOZt6B
         TpTHUm1+dMYhm6OBrQuRntwO3RelJRir8IQyExQclEcE5BR8/euCJjc48AVk5AGQ4SqR
         Cn2jz2q4JtkDJqzuzJ73sMiTl9lKik/srxWzntFLLium89FDAqeJnvaaqsVZhTmh4c7M
         eKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iUVD6hHDdhuW7GCZsG8dJPuJ1N22bIudQXJ3zUJff3M=;
        b=QWQZwRO1z/hTVUycw6p5AW+TbAgy0VnzEDvLI/9LkB6Lsm52xyo9BU40p9TVOJllIU
         EjJqV2P8E3nCqyFnLz+P1JZ38ky5Y6vXW5V7zjLCZ0zV/OEk9edHvOXb/MiLvuHSQ5Oh
         Lvu2WHsc28rEiRdFryH9sgDByMKyhIPjpErAMxED72ZO8CJDY74HN78tvfp1vCPeTCSd
         cuVQ6e0TJtYSYNde9uC1anj/hXm8ZvScvKHZAgnOpM5NpkH1+0d8kg/sIx5ZfYHRcua8
         vEmfTat3k5WikMASQIuaEsPM447dBgDWF8BDnzZSJqGjUhX1lSxEKxPad75fmME4JpR9
         1dkQ==
X-Gm-Message-State: AOAM531bulOgDSBWYgHmkJMJiUDvm1mS1yVj6rEKy3pTCDB1AwC4GrTw
        Z7W7iWUHbErMIHVZg6coly4RPe3M15DUFQ==
X-Google-Smtp-Source: ABdhPJzyPiAjpokIdsR84Z2X+j4Ar7d3DCkCim8wMt+QzEq0r3RqDKe1E+z0r2Fm5/a7986V4v2OHA==
X-Received: by 2002:a37:b7c1:: with SMTP id h184mr15503591qkf.65.1635196093300;
        Mon, 25 Oct 2021 14:08:13 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id i22sm2655574qko.2.2021.10.25.14.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:08:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, stolee@gmail.com,
        vdye@github.com, derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2] add, rm, mv: fix bug that prevents the update of non-sparse dirs
Date:   Mon, 25 Oct 2021 18:07:53 -0300
Message-Id: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These three commands recently learned to avoid updating paths outside
the sparse checkout even if they are missing the SKIP_WORKTREE bit. This
is done using path_in_sparse_checkout(), which checks whether a given
path matches the current list of sparsity rules, similar to what
clear_ce_flags() does when we run "git sparse checkout init" or "git
sparse-checkout reapply". However, clear_ce_flags() uses a recursive
approach, applying the match results from parent directories on paths
that get the UNDECIDED result, whereas path_in_sparse_checkout() only
attempts to match the full path and immediately considers UNDECIDED as
NOT_MATCHED. This makes the function miss matches with leading
directories. For example, if the user has the sparsity patterns "!/a"
and "b/", add, rm, and mv will fail to update the path "a/b/c" and end
up displaying a warning about it being outside the sparse checkout even
though it isn't. This problem only occurs in full pattern mode as the
pattern matching functions never return UNDECIDED for cone mode.

To fix this, replicate the recursive behavior of clear_ce_flags() in
path_in_sparse_checkout(), falling back to the parent directory match
when a path gets the UNDECIDED result. (If this turns out to be too
expensive in some cases, we may want to later add some form of caching
to accelerate multiple queries within the same directory. This is not
implemented in this patch, though.) Also add two tests for each affected
command (add, rm, and mv) to check that they behave correctly with the
recursive pattern matching. The first test would previously fail without
this patch while the second already succeeded. It is added mostly to
make sure that we are not breaking the existing pattern matching for
directories that are really sparse, and also as a protection against any
future regressions.

Two other existing tests had to be changed as well: one test in t3602
checks that "git rm -r <dir>" won't remove sparse entries, but it didn't
allow the non-sparse entries inside <dir> to be removed. The other one,
in t7002, tested that "git mv" would correctly display a warning message
for sparse paths, but it accidentally expected the message to include
two non-sparse paths as well.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Changes since RFC/v1 [1]:

- Inverted the loop direction to start from the full path and go backwards in
  the parent dirs. This way we can stop early when we find the first
  non-UNDECIDED match result.

- Simplified the implementation by unifing the code path for cone mode and
  full pattern mode. Since path_matches_pattern_list() never returns UNDECIDED
  for cone mode, it will always execute only one iteration of the loop and then
  find the final answer. There is no need to handle this case in a separate
  block.

- Inside the loop, made sure to change dtype to DT_DIR when going to parent
  directories. Without this, the pattern match would fail if we had a path
  like "a/b/c" and the pattern "b/" (with trailing slash).

- Changed the tests to use trailing slash to make sure they cover the corner
  case described above.

- Improved commit message.

[1]: https://lore.kernel.org/git/80b5ba61861193daf7132aa64b65fc7dde90dacb.1634866698.git.matheus.bernardino@usp.br
(The RFC was deep down another thread, so I separated v2 to help
readers. Please, let me know if that is not a good approach and I will
avoid it in the future.)

 dir.c                          | 25 +++++++++++++++++------
 t/t3602-rm-sparse-checkout.sh  | 37 +++++++++++++++++++++++++++++++---
 t/t3705-add-sparse-checkout.sh | 18 +++++++++++++++++
 t/t7002-mv-sparse-checkout.sh  | 24 ++++++++++++++++++++--
 4 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index a4306ab874..248f72e732 100644
--- a/dir.c
+++ b/dir.c
@@ -1504,8 +1504,9 @@ static int path_in_sparse_checkout_1(const char *path,
 				     struct index_state *istate,
 				     int require_cone_mode)
 {
-	const char *base;
 	int dtype = DT_REG;
+	enum pattern_match_result match = UNDECIDED;
+	const char *end, *slash;
 
 	/*
 	 * We default to accepting a path if there are no patterns or
@@ -1516,11 +1517,23 @@ static int path_in_sparse_checkout_1(const char *path,
 	     !istate->sparse_checkout_patterns->use_cone_patterns))
 		return 1;
 
-	base = strrchr(path, '/');
-	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
-					 &dtype,
-					 istate->sparse_checkout_patterns,
-					 istate) > 0;
+	/*
+	 * If UNDECIDED, use the match from the parent dir (recursively),
+	 * or fall back to NOT_MATCHED at the topmost level.
+	 */
+	for (end = path + strlen(path); end > path && match == UNDECIDED; end = slash) {
+
+		for (slash = end - 1; slash >= path && *slash != '/'; slash--)
+			; /* do nothing */
+
+		match = path_matches_pattern_list(path, end - path,
+				slash >= path ? slash + 1 : path, &dtype,
+				istate->sparse_checkout_patterns, istate);
+
+		/* We are going to match the parent dir now */
+		dtype = DT_DIR;
+	}
+	return match > 0;
 }
 
 int path_in_sparse_checkout(const char *path,
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index ecce497a9c..034ec01091 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -40,14 +40,20 @@ done
 test_expect_success 'recursive rm does not remove sparse entries' '
 	git reset --hard &&
 	git sparse-checkout set sub/dir &&
-	test_must_fail git rm -r sub &&
-	git rm --sparse -r sub &&
+	git rm -r sub &&
 	git status --porcelain -uno >actual &&
 	cat >expected <<-\EOF &&
+	D  sub/dir/e
+	EOF
+	test_cmp expected actual &&
+
+	git rm --sparse -r sub &&
+	git status --porcelain -uno >actual2 &&
+	cat >expected2 <<-\EOF &&
 	D  sub/d
 	D  sub/dir/e
 	EOF
-	test_cmp expected actual
+	test_cmp expected2 actual2
 '
 
 test_expect_success 'recursive rm --sparse removes sparse entries' '
@@ -105,4 +111,29 @@ test_expect_success 'refuse to rm a non-skip-worktree path outside sparse cone'
 	test_path_is_missing b
 '
 
+test_expect_success 'can remove files from non-sparse dir' '
+	git reset --hard &&
+	git sparse-checkout disable &&
+	mkdir -p w x/y &&
+	test_commit w/f &&
+	test_commit x/y/f &&
+
+	git sparse-checkout set w !/x y/ &&
+	git rm w/f.t x/y/f.t 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'refuse to remove non-skip-worktree file from sparse dir' '
+	git reset --hard &&
+	git sparse-checkout disable &&
+	mkdir -p x/y/z &&
+	test_commit x/y/z/f &&
+	git sparse-checkout set !/x y/ !x/y/z &&
+
+	git update-index --no-skip-worktree x/y/z/f.t &&
+	test_must_fail git rm x/y/z/f.t 2>stderr &&
+	echo x/y/z/f.t | cat sparse_error_header - sparse_hint >expect &&
+	test_cmp expect stderr
+'
+
 test_done
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 5b904988d4..54f3db4304 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -214,4 +214,22 @@ test_expect_success 'add allows sparse entries with --sparse' '
 	test_must_be_empty stderr
 '
 
+test_expect_success 'can add files from non-sparse dir' '
+	git sparse-checkout set w !/x y/ &&
+	mkdir -p w x/y &&
+	touch w/f x/y/f &&
+	git add w/f x/y/f 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'refuse to add non-skip-worktree file from sparse dir' '
+	git sparse-checkout set !/x y/ !x/y/z &&
+	mkdir -p x/y/z &&
+	touch x/y/z/f &&
+	test_must_fail git add x/y/z/f 2>stderr &&
+	echo x/y/z/f | cat sparse_error_header - sparse_hint >expect &&
+	test_cmp expect stderr
+
+'
+
 test_done
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 545748949a..1d3d2aca21 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -143,8 +143,6 @@ test_expect_success 'recursive mv refuses to move (possible) sparse' '
 	cat >>expect <<-\EOF &&
 	sub/d
 	sub2/d
-	sub/dir/e
-	sub2/dir/e
 	sub/dir2/e
 	sub2/dir2/e
 	EOF
@@ -186,4 +184,26 @@ test_expect_success 'recursive mv refuses to move sparse' '
 	git reset --hard HEAD~1
 '
 
+test_expect_success 'can move files to non-sparse dir' '
+	git reset --hard &&
+	git sparse-checkout init --no-cone &&
+	git sparse-checkout set a b c w !/x y/ &&
+	mkdir -p w x/y &&
+
+	git mv a w/new-a 2>stderr &&
+	git mv b x/y/new-b 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
+	git reset --hard &&
+	git sparse-checkout init --no-cone &&
+	git sparse-checkout set a !/x y/ !x/y/z &&
+	mkdir -p x/y/z &&
+
+	test_must_fail git mv a x/y/z/new-a 2>stderr &&
+	echo x/y/z/new-a | cat sparse_error_header - sparse_hint >expect &&
+	test_cmp expect stderr
+'
+
 test_done
-- 
2.33.0

