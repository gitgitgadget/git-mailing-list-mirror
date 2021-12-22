Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC18C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbhLVEHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbhLVEHM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7EFC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so718727wmc.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDCKtkUU2aJQZRLM9SFG+48XjPjXXLXhRqQ5AcbhFhg=;
        b=MhlMdYvx/wmGdJfxAXI0uYH0j/SuvcorozzRe2OfT7n1Q+G/na6flpiHVNGN6XAd5+
         Ek04Ifnzwew3djhAijyTY/lVHGH8HIgfDplpFyREW/0h+ROXZ9RX98zwB1iAlhxzsX94
         VaBTsifnNkv56EHoZYVWqD7zY+FbmROERoTC7G/bizYycXZ82F5l5oFgA23owYEFBHuH
         MbgPW4GRNglm6B22LBCumQ583cxVfYCYk0yoP6emwyvouJpbNZN66qXFJHxk+s+3q3qF
         t2aTWp7Oghmxvo2JOF0ICq1qpUOUjceZKCV+0+Og63/lambtVW1eat7jlmiJwTfWgzuc
         gB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDCKtkUU2aJQZRLM9SFG+48XjPjXXLXhRqQ5AcbhFhg=;
        b=mpIdOiEeJcJ6xWhdeEBbkuLB8/mdX2TiyMeGUEWB659XdDT6ctBgph1bjTXKSWwA3c
         yt9UU+hssVrwXlVFiY6pbbr7SpAfwHBLiAl/00jB/2W3THooK4nQ7igiYTiW296QX6CD
         DZkA4zx0sQaEx2sJ+bJfYFjlcM1kXDsZ83d8BpOQNNkWgTbWTYs0O1T3zpF4bTEBmWxK
         Vucor4+qleLMQSYRazSJlAuUuuEjsBKVV31QMv7RpdTfbH8C/MWyVMjsXEgKXFoX4sJP
         UeliOhyGwGhEffljkHz7Z8NUS4qxuJbxfSpN4eQ0GwmkGDZ3lhLYhm0gygf26lE9AJeb
         gzBg==
X-Gm-Message-State: AOAM532k+lWr5B8NARKjTHMJuz6JCKaQ8l61AdL53pCftISjD+AJSfZc
        43W0G8BRP0sS3GPAcjHWTgRhynALv/5nPA==
X-Google-Smtp-Source: ABdhPJxefvrq53ZyNaOigLNsrZMUKlJ+AzWz3J5VfgV5X4piz1qh6AQPrxLYui6bySzvMtja+hRj6g==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr777651wmq.49.1640146030893;
        Tue, 21 Dec 2021 20:07:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/9] refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
Date:   Wed, 22 Dec 2021 05:06:47 +0100
Message-Id: <patch-v3-8.9-6748298a782-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible for "cb->newlog" to be NULL if
!EXPIRE_REFLOGS_DRY_RUN, since files_reflog_expire() would have
error()'d and taken the "goto failure" branch if it couldn't open the
file. By not using the "newlog" field private to "file-backend.c"'s
"struct expire_reflog_cb", we can move this verbosity logging to
"builtin/reflog.c" in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 90b671025a7..5f8586a36e3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3105,12 +3105,12 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 
 	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
 				   message, policy_cb)) {
-		if (!cb->newlog)
+		if (cb->flags & EXPIRE_REFLOGS_DRY_RUN)
 			printf("would prune %s", message);
 		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("prune %s", message);
 	} else {
-		if (cb->newlog) {
+		if (!(cb->flags & EXPIRE_REFLOGS_DRY_RUN)) {
 			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
 				oid_to_hex(ooid), oid_to_hex(noid),
 				email, timestamp, tz, message);
-- 
2.34.1.1146.gb52885e7c44

