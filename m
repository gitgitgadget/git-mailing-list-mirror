Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16907EE4992
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379877AbjHRUEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379880AbjHRUE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 16:04:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E82135
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 13:04:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso12804965e9.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692389063; x=1692993863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qQklggrnspSiGTNvYzBMt3qU6UAercejsXOY2pynwiI=;
        b=g1F1RFtV6GKCv3uV2lPiszRPNqfeHudrbX7fo0g29Po0Fub+0rAyQDOhcvR0WXVRZE
         6GCmYpEVjJy/fFq60GmIWBpZ8YaiehcTu7nkTVmSzQ+u0hbcWBc3vNBGKvuYxWpw1Pdm
         yUun36qFF14goAvoLroobOvs9a1WszYYbPHfZGpuANXX4qXTacS2VVw8vF045gD0FW1a
         UhHSgKbm4ZbuKfzMX7RYxgo/45z7vHwuBcFexZ+cNA34ieuAB/YS5L5tfXwsIZpPNS4d
         x2Tn44zHqIp8A3YaYpPoa7HcnEBF5Kn7JSZurmgyYYt9uC9nuClOVUm0g4kMqe+HmXt1
         Q03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692389063; x=1692993863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQklggrnspSiGTNvYzBMt3qU6UAercejsXOY2pynwiI=;
        b=KPh6lrdDhCh7Bbsh9ppJm1gxS00/QwcJKb3SqugoyIjeDNvPjubyIi/eUQzAHxHqGL
         Ys6S8s0rdGhUZv/bM9ZxAMlMYNcWtmhBOGcvtjAHIsQH5B12lFZKKAcBtS7ygLyADMHr
         6Pa0RonuM3aPDiSbg56DHN/94mml37rutbVIMLFCba0EcbX/20qUinFtpRO2XjMn2Niu
         ATcDgk2YduRD25RBvAUfIuyLMX33R1g+I2cypJu5+fH0gopD/RStGeGkBafe3Ry31md4
         ToqFqNqiAxdWTuGnHxTuBrEIhpyUvWE49tOaM2QHHS2a2s8om01KXXoVAvQJgnlhi3Vl
         cz5g==
X-Gm-Message-State: AOJu0YyCtUfDgxdsFq/Z6k32NL24Aa7LJ7rQ9pUmrilJag4sXE1iydlj
        QBVn3M2MFe90jrsGitMSRmW088LgvZs=
X-Google-Smtp-Source: AGHT+IE+Lfsncdxz26oKg4vNdF/cu3nQHIRoDapFCyAn2f4BXELVK7QgSZxatIisQDlHi16BAgUkzQ==
X-Received: by 2002:a7b:cd87:0:b0:3fb:e573:4172 with SMTP id y7-20020a7bcd87000000b003fbe5734172mr138329wmj.31.1692389062592;
        Fri, 18 Aug 2023 13:04:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c028500b003fe505319ffsm7262809wmk.18.2023.08.18.13.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 13:04:22 -0700 (PDT)
Message-ID: <pull.1577.git.1692389061490.gitgitgadget@gmail.com>
From:   "Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Aug 2023 20:04:21 +0000
Subject: [PATCH] This fixes a minor memory leak (detected by LeakSanitizer) in
 git merge.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Backhouse <kevinbackhouse@github.com>,
        Kevin Backhouse <kevinbackhouse@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Backhouse <kevinbackhouse@github.com>

To reproduce (with an ASAN build):

```
mkdir test
cd test
git init
echo x > x.txt
git add .
git commit -m "WIP"
git checkout -b dev
echo y > x.txt
git add .
git commit -m "WIP"
git checkout main
echo z > x.txt
git add .
git commit -m "WIP"
echo a > x.txt
git add .
git merge dev
```

The fix is to call free_commit_list(merge_bases) when an error occurs.

Signed-off-by: Kevin Backhouse <kevinbackhouse@github.com>
---
    This fixes a minor memory leak (detected by LeakSanitizer) in git merge
    
    To reproduce (with an ASAN build):
    
    mkdir test
    cd test
    git init
    echo x > x.txt
    git add .
    git commit -m "WIP"
    git checkout -b dev
    echo y > x.txt
    git add .
    git commit -m "WIP"
    git checkout main
    echo z > x.txt
    git add .
    git commit -m "WIP"
    echo a > x.txt
    git add .
    git merge dev
    
    
    The fix is to call free_commit_list(merge_bases) when an error occurs.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1577%2Fkevinbackhouse%2Ffree-merge-bases-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1577/kevinbackhouse/free-merge-bases-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1577

 merge-ort-wrappers.c | 4 +++-
 merge-ort.c          | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 4acedf3c338..aeb56c9970c 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -54,8 +54,10 @@ int merge_ort_recursive(struct merge_options *opt,
 	struct tree *head = repo_get_commit_tree(opt->repo, side1);
 	struct merge_result tmp;
 
-	if (unclean(opt, head))
+	if (unclean(opt, head)) {
+		free_commit_list(merge_bases);
 		return -1;
+	}
 
 	memset(&tmp, 0, sizeof(tmp));
 	merge_incore_recursive(opt, merge_bases, side1, side2, &tmp);
diff --git a/merge-ort.c b/merge-ort.c
index 8631c997002..a0eb91fb011 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5070,8 +5070,10 @@ static void merge_ort_internal(struct merge_options *opt,
 		opt->branch1 = "Temporary merge branch 1";
 		opt->branch2 = "Temporary merge branch 2";
 		merge_ort_internal(opt, NULL, prev, next, result);
-		if (result->clean < 0)
+		if (result->clean < 0) {
+			free_commit_list(merge_bases);
 			return;
+		}
 		opt->branch1 = saved_b1;
 		opt->branch2 = saved_b2;
 		opt->priv->call_depth--;

base-commit: f9972720e9a405e4f6924a7cde0ed5880687f4d0
-- 
gitgitgadget
