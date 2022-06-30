Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A65CC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiF3Xrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiF3Xr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5245A2D5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so750835wrc.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7muzqgj3/G0KE3Mzt8FRH65f+F7vesuU8+ZaO5sh2k4=;
        b=Tj0EvJDnPR+avV0AitNWEmNvBjkcWXYvBHVR74xO2m/Rki9Z8Hiq8dZWSfuSDnSAHH
         9bh0f4HV/LlfYR5NkDN04hQyhEYMfKraiOmMT2I67Wy3Wmvt8R34VHKHa3PBeT1bPIwc
         HpWCFJw+ufse1bBIF/47U4e49+UnEDBBe+/P6OePCJc2VmTnebh+ISD8Dvq/URCdMPsE
         GDcZYfKznx4X2w08dlCRpDLqnfVojPnptjcEMiJQGyfyUJbgPLsP0jEE8dBjEdd9eVWT
         hiP1kICFu/mjpMODIeigzXGSaA9PNNQ3bhW3r1tGm3YtTfUcoQy+UsQovpebsevesPfm
         WhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7muzqgj3/G0KE3Mzt8FRH65f+F7vesuU8+ZaO5sh2k4=;
        b=lgwGsArCIoetk2Hw+PLh6TY58fsU0E3+s3gNlQgfft8CrorNt95hS6XWAZeJ3RaJZh
         U9ygJNXH3qE25+kuR5oHOPTV/XFPsTGU9cxceGK7gOtr3I4YOElklbzydHaI6dk0K0IA
         rj9q4hMqfk8SyyUdbtzaYF3nG19xYbOM5Cod97rKvLoampIlTNh4kmW8+O0TgsOXXfMK
         7OVg2rBZ/CI6cKKsqBHv97fgqJo28hLzRNkz/MvcoKAidOQL7G3+BYqGtfSKb07GzT5V
         G8IGFA1BcEXEck7fw8vGv900rM4BKdqfTP2Go/cFGNNTo80gWLT24TUf4SzNY47mTe3s
         uCdg==
X-Gm-Message-State: AJIora+ipjst3/kG6wX4eWXJ6tKDNywRS5BBcNvAlHSoLm9TiZaQ+6BJ
        JeEiRCLj08hoj8oWsLBqta96L6JzBBLm5w==
X-Google-Smtp-Source: AGRyM1u8VJjbg3jYVVZVJ1ue0mDHqinrXXwR9oPTB/dlm7G5M37vAZgLHMFf/usES9ssUYbIJX+fnA==
X-Received: by 2002:adf:fbc6:0:b0:21d:3fc3:99e with SMTP id d6-20020adffbc6000000b0021d3fc3099emr4632680wrs.550.1656632843551;
        Thu, 30 Jun 2022 16:47:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/9] test-tool ref-store: fix a memory leak
Date:   Fri,  1 Jul 2022 01:47:08 +0200
Message-Id: <patch-8.9-6becefc754e-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in fa099d23227 (worktree.c: kill
parse_ref() in favor of refs_resolve_ref_unsafe(), 2017-04-24), as a
result we can mark another test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-ref-store.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 9646d85fc84..4d18bfb1ca5 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -96,6 +96,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 			die("no such worktree: %s", gitdir);
 
 		*refs = get_worktree_ref_store(*p);
+		free_worktrees(worktrees);
 	} else
 		die("unknown backend %s", argv[0]);
 
-- 
2.37.0.874.g7d3439f13c4

