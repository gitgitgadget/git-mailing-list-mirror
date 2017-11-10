Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717691F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 11:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdKJLKO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 06:10:14 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:50718 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdKJLKG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 06:10:06 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id D7C7etmv6mITaD7CFeDJkk; Fri, 10 Nov 2017 11:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510312204;
        bh=ZMrFuVUwX9r1MSRpEcH5aEDe0htJeUH1mLqynHSrez8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ah7sCk8WfPAYlTcK9NnoxjMkhmI5WUjudKGsAPHxmQX9Wd/gIObgw4OWG2QUo/8oQ
         /IBa6xWq7Yo7B75Mjo9/Sy8HeO94yWtWS8j405DXt0FNyd77kgfd4a0oxyTBameDUh
         VS5saK7Ien8bi2IstmrfJzZye0J7iU0u3xTnOu1Y=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=inVNzjdFLu-BbrPpKXMA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/9] sequencer: dont't fork git commit
Date:   Fri, 10 Nov 2017 11:09:40 +0000
Message-Id: <20171110110949.328-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLbZ9CrY1Dr/oOY6KyRBMV0goCIU0OSS56iL8NCQSlfmyDtAYu2YTJL1eMJQq7lh7c/uB2LYCFL04/7yGZg9NLTLiKfrBQQVSS76a87mAVal/ML1vJ3k
 2Fw6Xut9FC4uvutavz6YRqpEZMEN9L+lVjlLoK2ZIGAu5BleN8Nr9FrVinCyinQ/P3AHuktM9wZ2rh6MEqFK3FlyOCynHg/OP//eepk4/tBRdhaOTfVyA1A+
 OaOP1nCtVScZjf/KalT55+TXk4p90R3yfLtSncFIys28CK9+Xxfb3LCgOPE7eLIU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks for the feedback on v1 I've updated the patches as
suggested. See the comments on each patch for what has changed. I've
added a patch to the start of the series to test the commit messages
of intermediate squashes. I've added this as the RFC version of this
series did not create these correctly but the test suite passed.

Here's the summary from the previous version
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
  sequencer: don't die in print_commit_summary()
  sequencer: simplify adding Signed-off-by: trailer
  sequencer: load commit related config
  sequencer: try to commit without forking 'git commit'

 builtin/commit.c              | 290 +++----------------------
 builtin/rebase--helper.c      |  13 +-
 builtin/revert.c              |  15 +-
 sequencer.c                   | 489 +++++++++++++++++++++++++++++++++++++++++-
 sequencer.h                   |  23 ++
 t/t3404-rebase-interactive.sh |   4 +
 6 files changed, 565 insertions(+), 269 deletions(-)

-- 
2.15.0

