Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7A31F453
	for <e@80x24.org>; Mon, 18 Feb 2019 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfBRRFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 12:05:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:56220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731720AbfBRRFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 12:05:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA056ADD3;
        Mon, 18 Feb 2019 17:05:20 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     git@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] worktree add race fix
Date:   Mon, 18 Feb 2019 18:04:55 +0100
Message-Id: <cover.1550508544.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am running a git automation script that crates a tree and commmits it into a
git repository repeatedly.

I noticed that the step which creates a tree is most time-consuming part of the
script and when a lot of data is to be automatically added to the repository it
is benefical to parallelize this part.

To do so I had the script create a dozen worktrees and share the work between
them. The problem is automatically creating several worktrees occasioanlly
fails.

The most common problem is in the worktree add implementation itself which
tries to find an available directory name and then mkdir() it. Of course, doing
that several times in parallel causes issues.

When running stress-test to make sure the fix is effective I uncovered
additional issues in get_common_dir_noenv. This function is used on each
worktree to build a worktree list.

Apparently it can happen that stat() claims there is a commondir file but when
trying to open the file it is missing.

Another even rarer issue is that the file might be zero size because another
process initializing a worktree opened the file but has not written is content
yet.

When any of this happnes git aborts failing to create a worktree because
unrelated worktree is not yet fully initialized.

I have tested that these patches fix the issue. However, I expect race against
removing/pruning worktrees is still possible.

For previous discussion see

http://public-inbox.org/git/CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com/

Michal Suchanek (2):
  worktree: fix worktree add race.
  setup: don't fail if commondir reference is deleted.

 builtin/worktree.c | 12 +++++++-----
 setup.c            | 16 +++++++++++-----
 2 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.20.1

