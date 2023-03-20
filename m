Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57300C6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCTUzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCTUzU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:55:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF92596B
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:55:01 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u8so479910ilb.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679345700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvIvVjgAUKqUGq05QEKidI7PXSt991uNTLhtWRXLt80=;
        b=WePVTLjLhDAkS4WeJ7XaKSOjHZ2yXMWRudoOHqhBV7H46HN4Gp5KkgcxjzVLRqr0Zo
         Jl/cl4UwCggx6WX9D/8XUVbBcV0US9FStryFvH3E/O8pEfP49/TgVSHfzvkFXzegsTxq
         h6sPE/XJx6inuz6Y66IYu979KppQisUqyKn3W8leaK73lrHAL0cGnnje00Wp4PyYbfMv
         uMCbXARq4Rrc+0sECldbR33dZNvxpk14Slnn4xu76THf0A5nDCVzXGyd3GFgtWsrC4OD
         si7bCFSFyUsv4neEy99DHZsn6Jr99OMNg4AS5wNRPQTsCprUIJI1fxwJsBbSiBOxeaHF
         jMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvIvVjgAUKqUGq05QEKidI7PXSt991uNTLhtWRXLt80=;
        b=Xc51Zaf3NMdAuSPkTBKEvno+MLBpE0RHqLX9ngn5/q9nqeCNvFElyBzD5rdXSPP7U1
         o2PR2ZizFzTu9lN545WPaa9vUTvLRIiSJp+9spSGOGnlr96YP1K9Tz9P6GdADpeBVBCb
         Z5dsgbmhNywesIiPr4OFGBqxqZQM1gn4YRSGyHjMExPC5V891ROBHiHke+VStyplpL4a
         LQl7RGfrCeULJmM10tFwM22mIgVhvEGbNQZ6G0ztujkFhFWDMQlhi2bcOMiq3LHiyF2N
         IccFiZamkJiORYqvVsUxVCGlNsSBN3DS/7yjNh0oc2Wm1V3VmXGitUx67ewHyRaXRcZt
         j2rw==
X-Gm-Message-State: AO0yUKVssB1wbtjBU5bqOL0Gk38v2B/gwlhkTDlLy0JxbbsjynXt+bT1
        LpcDbPDd0TYFJrhBfuxnpHWq1AGSpg4=
X-Google-Smtp-Source: AK7set8SIKiRbqUKTYvEaD4zc+RI32o3iR6CCRjvaP5yAAWCaC3hff2ZoC4YL+wUE7a3lcHWzk4Kng==
X-Received: by 2002:a05:6e02:80b:b0:322:fcb1:878a with SMTP id u11-20020a056e02080b00b00322fcb1878amr683054ilm.29.1679345700706;
        Mon, 20 Mar 2023 13:55:00 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a16-20020a056e020e1000b00323058c173csm3045610ilk.59.2023.03.20.13.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:55:00 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v6 2/2] diff-files: integrate with sparse index
Date:   Mon, 20 Mar 2023 16:52:41 -0400
Message-Id: <20230320205241.105476-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230320205241.105476-1-cheskaqiqi@gmail.com>
References: <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, diff-files a pathspec that is out-of-cone in a sparse-index
environment, Git dies with "pathspec '<x>' did not match any files",
mainly because it does not expand the index so nothing is matched.
Expand the index when the <pathspec> needs an expanded index, i.e. the
<pathspec> contains wildcard that may need a full-index or the
<pathspec> is simply outside of sparse-checkout definition.

Remove full index requirement for `git diff-files`
and add test to ensure the index only expanded when necessary
in `git diff-files`.

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
 builtin/diff-files.c                     |  8 ++++++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 31 ++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index dc991f753b..d88875aa07 100644
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
 
@@ -80,6 +84,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		result = -1;
 		goto cleanup;
 	}
+
+	if (pathspec_needs_expanded_index(the_repository->index, &rev.diffopt.pathspec))
+		ensure_full_index(the_repository->index);
+		
 	result = run_diff_files(&rev, options);
 	result = diff_result_code(&rev.diffopt, result);
 cleanup:
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
index c1329e2f16..6cbbc51a16 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2097,4 +2097,35 @@ test_expect_failure 'diff-files with pathspec outside sparse definition' '
 	test_all_match git diff-files folder1/a
 '
 
+test_expect_success 'diff-files pathspec expands index when necessary' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+	
+	# pathspec that should expand index
+	! ensure_not_expanded diff-files "*/a" &&
+	test_must_be_empty sparse-index-err &&
+
+	! ensure_not_expanded diff-files "**a" &&
+	test_must_be_empty sparse-index-err
+'
+
+test_expect_success 'sparse index is not expanded: diff-files' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	ensure_not_expanded diff-files &&
+	ensure_not_expanded diff-files deep/a &&
+	ensure_not_expanded diff-files deep/*
+'
+
 test_done
-- 
2.39.0

