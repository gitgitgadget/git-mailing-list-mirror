Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA68C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiF3SAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiF3SAc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DC42A245
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i1so23939671wrb.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82l5LxkXvS4/opIltRfd8tweB0pQ/NAlswZAKuZfnfA=;
        b=MSvCiHEoIRzzUIAFM0K43BZZ0FxR5o2wsThkRvsj8//hwwhJSF0y+JKlhO/s1YVOP1
         J59rUNbejOBALmXCQrndDdw/X4Q6TvRa9skdhtSUMvFD1f2G1mMx0sdXgb8ic+kx7AlA
         niQsviKaT2I23sqL1lVpu8HIP1wvPs59oIBmtklGZDYmctmYrSJIh529V6q4q1YbJiYg
         Udu6vSEFbDiQfO4yTy7mQPm++tAj79IKc9oIBp1M7yS836HYw1CiGA0IO8qy/S02AvLg
         UuBUNdGHi4fioAFMGCJmZqfqN2sOk/5YM+FyDu4VW9iZxvHmQTx5uAowRKDDkEscbcUF
         nzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82l5LxkXvS4/opIltRfd8tweB0pQ/NAlswZAKuZfnfA=;
        b=0M75d9NvOyoMOoOhFLKc0zpbyITopanNtuUbuSY6OCgQmiIpMztm1EEsuatYsm8Oh7
         wfGoyKKcqHpp5Dlr9NYXp/NMwlRpNSrfxDGUh8t7TEP/5M3hH4jJsQw/DqbeDDHbRM5c
         +Z4VnHeWKkjZiNwcTGSYkEDGxsa1MqehkvVsO4+YJEgUrwaZ9lhMQecYinnnfVNKLPb/
         GOY3JK9veOd+fiI6f3DPs4iA/uyT2HTMwgo2+s/PeerRzNG69nFsVNjhzGZ4FtKp5Pm4
         N0jIEmE/lIBPeNjickH0VHWTpQc0cyPcMPk94fMz2lZMq5cnHBRM3lJOuU+PRc2EN/Ui
         a6Xw==
X-Gm-Message-State: AJIora+5uA1tB31MU9x93pohUFwWZxyHhYzVemgLfDxy504S0AscP24G
        c2eX2icxcjCsuhkBFKx47pshpBDGxlNkgA==
X-Google-Smtp-Source: AGRyM1tEoegIFHlq4bC/64oddgbdMjX7p6gxvNBpviiXruUq8xg+oJT5kbubd8d6+LvXQeLPM34hMw==
X-Received: by 2002:a05:6000:a12:b0:21b:93b9:134f with SMTP id co18-20020a0560000a1200b0021b93b9134fmr9577125wrb.310.1656612029243;
        Thu, 30 Jun 2022 11:00:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/11] cat-file: fix a memory leak in --batch-command mode
Date:   Thu, 30 Jun 2022 20:00:15 +0200
Message-Id: <patch-05.11-9ba267377ee-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in 440c705ea63 (cat-file: add
--batch-command mode, 2022-02-18). The free_cmds() function was only
called on "queued_nr" if we had a "flush" command. As the "without
flush for blob info" test added in the same commit shows we can't rely
on that, so let's call free_cmds() again at the end.

Since "nr" follows the usual pattern of being set to 0 if we've
free()'d the memory already it's OK to call it twice, even in cases
where we are doing a "flush".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 50cf38999d1..ac0459f96be 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -655,6 +655,7 @@ static void batch_objects_command(struct batch_options *opt,
 		free_cmds(queued_cmd, &nr);
 	}
 
+	free_cmds(queued_cmd, &nr);
 	free(queued_cmd);
 	strbuf_release(&input);
 }
-- 
2.37.0.874.g7d3439f13c4

