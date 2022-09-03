Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6700CC38145
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 00:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiICAi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 20:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiICAiT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 20:38:19 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94618F94F
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 17:38:18 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11f4e634072so8660219fac.13
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 17:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QwxiLJLNI7zY6Q83FGkS3RkpwPiqHH+qBSBQqh0KA3U=;
        b=HqB6TJFzCq9JzpIe2PZXQ53Kj6lH9fm4PHOzE1qVqzy7YzceCVcU72Lz8IPOJHv3ri
         eljuCt9NJHsh2DuixS9mYLSUppkfRB/lkZ1dWZBdKNk0MVLufa65DUzk9q2vKaoKcwbO
         butIggI46m7frUCguc00NbAZZlP6Qzz5JdWa0Y6SUqmuBNvfaXAUySK80lRuYFqhSjJA
         sQnD4SP6EdTfZC7nOktEe6N2B4Hbj4P50LSuoK572gsgHrKMgkg99XL/TEs/tTiqCY+U
         RjcHQsoQXG1roNCz7DQeYUwEfaEsCmFEEDgsKdDpSxmu3UIPKLk0hZR9otBg3GzTmFCw
         LN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QwxiLJLNI7zY6Q83FGkS3RkpwPiqHH+qBSBQqh0KA3U=;
        b=JtHjf2LBKyAXHy1C7qwihqUrrBn92fT10FTh507wLENhNrwGBjJ2c3rgVEdgUd1bxE
         SON+nImZUvjWd0EhqAPLkmtYjpPx7nFGcdQSwDjkcG3KSWwZAFm/dhndrt/JgmraiVZN
         NAvY/kZCJ6SlG00iM0K7C3I6RTHvpgd0UfxBE2qZN6zVG1xDj0geXd7lQrbthAzOZBQF
         fc/ijsAhTgZ8pde1/oWNaLHcZ1Xf7y5tCp9NtAuApdoyb3nFZhXZ/9oObgQscpaEQY3l
         wcmVx8kfzfB6b6UCFgpVm2zgJo0JCsDz9l0m6qiVibLPelhzpQuNdFpvCq5PYHqXcdxm
         DyNA==
X-Gm-Message-State: ACgBeo1Oonp1nPhtEjgCOLSj4MHIy+T+hpduJGIXcxuKBCLHhy5vuCzs
        zulTMbZNIxm5eOXycLKdIBWCK8fySj8=
X-Google-Smtp-Source: AA6agR5sPM9enqslnhF5LxQ5vS/DPtyKZjlqpV3HS+MC9So61Sf6NuLrj/J8lQbgjdn7Ta3ZiS1Wmg==
X-Received: by 2002:a05:6870:4181:b0:125:72da:9bfd with SMTP id y1-20020a056870418100b0012572da9bfdmr1317759oac.232.1662165497849;
        Fri, 02 Sep 2022 17:38:17 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id n6-20020a4ad626000000b00435785e7b49sm1172472oon.19.2022.09.02.17.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:38:17 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v4 2/3] builtin/grep.c: integrate with sparse index
Date:   Fri,  2 Sep 2022 17:36:22 -0700
Message-Id: <20220903003623.64750-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220903003623.64750-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220903003623.64750-1-shaoxuan.yuan02@gmail.com>
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

Helped-by: Victoria Dye <vdye@github.com>
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

