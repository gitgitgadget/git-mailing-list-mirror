Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D540C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 00:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIHATx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiIHATo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 20:19:44 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BE2CDC7
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 17:19:43 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127ba06d03fso16618962fac.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QwxiLJLNI7zY6Q83FGkS3RkpwPiqHH+qBSBQqh0KA3U=;
        b=O5HUIM3o6G/qEx1cIWKfxDUIF3eg7yv4xL0BEtyc2s9pWqgJgnzllG0lLI8h+NLf4B
         SRIcAbgNZKCrJWgl5gd9Jd57Riz2PL3GOGQQ6YwSTdEYyzyUmvimjoFr8cc4Au15/PaN
         CNu/HMrKY827HHNhhbWYPtmLvv+3CCELuFmi5pTXmV2LnpVRPjoC6jb2FHz6j7OQIhnV
         E6DqQgwoe3i5wIv94BvrIjhS+wm62s+s+Pgylb7cPUZPL52lamukLvDhVF1ScjrBjL9F
         XiBatPQr53hFCZ90VtCAMk6HgjOCdYzOLlAsCC3zbzFKz0W8RMsN4uOQw8AF9xr6zvmh
         cjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QwxiLJLNI7zY6Q83FGkS3RkpwPiqHH+qBSBQqh0KA3U=;
        b=bvbI6L6kPfuSxjqzmnA9VSy2lBRNXhBBfcrRHOSBAt4rVFtU68mo8k4v5+N3em0jDU
         w+Tv+YMw5xs4H22exrOLZCWX45u5g1fJGLyXNxD3jfajh47gi5rVkUqgVLwK70h/8y64
         KT9Ls6jAHO6ughtFLRpJhhbemwP2LQRvn6ryfV3PwB+d8lUXC3GsgO+E8he0nJ8sWHm9
         OXPIJ/zozxB57QjOwHJZPYYsn2uynjdWRGHIjPX/wimmJ0aP2wi/KPFv0WkUGG7SEFsl
         mCYe38WN/PLUOECNo5SR2X80ArSJifmh8eZwJShhqQ4AjR3RVbiEWrXQzvm5o7tOWqks
         VifQ==
X-Gm-Message-State: ACgBeo0utJPYjj1yXgC8Li6qnJGJY4ZHLoNjhy0Kh+l5JUpK284I8gSh
        H/AhC5wu67rFi2F/P250+QY=
X-Google-Smtp-Source: AA6agR5oT3hyfvOzeXUWC/0Mij9VXsymP1ycW5hA/IVXXIBM1elPNCGYGbjIoulrNRCC5ldvmCQRtQ==
X-Received: by 2002:a05:6870:f14a:b0:127:9b8d:7ef3 with SMTP id l10-20020a056870f14a00b001279b8d7ef3mr506501oac.200.1662596383311;
        Wed, 07 Sep 2022 17:19:43 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id j95-20020a9d17e8000000b00638dd127f54sm7662091otj.1.2022.09.07.17.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:19:43 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, vdye@github.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: [PATCH v5 2/3] builtin/grep.c: integrate with sparse index
Date:   Wed,  7 Sep 2022 17:18:53 -0700
Message-Id: <20220908001854.206789-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
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

