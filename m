Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7787DC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiFWLlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiFWLlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2484BFE9
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so417511pjv.3
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+2LYce9/5O7DBU4nmEloC+Se6ahbetgPSOnJ+Obpcw=;
        b=T8UV25Gu2OcFmS401CA8XFR4FB+mN5dmEAJB8Su4/cpmVZHotjo+m+wpM+p7PJmThg
         8FZC7p3kNbJypaqcfex3BXD0X40CfXRZZikJ3uuh2lD0ngtP05ygatE2o47z5tjmjF8Q
         YB46WDSJLHoXKT/K2VJs50Px046bFZ1qRMeULGQzr3Feb2FqA+EEyKAxNSu58NkiOhg4
         gKXmUulkVWgad3l0lb1KGKLNPO1jFlyAA0XRJOq1yA9sVbJNwBNlALNzLOt7Mjed5Zph
         /Eml9mYqt/S0hpERu4w7YrEFe3FMCuPddREz9QBNNrXkYCLz9sqmTT+LlydFOaUc4XrG
         0kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+2LYce9/5O7DBU4nmEloC+Se6ahbetgPSOnJ+Obpcw=;
        b=FH92XbsvMOjceby0TDjWjz8J6DTN7oowbTPipuYkmyQ8zCrWuPMJTfCC+9mr8wWNR2
         GAVsxBeUbMW+VyFewk7yaALwn8QFW7/iLTKs/YppA54ITFT5THSmHIOYBqWz4Q5qSneC
         JKcfU6FypeQbmk8jcSMlnWZV3wu1CxgA6lZ5DmJm1ojg7EporxT/dywalTiB7cKZQgV3
         Gr/EFnLYQpUi7BSqYenUhV9oOverbMu6O7DiGI5cU/hnNCyDg92cfzXIDh8wOq3R/MUB
         e8VkUbOgjvFGd8Un2eG0yaE45FjWzS02oCket8YQqF/cLVN7YbmQ5/nrRX8Bg3T+a0D3
         imEg==
X-Gm-Message-State: AJIora8+aX0Od5pfptCTh9+bP2rVjlh72SdfDCJSh3X59BqgSzTI1x0z
        JQFbzqucdLGCthXBeiYLgtY=
X-Google-Smtp-Source: AGRyM1va/3iERz6891FKIq989FqlmNsR7+DYSpu6C0KQ04ONAzW8ae/3Rzshnrxhz+QIRLw1lF3gUg==
X-Received: by 2002:a17:90b:3a89:b0:1ec:93d2:f47d with SMTP id om9-20020a17090b3a8900b001ec93d2f47dmr3591565pjb.139.1655984503710;
        Thu, 23 Jun 2022 04:41:43 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.146.236])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm1629299pjl.55.2022.06.23.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:41:43 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com
Subject: [PATCH v4 0/7] mv: fix out-of-cone file/directory move logic
Date:   Thu, 23 Jun 2022 19:41:13 +0800
Message-Id: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

## Changes since WIP v3 ##

1. Fix style-nits.

2. Move "mv: update sparsity after moving from out-of-cone to in-cone" to the 
   (2/7) position (was (7/7) position in WIP v3). Make this move so that we
   can drop "git sparse-checkout reapply" from the tests, as suggested by
   Victoria [1]. The reason is we need to check out the moved cache_entry
   for all out-of-cone to in-cone moves, so this commit works better if being the
   first one.

3. Fix the commit message of "mv: use flags mode for update_mode", as suggested
   here [2].

4. Add "Helped-by" and "Suggested-by" trailers.

5. In "mv: add check_dir_in_index() and solve general dir check issue", change
   the 'check_dir_in_index()' to no more accept 'namelen' as argument. The
   original "namelen + 1" logic can be erroneous, for example when 'name' already
   has a trailing slash. So just use strlen() to save the trouble.

## Notes ##

As discussed in WIP v3, we can postpone the "in-cone to out-of-cone" move
to a later series. Hence, this series' functionality part has been done,
remove the WIP prefix.

[1] https://lore.kernel.org/git/adb795ba-56ce-8441-0c38-a3e6b0a6e861@github.com/
[2] https://lore.kernel.org/git/01b39c63-5652-4293-0424-ff99b6f9f7d2@github.com/

Shaoxuan Yuan (7):
  t7002: add tests for moving out-of-cone file/directory
  mv: update sparsity after moving from out-of-cone to in-cone
  mv: decouple if/else-if checks using goto
  mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
  mv: check if <destination> exists in index to handle overwriting
  mv: use flags mode for update_mode
  mv: add check_dir_in_index() and solve general dir check issue

 builtin/mv.c                  | 239 +++++++++++++++++++++++++---------
 t/t7002-mv-sparse-checkout.sh |  84 ++++++++++++
 2 files changed, 259 insertions(+), 64 deletions(-)

