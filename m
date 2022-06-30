Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D453C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiF3SAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiF3SA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5872A245
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r20so28439960wra.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpZt1MiGqApQZlUCB9tKc4a9Gu1UEEmFOp4kGkjAkik=;
        b=fpxbLUM5O1rYVf8aEC5j/HLYPr3dnXeohe0npkp/gPP4AgDXIEQffzhIcytCSw1DFJ
         IwewSgLarxYhrtXyQEucVNkEzAPCJ0TN3U9k7SnK2TGF3XzO0S9Pd3O4FWceQ1bviXKa
         3x/+rZ7FW3w9YjhZ0Ab9VXfFK6ifXCiAhe3oD0x0wqfdNGWWcI687b5bYuFYXVNLN9+o
         Bdy8npvbL+DzvGhNv9z0xR7POwKBo9LxE0H2XKxR9H0mG14s2q0RsSIyNX+qjmBf7syQ
         rxblRvaWmQookGF4ZzXuGxiISa/VDVUtbJ5bZZGiYdg1PU7nPIl5gBVWsXvyi6u3xVOV
         d/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpZt1MiGqApQZlUCB9tKc4a9Gu1UEEmFOp4kGkjAkik=;
        b=hRp+7fLJBPWMubUnRAZYgiEGz/pSz+u5bpRMI6ZL7SgjtnxkNt2JK7WBvxS351q29I
         X46IAgC92kK77jSnMDtfA+YLCdDh8riEupHU2br6ky2qxusprbr5MjgCGDTi7ijhG3rv
         idxnND/8Uan7z5gGip2MNQ5K4ZAj3R/dejofnNFGmc7w3LDqJ1/b/gGVt1xnF5+M1vlc
         CXc0nzO5Z6C2R+UzsBD5p9By53plXE5k7W3JsBrqkP2tclGP8jxqUDv5t7ZDD0YAOKG0
         fiHltPnY4FWseXOut5NGGmkbtPobqWLnBs/zn4RhGzbNz6OKHnHpMG77JygBBODTOiAF
         vA+A==
X-Gm-Message-State: AJIora9qxwivb2VmAVwUFG0exzanBFHl/qvxk3hXSiTmpioo4iCaarz6
        wTrqNOktY2eIJ1laLcfzjuRDnv+/ouywXQ==
X-Google-Smtp-Source: AGRyM1tlZuPMLTsojvbrQUJBvFk/9DiBD6LhgD/L5rGamrmeMSaSQSCwgzhHlxnH+NiHIHr6B5g7qg==
X-Received: by 2002:a05:6000:696:b0:21b:9219:b26e with SMTP id bo22-20020a056000069600b0021b9219b26emr9793674wrb.272.1656612025332;
        Thu, 30 Jun 2022 11:00:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/11] check-ref-format: fix trivial memory leak
Date:   Thu, 30 Jun 2022 20:00:11 +0200
Message-Id: <patch-01.11-f35cf7c6ee9-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "git check-ref-format" that's been present in the
code in one form or another since 38eedc634bc (git check-ref-format
--print, 2009-10-12), the code got substantially refactored in
cfbe22f03f9 (check-ref-format: handle subcommands in separate
functions, 2010-08-05).

As a result we can mark a test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/check-ref-format.c  | 11 ++++++++---
 t/t1402-check-ref-format.sh |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index bc67d3f0a83..fd0e5f86832 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -57,6 +57,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	int normalize = 0;
 	int flags = 0;
 	const char *refname;
+	char *to_free = NULL;
+	int ret = 1;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
@@ -81,11 +83,14 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 
 	refname = argv[i];
 	if (normalize)
-		refname = collapse_slashes(refname);
+		refname = to_free = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))
-		return 1;
+		goto cleanup;
 	if (normalize)
 		printf("%s\n", refname);
 
-	return 0;
+	ret = 0;
+cleanup:
+	free(to_free);
+	return ret;
 }
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index cabc516ae9a..5ed9d7318e0 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -2,6 +2,7 @@
 
 test_description='Test git check-ref-format'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 valid_ref() {
-- 
2.37.0.874.g7d3439f13c4

