Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9860DECAAD8
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 04:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiIAE7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 00:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiIAE7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 00:59:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF1114C6A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 21:59:04 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a15so12437577qko.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 21:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=inumtH4PqEjgPNLVBXUM+xaHlJT/IZQZ243OG+t0yDw=;
        b=eOLZNnrOCAonrfWfUneTqgjzqryb6DFDu2m3oF0rHciro0/ApfJdHN49OLCE/o1O5W
         7FSMihusBtesdp0jy7rxymtlG0FRzTezVhEYCsmditkxPjfehixTQk3Jx5ifTbViejTm
         WU/8b94WCpDvXft2OZDPBNNZfy4i3/vi41b0K2yeX9X9BAafpPajFDR7PKHRlCK9r/hs
         y/cIKfL8JE0qKipl5aUgw5YH6jhuADQ1r7XKvSF6mE3TwZeCpU9hJ4HD5zYdu9qqMJ/M
         CP7KgNr9y4wMdBAsBhOyDZR3sXFf1L3lM3ObqziaKmP34S1rr6twRhbCZ16F6mL0ct/2
         GPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=inumtH4PqEjgPNLVBXUM+xaHlJT/IZQZ243OG+t0yDw=;
        b=ofS344PL/K8vVWqJFckt/oxpKxoaQ7ejSWfol3/shrEhJvFWcbS2CQvB6Rdyhw+gwu
         q4tYytqNTDBcw6jEVHT+G9YR/KuI7ZpdTA/va+HzsMLNH0+YUYt/8wRJFq2m0Qzc5B0p
         4HCEpPexmpExHYPbE4g2qDnOFdTeg4gU4PLXW74qn5n5tVOF/D2wfBXtZS2VP0R0H0ww
         o8OkBAo8s3iFGNlfBY6wAg3Nil7j2TSSifWwv6HV+l+Ib0Wap8fgYcVIxUWOxYRUCR+c
         MlwAGotB7eiRPWosb+13Sw/8R+aBMNEVA6PYOu5nA1EALVaDGKe7mHjBzABO6q8oCpL8
         gXoA==
X-Gm-Message-State: ACgBeo1e2A1Kj5SwTStEooDS9DRlxcUtux4H50WoY6apYXCoee0igujE
        GHHaPt6G8Ni46hlmXdOT6wXOeoUiFnc=
X-Google-Smtp-Source: AA6agR4dleTrn4vkCaV9/bJ57lHm4nnUxMAL0ALJuuCf3iS20hZcm8eqDO0jjbMf+PSxydxwG9KseA==
X-Received: by 2002:a05:620a:3722:b0:6be:9f84:4c71 with SMTP id de34-20020a05620a372200b006be9f844c71mr6508456qkb.138.1662008343396;
        Wed, 31 Aug 2022 21:59:03 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id i5-20020a375405000000b006bb2f555ba4sm10752245qkb.41.2022.08.31.21.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 21:59:03 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 2/3] builtin/grep.c: integrate with sparse index
Date:   Wed, 31 Aug 2022 21:57:35 -0700
Message-Id: <20220901045736.523371-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn on sparse index and remove ensure_full_index().

Change it to only expand the index when using --sparse.

The p2000 tests do not demonstrate a significant improvement,
because the index read is a small portion of the full process
time, compared to the blob parsing. The times below reflect the
time spent in the "do_read_index" trace region as shown using
GIT_TRACE2_PERF=1.

The tests demonstrate a ~99.4% execution time reduction for
`git grep` using a sparse index.

Test                                  HEAD~        HEAD
-----------------------------------------------------------------------------
git grep --cached bogus (full-v3)     0.019        0.018  (-5.2%)
git grep --cached bogus (full-v4)     0.017        0.016  (-5.8%)
git grep --cached bogus (sparse-v3)   0.29         0.0015 (-99.4%)
git grep --cached bogus (sparse-v4)   0.30         0.0018 (-99.4%)

Optional reading about performance test results
-----------------------------------------------
Notice that because `git-grep` needs to parse blobs in the index, the
index reading time is minuscule comparing to the object parsing time.
And because of this, the p2000 test results cannot clearly reflect the
speedup for index reading: combining with the object parsing time,
the aggregated time difference is extremely close between HEAD~1 and
HEAD.

Hence, the results presenting here are not directly extracted from the
p2000 test results. Instead, to make the performance difference more
visible, the test command is manually ran with GIT_TRACE2_PERF in the
four repos (full-v3, sparse-v3, full-v4, sparse-v4). The numbers here
are then extracted from the time difference between "region_enter" and
"region_leave" of label "do_read_index".

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/grep.c                           | 10 ++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 12abd832fa..a0b4dbc1dc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -522,8 +522,9 @@ static int grep_cache(struct grep_opt *opt,
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(repo->index);
+	if (grep_sparse)
+		ensure_full_index(repo->index);
+
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
@@ -992,6 +993,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
 		git_config_get_bool("grep.fallbacktonoindex", &fallback);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0302e36fd6..63becc3138 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1972,4 +1972,22 @@ test_expect_success 'sparse index is not expanded: rm' '
 	ensure_not_expanded rm -r deep
 '
 
+test_expect_success 'grep with --sparse and --cached' '
+	init_repos &&
+
+	test_all_match git grep --sparse --cached a &&
+	test_all_match git grep --sparse --cached a -- "folder1/*"
+'
+
+test_expect_success 'grep is not expanded' '
+	init_repos &&
+
+	ensure_not_expanded grep a &&
+	ensure_not_expanded grep a -- deep/* &&
+
+	# All files within the folder1/* pathspec are sparse,
+	# so this command does not find any matches
+	ensure_not_expanded ! grep a -- folder1/*
+'
+
 test_done
-- 
2.37.0