Range-diff against v3:
1:  574cbdfdb4 ! 1:  90c38f479b t7002: add tests for moving out-of-cone file/directory
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
     +	test_when_finished "cleanup_sparse_checkout" &&
     +	setup_sparse_checkout &&
     +
    -+	git mv --sparse folder1 sub 1>actual 2>stderr &&
    ++	git mv --sparse folder1 sub 2>stderr &&
     +	test_must_be_empty stderr &&
     +
    -+	git sparse-checkout reapply &&
     +	test_path_is_dir sub/folder1 &&
     +	test_path_is_file sub/folder1/file1
     +'
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
     +	test_when_finished "cleanup_sparse_checkout" &&
     +	setup_sparse_checkout &&
     +
    -+	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
    ++	git mv --sparse folder1/file1 sub 2>stderr &&
     +	test_must_be_empty stderr &&
     +
    -+	git sparse-checkout reapply &&
    -+	! test_path_is_dir sub/folder1 &&
     +	test_path_is_file sub/file1
     +'
     +
7:  6fa630203b ! 2:  c6fcaf8313 mv: update sparsity after moving from out-of-cone to in-cone
    @@ Commit message
         2. The moved cache entry is checked out in the working tree to reflect
            the updated sparsity.
     
    +    Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		assert(pos >= 0);
      		rename_cache_entry_at(pos, dst);
     +
    -+		if (mode & SPARSE) {
    -+			if (path_in_sparse_checkout(dst, &the_index)) {
    -+				int dst_pos;
    ++		if ((mode & SPARSE) &&
    ++		    (path_in_sparse_checkout(dst, &the_index))) {
    ++			int dst_pos;
     +
    -+				dst_pos = cache_name_pos(dst, strlen(dst));
    -+				active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
    ++			dst_pos = cache_name_pos(dst, strlen(dst));
    ++			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
     +
    -+				if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
    -+					die(_("cannot checkout %s"), ce->name);
    -+			}
    ++			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
    ++				die(_("cannot checkout %s"), ce->name);
     +		}
      	}
      
      	if (gitmodules_modified)
    -
    - ## t/t7002-mv-sparse-checkout.sh ##
    -@@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'can move out-of-cone directory with --sparse' '
    - 	git mv --sparse folder1 sub 1>actual 2>stderr &&
    - 	test_must_be_empty stderr &&
    - 
    --	git sparse-checkout reapply &&
    - 	test_path_is_dir sub/folder1 &&
    - 	test_path_is_file sub/folder1/file1
    - '
    -@@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'can move out-of-cone file with --sparse' '
    - 	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
    - 	test_must_be_empty stderr &&
    - 
    --	git sparse-checkout reapply &&
    - 	! test_path_is_dir sub/folder1 &&
    - 	test_path_is_file sub/file1
    - '
    -@@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move sparse file to existing destination' '
    - 	test_cmp expect stderr
    - '
    - 
    --test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
    -+test_expect_success 'move sparse file to existing destination with --force and --sparse' '
    - 	test_when_finished "cleanup_sparse_checkout" &&
    - 	mkdir folder1 &&
    - 	touch folder1/file1 &&
2:  aac267091b ! 3:  aee896a3f2 mv: decouple if/else-if checks using goto
    @@ Commit message
         Refactor to decouple this if/else-if chain by using goto to jump ahead.
     
         Suggested-by: Derrick Stolee <derrickstolee@github.com>
    +    Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
3:  b0e90cfa01 = 4:  82c10486ec mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
4:  c0c9dc9575 ! 5:  59dcf1a55f mv: check if <destination> exists in index to handle overwriting
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'can move out-of-cone file wi
      	test_when_finished "cleanup_sparse_checkout" &&
      	mkdir folder1 &&
      	touch folder1/file1 &&
    +@@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'refuse to move sparse file to existing destination' '
    + 	test_cmp expect stderr
    + '
    + 
    +-test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
    ++test_expect_success 'move sparse file to existing destination with --force and --sparse' '
    + 	test_when_finished "cleanup_sparse_checkout" &&
    + 	mkdir folder1 &&
    + 	touch folder1/file1 &&
