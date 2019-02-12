Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4531B1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfBLW1B (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33109 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBLW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id a2so282700edi.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pmeTMDPKM93lJb5243lo/B/cCAovQPzmQ5C5K4WjQ3M=;
        b=cGE6u7FpAuE0f0B5rNTx0QcPCLrcEIL93mXTqWcVX+V7Q6C8ljuxRudgDoIFcA1mUt
         Fg62viUiWR3Etms8UGRBVwJGKehlBgdqQLYMdsiMVQFEoGP9kH73FV2m29dxN7cU5kce
         MckfMJollAjN3/KcoZ8A8hYV9dChaVumndVL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pmeTMDPKM93lJb5243lo/B/cCAovQPzmQ5C5K4WjQ3M=;
        b=uRg5rKPudjjxzVnItEqjKJGDRO+rSq6hORKN7eRZjTw3LzwqdjJg+4xKq/NUq8BEfA
         QjrVQeZ0iO81RtNlcfIUqnBGrBzxG8tH+hIn2dFmsa7iz+gNHQzeg19GNSuRMjA2ei53
         2dkndl3NbUtvfSoF59LDtLd7pG+fN1uOiqkYa/XjjHnm8QoeWZmZXN/04iHh2GQfWyF6
         oSOg+iG3LPpyDEC2Oc24KD/JeyCjeaLaxefNGOlptSY7eQ4ilkAm/4z+ClI1RfCKzGOT
         QJVMe4ayvRh5KBAMwjl+AMNuwcUBsNuFiyhrNI+J5gZUftizPrnkOhBty2SuVCmC4bT6
         R88Q==
X-Gm-Message-State: AHQUAua/OM4HNNcqvFLAUE8HIKf4XVefa9trO7xUq7r1Uoe+jlMAi2QW
        dJgHduKPfwj4LcCUQxmQgJeUNlV9JHu9GfMU
X-Google-Smtp-Source: AHgI3IbJYXM4/A+W+0jKgj0G2UBzMi+x8S5E61uDUGPvaURQ/07n4tOYt+NJNBPFfHRJ1gFS/uh5CQ==
X-Received: by 2002:a17:906:5053:: with SMTP id e19mr4333629ejk.9.1550010419365;
        Tue, 12 Feb 2019 14:26:59 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id ay20sm3349582ejb.32.2019.02.12.14.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:26:58 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC PATCH 0/5] builtin/grep.c: fix a tiny logic flaw
Date:   Tue, 12 Feb 2019 23:26:49 +0100
Message-Id: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Background: I noticed that the condition in add_work() for when the
producer could add a new item was oddly different from the other
conditions on the todo_* bookkeeping variables - namely, in the other
cases we want todo_a != todo_b, whereas in add_work the condition is
todo_a+1!=todo_b. Another hint that something is slightly off is that
the code would break down if TODO_SIZE was set to 1.

The practical effect is negligible, and fixing it seems to be a bit
involved, hence probably not worth the churn - and if that's the
verdict, I suggest adding a comment in add_work() for future readers
and/or people who copy the producer/consumer logic to their own code.

Rasmus Villemoes (5):
  builtin/grep.c: change todo_* variables to unsigned
  builtin/grep.c: refactor loop in work_done() slightly
  builtin/grep.c: add shorthand for &todo[todo_end] in add_work()
  builtin/grep.c: add todo_item helper
  builtin/grep.c: fix fence-post error in add_work()

 builtin/grep.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.20.1

