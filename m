Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4AD20966
	for <e@80x24.org>; Fri,  7 Apr 2017 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933777AbdDGT3Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 15:29:25 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35577 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932598AbdDGT3X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 15:29:23 -0400
Received: by mail-pg0-f51.google.com with SMTP id 81so75046510pgh.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ITv2psrGCkMw3RvfL8pKwcKFFq8Hj65Dhx8RnPlb5Cc=;
        b=N0DCBu4Ly9Cvgs9HDgpv9cwTd1RD5qPLtS1wSfBHC2lEqXvsqFSQtprwN9e+3Jt7wB
         4wq/wpwoATUsUqUQW2hTx5EkKKLCG3/FgTuLdUpD0cMtkUfT3D1ZWWXY+E9Kw3Dmqvjc
         bIDHc5kE41kw37j+1D5T+TgNGKRpRbf4+yIJbwPCm/Z3Iarq+1W6mswhwJhu0usbMiR3
         GMj88XBEv7RhiFm5Hzp7RQ+e/uo1zInPeZSDrzZEoiHAtqLDMeLbvmNGp6BIc5XIVbfI
         yS/ZRsI9uVzJaJnuE1GGyXft+B9yKqe02K3Fn5QEnnb/TxWtliawsD29IYnsHpeIGMVh
         tVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ITv2psrGCkMw3RvfL8pKwcKFFq8Hj65Dhx8RnPlb5Cc=;
        b=GAo7pL8CmAZiqhnSZAc3TztZ4BtDZdRkjjKXt1TslX6wCX14c5PrFkN2GV5dzkTlmG
         IeKXs+9iiVB1O6T+f851aacpiLFis06WbXV9DXgyrp7l4tCZKu58OtV44EfHugQS/3XU
         TcxV3ciV+3gXPgdmWjJdK/3mxvc1C0c7vFyyvumO4odex1DO6hxStGVFz7kjT8nFxMHk
         a+1/yUrtgoGsfPfMcAi+07fo3AAe29TdYYxTStRywCKZAu61tfRXHq/z3P3/jhdPBif7
         kSD+xX472Nh+nj8QIJVwA6via8ctej08jf3D6iILHHaFzT4O6BwubHU46U6QjBGD8B0p
         cE2Q==
X-Gm-Message-State: AN3rC/6bPOgKlMvUUMQTdlvnrYcO/UA10cZ4MLhWNnuJgH4S7h1zVxe050ZmYO4PWxPbgXfb
X-Received: by 10.98.75.25 with SMTP id y25mr4542645pfa.157.1491593362497;
        Fri, 07 Apr 2017 12:29:22 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l29sm11050125pfb.118.2017.04.07.12.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 12:29:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH] pathspec: fix segfault in clear_pathspec
Date:   Fri,  7 Apr 2017 12:29:19 -0700
Message-Id: <20170407192919.10209-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 'clear_pathspec()' the incorrect index parameter is used to bound an
inner-loop which is used to free a 'struct attr_match' value field.
Using the incorrect index parameter (in addition to being incorrect)
occasionally causes segmentation faults when attempting to free an
invalid pointer.  Fix this by using the correct index parameter 'i'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 303efda83..69ef86b85 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -724,7 +724,7 @@ void clear_pathspec(struct pathspec *pathspec)
 		free(pathspec->items[i].match);
 		free(pathspec->items[i].original);
 
-		for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
+		for (j = 0; j < pathspec->items[i].attr_match_nr; j++)
 			free(pathspec->items[i].attr_match[j].value);
 		free(pathspec->items[i].attr_match);
 
-- 
2.12.2.715.g7642488e1d-goog

