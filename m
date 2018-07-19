Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11381F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbeGSTkw (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:40:52 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:51887 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbeGSTkw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:40:52 -0400
Received: by mail-vk0-f74.google.com with SMTP id v76-v6so3192752vkv.18
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=R662rzOD/2ZsTqGm4RWGecHDdBxzmYPfgs22Z7oT7pk=;
        b=hQTyYwpUAH5o+/cytETH1KKxjigusDFpCICixjKDL4/ue8kZiKDqMobIYjje0x1nkM
         8+SDQ7Wm69k7sCqnJKZJhwIPpG2k9FtRPcAhrR0UggskBgSm9F4HtEYJR1hWcViqBhF8
         kDHMilxTT+qEjqy++pdocoj3UL5bukTgoN81Sa/G8QKDPRw3QBk2hxldnVDpvrVAMfIl
         0BlI3N8y3GB6HDqPUXpR6TCshkXb2Kk3eBFWCifje4IlILrzHoO+RVSHzdarjgO0UF11
         yQCFscOJM/GIn5xK6Kt2bU8FTYKR+1ZkUbRGJfd1ZGf5bEIalrKo/X5ydQoYhKs3xPkC
         HTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=R662rzOD/2ZsTqGm4RWGecHDdBxzmYPfgs22Z7oT7pk=;
        b=OlMmv5421OKERQgEJsfkuCFdk+K6K8I7eAsyFbLbZIRf9a6PGxxd2dHE/aIlWIl41T
         6xsF+tgiEQ6QiE0JdAr42Fr0+zd8QrsRU+3vu2WOgM8eBqlK1YNoM+M/ZLgrOHNyDzuc
         CKbn3Q4JEdhkPJ2ovq+E6W63MIyuqJ3547XBEwUyyjKydj1KK64ICZIoYt9vbiKn61eO
         ytUapyC/lCsUcGWP1mqcGMWR281ug7tWZP68+Uooi1kBLUGXp8bdSvq3yeSll9XhEPXG
         pdDUXrYiE/qh4pN+IWqAxW/FQdtUUb3aenrKBsw4vtJjQzgPsLdbWLpReMVEllPMGV/4
         4MLQ==
X-Gm-Message-State: AOUpUlGZ0Cdj6aTyLoHidkmfkMUvgNU76VVwxksdhge14sozkntqWG+c
        VgiwOPUxmFU4AgdcCX2kquq4c4nrG5FPU6eN7tVvx4792j4gOUDh1JgdIv+PcaTG+hYjUld8ERn
        heQ3Rhpcxb6WoJYKjQ3b8nZSkBMMYEiCDH6xze9e/glmv7JQ1dJt9D16VJ8HX
X-Google-Smtp-Source: AAOMgpe+x1zk7RzpUGnn0JxKeloVwUFxmnTzUGbgFtZNfOf7841WLmC60sIa20nVXSsil0+S2tCfJVFVWg6R
MIME-Version: 1.0
X-Received: by 2002:a1f:3dd0:: with SMTP id k199-v6mr5248544vka.51.1532026584620;
 Thu, 19 Jul 2018 11:56:24 -0700 (PDT)
Date:   Thu, 19 Jul 2018 11:56:17 -0700
Message-Id: <20180719185620.124768-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 0/3] histogram diff: Fix memory ballooning in corner case
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently if you run

    seq 1   100000 >one
    seq 1 4 100000 >two
    git diff --no-index --histogram one two

you might run into memory issues. After applying the last patch of this series
you only have to wait a bit (as it doesn't fix run time complexity), but
computes the result with less memory pressure.

Thanks,
Stefan

Stefan Beller (3):
  xdiff/xhistogram: pass arguments directly to fall_back_to_classic_diff
  xdiff/xhistogram: factor out memory cleanup into free_index()
  xdiff/xhistogram: move index allocation into find_lcs

 xdiff/xhistogram.c | 117 +++++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 51 deletions(-)

-- 
2.18.0.233.g985f88cf7e-goog

