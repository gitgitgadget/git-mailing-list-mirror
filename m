Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE982C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiBPIV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:21:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBPIVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:21:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AFF2722F0
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:21:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso3131247wmj.2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vp8BXneei8I55zVUJyy/ocA2E3e9jUq4OV8P3dA7gmY=;
        b=n5obx9BSnMFErXBlSDqtNmW4r8PQuWiV1cmSJ+WrVyHIqmKUB7EKl2lXWcXeb56wJF
         0UV4B8md0CvKD2FJuAyyqxutKNKeHGs8MRx83O2t8UHr8aI8Iz9Z3Jy/byT3+v/dKgE7
         5piUUR+zH1Swp/gJpQeIDTnzYeR6kfKS9mCRbs9fxj/HbNOxLXwO2tUM2gMh/Lt8jDUc
         CHQgxRG0LCl5anZJ0fNeMNrQcxuq+Z1DwlHliKkLp95B/RyISjg2N0IfwZqHigx4Ln02
         ZQ+/Jad368dSIjMTWFnT6BC4J0Wb7aNRrwPQxlSFner4CXNQ8gtodnZ0ABcFNsNXCVjZ
         atGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vp8BXneei8I55zVUJyy/ocA2E3e9jUq4OV8P3dA7gmY=;
        b=0MyeduVgOFPKtvdykX7BuRHh42P3tjdSSBxCR9OgzMwrvBPoFkqlZ5prketJOT1gfT
         poHvGNNaT8ysZETk7/WlLa2UFwAOyu+wyiBcnpN1u7+DyIVxQQha/Omef8FJeLFAhtTX
         nJcDmrcYaYSxLyLsaFoTnkiw71pwguCySvDh9gs05JRLEts1MAuN5AML4V5pMIpkoIqV
         aYjo199+LSEMlfyYuqQq6nEbLs2TWxmfC2cksaDtrd0qD57PgS+u7QEXST7lT2KuKH31
         pNfvV9xELAZTc521P9O7A7ETOFLY0I7P1qM8W6ri9EPUo9u85T2LecKcUfY9bIHf2WF6
         sCRg==
X-Gm-Message-State: AOAM531B3vvG6MIDsLVCAhFm48ytCbM1GW1G7zwXTkqEL4omZ7xq/QmC
        M6dw75YivbywG+pGfflPPlKV0IVIpXTL/A==
X-Google-Smtp-Source: ABdhPJygRP50oJH3tXv6TmDYLGbW6HiHjUlny7y7YVSSNZUFOQpA08TbBvWC9NeuXdeRx1bOCuAoOg==
X-Received: by 2002:a05:600c:4010:b0:346:e0d6:8781 with SMTP id i16-20020a05600c401000b00346e0d68781mr478464wmm.4.1644999671222;
        Wed, 16 Feb 2022 00:21:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2sm17460687wmc.33.2022.02.16.00.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:21:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] commit: use strbuf_release() instead of UNLEAK()
Date:   Wed, 16 Feb 2022 09:21:06 +0100
Message-Id: <patch-2.2-e3e78c9e40b-20220216T081844Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the UNLEAK() added in 0e5bba53af7 (add UNLEAK annotation for
reducing leak false positives, 2017-09-08) to release the memory using
strbuf_release() instead.

The tests being marked as passing with
"TEST_PASSES_SANITIZE_LEAK=true" already passed before due to the
UNLEAK(), but now they really don't leak memory, so let's mark them as
such.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c                 | 4 ++--
 t/t2203-add-intent.sh            | 1 +
 t/t7011-skip-worktree-reading.sh | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 696b3527adf..c38ae2b7656 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1866,7 +1866,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 cleanup:
 	strbuf_release(&author_ident);
-	UNLEAK(err);
-	UNLEAK(sb);
+	strbuf_release(&err);
+	strbuf_release(&sb);
 	return ret;
 }
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index db7ca559986..ebf58db2d18 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -2,6 +2,7 @@
 
 test_description='Intent to add'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'intent to add' '
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 1761a2b1b99..4adac5acd57 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -5,6 +5,7 @@
 
 test_description='skip-worktree bit test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect.full <<EOF
-- 
2.35.1.1028.g2d2d4be19de

