Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B541FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 12:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbcHWMgW (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 08:36:22 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37813 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbcHWMgU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 08:36:20 -0400
Received: by mail-wm0-f52.google.com with SMTP id i5so193252540wmg.0
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sqore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=GYLAk/kEcxLyjvNhpjuLLV5NmJZcKMxoT2F0mBrgm+w=;
        b=B76Yfo8XtqVsGT0SAA5UCdOBV9itPSj8LNH9qWAHR8yoNrJYL/NLCOlqp5Lmt1WsAv
         x5rErQvKF5RPjGY+rv3wUjSxv2cAVq6+8E9TBD0WrhkyuaTVOPD7Pq9QT3tJcfhMPkda
         t0+DNmJCWIZDwb+q2yvKN0fWvSH8mAAlGOt7+IlC7+mMWDN/5U0nIiHNFNUDH9ccIIsF
         sDtg6CnMgnQFPQLM33N89CX+YaRs7U8UWAJxzeQ3ZziBr/tg6B4lYWmpmprl14eSTxPM
         fABBzl47tCoIPQncMObQcpgn8QrPlm5lH7lb4CMeR/klSZmWdXyqOCw9ubOT6+iDE6Ze
         H7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GYLAk/kEcxLyjvNhpjuLLV5NmJZcKMxoT2F0mBrgm+w=;
        b=c8hKHQqTocRhvhQ2w89KQNaWXk7eLGeeDnQeQgHwySj3A/d4xnLY84pPyy5oQHBcdD
         RKG+PeJoOre+D1O34ODqDXPCzL6tTiJp2p037uw1wCmth8uUrL1mL3BFJQMMo49nV/G8
         yxYo7y6tkntwqeLM/huoyz6Y0e2v1IL55NvrlnQ+DfdpuGMFmVR9r0lsQn3+k7DmwKQR
         g5OHHlx8jTQR+jiJlbxAcNAtyiCtAclr131hd7c2Lx+PcUSLeQ9FIak3iKzNpQ2f5xaZ
         qzk5nxuHNy9RWhoOZ+r2P+7IbLPfcdkA+hOghsoU3GK8u5b+NdCLTy1fGF8rjw7moZFc
         ZUWg==
X-Gm-Message-State: AEkoouvCsBLWGCDgVdi3m3Dry0oSDwnIFvBY06+ejJ6TOPATyjKN/yM00+Atw66MR2DVvrijikTyNKa67m8gdQ==
X-Received: by 10.28.230.205 with SMTP id e74mr19265599wmi.42.1471955752201;
 Tue, 23 Aug 2016 05:35:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.206.135 with HTTP; Tue, 23 Aug 2016 05:35:31 -0700 (PDT)
From:   Max Nordlund <max.nordlund@sqore.com>
Date:   Tue, 23 Aug 2016 14:35:31 +0200
Message-ID: <CALqjkKZO_y0DNcRJjooyZ7Eso7yBMGhvZ6fE92oO4Su7JeCeng@mail.gmail.com>
Subject: Bug with git worktrees and git init
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been using multiple worktrees for months without issue (it's a
great feature, thanks), until recently when I wanted to add hooks to
them. So, when I added a template for the hooks, everything was fine
until I did a git reset --hard in the original repo which both applied
those changes to the other worktrees' working tree (the files on
disk), and made my master branch kinda lose it's connection to the
remote/think it was a kinda bare repo.

To reproduce this:

```
mkdir source-repo
cd source-repo
git init
touch foo
git add foo
git commit -m 'Add foo'
git worktree add ../worktree # which also creates a new branch 'worktree'
touch bar
git add bar
git commit -m 'Add bar'
cd ../worktree
git init
cd ../source-repo
git reset --hard master
cd ../worktree
git status # Suddenly `bar` has appear the working tree and is not tracked
```

I don't really now what is up with this, but I did notice that it is
the last worktree in which git init has been run that is affected. I
only ran git init to copy the hooks from the template, but if that is
not something you should do in a worktree then a check would have been
nice.

Thanks for this awesome tool, and I hope this helps
Max Nordlund
