Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA765ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 23:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiH2X3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2X3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 19:29:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A82861E4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 16:29:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m5so7264852qkk.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zPv4VNZPQbWY+Ybzx92XnsHpG4dLdzVGwp4GuIygJ1Q=;
        b=Hb2Mn/Up6HkDby3Ht60bceI3+Mo2L6rQfxm0j088Qep3Q2EEnbZF8gRfXABMWZIgmg
         beSkH85rPRkKdj56TFYBWkLQsxVxbZgkPE7MF/uIaOajFhF7W8dTCpOuT+F0yNJPNDZL
         GqDOiczSWKDSS3D2Xin9PmUrtuymWNIyb4eSVh9QdFlDMw/FmFDr7/hWrkmQRPxiBswW
         7+wA6pQ0VNkjSpzJ7FjzomwSXhWRirEN5iTcqOqP8ijJ4rIweot5ERNyaEDxnXZVzzR8
         df5QEYeZ/WXbt04XPt1Pb4xZs1sKM9vYWETGTZyF1ecE+nCnl7oi79iVWOXgVQxGCEDx
         y3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zPv4VNZPQbWY+Ybzx92XnsHpG4dLdzVGwp4GuIygJ1Q=;
        b=QLRcopsmu3NmqNbogXCAUpYmS4R1gYpyvPgwOCxS8S9TUw1+EkN68tsBye3R+V5/5Y
         kNUPe+uWrTA9+HWdKcQnw7ueCvErVveya9n2X/u/XKkqW8mUSTqYRUskxSkFWm2ikBL1
         XmT7bqG+DTz36M1V+ZylXh6L6SVXcY1we/rki5KZ9AXB/uCCUjVwwcfJGRHZdHA+kHQd
         0vxcC6Lf0YFTjQVjNTk2BO9IbCv3YBimHR0aA99TfhVHZR62GW5TpWilTvYYu219TUqf
         1Uosg2TFBbVCAJXPs9PCvWcNSw8rLN7wgisSILG5mAJubhgDv5gvAeZUeFVkhmF50R4a
         AUoA==
X-Gm-Message-State: ACgBeo2QhLqwmq4t3lcvR5YSwsgC6ZMHjMpWzJcXGu4KUzBGrZQ9H5YV
        PaB2lHLI1n9kqmeUYBneWCWFj1Y5MVg=
X-Google-Smtp-Source: AA6agR6+nv9sjfvMjULf8VEMUKJpSPgGVVgGXP56EYeIPgTFekbQEfZKf84ocRdKNivCgsg7OmTE0Q==
X-Received: by 2002:a05:620a:28d5:b0:6bb:a67b:5675 with SMTP id l21-20020a05620a28d500b006bba67b5675mr10027586qkp.741.1661815742369;
        Mon, 29 Aug 2022 16:29:02 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id l7-20020a05620a28c700b006a793bde241sm6679802qkp.63.2022.08.29.16.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 16:29:01 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 0/2] grep: integrate with sparse index
Date:   Mon, 29 Aug 2022 16:28:41 -0700
Message-Id: <20220829232843.183711-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate `git-grep` with sparse-index and test the performance
improvement.

Changes since v1
----------------

* Rewrite the commit message for "builtin/grep.c: add --sparse option"
  to be clearer.

* Update the documentation (both in-code and man page) for --sparse.

* Add a few tests to test the new behavior (when _only_ --cached is
  supplied).

* Reformat the perf test results to not look like directly from p2000
  tests.

* Put the "command_requires_full_index" lines right after parse_options().

* Add a pathspec test in t1092, and reword a few test documentations.

left-over-bits
--------------

As Derrick suggested here [1], we can use tree traversing, for example
`grep_tree()` in "builtin/grep.c", to grep each sparse directory,
rather than expand the index directly, so we save some overheads.

However, when testing "specifying a pathspec to limit the scope of
tree walking", my local branch Git does not show the contents within
the pathspec because of pathspec mismatch (which is not expected,
when "folder1/*" is used, "folder1/a" failed to match?!).
And when the pathspec is not used, Git walks all the trees as
expected, because `all_entries_interesting` is returned for the empty
pathspec.

So I'm convinced that something is wrong with the pathspec matching
logic within "builtin/grep.c", and I'm still working on it [2].

