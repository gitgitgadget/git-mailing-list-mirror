Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB834201C8
	for <e@80x24.org>; Fri, 17 Nov 2017 11:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754707AbdKQLgP (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 06:36:15 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:46964 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754349AbdKQLgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 06:36:11 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id FevAeP1Zopb8rFewJexNEZ; Fri, 17 Nov 2017 11:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510918568;
        bh=qc8gWIcI8CaqqGIJfUxVXXv1xr/KmS50ka6cmDXxKb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=BBxVldX0zXdBcmlSgwhZGwu4xbEE3OaGVE+zsd5GKZsE5o6stUVWWszAf491V7qig
         AwuX4BCEBSzPXE/Xpof0L/6Y+qXpW8r6wgX0rWu5Fym3WD4xsm2GeLVKpMECGPKwt0
         eRW1brFZ4M8yfQknov30wkK6YZdP1K+eb//qbZ4s=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=MtSNEJ5jy-OiO5VEnHwA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/8] sequencer: don't fork git commit
Date:   Fri, 17 Nov 2017 11:34:44 +0000
Message-Id: <20171117113452.26597-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDc64CB1MPzvK6LacHmEJsMxYJ3p+VxR6V/O8DZp7Rf7LOfvp1m+su1DtszJqpdMazG8twLWW0Q72EuqWx2rQ4ifaLkbX38bzCdFxj4Gqfb/6bpKqU1f
 00oWNvgVz7KVjR5LQK020huscat4PhRqMbUBlaMNkoEKD2PRNKYLOxA99kNw9vBhKR3VaCVXRQbOaTWWWpgax28LDH47Boqr7btijuO8pBPoNY7QbP9iDSXM
 oKqdbuhoEgPkxgDRsupBGC6z312jfD9nM0x8ArZhxkG993EdrsmBnR7llre3rzbI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated these based on the feedback for v2. I've dropped the
patch that stopped print_commit_summary() from dying as I think it is
better to die than return an error (see the commit message of the
patch that adds print_commit_summary() for the reasoning). Apart from
that they're minor changes - style fixes and a reworded a commit message.

Here's the original summary:
These patches teach the sequencer to create commits without forking
git commit when the commit message does not need to be edited. This
speeds up cherry picking 10 commits by 26% and picking 10 commits with
rebase --continue by 44%. The first few patches move bits of
builtin/commit.c to sequencer.c. The last two patches actually
implement creating commits in sequencer.c.


Phillip Wood (8):
  t3404: check intermediate squash messages
  commit: move empty message checks to libgit
  Add a function to update HEAD after creating a commit
  commit: move post-rewrite code to libgit
  commit: move print_commit_summary() to libgit
  sequencer: simplify adding Signed-off-by: trailer
  sequencer: load commit related config
  sequencer: try to commit without forking 'git commit'

 builtin/commit.c              | 289 +++----------------------
 builtin/rebase--helper.c      |  13 +-
 builtin/revert.c              |  15 +-
 sequencer.c                   | 486 +++++++++++++++++++++++++++++++++++++++++-
 sequencer.h                   |  23 ++
 t/t3404-rebase-interactive.sh |   4 +
 6 files changed, 561 insertions(+), 269 deletions(-)

-- 
2.15.0

