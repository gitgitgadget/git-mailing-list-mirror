Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A718FC32772
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 07:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiHQH4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiHQH4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 03:56:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F77AC12
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 00:56:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y141so11422398pfb.7
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qYBrB4jLuUxPzbc3+mtn4VAgHbWngMrMeBT/rB9xb9U=;
        b=MpTqlLiIJ2C2MnwNqk0Dhei3ll7MtyVlNUn8mgF67nEYlXpmzcKhfg6uALMDRVrnyq
         bjBJ9h0gyoPj2Pn473ZYnT3MLdZDAikuNJoWbojZIMNqkmVRCVP7A7H8ylciFKTh1+tP
         J+27zP8wFiH56tMjx9u8Icwvj7SKptsS3bbVFluIi/Kzs3sqqaQmls2Dpb8QGmqSCyCn
         T5wGsqV9FwgGnMJHQl0CnSPVh4qrApNIn6TgUp7scwRlwHJ3JMIJP3+32B8rGSNzouUe
         IzTp1YyjRIjZSGx5A2NLvks+JwQGV2TVas4AIHLo4p+/3MY9z64OZhawsZvFektHkp4w
         k4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qYBrB4jLuUxPzbc3+mtn4VAgHbWngMrMeBT/rB9xb9U=;
        b=y3F18toYPGIWL6JctcOrRh5JeJPh4HM2LTMo/tsoLtWzMoMbVqDCYIfkVe/6nu2TPr
         jtcp8duVUwySht8CoEuFbOmKZaA1dZppOOZu+EqwEcGDyd8Awtmanx3vPTeeXU91Owae
         cVSEqBP502kO42UuTaUNFlJrro1zmRj4vsa8pNHh4ggGzQG+Ba/tcXlQaWjwIZf0n9fq
         PMdISvHUYqVY9AE6H9g0OBG2a9jAOGcfk7dk9qHncqgJ77qLj6AActX6Ut5k8WB22/3G
         hTwelV4juoc9mHngI4qTNi6kHwrdsyLO3G+vGL63Zjap/bepdUJc7vAnaz72m4DUr2zS
         A0nA==
X-Gm-Message-State: ACgBeo3/jZjqBasXsTN2/m2rgQdnkOSDfN2ukEUuCNMU9QawcLnfMx1o
        vclG5M4+Jg5/iPE38pPF7k7xoqhpKM5aFA==
X-Google-Smtp-Source: AA6agR5CG8gIqb+x3C618fSW4G9HCpq/cBAv+ZVTnzzgs+gwOAGYgix6tpFnAoB7bkvt49OLngHMCw==
X-Received: by 2002:a05:6a00:1ac6:b0:52f:55f8:c3d3 with SMTP id f6-20020a056a001ac600b0052f55f8c3d3mr24444651pfv.76.1660723006559;
        Wed, 17 Aug 2022 00:56:46 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.228.141])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b0016d1b708729sm743532plg.132.2022.08.17.00.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:56:46 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 2/2] builtin/grep.c: integrate with sparse index
Date:   Wed, 17 Aug 2022 15:56:33 +0800
Message-Id: <20220817075633.217934-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn on sparse index and remove ensure_full_index().

Change it to only expands the index when using --sparse.

The p2000 tests demonstrate a ~99.4% execution time reduction for
`git grep` using a sparse index.

Test                                           HEAD~1       HEAD
-----------------------------------------------------------------------------
2000.78: git grep --cached bogus (full-v3)     0.019        0.018  (-5.2%)
2000.79: git grep --cached bogus (full-v4)     0.017        0.016  (-5.8%)
2000.80: git grep --cached bogus (sparse-v3)   0.29         0.0015 (-99.4%)
2000.81: git grep --cached bogus (sparse-v4)   0.30         0.0018 (-99.4%)

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
 builtin/grep.c                           |  8 ++++++--
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 17 +++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 61402e8084..cbaab604fd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -519,11 +519,15 @@ static int grep_cache(struct grep_opt *opt,
 		strbuf_addstr(&name, repo->submodule_prefix);
 	}
 
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
+
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(repo->index);
+	if (grep_sparse)
+		ensure_full_index(repo->index);
+
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index fce8151d41..9a466fcbbe 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -124,5 +124,6 @@ test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
+test_perf_on_all git grep --cached bogus
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a6a14c8a21..a9bb6734f6 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1972,4 +1972,21 @@ test_expect_success 'sparse index is not expanded: rm' '
 	ensure_not_expanded rm -r deep
 '
 
+test_expect_success 'grep expands index using --sparse' '
+	init_repos &&
+
+	# With --sparse and --cached, do not ignore sparse entries and
+	# expand the index.
+	test_all_match git grep --sparse --cached a
+'
+
+test_expect_success 'grep is not expanded' '
+	init_repos &&
+
+	ensure_not_expanded grep a &&
+	ensure_not_expanded grep a -- deep/* &&
+	# grep does not match anything per se, so ! is used
+	ensure_not_expanded ! grep a -- folder1/*
+'
+
 test_done
-- 
2.37.0