[1] https://lore.kernel.org/git/19dea639-389a-7258-e424-4912bde226df@github.com/
[2] https://github.com/ffyuanda/git/tree/grep/sparse-integration-v2.3-tree-walking

Shaoxuan Yuan (2):
  builtin/grep.c: add --sparse option
  builtin/grep.c: integrate with sparse index

 Documentation/git-grep.txt               |  5 +++-
 builtin/grep.c                           | 20 +++++++++++---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 18 +++++++++++++
 t/t7817-grep-sparse-checkout.sh          | 34 +++++++++++++++++++-----
 5 files changed, 68 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  bcac4dfc56 ! 1:  27c9341bca builtin/grep.c: add --sparse option
    @@ Metadata
      ## Commit message ##
         builtin/grep.c: add --sparse option
     
    -    Add a --sparse option to `git-grep`. This option is mainly used to:
    +    Add a --sparse option to `git-grep`.
     
    -    If searching in the index (using --cached):
    +    When the '--cached' option is used with the 'git grep' command, the
    +    search is limited to the blobs found in the index, not in the worktree.
    +    If the user has enabled sparse-checkout, this might present more results
    +    than they would like, since the files outside of the sparse-checkout are
    +    unlikely to be important to them.
     
    -    With --sparse, proceed the action when the current cache_entry is
    -    marked with SKIP_WORKTREE bit (the default is to skip this kind of
    -    entry). Before this patch, --cached itself can realize this action.
    -    Adding --sparse here grants the user finer control over sparse
    -    entries. If the user only wants to peak into the index without
    -    caring about sparse entries, --cached should suffice; if the user
    -    wants to peak into the index _and_ cares about sparse entries,
    -    combining --sparse with --cached can address this need.
    +    Change the default behavior of 'git grep' to focus on the files within
    +    the sparse-checkout definition. To enable the previous behavior, add a
    +    '--sparse' option to 'git grep' that triggers the old behavior that
    +    inspects paths outside of the sparse-checkout definition when paired
    +    with the '--cached' option.
     
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Suggested-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
    + ## Documentation/git-grep.txt ##
    +@@ Documentation/git-grep.txt: SYNOPSIS
    + 	   [-f <file>] [-e] <pattern>
    + 	   [--and|--or|--not|(|)|-e <pattern>...]
    + 	   [--recurse-submodules] [--parent-basename <basename>]
    +-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
    ++	   [ [--[no-]exclude-standard] [--cached [--sparse] | --no-index | --untracked] | <tree>...]
    + 	   [--] [<pathspec>...]
    + 
    + DESCRIPTION
    +@@ Documentation/git-grep.txt: OPTIONS
    + 	Instead of searching tracked files in the working tree, search
    + 	blobs registered in the index file.
    + 
    ++--sparse::
    ++	Use with --cached. Search outside of sparse-checkout definition.
    ++
    + --no-index::
    + 	Search files in the current directory that is not managed by Git.
    + 
    +
      ## builtin/grep.c ##
     @@ builtin/grep.c: static pthread_cond_t cond_result;
      
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      
     -		if (!cached && ce_skip_worktree(ce))
     +		/*
    -+		 * If ce is a SKIP_WORKTREE entry, look into it when both
    -+		 * --sparse and --cached are given.
    ++		 * Skip entries with SKIP_WORKTREE unless both --sparse and
    ++		 * --cached are given.
     +		 */
     +		if (!(grep_sparse && cached) && ce_skip_worktree(ce))
      			continue;
    @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      		OPT_INTEGER('m', "max-count", &opt.max_count,
      			N_("maximum number of results per file")),
     +		OPT_BOOL(0, "sparse", &grep_sparse,
    -+			 N_("search sparse contents and expand sparse index")),
    ++			 N_("search the contents of files outside the sparse-checkout definition")),
      		OPT_END()
      	};
      	grep_prefix = prefix;
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep searches unmerged fil
      
     -test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit' '
     +test_expect_success 'grep --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
    ++	cat >expect <<-EOF &&
    ++	a:text
    ++	EOF
    ++	git grep --cached "text" >actual &&
    ++	test_cmp expect actual &&
    ++
      	cat >expect <<-EOF &&
      	a:text
      	b:text
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep --recurse-submodules
      
     -test_expect_success 'grep --recurse-submodules --cached searches entries with the SKIP_WORKTREE bit' '
     +test_expect_success 'grep --recurse-submodules --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
    ++	cat >expect <<-EOF &&
    ++	a:text
    ++	sub/B/b:text
    ++	sub2/a:text
    ++	EOF
    ++	git grep --recurse-submodules --cached "text" >actual &&
    ++	test_cmp expect actual &&
    ++
      	cat >expect <<-EOF &&
      	a:text
      	b:text
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'working tree grep does not
      
     -test_expect_success 'grep --cached searches index entries with both CE_VALID and SKIP_WORKTREE' '
     +test_expect_success 'grep --cached and --sparse searches index entries with both CE_VALID and SKIP_WORKTREE' '
    ++	cat >expect <<-EOF &&
    ++	a:text
    ++	EOF
    ++	test_when_finished "git update-index --no-assume-unchanged b" &&
    ++	git update-index --assume-unchanged b &&
    ++	git grep --cached text >actual &&
    ++	test_cmp expect actual &&
    ++
      	cat >expect <<-EOF &&
      	a:text
      	b:text
