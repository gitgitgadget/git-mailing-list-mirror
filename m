Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27CEEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 23:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGRX34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGRX3x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 19:29:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C7ED
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:51 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-765a1690003so518684985a.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689722990; x=1692314990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXnE2UsfMNMUv58oOl7znKhbhrsCjg+Xz7ZnoFtwW84=;
        b=ERxQFK0mbnqmgmOXpOlVbYgwn6+SEuCN/HtJqlPALyWYP5gUelK0Vs1Mubwxmdyj82
         MwzjZ/b/AVPq5DaE7ntJJunWvD0xcYkmnvm/PJZv2+Atf3zhz6ZJPBu6+mJaOdba8eqn
         0HNFwAH4iuYj1ZPwiKYvTqIpjo/WXS9Z9LWol37eHgx3Z4UnXiBk8U+CRHHGkYU0UmeI
         GXuA1/AJciBwbh6aPtEat5CBNMf1c9xmKE5o8gBXIm78Sumy+ZOXszfdrwSwLEWWiVuz
         D3uAwULcfP6OFYEOAwYDB7AQ7QXIpjoKt51XQlyoU9u79uzj3ir+1ML3XfibNVlyH0K7
         DsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722990; x=1692314990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXnE2UsfMNMUv58oOl7znKhbhrsCjg+Xz7ZnoFtwW84=;
        b=gactI+Zfp1VENHRTqL0jI+oZkhz8cZCMDE0rKZwjyOfrUrbTU5hWFCiup8wUKmmOZw
         IWp8vC3kmkB1OtGLLxW4pmEShqvFbvAbxIILP7vmaHgQ9IUak/yD9i34ABaaX6Z0Npwl
         L7UreDT0SJu+DJid+p+DVgjqEknMwLro2+9Nb0T1aXH7tAf1VHdYH1cdf8rwlFwrZErK
         Vo/MmuhHIZhYkOTLnG2dkSP4VuQLoEkdDEr+h3eH1CAdJLnZVyWzcN47J1RlConVaI9D
         hREAOCZzARS5TByoGz1IJKES/eJgnLdAUgxyyO2kRvKxN4tRe74/Xy6S3XyNyhqR/EjY
         amCg==
X-Gm-Message-State: ABy/qLY4UjQVWp+fmQeaAm7/pcUGnTczccjWDwtfLfOvC5exEDVi1MJ2
        gXbKqERThBDq0YGOu+SZrPeWNnp/T384sQ==
X-Google-Smtp-Source: APBJJlHqABMx6YSvywFucw7U68EN1mZjNeSXeisQvTq8YMGCI4QNZ07gQzihu180+j9RQBmiMp6Htg==
X-Received: by 2002:a05:620a:1b98:b0:768:2386:966 with SMTP id dv24-20020a05620a1b9800b0076823860966mr662638qkb.48.1689722990371;
        Tue, 18 Jul 2023 16:29:50 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id h18-20020a0cf212000000b0063640486254sm1057695qvk.116.2023.07.18.16.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:29:50 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v4 3/3] check-attr: integrate with sparse-index
Date:   Tue, 18 Jul 2023 19:29:16 -0400
Message-Id: <20230718232916.31660-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230718232916.31660-1-cheskaqiqi@gmail.com>
References: <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the requires-full-index to false for "check-attr".

Add a test to ensure that the index is not expanded whether the files
are outside or inside the sparse-checkout cone when the sparse index is
enabled.

The `p2000` tests demonstrate a ~63% execution time reduction for
'git check-attr' using a sparse index.

Test                                            before  after
-----------------------------------------------------------------------
2000.106: git check-attr -a f2/f4/a (full-v3)    0.05   0.05 +0.0%
2000.107: git check-attr -a f2/f4/a (full-v4)    0.05   0.05 +0.0%
2000.108: git check-attr -a f2/f4/a (sparse-v3)  0.04   0.02 -50.0%
2000.109: git check-attr -a f2/f4/a (sparse-v4)  0.04   0.01 -75.0%

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/check-attr.c                     |  3 +++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index b22ff748c3..c1da1d184e 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -122,6 +122,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (repo_read_index(the_repository) < 0) {
 		die("invalid cache");
 	}
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 96ed3e1d69..39e92b0841 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -134,5 +134,6 @@ test_perf_on_all git diff-files -- $SPARSE_CONE/a
 test_perf_on_all git diff-tree HEAD
 test_perf_on_all git diff-tree HEAD -- $SPARSE_CONE/a
 test_perf_on_all "git worktree add ../temp && git worktree remove ../temp"
+test_perf_on_all git check-attr -a -- $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 3f32c1f972..125b205b0d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2307,4 +2307,19 @@ test_expect_success 'diff --check with pathspec outside sparse definition' '
 	test_all_match test_must_fail git diff --check -- folder1/a
 '
 
+test_expect_success 'sparse-index is not expanded: check-attr' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	mkdir ./sparse-index/folder1 &&
+	cp ./sparse-index/a ./sparse-index/folder1/a &&
+	cp .gitattributes ./sparse-index/deep &&
+	cp .gitattributes ./sparse-index/folder1 &&
+
+	git -C sparse-index add deep/.gitattributes &&
+	git -C sparse-index add --sparse  folder1/.gitattributes &&
+	ensure_not_expanded check-attr -a --cached -- deep/a &&
+	ensure_not_expanded check-attr -a --cached -- folder1/a
+'
+
 test_done
-- 
2.39.0

