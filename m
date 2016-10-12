Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5071F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 01:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbcJLB3L (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 21:29:11 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33457 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbcJLB3L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 21:29:11 -0400
Received: by mail-pf0-f172.google.com with SMTP id 128so10755995pfz.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Gj01v46vL1uCG1fGoG8mYLII7hSYmcqpuB0ITi/429o=;
        b=WcDTaEnr2o7tZt5bpSs56wkXAiIP1d5Co+i9ZrYAFimBLBozjBwAJ1RNofEKnps0ew
         RY8Sa7g/UxMdF1ZBZI/tuhrdo1x1rSAkWc/Q05IvMCoR6fBWjswr/PF7p02dwI37YjBH
         q/5npgd79sjCLQli3W4Fek++x1EQZamFK8dv5xLjS9jWv4mDobrFSOa8Pm6S48JfR6+R
         41904Bz2jDQwAm31vc0s3rpqT6u9/eVEPDk+QBkCtW9QLpWPym+U2cllj2JbnmOze5ho
         QFCl+dZBGJ6oSicyhnhMcj3iycqrwgL1Nywnc94ujfkaOaGmGaFDKSaO8sSTSfSlQ5/A
         eYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gj01v46vL1uCG1fGoG8mYLII7hSYmcqpuB0ITi/429o=;
        b=bVi50Koea1Ll3IDLRB/vDzLMOgbwGoQYjp1EfRhKSIX59dSFsZjXtFbsOQBWN28Kx3
         NJbep0BH8bCDIkNVhFFwQgXTRAOF2f8Zk+SCPrdn1tobGFiRRTHfXm/6jYw5ITItwo0m
         xh3LokrUAcQVxJOPWsldLSFSWivg8AqGPnjiK9VNrnzV1jAQaLhaHk/XvvDuSX9viZWV
         Xt49T/vjzdK6hQR6P76NIgCO366cFUNTmaX65ioo0IgOFZSqttVHdyQAx9nFLS27u1f6
         ZItOQGfcRpNVSGf/5ULtZnZqFmxM6tT9XOgBDdB9IocXNBTIyhQvUCpKxQWWZef7N113
         MYRg==
X-Gm-Message-State: AA6/9RleIj9ksdKtvaVFEfoJZSBKfd4iozRqkgBuiguXiqUWVYpKahUtHxgrkRsgGuOXRlsA
X-Received: by 10.98.4.6 with SMTP id 6mr1287661pfe.152.1476235414075;
        Tue, 11 Oct 2016 18:23:34 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b11sm7175042pfb.49.2016.10.11.18.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 18:23:32 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, gitster@pobox.com
Subject: [PATCH 0/5] allow non-trailers and multiple-line trailers
Date:   Tue, 11 Oct 2016 18:23:24 -0700
Message-Id: <cover.1476232683.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1], Junio explained a possible redesign of trailer support in
interpret-trailers and cherry-pick, something along these lines:

 1. Support non-trailers and multi-line trailers in interpret-trailers
 2. Create a helper function so that the new interpretation can be used
    elsewhere (e.g. in sequencer)
 3. Modify "Signed-off-by" and "(cherry picked by" to use the helper
    function

My current plans for step 1 and step 2 require relatively significant
refactoring in trailer.c, so I thought that I should send out a patch
set covering only step 1 first for discussion, before continuing with my
work on top of this patch set.

Support for steps 2 and 3, including my original use case of being
looser in the definition of a trailer when invoking "cherry-pick -x"
(and thus suppressing the insertion of a newline) will come in a
subsequent patch set.

[1] Message ID <xmqqwphouivf.fsf@gitster.mtv.corp.google.com>

Jonathan Tan (5):
  trailer: use singly-linked list, not doubly
  trailer: streamline trailer item create and add
  trailer: make args have their own struct
  trailer: allow non-trailers in trailer block
  trailer: support values folded to multiple lines

 Documentation/git-interpret-trailers.txt |  10 +-
 t/t7513-interpret-trailers.sh            | 174 +++++++++
 trailer.c                                | 638 +++++++++++++++----------------
 3 files changed, 480 insertions(+), 342 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

