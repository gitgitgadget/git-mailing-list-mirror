Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C633C1F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdEASBL (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:01:11 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35016 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdEASBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:01:08 -0400
Received: by mail-pg0-f51.google.com with SMTP id o3so42790406pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YiZqLs5b2TxrHRVlGw/YMMqIoF6U5+MBimNuPxAQR18=;
        b=IGKPhBy5EWPFvSi0sd3wHBND+SDlwxv+kW+AEjWBtvF20w7JLyBJuopWtvbRZ40J6f
         GStESCYtWSu3orfPmd1mtZDbqev38ddnOKj/NVo7k5B15pYcaCcjf5iwkII7muT58Gqi
         V1UaKL7m2UoFmFCdIl2IPzQvu2/eT3wvgMeT24wLENFiEl9dP8MQVo/idD77y49c1HVH
         Rvah7jgcuOCUGkkahvqZlLPU2S4jON+yrT6RDXZfOnD8RcJd2n40ibyPtEf7wQ+xi3yj
         EMkcmkKVnnhIEQBulK9K6TTC+1/vYb9zBU7q4Mx5koxC/J4AVVpmKg8CDjmY7CNyp1ne
         /U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YiZqLs5b2TxrHRVlGw/YMMqIoF6U5+MBimNuPxAQR18=;
        b=TDhkHeQ0sJQKvyU7CWq8ONRTUZSZuBl08N7xJ3j7Z//oREk1x/o/Pvl5TrPqncESvr
         T0z36XWYbARjD2tiFLyApxJVVTrtYnD+zgOWfoFmeDCua3YJ1I14veuIsb4TQxNMKucj
         uVLgVAcp5Qx/DiPU+gOi1milbmLSNPy0Lrgk8At5BIkLDiWXkigHdknr7KH+wk/uhIh8
         ralCnAwdX7aHXsSbOPQEvLTtgt7I/Stvwv+j774gmiEUON60fwhbUGo4xPx1wLXLpaiw
         s2OpGcnaf502wBrzlr6JXjxTNXCsc0fLKjwxLjruBu3AEWgLkb48G3kMiZ8XFVQGjh78
         cFtQ==
X-Gm-Message-State: AN3rC/7PvEMXSgFL5IJo4FjkbEGyKs+TCYWspAPBRvuUtSC9wlSJM6oS
        u1kJZdPiAkPEnjYA
X-Received: by 10.99.254.69 with SMTP id x5mr28378636pgj.2.1493661667550;
        Mon, 01 May 2017 11:01:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id m8sm24507739pgd.59.2017.05.01.11.01.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:01:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] submodule_move_head: fix leak of struct child_process
Date:   Mon,  1 May 2017 11:00:54 -0700
Message-Id: <20170501180058.8063-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
In-Reply-To: <20170501180058.8063-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While fixing the leak of `cp`, reuse it instead of having to declare
another struct child_process.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index d3299e29c0..cd098cf12b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1466,17 +1466,19 @@ int submodule_move_head(const char *path,
 		goto out;
 	}
 
+	child_process_clear(&cp);
+
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (new) {
-			struct child_process cp1 = CHILD_PROCESS_INIT;
+			child_process_init(&cp);
 			/* also set the HEAD accordingly */
-			cp1.git_cmd = 1;
-			cp1.no_stdin = 1;
-			cp1.dir = path;
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.dir = path;
 
-			argv_array_pushl(&cp1.args, "update-ref", "HEAD", new, NULL);
+			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
 
-			if (run_command(&cp1)) {
+			if (run_command(&cp)) {
 				ret = -1;
 				goto out;
 			}
@@ -1492,6 +1494,7 @@ int submodule_move_head(const char *path,
 		}
 	}
 out:
+	child_process_clear(&cp);
 	return ret;
 }
 
-- 
2.13.0.rc1.1.gbc33f0f778

