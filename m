Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933031F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdGYVjr (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:39:47 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35871 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdGYVjo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:44 -0400
Received: by mail-pg0-f46.google.com with SMTP id 125so75320892pgi.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JrC1ufnyO4Hh9H/xphrvSddumUlkN+ml8EUiErRCRzY=;
        b=rfqz4eGHrH6m0MR9GWzxmLsPZrgq3nvn7mV7i2K9h/VmSBytzZP5svL6fHFSqE2/VS
         QLiXtlArqFEOFiyrlQNgGV6yMdnjtixlOKQtnc4h8e/URmxRFdGxgWZPONVyf/IrE7Lg
         7epwq86dEXKZg8qG1HofFkXqQxy065gYp1N/Sp1g6BODp5iZt3kszfnDW3VjlIezop9Y
         YonNRtPduNDrEVISWJYYbCtBnWenGizKH5aoNsjBdpu84e8FmM0aizJYTe5zpHHSz2UW
         uvsQxonRGB/qnjC42FNhsL1e908r5OHBZ/IJWW9J9BpLxFMJzcIAqCHAftlxuocGKDrY
         CiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JrC1ufnyO4Hh9H/xphrvSddumUlkN+ml8EUiErRCRzY=;
        b=Ez6GquFQB1N6yFwGWQuouZtDVyX9XVa6u9yTi68O1HbNUG025Sxryu7cM6+g50Lrw/
         2VzxoFXfblkwsQ0TQjYBpBxZSBa0PcE5GZRRygHZlQzlazOdMU4ERKmzuQpu9TXdUC98
         EHgMW6IAxtLO5sEdVyJpVZEyfnmLEGVL2MuAeg8XpokZPnLe++PjaWbrHvSL1h7tmH/C
         1K4v+u+BmfnKCxLb9PM8UwfyYTawLPDcX6pMU2J2JrZ9FdxZxhnaUoTj5w+H2BKe9HoP
         4nE2P2HjTRlIo2e+XMjHSqcRw/TsJYtgR215fnqzVX/bYtL0lHCXRWcQZmxSrAtBI6j8
         nJtQ==
X-Gm-Message-State: AIVw112sigmSwTw3KEF8s4+vKHaVCDQS4onimTsSh46pdOXmrAectkHC
        T7AEJ5LZsROJ5V5DbZ1qbg==
X-Received: by 10.84.229.8 with SMTP id b8mr22253143plk.93.1501018783350;
        Tue, 25 Jul 2017 14:39:43 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:42 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 02/15] submodule: don't use submodule_from_name
Date:   Tue, 25 Jul 2017 14:39:15 -0700
Message-Id: <20170725213928.125998-3-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function 'submodule_from_name()' is being used incorrectly here as a
submodule path is being used instead of a submodule name.  Since the
correct function to use with a path to a submodule is already being used
('submodule_from_path()') let's remove the call to
'submodule_from_name()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7e87e4698..fd391aea6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1177,8 +1177,6 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 
 		submodule = submodule_from_path(&null_oid, ce->name);
-		if (!submodule)
-			submodule = submodule_from_name(&null_oid, ce->name);
 
 		default_argv = "yes";
 		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-- 
2.14.0.rc0.400.g1c36432dff-goog

