Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C8020970
	for <e@80x24.org>; Tue, 11 Apr 2017 23:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753521AbdDKXtx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 19:49:53 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34864 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbdDKXtu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 19:49:50 -0400
Received: by mail-pf0-f171.google.com with SMTP id i5so5340105pfc.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ttV8WwQ5NQw4jmk8DIv4xTztekwnKuTwoebjhZsjKjk=;
        b=rSqImzVMHNE6uUIzHyNHZ9wOF93FDpCIJ9Z4WUHwHgeKgimHnAsAHSJOKGnPpQPByX
         nahB0L1EiC0J/HiwcCP/VvoM+cK8mWNBiJmVTFGeLOLEczh9DOPGo9JFqfA7cap49ZuR
         fQpW8xZfXax115D8B490r25MbLywEe0/tjQMbTjRGa3WB7PcR0auwnl1TGAJgbO3R9DI
         h1AnwgyfzwdIPsrOLPzlJc/MzKON7wQ66q2Mv7emlhMYyZVlv1XBuJnfYg2ER77BFyCh
         /QDgIfkYJRLR+KgyWYmV+6syRT8Jv/MG/hmgQZR/1Cz3tMmJG2C5t3uaGhpMIXw+89Sd
         oF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ttV8WwQ5NQw4jmk8DIv4xTztekwnKuTwoebjhZsjKjk=;
        b=X2GiYNgkahXU0KovOtvoa3BXHR4fAvqnOvFCcbUHk/eEXm9GQUeRyl+Tb8a6QAzf/m
         bpaLvceL0R5otxcXN1u68ndW2l76ZQVoj0tIN2APYnnkbOR3BZITH4dJ3mGgPC8uZUT2
         /I3NgZttl9h8jhOL4rjAElQKcXsy+Yhtszt32yYbtuDc7V+d3CWJQt58NNvQAJszt0kK
         /T0pTJ4dkFMd+6e6nHnn8t3OPHFxP9D3IpE9bHtgizX1SQDBcB8bMvj2tVPooPv5z527
         J8V8lJblKTCTKu9D5QOH3idzz/vYUGo5YiHAYK7eoMQ6o/lMm6HF62KQLRUMpKX6Ipjf
         Si+A==
X-Gm-Message-State: AFeK/H1y/1zlsdfOiZWjNInCeqhaRfZpBtDvv3sS/yeezXycB1dqOuyZcC2D5FFvdNTvqzI0
X-Received: by 10.98.80.1 with SMTP id e1mr65694808pfb.250.1491954589342;
        Tue, 11 Apr 2017 16:49:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:118b:650f:9c66:86dd])
        by smtp.gmail.com with ESMTPSA id a87sm24346241pfe.34.2017.04.11.16.49.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 16:49:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] submodule.c: uninitialized submodules are ignored in recursive commands
Date:   Tue, 11 Apr 2017 16:49:21 -0700
Message-Id: <20170411234923.1860-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.603.g7b28dc31ba
In-Reply-To: <20170411234923.1860-1-sbeller@google.com>
References: <20170411234923.1860-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was an oversight when working on the working tree modifying commands
recursing into submodules.

To test for uninitialized submodules, introduce another submodule, that is
uninitialized in the actual tests. By adding it to the branch "add_sub1",
which is the starting point of all other branches, we have wide coverage.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 3 +++
 t/lib-submodule-update.sh | 1 +
 2 files changed, 4 insertions(+)

diff --git a/submodule.c b/submodule.c
index c52d6634c5..2fa42519a4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1332,6 +1332,9 @@ int submodule_move_head(const char *path,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const struct submodule *sub;
 
+	if (!is_submodule_initialized(path))
+		return 0;
+
 	sub = submodule_from_path(null_sha1, path);
 
 	if (!sub)
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index fb4f7b014e..22dd9e060c 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -73,6 +73,7 @@ create_lib_submodule_repo () {
 
 		git checkout -b "add_sub1" &&
 		git submodule add ../submodule_update_sub1 sub1 &&
+		git submodule add ../submodule_update_sub1 uninitialized_sub &&
 		git config -f .gitmodules submodule.sub1.ignore all &&
 		git config submodule.sub1.ignore all &&
 		git add .gitmodules &&
-- 
2.12.2.603.g7b28dc31ba

