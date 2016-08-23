Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD022018E
	for <e@80x24.org>; Tue, 23 Aug 2016 15:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbcHWPWB (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 11:22:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32975 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750862AbcHWPWA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 11:22:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1ABC2207A1;
        Tue, 23 Aug 2016 11:21:59 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 23 Aug 2016 11:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=DN/jTBcR0LpPv2mbldfhVBCsAl4=; b=Ptmq4C
        gLX/hJS53LNZiy50IJ8cUmOxMIgGbEw3loNdKGDkt2Cj3mD9aSGJskGmIYDpBMdQ
        m438wAbaFKcv+DcbMiW0QICuXnDSXGedwlHkiLy3HyU8tleAMGI9LkOO4fCSevjD
        fcxljpBlMbsTy1CPMiwqVqbbVzVRrb82bV7Nw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=DN/jTBcR0LpPv2m
        bldfhVBCsAl4=; b=t/SRdgrGKKOjfn5Bf4r2V4nAYjXRokdOAJ2HPV0uq+U74D1
        NZ+SUP8GSXuapbo8vI9WSjj+WdAYpQFRciIp/dF/oJ5H8skdOCE+lgCxqRGnuVNo
        4DPKHZkC4lH/m4jN6Wwy5DjYJgiISKbImMRw6GnkdtB40h1zX1YHZRnxzsVQ=
X-Sasl-enc: YGXHp+XCJ177y2ePsXBIVMPn2GqhlN7FdnrF60njYfAL 1471965718
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74541F285F;
        Tue, 23 Aug 2016 11:21:58 -0400 (EDT)
Subject: Re: Bug with git worktrees and git init
To:     Max Nordlund <max.nordlund@sqore.com>, git@vger.kernel.org
References: <CALqjkKZO_y0DNcRJjooyZ7Eso7yBMGhvZ6fE92oO4Su7JeCeng@mail.gmail.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <f55e70fa-5244-66a0-d3a7-c6479528039d@drmicha.warpmail.net>
Date:   Tue, 23 Aug 2016 17:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CALqjkKZO_y0DNcRJjooyZ7Eso7yBMGhvZ6fE92oO4Su7JeCeng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Nordlund venit, vidit, dixit 23.08.2016 14:35:
> Hi,
> 
> I've been using multiple worktrees for months without issue (it's a
> great feature, thanks), until recently when I wanted to add hooks to
> them. So, when I added a template for the hooks, everything was fine
> until I did a git reset --hard in the original repo which both applied
> those changes to the other worktrees' working tree (the files on
> disk), and made my master branch kinda lose it's connection to the
> remote/think it was a kinda bare repo.
> 
> To reproduce this:
> 
> ```
> mkdir source-repo
> cd source-repo
> git init
> touch foo
> git add foo
> git commit -m 'Add foo'
> git worktree add ../worktree # which also creates a new branch 'worktree'
> touch bar
> git add bar
> git commit -m 'Add bar'
> cd ../worktree
> git init

This is where the problem is created already: git init does not quite
notice that it is in a linked worktree. It treats

source-repo/.git/worktrees/worktree

as a proper gitdir and creates the full gitdir structure in there
(branches, hooks, info) which is usually shared among worktrees; also,
it adds the config setting

core.worktree = <abspath>/worktree

to the main config (source-repo/.git/config) which is why "git status"
thinks that bar is missing - it indeed is in that worktree.

I've cc'ed the master of worktrees.

> cd ../source-repo
> git reset --hard master
> cd ../worktree
> git status # Suddenly `bar` has appear the working tree and is not tracked
> ```
> 
> I don't really now what is up with this, but I did notice that it is
> the last worktree in which git init has been run that is affected. I
> only ran git init to copy the hooks from the template, but if that is
> not something you should do in a worktree then a check would have been
> nice.
> 
> Thanks for this awesome tool, and I hope this helps
> Max Nordlund
> 

