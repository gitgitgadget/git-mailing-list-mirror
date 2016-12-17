Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DEC51FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758353AbcLQO4k (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33042 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758080AbcLQO4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so10583547wmu.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nL6IMbrfKBVFywqn6myz+yAszeIDOfOymDEmVD0fSf4=;
        b=Psbqo0TUMeXwbhAwlKzmnzDJQDI2etEld7v8uz+/azoxHVType/yKkARdvccs+cOVg
         XY9y+kFl8lDM7P3yuocGnPs4ddGLfm6gtb5nceKw3fAjVRpMUOTC1hXnXzyUmBTa66Rl
         rREVbots+7ch2Lx5OVGPYO74jpNjTuJJhX7SR9yBtH7IW0baOzGZA3Dt3qGA3nu1Z1z0
         z6wj9pCHaw9dyLWH2spHe2N9QD4Kgj7c4bNG04nW+7jLObB0Jcbp/brm7W0tjNztUPE6
         BV2UtALNqM8WI7LCH+ppsJPY8h+lHzN2grP/KNybvmpeYdnNnMtIsVheo1DBblWcGWr0
         9dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nL6IMbrfKBVFywqn6myz+yAszeIDOfOymDEmVD0fSf4=;
        b=fr1yoHxOikuRepJsHXVP/xZAKuU2IxRTMcQnvzzRnVHTA1ndzDf+P0DRQhkNvIQPxJ
         5h/Slagk4y8Z53CHrGfT80L7UAtvFKfa6DlgzxBgxVZamP2mr+NbSr41s3kFZx3l0yqH
         DDdLpJF2ikTyg1leMaQePKsgi3V2Uc9cD5aaZBCeZnOfltjziXhdQsivdCUfFw5YVJfQ
         DoRunbnKAS1W1XlckxnF008taUGd1vku4sQbWYSb2oAiAfYPI+bF5+hTgkOMilKSQp/e
         lBDlSJhJ8NkaYEJOGyytdIN1Jz5XD3P9cl3AcqtY0V+wlJAa+TIloacydB4W3pWJZ+9H
         B3Ew==
X-Gm-Message-State: AIkVDXJJ164ES8qyb9p1hmOlSyX4aIDeQAr7hO6644ZnMd/rJx/FFk76lo7MwtgQZeBBpA==
X-Received: by 10.28.178.10 with SMTP id b10mr7884589wmf.83.1481986584017;
        Sat, 17 Dec 2016 06:56:24 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:22 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 18/21] read-cache: refactor read_index_from()
Date:   Sat, 17 Dec 2016 15:55:44 +0100
Message-Id: <20161217145547.11748-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks better and is simpler to review when we don't compute
the same things many times in the function.

It will also help make the following commit simpler.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8e99a7c325..96e097e341 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1702,6 +1702,8 @@ int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
 	int ret;
+	char *base_sha1_hex;
+	const char *base_path;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
@@ -1719,15 +1721,15 @@ int read_index_from(struct index_state *istate, const char *path)
 		discard_index(split_index->base);
 	else
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
-	ret = do_read_index(split_index->base,
-			    git_path("sharedindex.%s",
-				     sha1_to_hex(split_index->base_sha1)), 1);
+
+	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
+	base_path = git_path("sharedindex.%s", base_sha1_hex);
+	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
-		    sha1_to_hex(split_index->base_sha1),
-		    git_path("sharedindex.%s",
-			     sha1_to_hex(split_index->base_sha1)),
+		    base_sha1_hex, base_path,
 		    sha1_to_hex(split_index->base->sha1));
+
 	merge_base_index(istate);
 	post_read_index_from(istate);
 	return ret;
-- 
2.11.0.49.g2414764.dirty

