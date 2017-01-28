Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D87A1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdA1CCb (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:31 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33186 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdA1CC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:29 -0500
Received: by mail-pg0-f50.google.com with SMTP id 204so85672779pge.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fZkG/QdaR2rxIyINK+QrFFJ/jWQdfe+hFkV33p/P47M=;
        b=VHygZaEshFuD2aL4CZKrvuhKn3IS7ycdJ6itHGoK5Q3i+kWN03BxfcUJ2ggZGzrcMs
         XLuBq7cU1BRYfeGJZ2Q0OWS3TjLBHUdUmojIgSEKDA01SySQzazWxWulCUgR9K9hBU5m
         G3hXEc9uF8m2WelFEusASW1+yGS4TjRjOA818yvM6BaLWNK8j4RW24RTJWXe3CYvHyh2
         kKacgxkhlsvQzGih/uh5RUQu8RSgPLhX+AIDi2/51F0kvP4j4ghBtQ1pdZiCLGpwIhcE
         n2kJJ5hNiM/TGDlQUCthsxazFbC0c1OYwOk89fVupyCMAaOTIazzZwRWpP6qMuT0x3Um
         CHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fZkG/QdaR2rxIyINK+QrFFJ/jWQdfe+hFkV33p/P47M=;
        b=Jn7XVphdRxqoNAg5zLx2MSpHCgPe/68++eCkIdCuyhfvEu9KzJ1Hc6Um0fIbx6Ipcy
         09Sl8vMmk3g7TsLrZ2vdrjVLjeBTd1U04s9ZT9ylGkRZ8FfCk7pZi/jcv2Z29Z+oklos
         gwwknCbdmX/cfw6Vgbl09+P6/xQQRKlO0xJTs6fAwuXpfAYozP6zO3n0FKZQuXxYrhm8
         i39T9pO4eJhKtr8EpCDgdZ6WXJ797yks5zNWjtc/SX+5dnGMJz6y2dlwBTtZQYnM1O0S
         Sy7BQjFuug3XHhHJFIKsEZ2qIIdhIZzTWrklyEjVNu4GycW85yg2/Vot8I//gPlNxOyt
         3U0w==
X-Gm-Message-State: AIkVDXI1Tbs54a/MlMC9Xn1vO3RyxezE3bFpVykzYeO9VT6+82RuE1o3gmeimKFSR/31hSAi
X-Received: by 10.84.134.169 with SMTP id 38mr16462303plh.67.1485568948891;
        Fri, 27 Jan 2017 18:02:28 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:27 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 01/27] commit.c: use strchrnul() to scan for one line
Date:   Fri, 27 Jan 2017 18:01:41 -0800
Message-Id: <20170128020207.179015-2-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 2cf85158b..0c4ee3de4 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p = skip_blank_lines(p + 2);
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.11.0.483.g087da7b7c-goog

