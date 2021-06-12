Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65575C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3474661287
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 16:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhFLQxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 12:53:02 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:39504 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhFLQxB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 12:53:01 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:4c5e:b9bc:baad:cb60])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id BA09548C9D2;
        Sat, 12 Jun 2021 18:50:56 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1623516656; bh=fODGpUQ6aCVgW2ROHbr6/aULGQ4VdhPaldNavSmf7jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=83f9uexVtXKSs7msmghJL6Jj4xCa0bQaszxJMgtaVzdnBcHqAggwUTOY1aAv3or56
         Slr3enMdraTLoxlMleo0gOCUOtlewtbE8ta1maM923KXBjVDM1U8w++36E2i0A5LhR
         +ovwxOQRgnzuTpJPLVhpkZhFDMTiBFtR+o+0eClk=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v6 0/3] maintenance: add support for systemd timers on Linux
Date:   Sat, 12 Jun 2021 18:50:40 +0200
Message-Id: <20210612165043.165579-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608134000.663398-1-lenaic@lhuard.fr>
References: <20210608134000.663398-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Please find hereafter my fixed patchset to add support for systemd
timers on Linux for the `git maintenance start` command.

There are very few changes compared to the previous version.
The main change is the fix for the use-after-free bug that Jeff
pointed out.
Except from that, I’ve done some minor style fixes based on the `git
clang-format --diff …` recommendations.

The patches are:

* cache.h: Introduce a generic "xdg_config_home_for(…)" function

  This patch introduces a function to compute configuration files
  paths inside $XDG_CONFIG_HOME.

  This patch is unchanged compared to its previous version.

* maintenance: `git maintenance run` learned `--scheduler=<scheduler>`

  This patch adds a new parameter to the `git maintenance run` to let
  the user choose a scheduler.

  The only changes in this patch compared to its previous version are
  some code alignment changes that were suggested by `git clang-format
  --diff …`

* maintenance: add support for systemd timers on Linux

  This patch implements the support of systemd timers on top of
  crontab scheduler on Linux systems.

  The only change in this patch compared to its previous version is
  the fix of the use-after-free bug that Jeff pointed out.
  I’ve moved the `free(filename)` after the last usage of `filename`.
  I left the `free(filename)` below the `error` label as the
  `filename` will always be allocated at each `goto error`.

Best wishes,
Lénaïc.

Lénaïc Huard (3):
  cache.h: Introduce a generic "xdg_config_home_for(…)" function
  maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
  maintenance: add support for systemd timers on Linux

 Documentation/git-maintenance.txt |  60 ++++
 builtin/gc.c                      | 562 ++++++++++++++++++++++++++----
 cache.h                           |   7 +
 path.c                            |  13 +-
 t/t7900-maintenance.sh            | 110 +++++-
 5 files changed, 674 insertions(+), 78 deletions(-)

-- 
2.32.0

