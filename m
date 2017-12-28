Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3067C1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbdL1EOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:06 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:46103 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbdL1EOC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:02 -0500
Received: by mail-it0-f67.google.com with SMTP id c16so2827998itc.5
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bG4WatIAAPItlrhJf3xgOKj+aHaQFct1M8CToL0qZp0=;
        b=nD0uIVqQKT2+dNOa2KtTNDTfohwavvRv4HYKiJ/OFmj3UaVGAkkAXqBxNmGjLE75Cd
         Y38yTkj7RL9PHxoVGLf2n2TjZ1HIgfiEcafnZaCPBcoCv19yH4AvEe1mieL14UXahCc6
         LtTcNDlvUeOogLVmaF7HMU+rBR1Ap+6M0R+8/GyGAo9sg67U9VLRUZRPeCdt48kVdjo2
         E254Q5EgfYKlsSF2PhSzo1m5hcT8ansiCE9knhO49OcpPdBCD7JdX4WfLnlArKFxkjZX
         A4gApin93/1SmH+nVoJERUrpFIiczztr1WjvCWa98nNJPt07YFT+t4ce94QxOqjuUama
         UHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bG4WatIAAPItlrhJf3xgOKj+aHaQFct1M8CToL0qZp0=;
        b=FOXO9IkHuycStfIpk/Mqk4aiijSIas1ru2DAfodrzmX36rQJX/HuW6+4eHeOx1rhrK
         Sr9kW2oXKJfWm55xnLmy29CB1P/ednHbYj4TE+d6gPv/KcuYQqeMIO076L8sLT/HFa8F
         yIVIWUkyM/JJIa2DzMXEfnCroVg09eohSR2kmFN19GrAsRs3tgCr9FfUgH/hPc0HPWGQ
         I/cot92ynG1/GlZrrw5eaDg9tLhiWoXkdKWwiIsp2l3BE+UMVxF47e/55qA67dhVj+tf
         KrJXTJYbUbf9RdIftH1NO+mCNx4dZJyeisTvtbOG5cokD4ry0w7WygZOXl9HndNscSsw
         85nQ==
X-Gm-Message-State: AKGB3mId7OZaEsAGqDQ92f887Lin9yoLmhb88UhjMCXOsRb8gE3q3xz7
        ZYYWIBcj13ZAm0LggWsQNqQZZw==
X-Google-Smtp-Source: ACJfBoseQCLO85/69lWmfTkITci4xanwXOknfiJBEYqbS7aOIXhjicmFzCbq9cz1hBB4o1FJcDkPUQ==
X-Received: by 10.36.145.216 with SMTP id i207mr2640039ite.73.1514434441558;
        Wed, 27 Dec 2017 20:14:01 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 02/34] merge-recursive: fix logic ordering issue
Date:   Wed, 27 Dec 2017 20:13:20 -0800
Message-Id: <20171228041352.27880-3-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge_trees() did a variety of work, including:
  * Calling get_unmerged() to get unmerged entries
  * Calling record_df_conflict_files() with all unmerged entries to
    do some work to ensure we could handle D/F conflicts correctly
  * Calling get_renames() to check for renames.

An easily overlooked issue is that get_renames() can create more
unmerged entries and add them to the list, which have the possibility of
being involved in D/F conflicts.  So the call to
record_df_conflict_files() should really be moved after all the rename
detection.  I didn't come up with any testcases demonstrating any bugs
with the old ordering, but I suspect there were some for both normal
renames and for directory renames.  Fix the ordering.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d00b27438..98c84e73d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1982,10 +1982,10 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
-		record_df_conflict_files(o, entries);
 		re_head  = get_renames(o, head, common, head, merge, entries);
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
+		record_df_conflict_files(o, entries);
 		if (clean < 0)
 			goto cleanup;
 		for (i = entries->nr-1; 0 <= i; i--) {
-- 
2.15.0.408.g8e199d483

