Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129FBC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B226135C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhETWYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 18:24:51 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:51724 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhETWYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 18:24:48 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:12f:f769:9e2d:d907:5e8f:73c3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 2F26C46FB70;
        Fri, 21 May 2021 00:22:52 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1621549374; bh=NFk8HN5mTfH1KQKfu7xrRUbTYrXO6AC/C6ebYsnAKMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZPLjWKiffCiMoUE689fV6C5O/sWwsJ3kAsvzsBgtDYKgl9a9zsgxihatc+YvyNbdt
         7nV4anrzrdOXHJYefm3mJa/srTPiaHryCj6thovvKOi5CvRFicP8spXhipovwjmodN
         OKC7FOzyqNYTjF0d81T+ZHVobGNdYiltFT7HER1A=
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
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v3 0/4] maintenance: use systemd timers on Linux
Date:   Fri, 21 May 2021 00:13:55 +0200
Message-Id: <20210520221359.75615-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509213217.449489-1-lenaic@lhuard.fr>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thanks again for your valuable feedback!
I’ve reworked this submission to hopefully address all the raised
concerns.

As it’s becoming bigger, I’ve split it in several patches:

* cache.h: rename "xdg_config_home" to "xdg_config_home_git"

In order to honor `$XDG_CONFIG_HOME` to built the path of systemd units,
a lot of code from the `xdg_config_home()` function was
duplicated. This existing function couldn’t be used as-is because
it was hard-coding the `git` sub-directory below `$XDG_CONFIG_HOME`.

This first preparatory patch re-purposes `xdg_config_home()` to make
it more generic by removing the `git` path it used to append to
`$XDG_CONFIG_HOME`.
Thanks to this refactoring, `xdg_config_home()` can be used to build
paths like:
* `$XDG_CONFIG_HOME/git/…` it’s the new `xdg_config_home_git()`
function and
* `$XDG_CONFIG_HOME/systemd/user/…` it’s the new
`xdg_config_home_systemd()` function which will be introduced later,
in the last patch of this series.

* maintenance: introduce ENABLE/DISABLE for code clarity

Some functions in git maintenance are doing one thing and the exact
opposite, depending on a parameter that could be `0` or `1`.
This could sometimes be confusing.
This patch introduces an enum with `ENABLE` and `DISABLE` values to
make the code more explicit.

* maintenance: `git maintenance run` learned `--scheduler=<scheduler>`

This patch contains all the code that is related to the addition of
the new `--scheduler` parameter of the `git maintenance start`
command, independently of the systemd timers.

This part has significantly changed to review the testing mechanisms.
The `GIT_TEST_MAINT_SCHEDULER` environment variable can now take a
comma separated list of schedulers and their mock in order to be able
to test cases where multiple schedulers are available.

It allows to test that `git maintenance start --scheduler=XXX` not
only enables the scheduler XXX, but it also disables all the other
available ones.
We can also test that `git maintenance stop`, stops all the available
schedulers.

In order to remove the `cmd` parameter that was passed to a lot of
functions, the parsing of `GIT_TEST_MAINT_SCHEDULER` is now factorized
in a `get_schedule_cmd()` function that is invoked from the leaves of
the function call tree.
It means that this function is called many times to parse
`GIT_TEST_MAINT_SCHEDULER` again and again.
It is inefficient but as it is used for test only, it shouldn’t be a
concern.

`int get_schdule_cmd(const char **cmd, int *is_available)`

This function returns `true` if `GIT_TEST_MAINT_SCHEDULER` is
defined. `false` otherwise.

`*is_available` is set to `true` if `*cmd` is present in
`$GIT_TEST_MAINT_SCHEDULER`, and to `false` otherwise.

If `*cmd` is present in `$GIT_TEST_MAINT_SCHEDULER`, it’s value is
updated to its mock.

* maintenance: optionally use systemd timers on Linux

This last patch adds the support for systemd timers.

Lénaïc Huard (4):
  cache.h: rename "xdg_config_home" to "xdg_config_home_git"
  maintenance: introduce ENABLE/DISABLE for code clarity
  maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
  maintenance: optionally use systemd timers on Linux

 Documentation/git-maintenance.txt |  60 ++++
 attr.c                            |   2 +-
 builtin/config.c                  |   2 +-
 builtin/credential-cache.c        |   2 +-
 builtin/credential-store.c        |   2 +-
 builtin/gc.c                      | 549 ++++++++++++++++++++++++++----
 cache.h                           |  12 +-
 config.c                          |   2 +-
 dir.c                             |   2 +-
 path.c                            |  35 +-
 sequencer.c                       |   2 +-
 t/t7900-maintenance.sh            | 110 +++++-
 12 files changed, 685 insertions(+), 95 deletions(-)

-- 
2.31.1

