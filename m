Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EB11F4C0
	for <e@80x24.org>; Thu,  7 Nov 2019 10:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbfKGKgR (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 05:36:17 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:32833 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGKgR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 05:36:17 -0500
Received: by mail-yb1-f176.google.com with SMTP id i15so756297ybq.0
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 02:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oQn65EZIqu/d10eri/0+/irypgUG052gMGebYIZRpAg=;
        b=G6B8OIx2y/FiUZ07tOY4U1BpXOldeCYKC1X+U4LH0NTZVX+L+r+BKrLfjrT0r6LEgh
         UFEQWX2EhagXoB1Eqh/B5E2a0RjgL8xNfY/ByHmxNALlDYmtPO2bL2VNNJjK2aMV65D5
         htht9yzxQdht7c8rm4U5OcNvNCv/4asU+39gbZMnceEiRfVENREjdRfdUCntqvqqYsvA
         VaIyyFUjAZ//AJxKm4p+Ok66G6e/TL7BMjH4LKJAmR37swjuNXWMOn5hfKHWYkzm3wQP
         JAus6dhZUgQDPCPIUfKbJpu/5j+W4oAmdZaTRjGqJKLvOU4hT1jA2+ekftWWXEru6eWJ
         ZRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oQn65EZIqu/d10eri/0+/irypgUG052gMGebYIZRpAg=;
        b=pF4Fl4avy+2jWK2H8lr5i9QTLZd2/elFQU0ajaQZp8qBkv4iigNDawnYOLvpY15Gne
         ajeAPafrFZRUISL1jinaILNhzaDhd60uCX6B7N/fer0oyE9Kl80+6zvN5BlHZIUQlh5G
         d2uEkx023G3FnPspOEpx59+2QyqS02dUSX69+X4U0Bk1KfvbC3LshPr0hFfMLKpbzx9i
         6tYMYb/2bPxJGqFhP/dEXcfVbQjq6or6m7DMNNy1LZkkg/XjNsS5qy4Ce/QjpXuFFWPb
         DorU+jeV/yBgH4dELXR0uWFMFzaNfh46oBiQWxPQNGJ3OKlaxrRoR883pJPW20+uqHrI
         DuJg==
X-Gm-Message-State: APjAAAX755wZ7qFqurC4ScW3hkH29BAW8txNMAKy7WDo2urCIJZXFnf7
        TgAiPNmq7vhm/fKgxm9M2djOb6egdyBNTGq98ZD5gfslBrw=
X-Google-Smtp-Source: APXvYqyWQE7t7xA8gdPELsFub8h7jsN1HilC43NEIMDsPCJbpZ1x8bcx5es7mEo4xRVpJCNvklNszOQ+HT/jsPFcZbQ=
X-Received: by 2002:a5b:98a:: with SMTP id c10mr2494442ybq.5.1573122975937;
 Thu, 07 Nov 2019 02:36:15 -0800 (PST)
MIME-Version: 1.0
From:   Grzegorz Rajchman <rayman17@gmail.com>
Date:   Thu, 7 Nov 2019 10:36:05 +0000
Message-ID: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
Subject: [BUG] git stash pop --quiet deletes files in git 2.24.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, this is the first time I report an issue in git so I hope I'm
doing it right.

I have experienced some unexpected behaviour with git stash pop
--quiet in git 2.24.0. I use stash in a pre-commit hook script. In it,
I stash non-staged changes to keep the working directory clean while
running some linters, then I restore the stash by running pop, but
after the recent git update I noticed that it stages all previously
checked files as deleted.

Steps to reproduce:

  mkdir test-git-stash
  cd test-git-stash/
  git init
  echo foo > foo.txt
  git add . && git commit -m 'init'
  echo bar > foo.txt
  git stash save --quiet --include-untracked --keep-index
  git stash pop --quiet
  git status

This will unexpectedly output:

  On branch master
  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
      deleted:    foo.txt

  Untracked files:
    (use "git add <file>..." to include in what will be committed)
      foo.txt

Notice that foo.txt was staged as deleted whilst still being present
on the disk.

However, if I remove --quiet flag from stash pop:

  git restore --staged foo.txt
  git stash save --quiet --include-untracked --keep-index
  git stash pop
  git status

Then it works as expected. It used to work as expected in git prior to 2.24.0

My OS is Ubuntu 19.04.
