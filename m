Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEFFC1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbdLKONr (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:13:47 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:7040 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbdLKONq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:13:46 -0500
Received: from lindisfarne.localdomain ([92.22.30.250])
        by smtp.talktalk.net with SMTP
        id OOpteDPs4CbAZOOpzeBiuP; Mon, 11 Dec 2017 14:13:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513001624;
        bh=x3qGr8tsOm1e3l6sMYWV7arU9rFMspem/53NQTi1Fsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=a6B9u/y0EGhEviZSHABXjCahG9GEz2z/Zu6pn3rVrz3pDcA+8EbvtrjAikw+wZZcm
         xMBH4Gsnyez2S+qCuJmWTcjqt1KQOKDvPsA0cPwvrwiItKrZbhwxPt37zxr8RK2f3O
         qO+hyEFFXyDKpzZiZ+CTRqGXiiT+2ooslF5Zezy8=
X-Originating-IP: [92.22.30.250]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=hCO86xb6nvxPok+3LE1svw==:117
 a=hCO86xb6nvxPok+3LE1svw==:17 a=evINK-nbAAAA:8 a=sic9uHN5Wr5lsHpCApQA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 0/9] sequencer: don't fork git commit
Date:   Mon, 11 Dec 2017 14:13:21 +0000
Message-Id: <20171211141330.23566-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBgt4Y0EiPJGtUn7+k6+nS2aJKGToRgWxH+qBnV9URVbGwPhG6ZEt44HENUVr7OADtPpxRN0K4o27kFsJitXR5lZoY4So28u0WOuG7Mf1FLYb5XCMYGd
 VhyvcUu65IHmxrqlOxyZZjubQh+8pyiVPo8fgZ8UQoZIY/A5tdRkqHnt2dQVy6U1CAsaQuFUW6DcadN6n6cZ1kx1QFD7ALuYy+xgE980/q5EeK12Ec1FwB98
 j8Zlsmhv3Xvk7R1H6yqNHMOaXZZG9uUdOJosxX/kAqqdb4MQqlXrw1bd+yJS6nEGvk0bm3NgRdJ++Mo+iNET8fDq2KnyDw6ltXOZdtxnVMVBHFJcppqQFqlw
 y2LsZaxP7VJAJabmPxXj0AA8c11eO29YIiF1BRsbaEYb+zTwAJ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've reworked the config handling since v4. It now stores the default
values in struct replay_opt rather than using global variables and
calls git_diff_basic_config(). Unfortunately I've not had time to
modify git_gpg_config() to indicate if it successfully handled the key
so git_diff_basic_config() is called unnecessarily in that case. Within
git_diff_basic_config() userdiff_config() also suffers from the same
problem of not indicating if it has handled the key.

Here's the original summary:
These patches teach the sequencer to create commits without forking
git commit when the commit message does not need to be edited. This
speeds up cherry picking 10 commits by 26% and picking 10 commits with
rebase --continue by 44%. The first few patches move bits of
builtin/commit.c to sequencer.c. The last two patches actually
implement creating commits in sequencer.c.

Phillip Wood (9):
  t3404: check intermediate squash messages
  commit: move empty message checks to libgit
  Add a function to update HEAD after creating a commit
  commit: move post-rewrite code to libgit
  commit: move print_commit_summary() to libgit
  sequencer: simplify adding Signed-off-by: trailer
  sequencer: load commit related config
  sequencer: try to commit without forking 'git commit'
  t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1

 builtin/commit.c                 | 289 +++--------------------
 builtin/rebase--helper.c         |   2 +-
 builtin/revert.c                 |   4 +-
 sequencer.c                      | 495 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h                      |  24 ++
 t/t3404-rebase-interactive.sh    |   4 +
 t/t3512-cherry-pick-submodule.sh |   1 -
 t/t3513-revert-submodule.sh      |   1 -
 8 files changed, 549 insertions(+), 271 deletions(-)

-- 
2.15.1

