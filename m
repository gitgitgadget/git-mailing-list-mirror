Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C0C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 23:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiAaXXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiAaXXX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 18:23:23 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1536FC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 15:23:23 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id o10so13680610qkg.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 15:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVpc4FKTXxrNtp4lK1ATKN9JqcgVPp/Srm5E59C1amU=;
        b=Sh9Ye1RUh3F3/Yh+GfiRDvhtFQr47gB1/TqFVGY0+m2YtjAhKmc2ZHXMbu5CJRQvoP
         4Mab20/kNbzbJSgZnjglrGPdxwbWU+s0Gl6ReDVF4pTfWQvTPlzFvzRqLEFAIwIHU18v
         vKCSO7FaBgV+FPQK/QaseoX+boZcyLSiQ7Q18Qo9vCh8mXawOXR6cGdIYuCwIuLwBq2F
         dfYtqIj2ZUgs7q/761b68VRBljuLJRaayZxbO+hSiCDBMZjLYwpmHBlRnfF4JJQWWWcd
         EBQaZV2wKJ0QoqCui6XYqlpYTSygGXW4041YWd14OIWkTQsiNoIeAjgOXf3qn+8l8m/L
         oFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVpc4FKTXxrNtp4lK1ATKN9JqcgVPp/Srm5E59C1amU=;
        b=Oc1XbQVMGJxV0DpdEfcFK5cv3qDEGEsYcgsP4B4AP4paTGMdfVdqLSWsfDwHNYU8+K
         FMDjWM2l/Ju+s0rqm6rbeR6TGQLHJJHU4mqn/jz4JPpcN6wRPuDpVAYSo1PGIm56pNZq
         e8ptsweW4v37PcWszKWzc6o+scEID2/NTsnrp7zWE+iq/Zq6Or1uNn3PpfM94Iq5FJ1R
         RYTbauBTGs4AyuN9sbLP/VrHh2pxMQlS5c7IvP9zJQW9NK0lSl8gcrw8IDQuCr6AntJT
         zf1lZpD7C0OF+fabhqChGYCnlnB3AagqDRY8qSXyhVVphJlLLq/DvmkXkVP+HG39TKEy
         DC/Q==
X-Gm-Message-State: AOAM531LN7A6TfbYtMxSyw8+VAZLW8/arYtZaGgJiLC/wamZRn/eBqIy
        5yiOkcvWzvayyPsww9MXchayiPJ5AFl6nw==
X-Google-Smtp-Source: ABdhPJwdqLgVLVCfRpOv5IWcSTm7be6UfAWPx2PbdK5owImEHKD9k+Gd12+yQwdbGD8aLjfgz5jEiw==
X-Received: by 2002:a05:620a:8cd:: with SMTP id z13mr14754807qkz.487.1643671401852;
        Mon, 31 Jan 2022 15:23:21 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id t18sm3428936qta.90.2022.01.31.15.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:23:21 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH 1/2] format-patch: Fix antipatterns in tests
Date:   Mon, 31 Jan 2022 15:23:17 -0800
Message-Id: <20220131232318.8248-1-jerry@skydio.com>
X-Mailer: git-send-email 2.35.1.6.g61799e0acb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up the tests for format-patch by moving file preparation
tasks inside the test body and redirecting files directly into
stdin instead of using 'cat'.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 t/t4204-patch-id.sh | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 80f4a65b28..da60f5b472 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -164,42 +164,40 @@ test_expect_success 'patch-id respects config from subdir' '
 		cd subdir &&
 		test_patch_id irrelevant patchid.stable=true
 	)
 '
 
-cat >nonl <<\EOF
-diff --git i/a w/a
-index e69de29..2e65efe 100644
---- i/a
-+++ w/a
-@@ -0,0 +1 @@
-+a
-\ No newline at end of file
-diff --git i/b w/b
-index e69de29..6178079 100644
---- i/b
-+++ w/b
-@@ -0,0 +1 @@
-+b
-EOF
-
-cat >withnl <<\EOF
-diff --git i/a w/a
-index e69de29..7898192 100644
---- i/a
-+++ w/a
-@@ -0,0 +1 @@
-+a
-diff --git i/b w/b
-index e69de29..6178079 100644
---- i/b
-+++ w/b
-@@ -0,0 +1 @@
-+b
-EOF
-
 test_expect_success 'patch-id handles no-nl-at-eof markers' '
-	cat nonl | calc_patch_id nonl &&
-	cat withnl | calc_patch_id withnl &&
+	cat >nonl <<-EOF &&
+	diff --git i/a w/a
+	index e69de29..2e65efe 100644
+	--- i/a
+	+++ w/a
+	@@ -0,0 +1 @@
+	+a
+	\ No newline at end of file
+	diff --git i/b w/b
+	index e69de29..6178079 100644
+	--- i/b
+	+++ w/b
+	@@ -0,0 +1 @@
+	+b
+	EOF
+	cat >withnl <<-EOF &&
+	diff --git i/a w/a
+	index e69de29..7898192 100644
+	--- i/a
+	+++ w/a
+	@@ -0,0 +1 @@
+	+a
+	diff --git i/b w/b
+	index e69de29..6178079 100644
+	--- i/b
+	+++ w/b
+	@@ -0,0 +1 @@
+	+b
+	EOF
+	calc_patch_id nonl <nonl &&
+	calc_patch_id withnl <withnl &&
 	test_cmp patch-id_nonl patch-id_withnl
 '
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc

