Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0279CC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C73230FE
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbhASWm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbhASOfD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 09:35:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285BAC061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:34:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g1so21107961edu.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ll/yvkIPHnGgSEsvcwc8foqBhsak1i50K2stkAfn73U=;
        b=RgCqY5ug0u9zySK5U2q/31r+PRndQ83nVQxAsulXhOG+bIWBIRcwVsi+oVL9eva6IZ
         pebuaOZPRyp8f4SI6VL5TmLtmcPJWifBoXuj4Dj0r4RFamaS2ErBDwigDsNCA3fLkBjt
         eDpXs1tzaq+dXm/bH30br/X0wUhl3Uz9sZLCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ll/yvkIPHnGgSEsvcwc8foqBhsak1i50K2stkAfn73U=;
        b=uKA/cMM0JQsQEe0AiwnUFljeFTsg5eBBdnqmd+XzVn0EKVvjZwznTCwi3Z3hO/ibyy
         BF7B4uKvKngbMA6LvzXrjDgOGf9sDPk9E0K7n6SYAYeLivadFr+AZpmoqu4fTVPfE7vw
         bANo0ywGdWxbg1ZkTjEy9tux8sCKLmLFyaExwgiF+WcG+kqSeslszI01MCCv4fcmYX6a
         LNnXCjMzeJJruf2XaXIb3Mk+U7D76KFoTTeoq/7SnxX9qVwbmJTj7AG7RW2N0IJo3wgo
         QwLjLflai9HcAzDTHlXWzzPhDxkHZO5en/IhaPFJ4s08xp3rnJsNQubH29mRjioQytDw
         8a+w==
X-Gm-Message-State: AOAM532h8WxIddwvhjgdp1jJ/aKS7iqqGaEBb9KSKFDMyPyApFYV3r9H
        +kFVU2RUqo+PNyejrH9YcDxEw5bUiMnjpR+Z
X-Google-Smtp-Source: ABdhPJxeR64yZVSuqwKf7uCLLYsvkPFLcxb4I5I+arMLOXqFtx3KKYjdfA5cUa198DHkuYRNSJ3fxQ==
X-Received: by 2002:a05:6402:270d:: with SMTP id y13mr3644087edd.149.1611066860652;
        Tue, 19 Jan 2021 06:34:20 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id p12sm10819085ejc.116.2021.01.19.06.34.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 06:34:19 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
Date:   Tue, 19 Jan 2021 15:33:48 +0100
Message-Id: <20210119143348.27535-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119143348.27535-1-jacob@gitlab.com>
References: <20210119143348.27535-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-pack-objects, we iterate over all the tags if the --include-tag
option is passed on the command line. For some reason this uses
for_each_ref which is expensive if the repo has many refs. We should
use a prefix iterator instead.

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2a00358f34..2b32bc93bd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3740,7 +3740,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
-		for_each_ref(add_ref_tag, NULL);
+		for_each_fullref_in("refs/tags/", add_ref_tag, NULL, 0);
 	stop_progress(&progress_state);
 	trace2_region_leave("pack-objects", "enumerate-objects",
 			    the_repository);
-- 
2.30.0

