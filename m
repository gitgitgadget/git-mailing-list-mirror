Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1443211B5
	for <e@80x24.org>; Fri,  1 Feb 2019 06:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBAG1n (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 01:27:43 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:37844 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfBAG1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 01:27:43 -0500
Received: by mail-qk1-f170.google.com with SMTP id g125so3412230qke.4
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 22:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HUg4ydszKHRCGzn1+lZSoIFhnZ6DT9Frw76nzbCzfo=;
        b=DUD/vlDowE/+h5LI9Wb6wFVzApTrQRlB1fRUUamYySF47svkwIr4EhOkX1X74dB8Mv
         fY+YN8+RAvzcGM+n/vW3eh9WihE36ngx9ZNNExK4aL5gAddEd2+635HQUCUxnGutRTmE
         cnTbasFc6yqPMclUbJF7voOuOXCF96eeu3AJ2LUKjIFsh+Daw7tPJPZTymLRyvDX0nQ7
         KDeYQyQ12KfZeYHo4+Uknv7smHInryN72+Xhu2ZYgwSfCN2OMpujN+MlzXKL2TLxZtfj
         9uyxd62SlzvH89j4Q/iP1KBOskl7NqgJrR6jFzCQcs4iH8DSQTaNk32yukB7VipmJ3zb
         YUPw==
X-Gm-Message-State: AJcUukeqcy+VpNI6SKSQrseLM+akfyTpTUdM3UB8Akg2CgrN6hbGbXys
        Gv2PhviVEXqN0KkGCofTK6fNNp8J583V8iEoZiA=
X-Google-Smtp-Source: ALg8bN5lB5zgafegLJkz4Uzn8t5ccwDY77ns79dMtfRfQl3P1YGRCFlxlNCTHSRyoYCczaUmYMVM/SYMeHK4HMq0Bwg=
X-Received: by 2002:a37:5e42:: with SMTP id s63mr33298254qkb.220.1549002461942;
 Thu, 31 Jan 2019 22:27:41 -0800 (PST)
MIME-Version: 1.0
References: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz> <2ee89ff3-e672-e940-f601-aa1d2647756a@suse.cz>
In-Reply-To: <2ee89ff3-e672-e940-f601-aa1d2647756a@suse.cz>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 01:27:31 -0500
Message-ID: <CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com>
Subject: Re: Worktree creation race
To:     Marketa Calabkova <mcalabkova@suse.cz>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 7:58 AM Marketa Calabkova <mcalabkova@suse.cz> wrote:
> On 15/01/2019 15:03, Marketa Calabkova wrote:
> > I am writing to report a bug. The original report is from my colleague, I am also providing his suggestions.
> >
> > There is insufficient locking for worktree addition. Adding worktree may fail.
> >
> > The problem is that git reads the directory entries in $GIT_DIR/worktrees,
> > finds a worktree name that does not exist, tries to create it, and if an
> > error is returned adding the worktree fails. When multiple git processes
> > do this in parallel only one adds a worktree and the others fail. Git should
> > reread the directory and find a new name that does not exist when creating
> > the worktree directory fails because another git process already created it.
> >
> > I suppose adding PID in the tree name would mitigate the issue to the point it will be very unlikely to encounter.
> >
> > I need more than the tree in the temporary directory so using the temporary directory directly as a tree is out of question.
> >
> > cd gitrepo
> > git commit --allow-empty -m Empty
> > for n in $(seq 10000) ; do ( tmp=$(mktemp -d /dev/shm/gittest/test.XXXXXXXXXXX) ; mkdir $tmp/test ; git worktree add --detach $tmp/test ; ) & done
> >
> > (you should see many messages like:
> > fatal: could not create directory of '.git/worktrees/test284': File exists)
> >
> Does anyone has a suggestion what to do with this bug? It looks like a
> one-line fix probably in builtin/worktree.c, but I have no idea how to
> do it. Sorry.

I doubt this is a one-line fix, and I don't think it has anything to
do with reading entries in $GIT_DIR/worktrees.

add_worktree() already attempts to give a unique identifier to each
worktree by adding a numeric suffix and incrementing that suffix if
the name already exists (such as the 284 in your example error
message) but there is definitely a race-condition between the time it
stat()s the name and the time it mkdir()s it.

One possible fix would be to unconditionally use the PID, as you
suggest, though, this is not necessarily foolproof against races
either (though it makes collisions very unlikely).

Another possibility would be to skip the stat() and instead do the
mkdir() in a loop, incrementing the sequence number each time through
the loop. That should eliminate the race entirely (I think).
