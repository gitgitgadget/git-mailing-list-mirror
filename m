Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD5CEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjGGPTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjGGPTG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 11:19:06 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC2268A
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 08:19:03 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40320e38b64so16466211cf.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688743142; x=1691335142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i587RNCUvdX8WA7bNKetV3Xxs2OD/ioIn1qkvZ84bbQ=;
        b=VjYJUjn26EkBwOtKuiiy2k5rH7imS038PjjOOaOj39qeCcFfOTLGsEG2Qr3BdM7W6k
         1jOgRK7NmOdEeJOSasdSWh1oThGZA0EIpBSAIcDFLAhPwaiFp+7KoUcmoxmqa2edo8uI
         ud9rJ0RQRtxQks8m2fx7FUVXkqKVPIamNr2QMYdsybdPLOb457urbShjmPrUx4+OCE0K
         vctWwidpR1HbIiCYiFz19iHnfx+pO8/8yRinGcbyHZ/a4LPDVgVHXa3Ezqf13q9Z1/rm
         fI+iPt+S+qmRCu+8BkGLg4snLbWtaIzITyw1lSQVH8EFd08h9/CD/1xW139BLIUr4dJo
         cGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688743142; x=1691335142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i587RNCUvdX8WA7bNKetV3Xxs2OD/ioIn1qkvZ84bbQ=;
        b=ROj8DX73D8FNghl+qTMeF+DWisrwu9WF0ratIHRKq2i15KcYLnalz8svw1nRxSuuig
         vTIrWwfQ89rYFgRoWnUOjVF1zSGi9wwG3zBMTFyP0G5NU9ozYJ99mCm0FTulJ7A5NYBy
         kOyGf5WUDNAUWfNAJbXxgdMYDTdQRbneU2gMHgirsO64mGnbEz5UZZWQOgmFIWbdsSX2
         1ML8HZ8y7A/RThMJT33GNz9Zcp4tnmKUn8KSkIMoOgneVEeic3nCjnQQrNxaI/Rb7xDv
         Or6rfeaB/W65UkiOFY6X1fKC0DSsym7CbC4mLhy8YJb3Ztz9jxtJycAtC8h99wQhzVpz
         CH4Q==
X-Gm-Message-State: ABy/qLaQx5VnKYjHZn9QYFhvPLkcKk3oPgsUNVOqCfoY2o12fOQFOK1f
        ow8Iywr4vYnkddfSYV3foK58e74xQj4=
X-Google-Smtp-Source: APBJJlFk7udyXFVXhuoo1gyiIkKaNNAYZ5Pb3M/ux/VDfvZb0LI1WeM8D8s0yAl75dW81P/A+0CeZQ==
X-Received: by 2002:a05:622a:1492:b0:400:9666:4349 with SMTP id t18-20020a05622a149200b0040096664349mr7285771qtx.46.1688743142602;
        Fri, 07 Jul 2023 08:19:02 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id a14-20020aed278e000000b004039e9199cesm338698qtd.60.2023.07.07.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:19:02 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v2 3/3] check-attr: integrate with sparse-index
Date:   Fri,  7 Jul 2023 11:18:39 -0400
Message-Id: <20230707151839.504494-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707151839.504494-1-cheskaqiqi@gmail.com>
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
 <20230707151839.504494-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the requires-full-index to false for "diff-tree".

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
index 839e08d8dd..db2c38ab70 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2299,4 +2299,19 @@ test_expect_success 'check-attr with pathspec outside sparse definition' '
 	test_all_match git check-attr  -a --cached -- folder1/a
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

