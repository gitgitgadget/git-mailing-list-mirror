Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6478A1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeAEUV1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:21:27 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:42767 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeAEUVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:21:25 -0500
Received: by mail-it0-f68.google.com with SMTP id p139so2868739itb.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hZKHvK0fQ+vp68tkiPTa50z+B0urnOTY/annlr4DyuM=;
        b=PNcW3Cq8583ehGDQ5w7eSUHaHHUHmib87DeHVCXa79n5klV5UoNPamoY38HUxr0AVQ
         r7Whqh4EcadP89NyWNL35/CVi3uogkMX1VaV/L3+OfJnNrDFgXmqfC6ilwkSK1gn/iHj
         0wYry9Faup17z0yJEGhybYKDjimRRunHn7KZ1H/dd7EsVO61HJb+wR9Qyuo7quwgma/9
         1LSVVkpShrMGSJ1F3c7wz7XDfI9pZtCDVtkgakfHSDpURr8NsvdxMNGnKRQqUdP66sEc
         NVl/GE0k3yrc2fdIvHg0cQpW4BlqdeR7yUkjLvoCy2+1i35yOxiU2tuLBNWViMM747XU
         FgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hZKHvK0fQ+vp68tkiPTa50z+B0urnOTY/annlr4DyuM=;
        b=GO/MnR6inCcbhnNoPrp0mhEEIWUhMxsm91g9CE6TXmKtX2FRv12fJQ/hwmqN3rRdDK
         RQDyD6z4g7303mGP8sJCowMELMkFWgWGPlbi24hXMWdZUSglg8l9YP0Vc2BvyQ/JNvsH
         oQUmAMIllrBCRVNND66FERjUC2ZsKz6Lmis55Rr+Giw10J7D0aD/dyaPwA6fPkRNwvIU
         ycDPd/Ofu8l6m7ZjNwtBrOqhRfzCL1bjbztGgxPcQGmJDmr/kOqUrK6UBangDhQDXT7n
         hNbYdDko/Oozp2NstcY1N1u15Pf2QRtog6k3jU2m3gdF0OGMVMBElD7dDbhPfyHimPbN
         NSfQ==
X-Gm-Message-State: AKGB3mKewq3j6Bb5LfyDNJWgn/jupOSGE3nz9SJhUFQfqQ1hXDBro7Bu
        hFp5Pl0KkGK1+4b3uQEo8SA=
X-Google-Smtp-Source: ACJfBot7Kg8BRgz80yKvcCDWxn4WJCy3lJHIR+Fg9LdeANZJb3isxiECY8Q72004heG1mEPsseFwgQ==
X-Received: by 10.36.117.79 with SMTP id y76mr4677402itc.9.1515183684414;
        Fri, 05 Jan 2018 12:21:24 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id p68sm3876894itc.26.2018.01.05.12.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:21:23 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] merge-recursive: fix logic ordering issue
Date:   Fri,  5 Jan 2018 12:20:00 -0800
Message-Id: <20180105202001.24218-3-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202001.24218-1-newren@gmail.com>
References: <20180105202001.24218-1-newren@gmail.com>
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

Reviewed-By: Stefan Beller <sbeller@google.com>
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
2.14.2

