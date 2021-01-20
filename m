Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F3FC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A98D233EF
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbhATOIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbhATMqf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 07:46:35 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F09C0613D3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:45:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id l9so27633469ejx.3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPxhHu6rS+/fDIgAPAQw2WZPqwoybYnBs32LhAegb2c=;
        b=WXnWCh8lY0ZAJcqpVvKQZs9ziNiG6j8+qnBq+tEARq/wAfntjGVARTST35+M+JU1Cz
         stBwviPc3oQVznUqLwRHKtPIYPiuLjd5nXjSahifjClha2qXt3FHSmBC+slaqtmtrsT6
         tatRZNdle1s1Q+wT59BPBPN02cMpv4jOaq6jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPxhHu6rS+/fDIgAPAQw2WZPqwoybYnBs32LhAegb2c=;
        b=SX2UVr5PE4E74nxnSp8POnWStGjwB0dOtEu69WorukreWx1PlLtB0hWzKXsxRKtJrm
         YpnukVk/YJUOkrsLC7qcr+ZZ1mzBopQS/fWftYpwcJ0few6h4Sum4NakamI4Hj/i4E5U
         2yh2Pje9MaIoQjznaAyCeT3YFl0shqI5FhmdpKZ8VPaV7LDSjGd5YaNiLDTEkIUXBeBJ
         3AmaiwIT8Tk9WDSDqGHbYdonVBae80qgnL1H90U5OSzvqlEnoOZH0ZK788ElR0GZZZaW
         VdYIaHVfCciTCq9+VD1dvPqSAs1QFwTW0DzKg5vvT0nHHnAR70W25FasLFreQT+B69Wf
         Tgpg==
X-Gm-Message-State: AOAM530DvPQPwWAgnL5bfHvDqisDuAXVcQ/yNtSjdIimEOLGFXJO0x3A
        rAwSkfzm+LqhE7LDhOi111Dp7sNSGRio0MSW
X-Google-Smtp-Source: ABdhPJxRoZMQunF3E+BI3smF9Y8YTOU/X0x8vLMR0a5QlAl1Mt76jPbPlpHQt70YwXmsLm4MyqpUKQ==
X-Received: by 2002:a17:906:7f83:: with SMTP id f3mr5776771ejr.282.1611146753600;
        Wed, 20 Jan 2021 04:45:53 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id dh14sm1033351edb.11.2021.01.20.04.45.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 04:45:53 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, me@ttaylorr.com,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
Date:   Wed, 20 Jan 2021 13:45:14 +0100
Message-Id: <20210120124514.49737-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120124514.49737-1-jacob@gitlab.com>
References: <20210120124514.49737-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-pack-objects, we iterate over all the tags if the --include-tag
option is passed on the command line. For some reason this uses
for_each_ref which is expensive if the repo has many refs. We should
use for_each_tag_ref instead.

Because the add_ref_tag callback will now only visit tags we
simplified it a bit.

The motivation for this change is that we observed performance issues
with a repository on gitlab.com that has 500,000 refs but only 2,000
tags. The fetch traffic on that repo is dominated by CI, and when we
changed CI to fetch with 'git fetch --no-tags' we saw a dramatic
change in the CPU profile of git-pack-objects. This lead us to this
particular ref walk. More details in:
https://gitlab.com/gitlab-com/gl-infra/scalability/-/issues/746#note_483546598

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 builtin/pack-objects.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2a00358f34..ad52c91bdb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2803,13 +2803,11 @@ static void add_tag_chain(const struct object_id *oid)
 	}
 }
 
-static int add_ref_tag(const char *path, const struct object_id *oid, int flag, void *cb_data)
+static int add_ref_tag(const char *tag, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct object_id peeled;
 
-	if (starts_with(path, "refs/tags/") && /* is a tag? */
-	    !peel_ref(path, &peeled)    && /* peelable? */
-	    obj_is_packed(&peeled)) /* object packed? */
+	if (!peel_ref(tag, &peeled) && obj_is_packed(&peeled))
 		add_tag_chain(oid);
 	return 0;
 }
@@ -3740,7 +3738,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
-		for_each_ref(add_ref_tag, NULL);
+		for_each_tag_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
 	trace2_region_leave("pack-objects", "enumerate-objects",
 			    the_repository);
-- 
2.30.0

