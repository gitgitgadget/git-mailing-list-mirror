Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E5C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiF3SAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiF3SAe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAB82AE37
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o4so24504536wrh.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8qlx5O+l0l0/i1CTDATQMorD1xC/Z/9bWF8zP1ZvK0=;
        b=QEADpllCYc5r7cMAQkoWt8Kfvd6jwsnYUXR0iF96Dq27AQRc6aa1dujkQfyiq+pYO/
         7NtuS0i4iuRfPesCe0S+93LmMdh6vKIva9VQzdzL+EHiyu2F7BLDBDG4nx2eI+xK/80y
         HKFfDcm3CGN3FakxL3b8qNw1wcNkqTYXKQXTvQeV7BWzPQegcJX5n12fQdg33kO1c+Qi
         7uJuHArcRsdHiS4bW90FdXsS3BpqSCxIm5otnIOW2i5wwgY72T0KsSXl7HPvnqqcQBBS
         wT/o5FGugBR37foPVww68BOSw4FLeH2MUzLjLjR2Q/3LEpPA/4TIQ6+y969HTiN7yz40
         eNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8qlx5O+l0l0/i1CTDATQMorD1xC/Z/9bWF8zP1ZvK0=;
        b=QUugs4Sp3Z/35iRm/KzwPwc+AuM/wTDt55FB7L2gCd7Q4uGhLXWfkJDIN2cnMv8nph
         hxfi0X4JhuJkK9a+KYwvlqI3dXLcUf/8HtTt4NzLqDwXaTqZ8+AviBjSa5s0urLGO3Y9
         B3e8T4ycz6BqSFJV2dJdAZ7P55n9zDK7xMzBCtnbcx/xKjxsBmV1qCyzWbcXziZEO/BU
         Z6suDdwc9SVDHtZPFCx4l2iTjW5ki0nvcvJRvQVSVhGkRKI9RyHyDbvyEOvZ8pkEgghZ
         0PML5NexBhWy963ISES8T1bwrS/jX5mJ/e1i8RMpeGOxcXS+hWNbKeKrSJk+CTwt6nCT
         4hng==
X-Gm-Message-State: AJIora+liFQ6mmv7TCjCOLMZs/QefcmHvU+RXL8OVyeR8hpLccXEOKJN
        Cv2d5vCecN+YQk34QUNOcAs2QIl2gEo5uw==
X-Google-Smtp-Source: AGRyM1tiVGOTJ037B7a7vImC6toTH+dfDDarcYrRH2n9EjfURbeG4GgFdQ4TQLnTOsMrNF4k+7OPfA==
X-Received: by 2002:a05:6000:1f05:b0:21b:a1b6:1829 with SMTP id bv5-20020a0560001f0500b0021ba1b61829mr9605682wrb.697.1656612033053;
        Thu, 30 Jun 2022 11:00:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/11] gc: fix a memory leak
Date:   Thu, 30 Jun 2022 20:00:19 +0200
Message-Id: <patch-09.11-b51a275b6b1-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in 41abfe15d95 (maintenance: add
pack-refs task, 2021-02-09), we need to call strvec_clear() on the
"struct strvec" that we initialized.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 021e9256ae2..eeff2b760e0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -168,9 +168,15 @@ struct maintenance_run_opts;
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts)
 {
 	struct strvec pack_refs_cmd = STRVEC_INIT;
+	int ret;
+
 	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
 
-	return run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD);
+	ret = run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD);
+
+	strvec_clear(&pack_refs_cmd);
+
+	return ret;
 }
 
 static int too_many_loose_objects(void)
-- 
2.37.0.874.g7d3439f13c4

