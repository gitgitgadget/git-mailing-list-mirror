Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97192C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DAF61040
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 13:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhFHNng (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:43:36 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:46766 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232403AbhFHNnf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 09:43:35 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:4a10:7e85:729c:98ea])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 7BD8248743B;
        Tue,  8 Jun 2021 15:41:08 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1623159669; bh=+FACmCFCTGMcJzpo5qpPHrLqU0/t7/YEFqtnv6XPXOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nYaDsQS9SjrnnC8qwtPYLXZrPyZ7w3e/Dmmtz0RYgY4p663nTnTdWtTL3cMNXv1tf
         pTDi7NFrUHY8yFcVvz8AJM0t8QWENFkmwJt4HU2PMNI+V/zcXat+Wlv97UkIQPb8CY
         lgmQPVsnkYtvsbrfeyMKPKg+j4gDFB9RVnvdbtss=
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
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v5 0/3] add support for systemd timers on Linux
Date:   Tue,  8 Jun 2021 15:39:57 +0200
Message-Id: <20210608134000.663398-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210524071538.46862-1-lenaic@lhuard.fr>
References: <20210524071538.46862-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I’ve reworked this submission based on the valuable feedback I’ve received.
Thanks again for it!

The patchset contains now the following patches:

* cache.h: Introduce a generic "xdg_config_home_for(…)" function

  This patch introduces a function to compute configuration files
  paths inside $XDG_CONFIG_HOME or ~/.config for other programs than
  git itself.
  It is used in the latest patch of this series to compute systemd
  unit files location.

  The only change in this patch compared to its previous version is
  the renaming of the first parameter of the `xdg_config_home_for(…)`
  function from `prog` to `subdir`.

* maintenance: introduce ENABLE/DISABLE for code clarity

  I just completely dropped this patch as it turned out that replacing
  some 0/1 values by `ENABLE`/`DISABLE` enum values wasn’t making the
  code look nicer as initially expected.

* maintenance: `git maintenance run` learned `--scheduler=<scheduler>`

  This patch contains all the code that is related to the addition of
  the new `--scheduler` parameter of the `git maintenance start`
  command, independently of the systemd timers.

  The main changes in this patch compared to its previous version are:

    * Revert all the changes that were previously introduced by the
      `ENABLE`/`DISABLE` enum values.

    * Remove the `strlcpy` in the testing framework inside the
      `get_schedule_cmd` function.

    * `update_background_schedule` loops over all the available
      schedulers, disables all of them except the one which is
      enabled.
      In this new version of the patch, it is now ensured that all the
      schedulers deactivation are done before the activation.
      The goal of this change is avoid a potential race condition
      where two schedulers could be enabled at the same time.
      This behaviour change has been reflected in the tests.

    * The local variable `builtin_maintenance_start_options` has been
      shortened.

* maintenance: add support for systemd timers on Linux

  This patch implements the support of systemd timers on top of
  crontab scheduler on Linux systems.

  The main changes in this patch compared to its previous version are:

    * The caching logic of `is_systemd_timer_available` has been
      dropped.
      I initially wanted to cache the outcome of forking and executing
      an external command to avoid doing it several times as
      `is_systemd_timer_available` is invoked from several places
      (`resolve_auto_scheduler`, `validate_scheduler` and
      `update_background_scheduler`).
      But it’s true they’re not always all called.
      In the case of `maintenance stop`, `resolve_auto_scheduler` and
      `validate_scheduler` are not called.
      In the case of `maintenance start`, the `if (enable &&
      opts->scheduler == i)` statement inside
      `update_background_schedule` skips the execution of
      `is_systemd_timer_available`.

    * The `is_systemd_timer_available` has been split in two parts:
      * `is_systemd_timer_available` is the entry point and holds the
        platform agnostic testing framework logic.
      * `real_is_systemd_timer_available` contains the platform
        specific logic.

    * The error management of `systemd_timer_write_unit_templates` has
      been reviewed.
      The return code of `fopen`, `fputs`, `fclose`, etc. are now
      checked.
      If this function manages to write one file, but fails at writing
      the second one, it will attempt to delete the first one to not
      leave the system in an inconsistent state.

    * The error management of `systemd_timer_delete_unit_templates`
      has also been reviewed. The error code of `unlink` is now
      checked.

I hope I’ve addressed all your valuable feedback. Do not hesitate to
let me know if I’ve forgotten anything.

Lénaïc Huard (3):
  cache.h: Introduce a generic "xdg_config_home_for(…)" function
  maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
  maintenance: add support for systemd timers on Linux

 Documentation/git-maintenance.txt |  60 ++++
 builtin/gc.c                      | 564 ++++++++++++++++++++++++++----
 cache.h                           |   7 +
 path.c                            |  13 +-
 t/t7900-maintenance.sh            | 110 +++++-
 5 files changed, 676 insertions(+), 78 deletions(-)

-- 
2.32.0

