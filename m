Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D232BC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 09:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbiBUJJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:09:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347827AbiBUJI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 04:08:56 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D982727149
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:00:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qk11so31446042ejb.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0EfGOzU715IVH37O3z42jLM89YggVp/xbhSAMvoX20=;
        b=WHaGUS7dsIXKjzri72TyVA/4+x9T7yEDH00g8gg+/CyaXYlRxhRd7lwQszaQFgsUzD
         yfP7gs0teEv7nz65fwq1z1zah+Q5mvNEU4lt6pu8hYejqCzc7HMihs2EZ2KSq8joO9X7
         T+ay5vNiR+HDEfFGNddjxZ5u1saEkQJEGe/qd7l32txBeFotNHMB9x12acPH328hPHnn
         +rSV1+t1JZq2hxWC0ELd9F6VkDi/7sU9GuvuoQVdw92SNUKJIKyA/+xR0i5MnhRRk4ip
         6TbOcmDF1ZbW2tODGPcn8ezM7JalXDloBuHJs6RWLG1o8lIyBa0aGNYTq4sf8UUzUi94
         cj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0EfGOzU715IVH37O3z42jLM89YggVp/xbhSAMvoX20=;
        b=43t/YS3S0MRIo0IeURLxdoTpkR2gKD5x1QYsAslQIBCONFl+FlVwpWciNWjzVmq9mI
         gMhheJkwrC70sgUq/IagcVLh7qVolkXF4jk3luvfvBW3CS5wnLNKfxEnCV4eH2E1pYP4
         8O3jbjpolK0DL4kGkrblj9xm43U29u67hk8LrNg36giu6IKqiICsJS1QOGb8EsZlm7rF
         51iceXzYjDmG0LRJMYUt80VZwh/1Vj/jq3TYRdjsn6H1vXgNwfjRTn7pBqdR11t/Icsk
         yaiiOTP6VjSZ+cv9CXmfMAl5zorj3gBISWkAI9L+XLu2gQ8yT0aZgNaqPD1/ixUfmG3o
         /D1Q==
X-Gm-Message-State: AOAM533HK6YqiZa8CJYGRSKcrrJVTGcFzPJMHzU/DPHsFNLtUuZoaJ3V
        nDLiADL1Igq7m5cesrVHU79sSLCSOIj1EA==
X-Google-Smtp-Source: ABdhPJyvHQJwxDlGvY4BccBG0Jq8Yhb3FoNzLgkp606N4hVG7R9yZEEaU1DYUoSqDI/IYDLMN3UoqA==
X-Received: by 2002:a17:906:95d5:b0:6b3:2e97:25ab with SMTP id n21-20020a17090695d500b006b32e9725abmr15288586ejy.322.1645434051065;
        Mon, 21 Feb 2022 01:00:51 -0800 (PST)
Received: from matebook-pat.. ([2a04:ee41:84:d422:21c:c2ff:fe46:a5ad])
        by smtp.gmail.com with ESMTPSA id j8sm8793958edw.40.2022.02.21.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 01:00:50 -0800 (PST)
From:   Patrick Marlier <patrick.marlier@gmail.com>
To:     git@vger.kernel.org, newren@gmail.com
Cc:     Patrick Marlier <patrick.marlier@gmail.com>
Subject: [PATCH v2 1/2] clean: avoid looking for nested repositories when unnecessary
Date:   Mon, 21 Feb 2022 10:00:33 +0100
Message-Id: <20220221090034.4615-1-patrick.marlier@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With `git clean --ff` we will be deleting nested untracked repositories,
so there is no need to differentiate them from other untracked files.
Use the DIR_NO_GITLINKS flag in dir.flags to signify this and avoid the
is_nonbare_repository_dir() checks.
---
 builtin/clean.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3ff02bbbff..18b37e3fd9 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -955,9 +955,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				  " refusing to clean"));
 	}
 
-	if (force > 1)
+	if (force > 1) {
 		rm_flags = 0;
-	else
+		dir.flags |= DIR_NO_GITLINKS;
+	} else
 		dir.flags |= DIR_SKIP_NESTED_GIT;
 
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
-- 
2.35.1

