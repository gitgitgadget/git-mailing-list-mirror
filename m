Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7922022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdBWXs7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:48:59 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35350 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pf0-f180.google.com with SMTP id 68so478883pfx.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QOiVwhOcABS7lMOQHn8pUVghKISNw2Y+3TQ+FVp9o5w=;
        b=mvLtQRl6LQwE91Nyw2mC8czc+kJmSjfWv8auCcN3xHeL+zey4YEyfSv8kr9cX1I1s6
         h0j6Yo+7i0ibDYa0G5Vsdl+NUcHAd3x/VdhsZEX0QxlW9Kz6w7+49cTkwtcjLU691HZC
         BxazEdCSa78LxnYESfmcJg2H6brVtw1heE01Zkq1ZUJ+tF0VX90pjvwpOKzUNrWkZ0U3
         GqlBpfvqdC7TygyzWmYkvM8XieL34TsoQMNpkcaouVxPv5eUY/uEchbdFjc7Xc9xyLJU
         FIoxGt+MffJ12aXDbaL1XEh6Z8fRs4p7YqHtM6lO9M6vkrKNARUEeVmL31jITk58d0pr
         tdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QOiVwhOcABS7lMOQHn8pUVghKISNw2Y+3TQ+FVp9o5w=;
        b=lJichkzjTKStiapPZuGUfk1hD/ii5jYSGVeksQYMjOnGpaCzcQML+U3WPbPs6lWJC6
         FmJ7CtGQRU/wt2P6obnA7NQZxVqaDRNpRe7UkHnvBuJZ9mYV5Y8x2Ri89g9Au8qQ5TPd
         n8Iv1JF06kMc8sLdny7RABwiqGW5ccXbajDW+KXwFcdWIf7Q3Gzc3n4ffiKP8NmzX1c0
         rraUktLEatyCKRiv36A+bsrTxoRE22a4oT26T9L1ciTGOUYTDCW/NCtxg4X7PIWkCNL2
         aDR/qGOvGHpo2BhhFfpVT1J1tMr/7Jxl8GeF9M/jofVOEY3tEMcOf6SYAKJyUvlTAkhy
         BUQQ==
X-Gm-Message-State: AMke39mf8xAZuxwUQuIvvMqX56MV0b6n+cdkL1kXhuNiwHh9DUih6/KnFoGde/hXhcz/l3BL
X-Received: by 10.84.142.1 with SMTP id 1mr58886844plw.127.1487893659117;
        Thu, 23 Feb 2017 15:47:39 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:37 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 00/10] decoupling a submodule's existence and its url
Date:   Thu, 23 Feb 2017 15:47:18 -0800
Message-Id: <20170223234728.164111-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two motivations for decoupling a submodule's existence from the url
that is stored in .git/config.

1. Worktrees can't really be used with submodules since the existence is
   checked based on the shared .git/config.  This means that two different
   worktress have to have the same initialized submodules.  By decoupling a
   submodule's existence from the url, two different work trees can be
   configured to have different submodules checked out.
2. Easily configure gorups of submodules that a user is interested in.  In a
   repository with hundreds of submodules it would be difficult to easily tell git
   which modules to worry about without having to individually init all of
   them.  Instead, a pathspec can be used to more easily select or deselect
   groups of submodules.

This patch series works to do this decoupling and instead allows a user to
configure submodule.active with a pathspec to use to check if a submodule is
initialized.

Brandon Williams (10):
  submodule: decouple url and submodule existence
  submodule update: add `--init-active` switch
  clone: add --submodule-spec=<pathspec> switch
  completion: clone can initialize specific submodules
  submodule--helper: add is_active command
  submodule add: respect submodule.active
  submodule status: use submodule--helper is-active
  submodule deinit: use most reliable url
  submodule sync: use submodule--helper is-active
  submodule--helper clone: check for configured submodules using helper

 Documentation/git-clone.txt            |  23 ++++---
 Documentation/git-submodule.txt        |  11 +++-
 builtin/clone.c                        |  36 ++++++++++-
 builtin/submodule--helper.c            |  22 ++++---
 contrib/completion/git-completion.bash |   1 +
 git-submodule.sh                       |  39 +++++++++---
 submodule.c                            |  25 +++++++-
 t/t7400-submodule-basic.sh             | 109 +++++++++++++++++++++++++++++++++
 t/t7413-submodule-is-active.sh         |  85 +++++++++++++++++++++++++
 9 files changed, 323 insertions(+), 28 deletions(-)
 create mode 100755 t/t7413-submodule-is-active.sh

-- 
2.11.0.483.g087da7b7c-goog