2:  48b21afb94 ! 2:  cb16727c05 builtin/grep.c: integrate with sparse index
    @@ Commit message
         The p2000 tests demonstrate a ~99.4% execution time reduction for
         `git grep` using a sparse index.
     
    -    Test                                           HEAD~1       HEAD
    +    Test                                  Before       After
         -----------------------------------------------------------------------------
    -    2000.78: git grep --cached bogus (full-v3)     0.019        0.018  (-5.2%)
    -    2000.79: git grep --cached bogus (full-v4)     0.017        0.016  (-5.8%)
    -    2000.80: git grep --cached bogus (sparse-v3)   0.29         0.0015 (-99.4%)
    -    2000.81: git grep --cached bogus (sparse-v4)   0.30         0.0018 (-99.4%)
    +    git grep --cached bogus (full-v3)     0.019        0.018  (-5.2%)
    +    git grep --cached bogus (full-v4)     0.017        0.016  (-5.8%)
    +    git grep --cached bogus (sparse-v3)   0.29         0.0015 (-99.4%)
    +    git grep --cached bogus (sparse-v4)   0.30         0.0018 (-99.4%)
     
         Optional reading about performance test results
         -----------------------------------------------
    @@ Commit message
     
      ## builtin/grep.c ##
     @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
    - 		strbuf_addstr(&name, repo->submodule_prefix);
    - 	}
    - 
    -+	prepare_repo_settings(repo);
    -+	repo->settings.command_requires_full_index = 0;
    -+
      	if (repo_read_index(repo) < 0)
      		die(_("index file corrupt"));
      
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      	for (nr = 0; nr < repo->index->cache_nr; nr++) {
      		const struct cache_entry *ce = repo->index->cache[nr];
      
    +@@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
    + 			     PARSE_OPT_KEEP_DASHDASH |
    + 			     PARSE_OPT_STOP_AT_NON_OPTION);
    + 
    ++	if (the_repository->gitdir) {
    ++		prepare_repo_settings(the_repository);
    ++		the_repository->settings.command_requires_full_index = 0;
    ++	}
    ++
    + 	if (use_index && !startup_info->have_repository) {
    + 		int fallback = 0;
    + 		git_config_get_bool("grep.fallbacktonoindex", &fallback);
     
      ## t/perf/p2000-sparse-operations.sh ##
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git read-tree -mu HEAD
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
      	ensure_not_expanded rm -r deep
      '
      
    -+test_expect_success 'grep expands index using --sparse' '
    ++test_expect_success 'grep with --sparse and --cached' '
     +	init_repos &&
     +
    -+	# With --sparse and --cached, do not ignore sparse entries and
    -+	# expand the index.
    -+	test_all_match git grep --sparse --cached a
    ++	test_all_match git grep --sparse --cached a &&
    ++	test_all_match git grep --sparse --cached a -- "folder1/*"
     +'
     +
     +test_expect_success 'grep is not expanded' '
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
     +
     +	ensure_not_expanded grep a &&
     +	ensure_not_expanded grep a -- deep/* &&
    -+	# grep does not match anything per se, so ! is used
    ++
    ++	# All files within the folder1/* pathspec are sparse,
    ++	# so this command does not find any matches
     +	ensure_not_expanded ! grep a -- folder1/*
     +'
     +

base-commit: 07ee72db0e97b5c233f8ada0abb412248c2f1c6f
-- 
2.37.0

