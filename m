Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87EC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbhLGUFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbhLGUFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:05:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD51DC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:02:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t18so16973wrg.11
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8n49IrCinbvTdGsbFNvzcILsfe/9BYZoqmc6kar9Ivg=;
        b=BvJj9qBWdpxBvaBJB73b30gSPfa6zWEHhTPBC+ASW7TdgQs2BlDOi/EkDqLnHgt7iv
         G9zn/krP3P27RKxDOXFDl3NzHgPEKoFmbaLoR+oNuDsrAzvbDLLvZ5tm2zo3kBdIKuJc
         uwVjkAHseWKrette0R0xQUlYNYHiy3Ebu7TDepN6CKSrDAFOX4TLsb+9jJm3IClpI6J9
         vd8f+rqswh5Hf1f81H6/VtAuDYu40oYFNEmI3/heXkg/pzLSp8KpIrvQRupS/b/J/FZL
         k2uaf73383oj0zDafOlwpU4akiLMdzhfdRsxFUH/NGMde7GLzn6GYZ6aW/YOXJ3ScPJN
         5m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8n49IrCinbvTdGsbFNvzcILsfe/9BYZoqmc6kar9Ivg=;
        b=J1fbmcsJsDYGT+waLdB3my3cZDJsIblSEDdH6dzJDOtMuz73sp551yS3a0ttFDQ7Tu
         uSoEvA3AwBh1H/XB0hFYw41OsdjIFiQasML0Q1GQNlDF5Y5AfT6lVN/WWdJfHSJRKBad
         lk7+Bsc7SmzoyXqWowmuu1Cnc43M0Tudh5+VnGFx/EKkv15c0YIsxpuKMVW8+JDfd4I3
         STqGP+ZPMjmWlt8KSy6uTv/urJDopTrzRFaefqCsuZo2bfEKuWarYx8JesTxjRV0vK4Y
         Reoin7skQ7SkYl6TLHpx9ruWKDrwMficn8Oc5nGuljRlL6H6M37hwYW5yExuZ4PPZ/Km
         PKJg==
X-Gm-Message-State: AOAM530QeIpTOrQWr29g9sNKdQm9H2SShiGO2Rb8N45V2fvbLO8TR6rn
        sX0Nr9MlSjRkbC+OPkfdkeG3AxBDxHw=
X-Google-Smtp-Source: ABdhPJx0J2Hsshq1RqGPV0ffL5D8YtmPEqlhnPY3FPNVKkxQJlukKimaBCm3l+e7cNWKahurXKZbcg==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr53461081wrr.444.1638907339373;
        Tue, 07 Dec 2021 12:02:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm549793wme.39.2021.12.07.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:02:19 -0800 (PST)
Message-Id: <239bf23eacb7dbf7b0659b483709dc4579d43b1a.1638907336.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:02:15 +0000
Subject: [PATCH 2/3] sparse-checkout: fix OOM error with mixed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a test to t1091-sparse-checkout-builtin.sh that would result in an
infinite loop and out-of-memory error before this change. The issue
relies on having non-cone-mode patterns while trying to modify the
patterns in cone-mode.

The fix is simple, allowing us to break from the loop when the input
path does not contain a slash, as the "dir" pattern we added does not.

This is only a fix to the critical out-of-memory error. A better
response to such a strange state will follow in a later change.

Reported-by: Calbabreaker <calbabreaker@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  2 +-
 t/t1091-sparse-checkout-builtin.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d0f5c4702be..9ccdcde9832 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -483,7 +483,7 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 		char *oldpattern = e->pattern;
 		size_t newlen;
 
-		if (slash == e->pattern)
+		if (!slash || slash == e->pattern)
 			break;
 
 		newlen = slash - e->pattern;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index c72b8ee2e7b..67ce24c9c83 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -103,6 +103,17 @@ test_expect_success 'clone --sparse' '
 	check_files clone a
 '
 
+test_expect_success 'switching to cone mode with non-cone mode patterns' '
+	git init bad-patterns &&
+	(
+		cd bad-patterns &&
+		git sparse-checkout init &&
+		git sparse-checkout add dir &&
+		git config core.sparseCheckoutCone true &&
+		git sparse-checkout add dir
+	)
+'
+
 test_expect_success 'interaction with clone --no-checkout (unborn index)' '
 	git clone --no-checkout "file://$(pwd)/repo" clone_no_checkout &&
 	git -C clone_no_checkout sparse-checkout init --cone &&
-- 
gitgitgadget

