Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CCA1F461
	for <e@80x24.org>; Thu, 16 May 2019 11:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfEPL7Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 07:59:25 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36446 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfEPL7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 07:59:25 -0400
Received: by mail-wr1-f45.google.com with SMTP id s17so3111257wru.3
        for <git@vger.kernel.org>; Thu, 16 May 2019 04:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8hee1kNIZ6Seqq261jLIoC2cefvF18BRvyqmlZ7g2w=;
        b=Ddmi54LusNCS5+8aInMo0MSHoKKx51LYTYniY/LHJmTKFecJ3m9hSrX7aI2TGSUcii
         EY0UdC7GKEQEP1/QjM67ysQ2Dw8obpgwLbJNI9OQQpwNr/oSzFrBeki0J3UOl18qDph8
         5E5Ivd8CYzVqKP9/bg4/sGvpFGpkjLL8a1HoIHPYbnWvzyp8lrmL527Shz/G8riWBSkK
         /UYB/QLDGXKKhF00YouSVVcolpQyoM+CXATr/TO2pYxdyLZXBUgBIn//p7DYw5r1eZOW
         L3mjjTzmQfyn+vjpQVM43r4KWECfhKfR7Gl4Ob9ulFzH8l07+LzJYjvTl8yZOE8ke5dK
         bPiw==
X-Gm-Message-State: APjAAAXEHkWF4qc64BofrOLPjODNaTt0G2H82G+0h9DQfsiGqOLErDKq
        Mm499xZH8tdPzZWH000Qbyw+I6rKqVObsnXxDPM8lerx
X-Google-Smtp-Source: APXvYqxdaYoowuB1IyB1qmwovh8QffOr9ufJFyPVYezR/mKmcA+7eFU3Pse5yWU1Sl2lqdDnPhxQCBjbL47Kdbt2PBM=
X-Received: by 2002:a5d:4206:: with SMTP id n6mr16983611wrq.58.1558007963802;
 Thu, 16 May 2019 04:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
In-Reply-To: <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 May 2019 07:59:12 -0400
Message-ID: <CAPig+cQ5T1yj0t1gehXYKN7=rEJ15feOUEJEtAVK565=VwdUrg@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 7:25 AM Duy Nguyen <pclouds@gmail.com> wrote:
> pre-commit hook sets GIT_INDEX_FILE to this "index.lock" so you have
> the latest index content (which is not the same as from
> $GIT_DIR/index). This variable will interfere with any commands that
> work on a different worktree.

I think that this is not quite accurate. The problem isn't that
git-commit is pointing GIT_INDEX_FILE at a temporary index; that works
fine. The problem is when it is using the normal .git/index file, in
which case the value it assigns to GIT_INDEX_FILE is relative.

For instance, with pre-commit hook:

    #!/bin/sh
    echo "GIT_INDEX_FILE=$GIT_INDEX_FILE"
    git worktree add --detach other

"git-worktree add" with a normal git-commit breaks due to the relative
location specified by GIT_INDEX_FILE:

    $ git add file
    $ git commit -m foo
    GIT_INDEX_FILE=.git/index
    Preparing worktree (detached HEAD 0857fef)
    fatal: Unable to create '/.../other/.git/index.lock': Not a directory
    $

whereas, the "git commit <file>" form succeeds just fine because it
assigns an absolute path for the temporary index:

    $ git commit -m foo file
    GIT_INDEX_FILE=/.../.git/next-index-23675.lock
    Preparing worktree (detached HEAD 0857fef)
    HEAD is now at 0857fef first
    [master 2fa5413] foo
    $
