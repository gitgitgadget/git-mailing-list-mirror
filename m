Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67113C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbiBOWQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:16:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244528AbiBOWQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:16:34 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC2C36
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:16:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gb39so294325ejc.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODvOqst7GZOYCPzP/oB72wNmrfjCZAv2H2KwDGmzKAw=;
        b=IlqWF3QChRch951ddJhgk/+ygWrf/AbFYIOeGnMJ+eHXqc48PhBVTwqcxTC+MCBYa3
         AFDbR+4mBOltcsCiDB79vG/iLMGZ6Bp0SwC0L18tUZgVz74y/d0mqruXaB3EykrHCtAV
         KsuBNz65XDv+aCAQrnuP745CpLg6qMXsbSnZdY/mGunZ1v34d9pAVVFJFuq0WZ/ZjnKM
         fNS7rVUF8dFKvGx5ro5aPLUaJweju5JEMD3midIKPsyGS23NJ+SvndAVOLvz10/BMmb3
         xAK/rDNPmHq7/x/2c5av9MtKe15inEt5ov2fiA51wegpHnWMgDTOU+lAcMA3oppXj/XB
         goiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODvOqst7GZOYCPzP/oB72wNmrfjCZAv2H2KwDGmzKAw=;
        b=tHNC9sk1hQDsaOvbOPmBYqs9PBBpC+TgiHtOjqxaJX0rttBofc3DIFB5fYGNBNdDia
         8VTWQ6vvej1jrVBxE9bCMsqDSwN4h4t+7N69SHdft52CSmgv84WdnGDPgmnjtLoFWNCP
         uE5UZ0E0FPQRaTUdWcsYyWb/kdGiJPPWf1sHplzQQq85nb5kUK6ihsO0UDw2Bq4KMPww
         zcanihJ4L+lRm6xqZUuIJypqwoZ2Qg63G+/18MSsGn0C5IX0FsMPBVmsmKVu8GMJGo1g
         xrF35kYcQFL6X1gNKhRBQcmzJS/ODivR3tQDjapu4W54hjCjt1kHEmCGbv9hokjR880C
         ceRQ==
X-Gm-Message-State: AOAM532YTx7gCpbvfgtoJ6NXfNW7befNHgG4vueVDsPlyZyI/R++umLz
        HGuAJtzOZFeEhXOTCUA/wdVh2CBTPIs=
X-Google-Smtp-Source: ABdhPJxtYLupxYJXVz+2Z7xvwc9jwg79wv/cJfMh+vfrJOZL7lX4isuPFuJPhuA5vHSMg/HCPH1spg==
X-Received: by 2002:a17:906:a1d5:b0:6ce:e4c5:4812 with SMTP id bx21-20020a170906a1d500b006cee4c54812mr107286ejb.292.1644963381251;
        Tue, 15 Feb 2022 14:16:21 -0800 (PST)
Received: from matebook-pat.. ([213.55.247.223])
        by smtp.gmail.com with ESMTPSA id i5sm571341edc.94.2022.02.15.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:16:20 -0800 (PST)
From:   Patrick Marlier <patrick.marlier@gmail.com>
To:     git@vger.kernel.org, newren@gmail.com
Cc:     Patrick Marlier <patrick.marlier@gmail.com>
Subject: [PATCH 1/2] clean: avoid looking for nested repository when appropriate
Date:   Tue, 15 Feb 2022 23:16:14 +0100
Message-Id: <20220215221615.20683-1-patrick.marlier@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

avoiding the unnecessary checks for is_nonbare_repository_dir() via setting DIR_NO_GITLINKS
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

