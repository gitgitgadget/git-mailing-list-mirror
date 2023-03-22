Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EFEC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCVQSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCVQSq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:18:46 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268649C7
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:18:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l15so8616405ilv.4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679501918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Doa9IcuIP5f+/qKJeIDd8s3hsl9gxWEWivHxKOMjcuI=;
        b=QYqvqkRNuCfrjC7uy4yTmaGCPVIJ5xlqflUfvXHpa15ky1ch75g/U7a3Z3Hx/HweZC
         2DJmEp/Le9eUuRoA/Tw4XqShXx5Z+jrkmnks8Q3dQVKEfgdV/kGJbUzi842bYgkikc84
         8bHuEhaDYUTJVfoY1FR4TQYhFM7ux8HYkzKGDOwexrLTykpm2ILXH+HyWfzE41BB/11l
         +IeQomzKGzR+HebjEcsuHoIHX7Bj4H/Fl4cyCkLHjzWsMmJxmtlKcaN+QvuonoovXbUq
         8Sk4qpkJfK6Fsqovl2MzudPkKuPVwrEVHKOCtO35KYE0dSWQ+dj5pc84lOAIGZ9y1crV
         ujmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Doa9IcuIP5f+/qKJeIDd8s3hsl9gxWEWivHxKOMjcuI=;
        b=YC9P4FqhE5ODY2WpfaqIeFvvRlOI9AsLClbr4Iduupy6D3ElIOJC8BGWa5KANsZqxc
         cA9YROjkawa0bBhfDlkhz7meLCiFHFhouZtZzKK9av9AUFUPuK233tw0Fx0EB46ee3uj
         DaqDXopWg74GkhucR7QCsy1AoNC5GG3xIuRh873W453eFf1HtScnmyyAh4QKTczMi6lY
         wsrwiyVe/YXTsOOgqmYIgjU4D09rOQn5R6oUrPyVJPZ2BFS9U3niGN1KdCNYgdOwYM0U
         EkOs1d7FNCe+JR5/qsnoC0i/kNygbSURuJ5Zwc94DI5WfUY3XEgkmblHFAJB/0jzwtf0
         c+EQ==
X-Gm-Message-State: AO0yUKVl+zq/Zv3T5gNI0mkCt+rZhq6RejfFd5lTHQZjrndZwJUHRwx3
        WzbLecQCHuLyQ+di1uAcbdLytrNFbao=
X-Google-Smtp-Source: AK7set8lRLSNu1DyVwjVpS23tGCeSFglIJ0gpXmQzJ7hiFgLAucLLsZ19ggtsi/2jSKrE1JMDmfkUQ==
X-Received: by 2002:a92:c641:0:b0:325:a6c5:70fa with SMTP id 1-20020a92c641000000b00325a6c570famr4561277ill.26.1679501918400;
        Wed, 22 Mar 2023 09:18:38 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056e02107200b0032304e1814bsm4460129ilj.40.2023.03.22.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:18:38 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v7 2/2] diff-files: integrate with sparse index
Date:   Wed, 22 Mar 2023 12:18:20 -0400
Message-Id: <20230322161820.3609-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230322161820.3609-1-cheskaqiqi@gmail.com>
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-1-cheskaqiqi@gmail.com>
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

Remove full index requirement for `git diff-files`.Create an
'ensure_expanded' to handle silent failures. Add test to
ensure the index only expanded when necessary in `git diff-files`.

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
 builtin/diff-files.c                     |  8 ++++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 52 ++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index dc991f753b..db90592090 100644
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
index d23041e27a..152f3f752e 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1401,6 +1401,30 @@ ensure_not_expanded () {
 	test_region ! index ensure_full_index trace2.txt
 }
 
+ensure_expanded () {
+	rm -f trace2.txt &&
+	if test -z "$WITHOUT_UNTRACKED_TXT"
+	then
+		echo >>sparse-index/untracked.txt
+	fi &&
+
+	if test "$1" = "!"
+	then
+		shift &&
+		test_must_fail env \
+			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+			git -C sparse-index "$@" \
+			>sparse-index-out \
+			2>sparse-index-error || return 1
+	else
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+			git -C sparse-index "$@" \
+			>sparse-index-out \
+			2>sparse-index-error || return 1
+	fi &&
+	test_region index ensure_full_index trace2.txt
+}
+
 test_expect_success 'sparse-index is not expanded' '
 	init_repos &&
 
@@ -2101,4 +2125,32 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
 	test_all_match git diff-files "folder*/a" 
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
+	ensure_expanded diff-files "*/a" &&
+	ensure_expanded diff-files "**a" 
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

