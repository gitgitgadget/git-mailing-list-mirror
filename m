Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB0C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EDC64F19
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhCMQGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:06:33 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36175 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhCMQG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 11:06:28 -0500
Received: by mail-ot1-f51.google.com with SMTP id t16so5042951ott.3
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 08:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=x/ZDvkDWB3vCgqAB9eVijGthgdGGDbWTHvYOdazoIaY=;
        b=PaAlac0wr6XiDV2MgqtJXBf8rsX6Y5J0fTN+fK7h7GQUKOPznaRVRreonFK0G4QlIy
         YAcH0dfNVXqHCgF77Pzh+G6J600qZNWuT4qhy13EHTafzeg4NE+H71Mq/xnXPYlEXtnm
         yuE5/wE0ZdU1mbezFBFdXtFn34Un8DhMWnB5dV3oXlrsoIv2V6K/6ofsUaQuFiy0zKgs
         +peQrwTH9Q0MGwtSa4u16n52xfFauQwU9Ar5z6tCmq2dzrYlguM808b++BkTi6jFp4PW
         x0GyLtBJ14FWlXUBiuyryi5lZt66B3Kk9a9OxPJLsiYpKErdsq1A+pb0CX0nUOMMIYkc
         i/rw==
X-Gm-Message-State: AOAM533DYEv+YLMu/FCfJ5l6P1c9HsNSqKHAAYuobwrM3i5D0aAZl6nw
        3ZEvKRr1Q1GFP9OHqYJQXCTnWW/c6KVCAgAdlQUkfihgGfQiww==
X-Google-Smtp-Source: ABdhPJxkCcoBUJdQ/435xDEmUpa9fAS5K7Tyez8trtw4VceWjQjss6Xh0kGIhBM2NxMv5zIDhj2KJo5HxLo67O6pKz0=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr7623526otk.172.1615651587870;
 Sat, 13 Mar 2021 08:06:27 -0800 (PST)
MIME-Version: 1.0
From:   Arun Sharma <arun@sharma-home.net>
Date:   Sat, 13 Mar 2021 08:06:18 -0800
Message-ID: <CAN7rbOve-EFOGPjr1wrD77r-3RQ+3+qso82_oV5Qud-skobL7w@mail.gmail.com>
Subject: bug report: mutual recursion in the git-subtree shell script
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ resending bug report from git-users since there weren't any responses ]

So I'm trying to split out a directory from postgres source code
(which has 52k commits). I was able to split a directory into a
separate subtree (with 1685 commits). All good so far.

Now I do a pull from upstream and want to push the directory to my
subtree. The command fails with:

$ git subtree push --prefix=src/interfaces/libpq libpq master
/usr/lib/git-core/git-subtree: 647: Maximum function recursion depth
(1000) reached

As far as I can see, it seems to be a mutual recursion between

process_split_commit() and check_parents()

If this diagnosis is correct, are there any known workarounds? I've
tried increasing ulimit -s and FUNCNEST=10000, but it didn't fix the
problem.

Can this flow be coded without using recursion? Are there
implementations of git-subtree in another language which doesn't have
this problem?

 -Arun