5:  3088724e72 ! 6:  b8e3094178 mv: use flags mode for update_mode
    @@ Commit message
         of the file and make it use "flags" mode (each state is a different
         bit in the word).
     
    +    Change the flag assignments from '=' (single assignment) to '|='
    +    (additive). Also change flag evaluation from '==' to '&', etc.
    +
         [1] https://lore.kernel.org/git/22aadea2-9330-aa9e-7b6a-834585189144@github.com/
     
    +    Helped-by: Victoria Dye <vdye@github.com>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
    @@ builtin/mv.c: static const char * const builtin_mv_usage[] = {
     +	WORKING_DIRECTORY = (1 << 1),
     +	INDEX = (1 << 2),
     +	SPARSE = (1 << 3),
    -+	SKIP_WORKTREE_DIR = (1 << 4),
     +};
     +
      #define DUP_BASENAME 1
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		if (show_only)
      			continue;
     -		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
    -+		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
    -+			rename(src, dst) < 0) {
    ++		if (!(mode & (INDEX | SPARSE)) &&
    ++		    rename(src, dst) < 0) {
      			if (ignore_errors)
      				continue;
      			die_errno(_("renaming '%s' failed"), src);
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		}
      
     -		if (mode == WORKING_DIRECTORY)
    -+		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
    ++		if (mode & (WORKING_DIRECTORY))
      			continue;
      
      		pos = cache_name_pos(src, strlen(src));
6:  0c7ba28ddc ! 7:  080f34ee01 mv: add check_dir_in_index() and solve general dir check issue
    @@ Commit message
         instead of "bad source"; also user now can supply a "--sparse" flag so
         this operation can be carried out successfully.
     
    +    Helped-by: Victoria Dye <vdye@github.com>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
    +@@ builtin/mv.c: enum update_mode {
    + 	WORKING_DIRECTORY = (1 << 1),
    + 	INDEX = (1 << 2),
    + 	SPARSE = (1 << 3),
    ++	SKIP_WORKTREE_DIR = (1 << 4),
    + };
    + 
    + #define DUP_BASENAME 1
     @@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
      	return last - first;
      }
    @@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
     + * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
     + * Return 1 otherwise.
     + */
    -+static int check_dir_in_index(const char *name, int namelen)
    ++static int check_dir_in_index(const char *name)
     +{
    -+	int ret = 1;
     +	const char *with_slash = add_slash(name);
    -+	int length = namelen + 1;
    ++	int length = strlen(with_slash);
     +
     +	int pos = cache_name_pos(with_slash, length);
     +	const struct cache_entry *ce;
    @@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
     +	if (pos < 0) {
     +		pos = -pos - 1;
     +		if (pos >= the_index.cache_nr)
    -+			return ret;
    ++			return 1;
     +		ce = active_cache[pos];
     +		if (strncmp(with_slash, ce->name, length))
    -+			return ret;
    ++			return 1;
     +		if (ce_skip_worktree(ce))
    -+			return ret = 0;
    ++			return 0;
     +	}
    -+	return ret;
    ++	return 1;
     +}
     +
      int cmd_mv(int argc, const char **argv, const char *prefix)
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      			pos = cache_name_pos(src, length);
      			if (pos < 0) {
     +				const char *src_w_slash = add_slash(src);
    -+				if (!check_dir_in_index(src, length) &&
    -+					!path_in_sparse_checkout(src_w_slash, &the_index)) {
    ++				if (!path_in_sparse_checkout(src_w_slash, &the_index) &&
    ++				    !check_dir_in_index(src)) {
     +					modes[i] |= SKIP_WORKTREE_DIR;
     +					goto dir_check;
     +				}
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     +dir_check:
     +		if (S_ISDIR(st.st_mode)) {
      			int j, dst_len, n;
    --			int first = cache_name_pos(src, length), last;
    -+			int first, last;
    -+			first = cache_name_pos(src, length);
    + 			int first = cache_name_pos(src, length), last;
    + 
    +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + 			printf(_("Renaming %s to %s\n"), src, dst);
    + 		if (show_only)
    + 			continue;
    +-		if (!(mode & (INDEX | SPARSE)) &&
    ++		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
    + 		    rename(src, dst) < 0) {
    + 			if (ignore_errors)
    + 				continue;
    +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    + 							      1);
    + 		}
    + 
    +-		if (mode & (WORKING_DIRECTORY))
    ++		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
    + 			continue;
      
    - 			if (first >= 0) {
    - 				prepare_move_submodule(src, first,
    + 		pos = cache_name_pos(src, strlen(src));
     
      ## t/t7002-mv-sparse-checkout.sh ##
     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-skip-worktree sparse path' '

base-commit: ddbc07872e86265dc30aefa5f4d881f762120044
-- 
2.35.1

