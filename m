Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9E01FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbcLHS7b (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:31 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35215 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbcLHS73 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:29 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so84464328pfk.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shEiNlrXEHlBzb2mZmj2tLpRHHgcEma8qB9EFHlO3JA=;
        b=at40nFxFAXmRF1dfcRCCwGuNzMEW38D+wysCcFskCFv4SDzLwbWQPCB4oNJie/ONsu
         JGyqBUSEp/dLMImtEKr0e9bQBjjpDZdDr+USjSn6pGVd4Dbi783T0esIONcLvuP4cnYN
         u61qVRFz/mTEDjdc/NC9s/Tms4vxAalayRun6lXVj7w8b3duB6+W5t3NdmDfntdqnBqr
         yTmSK/WBSGSzhw4rTh4gf7CMNsq0rsoWinRkSGcnupULUC2XR1yjtf1c7fSkJza+if6u
         3puYjUD6n65zuy4RUghzv2hlDB+ybjDHC5uGZhMdCuW4qDKcBOD7aMkbXnoCVL7v6ZRN
         42IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shEiNlrXEHlBzb2mZmj2tLpRHHgcEma8qB9EFHlO3JA=;
        b=DoL/wTny0vUboPytVv/QnMxpdsXCiWaQdQ4TPWfQnkJUd079wSOp4QFqLWIc4myDyX
         xFsRzrYM4C93+onBrDYXFOE+mVTylHUJOlvY19jBM1C6aYQMJNXjK9yzS7DOFOy6wpBA
         AHLfFi1u+hAB4+CqK/wg7B2N79A7oT3zU4zkcNspLdRNrrIG3+F0TmyQiMogwW6EX5pP
         yfZ1wQznxiGoQ7qsHRQLdSyF7fUwhHflhbknIE089P5uiuxcAEs8qBMjF7FbeExAglHx
         jM1B9+IFrmOeCRQLsoHqIZg8Sya/BxkrlGjaDFGTlV8bvJ2qbDZYwFYbUivomT4dH9T9
         1ZUA==
X-Gm-Message-State: AKaTC03pBqRQeGfUoKd++aGots3R+UL4CxKGnyTRukd28S1kaDk3v5cq0zecJJVouNXT3Qgk
X-Received: by 10.98.31.14 with SMTP id f14mr76041917pff.27.1481223568007;
        Thu, 08 Dec 2016 10:59:28 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:27 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 02/16] dir: convert create_simplify to use the pathspec struct interface
Date:   Thu,  8 Dec 2016 10:58:56 -0800
Message-Id: <1481223550-65277-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'create_simplify()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a..7df292b 100644
--- a/dir.c
+++ b/dir.c
@@ -1787,25 +1787,24 @@ static int cmp_name(const void *p1, const void *p2)
 	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
-static struct path_simplify *create_simplify(const char **pathspec)
+static struct path_simplify *create_simplify(const struct pathspec *pathspec)
 {
-	int nr, alloc = 0;
+	int i;
 	struct path_simplify *simplify = NULL;
 
-	if (!pathspec)
+	if (!pathspec || !pathspec->nr)
 		return NULL;
 
-	for (nr = 0 ; ; nr++) {
+	ALLOC_ARRAY(simplify, pathspec->nr + 1);
+	for (i = 0; i < pathspec->nr; i++) {
 		const char *match;
-		ALLOC_GROW(simplify, nr + 1, alloc);
-		match = *pathspec++;
-		if (!match)
-			break;
-		simplify[nr].path = match;
-		simplify[nr].len = simple_length(match);
+		match = pathspec->items[i].match;
+		simplify[i].path = match;
+		simplify[i].len = pathspec->items[i].nowildcard_len;
 	}
-	simplify[nr].path = NULL;
-	simplify[nr].len = 0;
+	simplify[i].path = NULL;
+	simplify[i].len = 0;
+
 	return simplify;
 }
 
@@ -2036,7 +2035,7 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	 * subset of positive ones, which has no impacts on
 	 * create_simplify().
 	 */
-	simplify = create_simplify(pathspec ? pathspec->_raw : NULL);
+	simplify = create_simplify(pathspec);
 	untracked = validate_untracked_cache(dir, len, pathspec);
 	if (!untracked)
 		/*
-- 
2.8.0.rc3.226.g39d4020

