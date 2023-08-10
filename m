Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE43C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHJVRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjHJVRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:17:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A05273E
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso12340755e9.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702222; x=1692307022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxI3WHdBfrfL/L4IrOiNozyXFte3Y9bjt+cYin8E1qo=;
        b=fwrWJ+HyzaStfmVGQBUrSf3TIpc0j30+vo8alc9YK/vZKs+nJeDejCKeyW0r+mI5oi
         /chGToEtiutbfyDabBGvRpTZBopUPYcf72QGhQt0EeXL9cVqEYeDa873yOcOE2hpj+GE
         BODB6k9bOdq9vRA11B1/ynMxLvtKdkIVejhVkEAvznfBNZVBxza0mqPvtOR+TVH2cenf
         DwBPg2CUXVHA5j+o+OfkdxdfGVAsXRhZgPrPo4OfCAfRBo+Moj9MkUpj7a8aHAp54avc
         9+Og9/4S3ctufjdo8pJFKNfosa072RIGNxmtQVxkwUOFdOgxr1iRMsdpSwSf6jIsb/Q/
         XbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702222; x=1692307022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxI3WHdBfrfL/L4IrOiNozyXFte3Y9bjt+cYin8E1qo=;
        b=eYA168jwRrpAcsx6HNWK3N+7vEutX6RHOE2Oai0McrSXQYUxlNA3qPd5mZhHBfyeD2
         teY0Y6w8GntbWszGO0gdI8rF6q7VNKBmBtpsnwHldArOlkzGig9Sl0LfgYwVPNl6VkjX
         0A1GveWTnQHMf/iJiZJ4D4vYh/lybGoC8aT3aQlZLIbE8eVz9R+EVRgmNNXkAXkfm9IG
         JXzQ5wJuMjIEMXzwI7n5XLRhNCgKsIZ4PPyGywM4rz6p7nPcGT9NntAC08VX8OAy7gYt
         Jyjw/zIyybZBXtWpfEB7zdMGFtxKpVmlEgf92Bft0ij7Byk1mboSwcCloCOTZq/FpClC
         seBA==
X-Gm-Message-State: AOJu0Yw/V5/Lza95HOuoK1qTO8KjqSiUsje07XOY6JC+Gv//b+T9Covp
        DubxOfJxDV78z9qN/qu1D23oRt8FOsDc6w==
X-Google-Smtp-Source: AGHT+IG3zp6EgfTKz7790RTWRKj7seIfNecj5EUmANnvYzvn8Gi7dgAHf9FCVgKVu0mViEeGa5c4mA==
X-Received: by 2002:a7b:cd0b:0:b0:3fb:b008:2003 with SMTP id f11-20020a7bcd0b000000b003fbb0082003mr56083wmj.38.1691702222328;
        Thu, 10 Aug 2023 14:17:02 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fe24da493dsm3169864wmf.41.2023.08.10.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:17:02 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 4/7] decorate: avoid some unnecessary color overhead
Date:   Thu, 10 Aug 2023 22:16:16 +0100
Message-ID: <20230810211619.19055-4-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230810211619.19055-1-andy.koppe@gmail.com>
References: <20230715160730.4046-1-andy.koppe@gmail.com>
 <20230810211619.19055-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In format_decorations(), don't obtain color sequences if there are no
decorations, and don't emit color sequences around empty strings.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index cd12c26c29..7c6d3f1ac3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -312,10 +312,7 @@ void format_decorations(struct strbuf *sb,
 {
 	const struct name_decoration *decoration;
 	const struct name_decoration *current_and_HEAD;
-	const char *color_commit =
-		diff_get_color(use_color, DIFF_COMMIT);
-	const char *color_reset =
-		decorate_get_color(use_color, DECORATION_NONE);
+	const char *color_commit, *color_reset;
 
 	const char *prefix = " (";
 	const char *suffix = ")";
@@ -334,6 +331,9 @@ void format_decorations(struct strbuf *sb,
 			separator = opts->separator;
 	}
 
+	color_commit = diff_get_color(use_color, DIFF_COMMIT);
+	color_reset = decorate_get_color(use_color, DECORATION_NONE);
+
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
 	while (decoration) {
 		/*
@@ -342,9 +342,12 @@ void format_decorations(struct strbuf *sb,
 		 * appeared, skipping the entry for current.
 		 */
 		if (decoration != current_and_HEAD) {
-			strbuf_addstr(sb, color_commit);
-			strbuf_addstr(sb, prefix);
-			strbuf_addstr(sb, color_reset);
+			if (*prefix) {
+				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, prefix);
+				strbuf_addstr(sb, color_reset);
+			}
+
 			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
 			if (decoration->type == DECORATION_REF_TAG)
 				strbuf_addstr(sb, "tag: ");
@@ -364,9 +367,11 @@ void format_decorations(struct strbuf *sb,
 		}
 		decoration = decoration->next;
 	}
-	strbuf_addstr(sb, color_commit);
-	strbuf_addstr(sb, suffix);
-	strbuf_addstr(sb, color_reset);
+	if (*suffix) {
+		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, suffix);
+		strbuf_addstr(sb, color_reset);
+	}
 }
 
 void show_decorations(struct rev_info *opt, struct commit *commit)
-- 
2.42.0-rc1

