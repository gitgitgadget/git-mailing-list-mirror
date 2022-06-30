Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF01C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiF3Xrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiF3Xr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383E5725C
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so2681462wmp.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yr6R4Mg1JR6gKO40LGtsMr1zSO4ijoQgry/UrvzvLWc=;
        b=oyHIaWMXJLvAQjYxmG4wxER9lKz/QCI5VoBsv6LecG0lJr4Mqsin3UAOO/LS4yjUEq
         oQSep2C4USTmRNnELuiIpi910OE3dCyBpFd7osuf2KaMX3rbUCf447oQ3i7Du8LtaEl3
         fNkZiNYo0h+gCehUNq/1+nPQ7Je5b3iCQVC63JP4/QbCyiPKHq8FoyACm0WYBK5MLado
         qWawoAgoRxq105NnuoNjbwPaI3GRWyjl84AR2/Y0UuJryxOHfrRsUEu86sROfo/QDj3p
         ymdzizpJoQmwxsx862Bu/NXmLxhe0/xtKfuRcVHEBc1g6Mh1yHvApxVQwmykNdlSwZ99
         AG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yr6R4Mg1JR6gKO40LGtsMr1zSO4ijoQgry/UrvzvLWc=;
        b=BVPqcc6dzdzx8Fln21xl7QM8JOBpwi3sBBbuvjUBC1/RcSxwTZtPdOpzceOgGSDgqa
         wNpdaOr4Ao+SdpdB4BUMott4jMpY6YeDBlPq4GYk20HRLOg88THM1WvHtQWPh7pycNbw
         80m2HINyvu2/Oe+QUHhlCqpf2MnCKPcj/DRv7DNul2seVRlG9Ij0VaHoRjZa/uuhvSf1
         f9r22MvaKLiBxLE/rMFoaStl5pi5qWPHUoSbk9Jq6ujqOqex7I3O2ho5XyxoIIcZlghh
         sFxFvw8d1d+1w/AaKF7Ahfj9H2c3Cb5m7OLQOXJ7gUjynUZCm+RYp8oTheJdk5pVoZ5C
         kW2Q==
X-Gm-Message-State: AJIora97nZCnTkFFpLNI4TF5RGZdci0VUYMmGtzxdyYtU+CqF/57q6+W
        b+c5stGhI2svncgNeV7+F4OKtbv+Ml5f5w==
X-Google-Smtp-Source: AGRyM1torezxlJ1I7M1DcdX8FQFyaEIFevM5Z2OXl70d5WO479rean7xHuvwL0rKLNopCZjC4WZ/4g==
X-Received: by 2002:a1c:720f:0:b0:3a0:2ac9:5231 with SMTP id n15-20020a1c720f000000b003a02ac95231mr12948791wmc.39.1656632837565;
        Thu, 30 Jun 2022 16:47:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/9] test-tool test-hash: fix a memory leak
Date:   Fri,  1 Jul 2022 01:47:01 +0200
Message-Id: <patch-1.9-4406fedba80-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "test-tool test-hash" which has been there since
b57cbbf8a86 (test-sha1: test hashing large buffer, 2006-06-24), as a
result we can mark more tests as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-hash.c              | 1 +
 t/t0015-hash.sh                   | 3 ++-
 t/t5308-pack-detect-duplicates.sh | 2 ++
 t/t5309-pack-delta-cycles.sh      | 2 ++
 t/t5321-pack-large-objects.sh     | 2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 261c545b9d1..5860dab0ffa 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -54,5 +54,6 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 		fwrite(hash, 1, algop->rawsz, stdout);
 	else
 		puts(hash_to_hex_algop(hash, algop));
+	free(buffer);
 	return 0;
 }
diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
index 086822fc45b..0a087a1983d 100755
--- a/t/t0015-hash.sh
+++ b/t/t0015-hash.sh
@@ -1,8 +1,9 @@
 #!/bin/sh
 
 test_description='test basic hash implementation'
-. ./test-lib.sh
 
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
 
 test_expect_success 'test basic SHA-1 hash values' '
 	test-tool sha1 </dev/null >actual &&
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 693b2411c89..655cafa0541 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='handling of duplicate objects in incoming packfiles'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 55b787630fc..4e910c5b9d2 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test index-pack handling of delta cycles in packfiles'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
index 8a56d98a0e8..70770fe274d 100755
--- a/t/t5321-pack-large-objects.sh
+++ b/t/t5321-pack-large-objects.sh
@@ -6,6 +6,8 @@
 test_description='git pack-object with "large" deltas
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
-- 
2.37.0.874.g7d3439f13c4

