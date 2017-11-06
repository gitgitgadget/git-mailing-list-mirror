Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51731202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbdKFL14 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:27:56 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:15362 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbdKFL1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:27:55 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id BfYqeiZ2C3CyHBfZ1ewtt4; Mon, 06 Nov 2017 11:27:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509967666; bh=llXIpeIdTJ1TcKd2OwsZpcoJIbVN2inVxaS0VHqhqFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=q+zToinhVNMhoOfFQ75Og2C9G/1oPx7ArcAQdBhPACrjDm6VDzAxU2qCmYWL8HGQu
         Q9waMpQuAaob4PdLaA/l1ROMBPXi34jLSOPfAHButCx+HuKlLB3ed5lKLnKfE+3SYP
         jRi2VTY7PAo8dVIkO6TZ3dOlNugz0QyCvz3zx+gI=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=9hlyrQL2nqYV9MhjvlYA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 0/8] sequencer: dont't fork git commit
Date:   Mon,  6 Nov 2017 11:27:01 +0000
Message-Id: <20171106112709.2121-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfD68eA3nVyxM1crcXi7peygKTo2uBUsZPtKa1oCc/T20MVc1fPxhhg7hINKHCR7qKFYQJ4gGxyXUYhW5C8YnsFcAC+zxW0JxxupmNXBbG19vCpLcHliu
 dx8O8yJWdDJbs62XRE2815JkCMoOn3GqhOn4ZEM+iYioOOPvnd4Vd9XbS2fKI0c0y61ZoDTEqApVb1jlaE5VtgOoPdCEM+txSYVpyNtfwLIBr7tq0xnLTTW2
 ppz78Xyg4B/bIYTm+ZdT8WkskVBruG3A2nidreNpnHqSA8tAqhkAJZS1xGzb84wN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Changes since the last version
 - reworked the second patch based on Junio's feedback so it no longer sets
   GIT_REFLOG_ACTION
 - reworded commit messages
 - print_commit_summary() no longer dies but returns an error so the sequencer
   can exit cleanly
 - reworked the last patch to return errors rather than dying when creating a
   commit and to use the correct commit message with intermediate squashes.
 - rebased onto next as there were some conflicting changes in builtin/commit.c
 - updated benchmarks compared to v2.15.0 (the percentage difference is
   essentially the same)
 - fixed some style issues

Here's the summary from the previous version
These patches teach the sequencer to create commits without forking
git commit when the commit message does not need to be edited. This
speeds up cherry picking 10 commits by 26% and picking 10 commits with
rebase --continue by 44%. The first few patches move bits of
builtin/commit.c to sequencer.c. The last two patches actually
implement creating commits in sequencer.c.

Phillip Wood (8):
  commit: move empty message checks to libgit
  Add a function to update HEAD after creating a commit
  commit: move post-rewrite code to libgit
  commit: move print_commit_summary() to libgit
  sequencer: don't die in print_commit_summary()
  sequencer: simplify adding Signed-off-by: trailer
  sequencer: load commit related config
  sequencer: try to commit without forking 'git commit'

 builtin/commit.c         | 260 ++------------------------
 builtin/rebase--helper.c |  13 +-
 builtin/revert.c         |  15 +-
 sequencer.c              | 478 ++++++++++++++++++++++++++++++++++++++++++++++-
 sequencer.h              |  21 +++
 5 files changed, 531 insertions(+), 256 deletions(-)

-- 
2.14.3

