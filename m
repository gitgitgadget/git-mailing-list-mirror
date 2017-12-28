Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A5A1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbdL1EPY (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:24 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:42331 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdL1EOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:19 -0500
Received: by mail-it0-f67.google.com with SMTP id p139so27006348itb.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DVoELPeISBqC26LXDjZVI62UYhdxah3+uNQgEpwg/FY=;
        b=sIy2jbJW6EGlVs3cWk7bmePvj0hg10FjDPmGF2q04eX7kYTBGZw3xY0J9mc4iuGgtm
         wUG+7aiTUlNlY2jYD+BXJtlXdUpU5cJKCqaZIi3CxGKTxjeMs/4sxEOWcKTvzsg3GZGm
         rTIVE7/B3ZkjGF7MWCdxnZuvh1H84iDaCARn8jHfN2u4qxDqyiTwImt9bXyYZymun/fm
         je0yVI/EpNzXGcROTmPkeK8BGJ1zMY1Gf7pMjBikbfESclHFY171I59r2Yp9+xO9UjyX
         VHvlee+6QnrNvVtah/92DVqANMKsTU6xfqYaNrHNGhSgkNis0CuHD8GEvyr8fX5Y2A8y
         iVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DVoELPeISBqC26LXDjZVI62UYhdxah3+uNQgEpwg/FY=;
        b=bKbFLks3HZmDBQcRR4WK06IuBGwWx2+rn7I/CaO4weSpuQsN/M8u6cWj8ujMePj7/k
         TX6EenZDYitxANPBDxOlKeGWoadBOJiisrobo9gmw9j0ES1D8+Qs9lxFb4sjN2DPkh0d
         qSZCsyaVguvvAgzLc308EGxHEmFXMw4FVvcLL+xSAjHZXP00AEtIAhWEEYxOXN4FB9mo
         hOXicrg833QL+YwrFv1AHz79+D/5J0uJZrg6MG5ZmbEDAXKaU71jjYBHVpZvsk2Ph1vG
         HDGyu+cufFhOl3CjKs9+oDZQ08vFN8661xV2rS0kaxw/9zv4GT3GFpZZ7cabN501u9EX
         z1eQ==
X-Gm-Message-State: AKGB3mIAw0Sg2QSZBqESR1EkiXyUFnBtYtrnbPf14xPP3m2G/c3TsxM1
        Xuo5z3+aFkRTCyBppQICRBEjpg==
X-Google-Smtp-Source: ACJfBovoV1QyZ9CTUGB/t0OYIlMCC+x2OPk1DAT6djVjegKifh+CfiXzxvEcRjQbqjt+4VMeKb633Q==
X-Received: by 10.36.250.72 with SMTP id v69mr38078363ith.120.1514434458157;
        Wed, 27 Dec 2017 20:14:18 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:17 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 17/34] merge-recursive: fix leaks of allocated renames and diff_filepairs
Date:   Wed, 27 Dec 2017 20:13:35 -0800
Message-Id: <20171228041352.27880-18-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_renames() has always zero'ed out diff_queued_diff.nr while only
manually free'ing diff_filepairs that did not correspond to renames.
Further, it allocated struct renames that were tucked away in the
return string_list.  Make sure all of these are deallocated when we
are done with them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e95eac2c7..cdd0afa04 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1653,13 +1653,23 @@ static int handle_renames(struct merge_options *o,
 	return process_renames(o, ri->head_renames, ri->merge_renames);
 }
 
-static void cleanup_renames(struct rename_info *re_info)
+static void cleanup_rename(struct string_list *rename)
 {
-	string_list_clear(re_info->head_renames, 0);
-	string_list_clear(re_info->merge_renames, 0);
+	const struct rename *re;
+	int i;
 
-	free(re_info->head_renames);
-	free(re_info->merge_renames);
+	for (i = 0; i < rename->nr; i++) {
+		re = rename->items[i].util;
+		diff_free_filepair(re->pair);
+	}
+	string_list_clear(rename, 1);
+	free(rename);
+}
+
+static void cleanup_renames(struct rename_info *re_info)
+{
+	cleanup_rename(re_info->head_renames);
+	cleanup_rename(re_info->merge_renames);
 }
 
 static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
-- 
2.15.0.408.g8e199d483

