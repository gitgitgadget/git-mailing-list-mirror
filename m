Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C33C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 00:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiIHATu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiIHATo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 20:19:44 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241832C666
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 17:19:43 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1278a61bd57so21647764fac.7
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jOtJ79aFd8RCKOpzHr11un7LMCyqar9A66DYrIrSupY=;
        b=BR7Q4fNgT2aiFTZDfZFALMOIJ+SzCEqELwAMExedUYYrtU6KE/1QhhPlzkl/nBE17C
         pr1HCFR+Zbd50I4bjHIRpECd04HWpyXetBGIN9JTlVvlxUmizjXbj5dNbVPGT59LRyhL
         CACVQ1fIEb/S1vTyl/1e0EPEXHhbGeYCNbChVMgYA8D0vOWlxlerneBuVhcB3/5FjJI6
         JYbJxzHBeCg1YEzyBuHaTRxLbKtID99UQ40Zz+fQsW2llfBqZZ/e0fXKDoLUDXYs9MnQ
         Q+wIpczr+D/SVXMVYlLPZYPccR9dB1y4d/IuExoGDoRMxWmT2adb3qXkKCz00QJXJV0x
         pOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jOtJ79aFd8RCKOpzHr11un7LMCyqar9A66DYrIrSupY=;
        b=AuMiX4OKgQeJbIN5AHB4n5cF05Q5mpmf6dSMeibLAgNx783jNC43t3ac7XRBvsYTF7
         OAUub8zAvdcZuk7AwW9P4clrKxRHPI6cZWrttQXdt3nWQOv+vYagXU82280mQJOyTXci
         SPjTRX67c92bo9LKK/oXDqhnihZjdo09zXMcl2wD/kjHuazly2XcgJU+57gAATfr040N
         SVTnYzQiZ2PFkVtvCudu57xa/CISpZmSyjO8BVKbfjkaHJ6q/KCaTAZv3Cf9bNeq7vvU
         g6ie1/XZDrM5qL7LG3L9oxsnbot+z+MOnidDqqybKsG/ljjw81g6mrwunUrH4umdZoAp
         r9vw==
X-Gm-Message-State: ACgBeo3VxfPKaFWzBv130PXSYwDWXav/5QrsmPwXwyx68gI6Ydt86nEO
        JSsa1kWpqjdH0MSeiIjFByw=
X-Google-Smtp-Source: AA6agR4Q3fkNRwQbB5CDTCroHq4aqemlv9DM8t9J+MMVKDwODvL5jWAnXGD62tfDmYR+w0eTQo74ZA==
X-Received: by 2002:a05:6870:3285:b0:11f:5465:4943 with SMTP id q5-20020a056870328500b0011f54654943mr534691oac.188.1662596382442;
        Wed, 07 Sep 2022 17:19:42 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id j95-20020a9d17e8000000b00638dd127f54sm7662091otj.1.2022.09.07.17.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:19:42 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, vdye@github.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: [PATCH v5 1/3] builtin/grep.c: add --sparse option
Date:   Wed,  7 Sep 2022 17:18:52 -0700
Message-Id: <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --sparse option to `git-grep`.

When the '--cached' option is used with the 'git grep' command, the
search is limited to the blobs found in the index, not in the worktree.
If the user has enabled sparse-checkout, this might present more results
than they would like, since the files outside of the sparse-checkout are
unlikely to be important to them.

Change the default behavior of 'git grep' to focus on the files within
the sparse-checkout definition. To enable the previous behavior, add a
'--sparse' option to 'git grep' that triggers the old behavior that
inspects paths outside of the sparse-checkout definition when paired
with the '--cached' option.

Suggested-by: Victoria Dye <vdye@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 Documentation/git-grep.txt      |  5 ++++-
 builtin/grep.c                  | 10 +++++++++-
 t/t7817-grep-sparse-checkout.sh | 34 +++++++++++++++++++++++++++------
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 58d944bd57..bdd3d5b8a6 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -28,7 +28,7 @@ SYNOPSIS
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--recurse-submodules] [--parent-basename <basename>]
-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached [--sparse] | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -45,6 +45,9 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
+--sparse::
+	Use with --cached. Search outside of sparse-checkout definition.
+
 --no-index::
 	Search files in the current directory that is not managed by Git.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index e6bcdf860c..12abd832fa 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -96,6 +96,8 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
+static int grep_sparse = 0;
+
 static void add_work(struct grep_opt *opt, struct grep_source *gs)
 {
 	if (opt->binary != GREP_BINARY_TEXT)
@@ -525,7 +527,11 @@ static int grep_cache(struct grep_opt *opt,
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-		if (!cached && ce_skip_worktree(ce))
+		/*
+		 * Skip entries with SKIP_WORKTREE unless both --sparse and
+		 * --cached are given.
+		 */
+		if (!(grep_sparse && cached) && ce_skip_worktree(ce))
 			continue;
 
 		strbuf_setlen(&name, name_base_len);
@@ -963,6 +969,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_INTEGER('m', "max-count", &opt.max_count,
 			N_("maximum number of results per file")),
+		OPT_BOOL(0, "sparse", &grep_sparse,
+			 N_("search the contents of files outside the sparse-checkout definition")),
 		OPT_END()
 	};
 	grep_prefix = prefix;
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index eb59564565..a9879cc980 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -118,13 +118,19 @@ test_expect_success 'grep searches unmerged file despite not matching sparsity p
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit' '
+test_expect_success 'grep --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	git grep --cached "text" >actual &&
+	test_cmp expect actual &&
+
 	cat >expect <<-EOF &&
 	a:text
 	b:text
 	dir/c:text
 	EOF
-	git grep --cached "text" >actual &&
+	git grep --cached --sparse "text" >actual &&
 	test_cmp expect actual
 '
 
@@ -143,7 +149,15 @@ test_expect_success 'grep --recurse-submodules honors sparse checkout in submodu
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --recurse-submodules --cached searches entries with the SKIP_WORKTREE bit' '
+test_expect_success 'grep --recurse-submodules --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/B/b:text
+	sub2/a:text
+	EOF
+	git grep --recurse-submodules --cached "text" >actual &&
+	test_cmp expect actual &&
+
 	cat >expect <<-EOF &&
 	a:text
 	b:text
@@ -152,7 +166,7 @@ test_expect_success 'grep --recurse-submodules --cached searches entries with th
 	sub/B/b:text
 	sub2/a:text
 	EOF
-	git grep --recurse-submodules --cached "text" >actual &&
+	git grep --recurse-submodules --cached --sparse "text" >actual &&
 	test_cmp expect actual
 '
 
@@ -166,7 +180,15 @@ test_expect_success 'working tree grep does not search the index with CE_VALID a
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --cached searches index entries with both CE_VALID and SKIP_WORKTREE' '
+test_expect_success 'grep --cached and --sparse searches index entries with both CE_VALID and SKIP_WORKTREE' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	test_when_finished "git update-index --no-assume-unchanged b" &&
+	git update-index --assume-unchanged b &&
+	git grep --cached text >actual &&
+	test_cmp expect actual &&
+
 	cat >expect <<-EOF &&
 	a:text
 	b:text
@@ -174,7 +196,7 @@ test_expect_success 'grep --cached searches index entries with both CE_VALID and
 	EOF
 	test_when_finished "git update-index --no-assume-unchanged b" &&
 	git update-index --assume-unchanged b &&
-	git grep --cached text >actual &&
+	git grep --cached --sparse text >actual &&
 	test_cmp expect actual
 '
 
-- 
2.37.0

