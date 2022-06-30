Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29B9C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiF3Xrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiF3Xrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AC45A2D4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v9so769075wrp.7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2nj8LFoD6RF2xoHC5lPEoeVuco7GJmeG1OZTUmyQe8=;
        b=jFZPzyeEuXOy4ibwR+LqSXe20gsicPBQcbh4ibbRv43bGnN0z9FnlveLZkpkFouJu0
         mpgV3dJEGm2+bvkf8Rpt+MsXx71ixKv9LZSqTvKKnH6cQWxpP95gMgK/Lcg5hyqdILkB
         pGmyhh7GnFcfKIz2/Ny4pcooe/1n41oZUT3wmlmrsEBVOlHj473blViWDoQsx9pxKKXk
         2UJRCco1xZszKzi4L9oTsUdNnigIqTe/6cdi2SBaCRs6ORPoqHFd6eZIo/L6A41QcN3d
         WsnRtclMErkF1XkQHcD2jGMUYJiuWE4mfva4dNddYuPBg9GONWcUSv2AefuyITAoiIYE
         1gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2nj8LFoD6RF2xoHC5lPEoeVuco7GJmeG1OZTUmyQe8=;
        b=EacgPdyvRRry0wSndgpyxZnF76+sh/uZRsQuJ8Pt/ERGaGzl2+vAavgLswa58+Fbds
         fa5DR/Qmcp1+imw1ESOjPxemtp8QZHGOd365ioy2h2bmEaGw63hFQfb+Ux0kkPBq98cm
         UEaCXTEVy8nEGBnZ3WbaW84FPGpLAY1xvk/9T9Bs+OfpaTYnIoiA7PMkuLNNJq1OQIQZ
         P78WoW7BXS4XdmpcvekyEFEmhe6fvVvDy5jRTEPRYjL9an6B7h6n0qjQnYpojUlzA9CY
         50thn/QJAFhVTRvlfztheNfIj14OYt3A1f2khNkz1/IOwRKPKsw83a9KTBvmAQMReJNl
         AUFw==
X-Gm-Message-State: AJIora+u7pLCrd8cVEaNLCipdCeHmLJ9crfbc0q3fRqzhAnCdtwjl2jO
        dJebCRFStjEyiskaxEn4no56J6gIMONLWQ==
X-Google-Smtp-Source: AGRyM1szO6ehbdQkOqddExtJyuaHnKSHD+0++pzpGcKIjRM7N5P/oCxt2zDJBjsQ4/Z3saSv9dfMdA==
X-Received: by 2002:a05:6000:156b:b0:21b:cc89:f792 with SMTP id 11-20020a056000156b00b0021bcc89f792mr10204853wrz.421.1656632842650;
        Thu, 30 Jun 2022 16:47:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/9] test-tool bloom: fix a memory leak
Date:   Fri,  1 Jul 2022 01:47:07 +0200
Message-Id: <patch-7.9-bdb467d1414-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks introduced with these tests in f1294eaf7fb (bloom.c:
introduce core Bloom filter constructs, 2020-03-30), as a result we
can mark almost the entirety of t0095-bloom.sh as passing with
SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true", there's still an
unrelated memory leak in "git commit" in one of the tests, let's skip
that one under SANITIZE_LEAK for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-bloom.c | 2 ++
 t/t0095-bloom.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index ad3ef1cd77a..6c900ca6684 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -16,6 +16,7 @@ static void add_string_to_filter(const char *data, struct bloom_filter *filter)
 		}
 		printf("\n");
 		add_key_to_filter(&key, filter, &settings);
+		clear_bloom_key(&key);
 }
 
 static void print_bloom_filter(struct bloom_filter *filter) {
@@ -80,6 +81,7 @@ int cmd__bloom(int argc, const char **argv)
 		}
 
 		print_bloom_filter(&filter);
+		free(filter.data);
 	}
 
 	if (!strcmp(argv[1], "get_filter_for_commit")) {
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 5945973552a..daeb4a5e3e7 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -67,7 +67,7 @@ test_expect_success 'compute bloom key for test string 2' '
 	test_cmp expect actual
 '
 
-test_expect_success 'get bloom filters for commit with no changes' '
+test_expect_success !SANITIZE_LEAK 'get bloom filters for commit with no changes' '
 	git init &&
 	git commit --allow-empty -m "c0" &&
 	cat >expect <<-\EOF &&
-- 
2.37.0.874.g7d3439f13c4

