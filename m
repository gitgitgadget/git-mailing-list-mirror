Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A71ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 23:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiH2X3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2X3H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 19:29:07 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991D83BF4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 16:29:06 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l5so7487182qvs.13
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j0cjOcQ+vMiF17X5msejAmkCgE/96Qt1wuz7o/avwHw=;
        b=O8U1r1sp9QezIDOq8NDutg9fR4z9eY+I9MgLeMIRqh1mCJ1z0GVnJh/P0813uDZ7PR
         +TdAjLRweChuSKzthb/APQN9YydyEmb7eyvoVPSh0rBA/PV4ceQb4gkVhhj2nQ40teRN
         Mq3W3Yqe2BhA1jiqKrC6iwOUNyu2gCEY5rCALkr3tu7iXOkPHEdHmHqDKLeCM+iA+ATT
         9xQJQtnwCZKxkfpcgpqtd5ic2TeDQsqnymzaCjtc6UMscrap/ASuUdAKFjgddPEDX0SI
         FpbbvtBUCjefWIc5vY9liQlGSr8ObAtG4s1cnct969AfL821sPqOymE3nGTU9bOth0WX
         Jtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j0cjOcQ+vMiF17X5msejAmkCgE/96Qt1wuz7o/avwHw=;
        b=vGEUVnNcLxQjmLtmDRxhwxAq0QA88EvcSYPS+PgX7kBdJaOBE01/flXrtxIqCy27tP
         octTMw8WeJry4mMMfmwOxwAi4ez+71ztM18Unls/hCRDE0ucBgrsZDtHfMrsS3fOQYSV
         N0brTV0+NzD6lhriwW+5/472V1QU5EA4yj8pI/PkF0czvr7vexuixcXiZDA6qz3wUXLI
         tpNdP9Ll/d/Zh5HA8lUuml0Uunuf6X+ombkKo1kfo40x+etxKdh0iC+5FRNmstdcvOAj
         n73cYcVHGu69aFFcilmlnRX6pB6+Wt38X4BROFD0oUZoQTg94GAmRJ8hsLm5ieFzeUlu
         0xBA==
X-Gm-Message-State: ACgBeo0maNtiquR96iaL+FZDo1C9CAzrxf1swTU3QivloWes9ISWNdcy
        6eNyOKy9ktlRem1ZMYP/mogF0vlbQLEifA==
X-Google-Smtp-Source: AA6agR4C2IphAfUgIX8myfgMcsWJdLKVVLLPeySbrlf10lNDs0kxMs6NYwbosw8Q2u0B1x4Xas4mwg==
X-Received: by 2002:a05:6214:e4d:b0:499:42f:bebd with SMTP id o13-20020a0562140e4d00b00499042fbebdmr5249198qvc.102.1661815744970;
        Mon, 29 Aug 2022 16:29:04 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id l7-20020a05620a28c700b006a793bde241sm6679802qkp.63.2022.08.29.16.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 16:29:04 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 2/2] builtin/grep.c: integrate with sparse index
Date:   Mon, 29 Aug 2022 16:28:43 -0700
Message-Id: <20220829232843.183711-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220829232843.183711-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220829232843.183711-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn on sparse index and remove ensure_full_index().

Change it to only expands the index when using --sparse.

The p2000 tests demonstrate a ~99.4% execution time reduction for
`git grep` using a sparse index.

Test                                  Before       After
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
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

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
index a6a14c8a21..270b47840b 100755
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

