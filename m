Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F4E1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeC1Rg7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:36:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:46220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751434AbeC1Rg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:36:58 -0400
Received: (qmail 13472 invoked by uid 109); 28 Mar 2018 17:36:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 17:36:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10472 invoked by uid 111); 28 Mar 2018 17:37:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 13:37:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 13:36:56 -0400
Date:   Wed, 28 Mar 2018 13:36:56 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git complains packed-refs is not a directory when used with
 GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180328173656.GA29094@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net>
 <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
 <20180327164757.GB24747@sigill.intra.peff.net>
 <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
 <20180327173024.GA5017@duynguyen.home>
 <20180328095203.GB1523@sigill.intra.peff.net>
 <CACsJy8AVcPi=0i7s9o8cy-XGFuOLr72fe9WLRnEqo1SwLJEBOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AVcPi=0i7s9o8cy-XGFuOLr72fe9WLRnEqo1SwLJEBOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 12:10:21PM +0200, Duy Nguyen wrote:

> > I think it might be clearer if a single call is given both the old and
> > new paths. That requires the caller of chdir() storing getcwd() before
> > it moves, but I don't think that should be a big deal.
> 
> The problem is switching relative paths relies on the old $CWD if I'm
> not mistaken and we need  getcwd() for this. I'd love to have one
> callback that says "$CWD has been switched from this path to that
> path, do whatever you need to" that can be called any time, before or
> after chdir(). I'll look more into it.

I think it should be OK to save getcwd() and just construct the original
path after the fact. Here's some patches which do that in a nice way.

For those just joining us, this fixes a regression that was in v2.13 (so
nothing we need to worry about as part of the 2.17-rc track).

  [1/4]: set_git_dir: die when setenv() fails
  [2/4]: add chdir-notify API
  [3/4]: set_work_tree: use chdir_notify
  [4/4]: refs: use chdir_notify to update cached relative paths

 Makefile              |  1 +
 cache.h               |  2 +-
 chdir-notify.c        | 71 +++++++++++++++++++++++++++++++++++++++++++
 chdir-notify.h        | 64 ++++++++++++++++++++++++++++++++++++++
 environment.c         | 22 ++++++++++++--
 refs/files-backend.c  |  4 +++
 refs/packed-backend.c |  3 ++
 setup.c               |  9 ++----
 t/t1501-work-tree.sh  | 12 ++++++++
 9 files changed, 178 insertions(+), 10 deletions(-)
 create mode 100644 chdir-notify.c
 create mode 100644 chdir-notify.h

-Peff
