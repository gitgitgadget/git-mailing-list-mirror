Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEE420954
	for <e@80x24.org>; Fri, 24 Nov 2017 11:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbdKXLIO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 06:08:14 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57722 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbdKXLIN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 06:08:13 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id IBq0eNps6Ap17IBq6eb1BI; Fri, 24 Nov 2017 11:08:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511521691;
        bh=aq5AJYjV3si6e9e+byGtk7mTx3R/L2u4n8bGdph1IWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=lDfgDMFYgrk8Uay6N57P3OmwuaeBmyX9CT5uVl8cxje6Tys1FIvvj8E4fwvZ9ngV0
         QC0Gn/BI6q5ehI8gujTr2NiqZzEnhPo8UfXBk+lhxbbeb6qCXx9g1XytSxf7hfHHOv
         uOZqEb51ORE7smi/glz4gjqiZEVY8RNAk4NL0cjU=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=oiBNXzDSRNRMXQ8EyGAA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 0/9] sequencer: don't fork git commit
Date:   Fri, 24 Nov 2017 11:07:49 +0000
Message-Id: <20171124110758.9406-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGwGswSee6wOeCXD0AyVfNaTC/zCT3Om9k7A+svH9NxbqWWWjhqDma3K9byIm7E3TyBu0f9dKKxzu20Vk4bj5FLX5W4m5gNguZ01LLaFBCur1ITkE2ky
 gTUbSw6IsmBsSoezFYvUFvhy5c9dlr0xP6CpN7yFUPXR7JwD/fqtafRSN5zE0imRj5puy++G3iAVcP07RQt2Jfwbr9HX81VI9p52L7JyhAnH0jnsU77UnUL+
 BMi9RcjnvdJhw5iapH8F2DvNbOHurWWcsxlhRhZqE/WpKxRUu5c38dSAqqBCAECpC0gZ7iC3oAS8GI1VhtzTQi/+TE/IpdMStfgG9io6tqDvF3IqehIiakXo
 jXiN98Mg9kgP8cWcFUQc4UvTha1SJ5gQmUFZhsjhzlIafd9ILvQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated the patches to fix the embarassing build failure in
v3. I've also added a patch to remove the known breakage from some of
the tests in t3512/t3513 that now pass - someone who knows about
submodules should check this. The only other change is to interpret
commit.cleanup=scissors to mean COMMIT_MSG_CLEANUP_SPACE when loading
the default value for message cleanups to be consistent with 'git
commit'. (I can't imagine many people have that value set in their
config)

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
 builtin/rebase--helper.c         |  13 +-
 builtin/revert.c                 |  15 +-
 sequencer.c                      | 486 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h                      |  23 ++
 t/t3404-rebase-interactive.sh    |   4 +
 t/t3512-cherry-pick-submodule.sh |   1 -
 t/t3513-revert-submodule.sh      |   1 -
 8 files changed, 561 insertions(+), 271 deletions(-)

-- 
2.15.0

