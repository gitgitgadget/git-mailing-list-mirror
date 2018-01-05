Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B241E1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeAEU37 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:29:59 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37990 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeAEU2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:38 -0500
Received: by mail-io0-f196.google.com with SMTP id 87so6978614ior.5
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDOUCOc/kOrOHJGigoygd+lXUpdw8ftKo/+DHnD7HI8=;
        b=IHTzhz8TawjxC33oAXULcWnG+TmoM/6sHiGqbR9vEL+2/zrUaT7pWtIgWC5/pIqG8O
         TmY1kDA5xcuP5IeIdJZwBOOoUZFzYM2kbdUXOhZ+6Owkd9mU3CrOo7HPjydrLPOFXuOs
         iH3y//MZSUMAd/ymBldveYvB+b1pJgrR3jGxZx0K00LM6k2P5DNw3v/8vjjRwjtfZpwm
         KxNyNgwqr+CGdIf6DbUpHDtztyudfRaTDiZuJ0DmdtOZeFKHE27VwzFCeJ1cyEO9skBo
         ud0rI79+VEm+DgrXf3lCKcaJRSg4T8xsfSCB7/E3N6UzbRUyIXmwWcy6gM+h9eRvZTCc
         sfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nDOUCOc/kOrOHJGigoygd+lXUpdw8ftKo/+DHnD7HI8=;
        b=pZeGGsk7j+hCf13fL/MlyvXQmarHBq1d+o/bo3EgnW0yTQxw4D3cxer1MEN16RedNK
         w8pLexedDcon19trm33Bt/Il2n8EeijCmMChgxGAk3oPS2JGXb8h+EcVATs8HSJLpDAn
         hseXWcs6zhBRxg61chmU9XpH8qRBndqglQdSxqopmSFyWEoipozZpi/zuoAIH/FMLZpU
         G7zRTo1+R6cQ9jgizGXidPyugHT0wODUHtmAQWRRuUZkdaNxlkZrsxcMakPmKd3dHKIy
         1AIfV62jAdhVlO7piifWBwzUEPM3djAcR0mDNU5bWH18NjCGpHtw6cFtc1bdjTTcOCxE
         C2qw==
X-Gm-Message-State: AKwxytcbua5p+IqPaOhes40Y6hbbV009KKhhT1Hhr4UXnA65ecQQRKf5
        ZeutiiGP1Tv0NRNYJKZnN/d2Ui2z
X-Google-Smtp-Source: ACJfBosT0hI0iNpfsg1EQuHuWQSl+/cXPHqXrYpV/jA2G+cSN4+O4b93e72v4Np9Xy5SxvczW6xMCQ==
X-Received: by 10.107.174.159 with SMTP id n31mr4424092ioo.256.1515184117993;
        Fri, 05 Jan 2018 12:28:37 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:37 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 14/31] merge-recursive: fix leaks of allocated renames and diff_filepairs
Date:   Fri,  5 Jan 2018 12:26:54 -0800
Message-Id: <20180105202711.24311-15-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
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
2.14.2

