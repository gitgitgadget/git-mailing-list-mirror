Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EF6C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 05:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCJFAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 00:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCJFAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 00:00:43 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B33E682F
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 21:00:42 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id f14so1610169iow.5
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 21:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678424441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5ZGT3fTEdPbZ5yXeC1QyBWNxTTiLPsiCTP77sXSdIk=;
        b=WjVGbdh7mpY4c1lc4lGqUtkuRgz2QnVRawperKp1YOEiOwTVBeeoeNfiWvU4CutzMu
         zrrmcCF/RfrLtnXStD7rHsOVhIbVjDErV1Q8JS6ty4DsmC5bcSXMXDcsT3Vado3GVezq
         BHo5BqrnOgm1G5SOcI8CPeMIf5Un66Kha8Xm44gZU8a7T2issK1RJE139qYzPuRs0r/3
         j0GxZLTm22X9m4QrVQ02HiKfzwyL1B8tmPsFEW3dSpq+bqYiRKSnVFkscpDv/ign1usB
         A2kJVx0mbehibHcr41dZwX5hUmzSOQ85i2ozgS5Gdd7QdFD29s34VuhsU48M+qQWJoWw
         aiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678424441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5ZGT3fTEdPbZ5yXeC1QyBWNxTTiLPsiCTP77sXSdIk=;
        b=LZsbjGjm6E0DsTX34wx3H58ZfZKp1x63bhF35HzVo8nkmMB0Aq15yWD2wesxlU4gWt
         nx+oec9uuWDPP0+oq+1EQxlJ/DaXNLuhMuZ+ykDyNrsnxPlHAPwmkrZEffGXT9zPZItb
         IbBCcfFpjEGfwToAV23fOagz789qsAEWbfmTThfsVa4Vn5cqbP86BB7El80cQ3916kIL
         YXoOWSThxxb7lqOraJMdft0Bm9exIlgoSA36v2Tme5uw2vtECmWqxy4Oq71QZIwjQqnO
         mf8wo3BWWf7vSt+6JpeYvhUVFDimLe7pIVkVRB7Cx8wqGsmukUcoc2afVCK1hP6sFJ5J
         pifw==
X-Gm-Message-State: AO0yUKUlm2vCzmwpzs3vJTDfbQnxJvv8py0+CCZcuDb2/fdtHwfjQmfl
        6IltlFlusZAVy92X0TX1OGRpvb5H2co=
X-Google-Smtp-Source: AK7set+2U/MyZ6JQXXgSIh0XVvqro+mv7EKXI0UQxad7BUFZOwIuIbp3LmURwqiXXKM3+Sgb568D1A==
X-Received: by 2002:a5d:9718:0:b0:74d:36ce:d68a with SMTP id h24-20020a5d9718000000b0074d36ced68amr853125iol.0.1678424441130;
        Thu, 09 Mar 2023 21:00:41 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id c4-20020a6bfd04000000b00734ac8a5ef7sm323930ioi.25.2023.03.09.21.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 21:00:40 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v5 2/2] diff-files: integrate with sparse index
Date:   Fri, 10 Mar 2023 00:00:21 -0500
Message-Id: <20230310050021.123769-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230310050021.123769-1-cheskaqiqi@gmail.com>
References: <20230309063952.42362-1-cheskaqiqi@gmail.com>
 <20230310050021.123769-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove full index requirement for `git diff-files`
and test to ensure the index is not expanded in `git diff-files`.

The `p2000` tests demonstrate a ~96% execution time reduction for 'git
diff-files' and a ~97% execution time reduction for 'git diff-files'
for a file using a sparse index:

Test                                           before  after
-----------------------------------------------------------------
2000.78: git diff-files (full-v3)              0.09    0.08 -11.1%
2000.79: git diff-files (full-v4)              0.09    0.09 +0.0%
2000.80: git diff-files (sparse-v3)            0.52    0.02 -96.2%
2000.81: git diff-files (sparse-v4)            0.51    0.02 -96.1%
2000.82: git diff-files f2/f4/a (full-v3)      0.06    0.07 +16.7%
2000.83: git diff-files f2/f4/a (full-v4)      0.08    0.08 +0.0%
2000.84: git diff-files f2/f4/a (sparse-v3)    0.46    0.01 -97.8%
2000.85: git diff-files f2/f4/a (sparse-v4)    0.51    0.02 -96.1%

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/diff-files.c                     |  4 ++++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index dc991f753b..360464e6ef 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -27,6 +27,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		usage(diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..82751f2ca3 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -125,5 +125,7 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git diff-files
+test_perf_on_all git diff-files $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9b71d7f5f9..4f582164a3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2103,4 +2103,17 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
 	test_cmp expect sparse-checkout-out
 '
 
+test_expect_success 'sparse index is not expanded: diff-files' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	ensure_not_expanded diff-files  &&
+	ensure_not_expanded diff-files deep/a 
+'
+
 test_done
-- 
2.39.0

