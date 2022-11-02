Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E92FC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKBWBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiKBWBw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:01:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA69FED
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:01:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l14so219003wrw.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meNx4qMBZCbA9MsohxwdX8UH6wW0Nf1nJgUCnZAl2fA=;
        b=HPHSHUAHy/Qg6BWAObPq3Pwa+kXNT/nzV3h7nII/owryfQQzjejFfugocusjfVsEmP
         BYjuihnTZTa0nwfBQALR9zopCUZHI+3maix94/8+BzrjJGAaVo8XchMKG5RjfM15R0Oq
         BITJ/b7wbPIyyV3c0nXr2PUB/q/aUbS6GwrIxZi5ipsDG0dEemPQcugzTEJrFfMA21Ei
         ysVmWRVsfpdeFoHkehykVijHdQP12faqq6W6X/S4K0nbmknxjCjb4jQrG9DX8+yx5EDH
         IN/1iKSpDAE4/9y/OXRlEnjhZUeR1n6NEB2fdwWMxkrOgg8MSzdWNq6s8b+PN1ELBtPA
         8XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meNx4qMBZCbA9MsohxwdX8UH6wW0Nf1nJgUCnZAl2fA=;
        b=WiYZ7Yps/acorEyFTJH+khyoUpyG2qXB95hJN5sfyoS2uRvWGV1TAuZVTJHiXgl4Dl
         wpDnHXXWBX6BE6yvSQbLFVYLY9wdomnBh3TKy2WxC6hVpcqhL+k5RmicO/CxHKM4ptkp
         vzzXgY5FcdLi+emB5PFm1KfvrSqzW79X2nqfOepzrdbt0HKXxZW0e3fjPs8f5/MziIDE
         o3E32+JNdxsfv7SnaFiGLu9pg8tjcVRm8DejtDkqf7e6ZS3Y+SkgZG5IULiwRJFmjYRX
         JJ3otR5EnHn/ckFN9Rddk9wygRIbFEbwji7fFDS7xNNaQQGBl56raWviUdAFwoVuglcd
         oetw==
X-Gm-Message-State: ACrzQf0vCaNcV2rjvsd2K2D80JQ5YnsSxMdKn8sRxNkrVw04YaDzH/Zu
        hz3hHaLIKOhYMMzwdZgfCCQy6MZ6Qz4=
X-Google-Smtp-Source: AMsMyM5iV5mrMJDbG2ugHHOGMhmg+dKREhUWeJuQxok/nqpFVeOWJRWywwkH/DHDwpEa+ldEtcsiDw==
X-Received: by 2002:adf:f5c4:0:b0:236:c419:710f with SMTP id k4-20020adff5c4000000b00236c419710fmr13079823wrp.56.1667426509142;
        Wed, 02 Nov 2022 15:01:49 -0700 (PDT)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c502a00b003cf5ec79bf9sm3399291wmr.40.2022.11.02.15.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:01:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, man dog <dogman888888@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] line-log: free the diff queues' arrays when processing merge commits
Date:   Wed,  2 Nov 2022 23:01:41 +0100
Message-Id: <20221102220142.574890-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.1.564.g99c012faba
In-Reply-To: <20221102220142.574890-1-szeder.dev@gmail.com>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When processing merge commits, the line-level log first creates an
array of diff queues, each comparing the merge commit with one of its
parents, to check whether any of the files in the given line ranges
were modified.  Alas, when freeing these queues it only frees the
filepairs in the queues, but not the queues' internal arrays holding
pointers to those filepairs.

Use the diff_free_queue() helper function introduced in the previous
commit to free the diff queues' internal arrays as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index 7a74daf2e8..a7f3e7f6ce 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1089,10 +1089,8 @@ static struct diff_filepair *diff_filepair_dup(struct diff_filepair *pair)
 
 static void free_diffqueues(int n, struct diff_queue_struct *dq)
 {
-	int i, j;
-	for (i = 0; i < n; i++)
-		for (j = 0; j < dq[i].nr; j++)
-			diff_free_filepair(dq[i].queue[j]);
+	for (int i = 0; i < n; i++)
+		diff_free_queue(&dq[i]);
 	free(dq);
 }
 
-- 
2.38.1.564.g99c012faba

