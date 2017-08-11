Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBE520899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbdHKWtV (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:49:21 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33861 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753638AbdHKWtV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:49:21 -0400
Received: by mail-pg0-f47.google.com with SMTP id u185so20581012pgb.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 15:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PKrf1fr+5Fo//xPSlp09N93KNS1Rc7PSuUAm9BbQ+wQ=;
        b=ByiCyzEaBF6cAO6YlkE2siFmiRPriTVR65aDcnsOdPcZHXZGPRSay/bqPdPMyBB/BW
         ij6aG6C5+Ka/xJSU6NLjbaWLhrHunfnrnmnzFRLLYClXAs1JLevK78XbDB0UfsJbYoLJ
         Y4nSxnP2x7KCaTgELlhzEz94tIjrNtxpqznjwz1HldIWvFCv6cvK9ZdFlUXivBbGqW/3
         NOEUeK92eQe+w/ozMbBBRtSouqK0a2v64YZqs4MpPzPJAfAiVWI3zjYEa0iEKrnieyWW
         4kPXKRcMqNIo8oQRMx3LJ4aw6G/TzjTihNa9y6KVv7Bjy+eT4pSlawZFTufU+47fGqzb
         fxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PKrf1fr+5Fo//xPSlp09N93KNS1Rc7PSuUAm9BbQ+wQ=;
        b=NaNOnOaA1YQ1IRqafPCXPZubA3CZW5ZSk8gwa7OeRdG2P8eE/lfjnQiYrWle3La/Cy
         OQetL6g0WdxXSrsFZ72pPbt4WIGNT0H4MwVoJWuHuHFy2rWm0JR1F4bGIvJdVBohI1Gr
         JRdHUYdwolX74vPGaHjTGrZc66y5Jv2TRTcEAzJ9Dq3hhbEVBZg1+G6hCZmqBvQsVL+v
         gGAuQR8E3AulPjR9AAjIS+e0Bd61cq4C3eM1uwQpQ5zRT9dhDtl5fR8uRL+HQcYu7Cig
         2Q/hPdZPQ/WQy2oZJWuYHjFh31pGYB9tqTxceLQAzuNg5J4QK9j3ZXofkinMyrSsHCoA
         RkcQ==
X-Gm-Message-State: AHYfb5hWTHzt65OZqkGMX5YgiEJVmrDqj0O4ZID7yNLo1lchpgUdBiT+
        +u8G0Y3L23UZEW1WPQ/TPw==
X-Received: by 10.84.160.226 with SMTP id v31mr18784839plg.91.1502491760226;
        Fri, 11 Aug 2017 15:49:20 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id j9sm3780502pfk.30.2017.08.11.15.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 15:49:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [RFC PATCH 0/3] Fixes to "diff --color-moved" MIN_BLOCK_LENGTH handling
Date:   Fri, 11 Aug 2017 15:49:13 -0700
Message-Id: <cover.1502491372.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that these patches are for "next", depending on the "--color-moved"
patches.

While working on something else [1], I noticed some irregularities with
how "diff --color-moved" treats the minimum block size, occasionally
coloring blocks smaller than that as moved.

I've marked this as RFC because now I'm not sure if minimum number of
lines is the best way to handle the minimum block size. In particular,
an existing test (in t4015) assumes that 2-line blocks can be
legitimately colored as moved (and notice that it is now marked
test_expect_failure in patch 3), and in my work, I would also like the
rules to be relaxed. What do you think of also changing the rule to,
say, "minimum 10 non-whitespace characters"?

[1] https://public-inbox.org/git/cover.1502483486.git.jonathantanmy@google.com/

Jonathan Tan (3):
  diff: avoid redundantly clearing a flag
  diff: respect MIN_BLOCK_LENGTH for last block
  diff: check MIN_BLOCK_LENGTH at start of new block

 diff.c                     | 35 +++++++++++++++-----
 t/t4015-diff-whitespace.sh | 80 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.14.0.434.g98096fd7a8-goog

