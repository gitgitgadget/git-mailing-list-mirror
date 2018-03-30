Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7AD01F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeC3Se2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:34:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:49032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752338AbeC3Se1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:34:27 -0400
Received: (qmail 24121 invoked by uid 109); 30 Mar 2018 18:34:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 18:34:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31009 invoked by uid 111); 30 Mar 2018 18:35:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 14:35:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 14:34:25 -0400
Date:   Fri, 30 Mar 2018 14:34:25 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 0/5] re-parenting relative directories after chdir
Message-ID: <20180330183425.GA30575@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net>
 <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
 <20180327164757.GB24747@sigill.intra.peff.net>
 <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
 <20180327173024.GA5017@duynguyen.home>
 <20180328095203.GB1523@sigill.intra.peff.net>
 <CACsJy8AVcPi=0i7s9o8cy-XGFuOLr72fe9WLRnEqo1SwLJEBOw@mail.gmail.com>
 <20180328173656.GA29094@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328173656.GA29094@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 01:36:56PM -0400, Jeff King wrote:

> For those just joining us, this fixes a regression that was in v2.13 (so
> nothing we need to worry about as part of the 2.17-rc track).
> 
>   [1/4]: set_git_dir: die when setenv() fails
>   [2/4]: add chdir-notify API
>   [3/4]: set_work_tree: use chdir_notify
>   [4/4]: refs: use chdir_notify to update cached relative paths

Here's a re-roll based on the feedback I got, including:

 - fixes the memory leak and vague comment pointed out by Eric

 - adds in tracing code from Duy

 - I took Duy's suggestions regarding "least" surprise in some of the
   functions (reparenting NULL is a noop, and registering a reparent
   handler does so even for an absolute path).

I punted on the "registering the same path twice" thing. That is a
potential way to misuse this API, but I don't think there's a good
solution. The "reparent" helper could figure this out for you, but in
the general case we actually install an arbitrary callback. So the
caller really has to handle it there.

I think in the long run we'd want to outlaw calling set_git_dir() twice
anyway. But possibly the handler-installers should be more careful.

I'm dropping poor Rafael from the cc here, since it is turning into
quite a lot of messages. :) I think at this point his bug has been duly
reported and we are working on the fix.

  [1/5]: set_git_dir: die when setenv() fails
  [2/5]: trace.c: export trace_setup_key
  [3/5]: add chdir-notify API
  [4/5]: set_work_tree: use chdir_notify
  [5/5]: refs: use chdir_notify to update cached relative paths

 Makefile              |  1 +
 cache.h               |  2 +-
 chdir-notify.c        | 93 +++++++++++++++++++++++++++++++++++++++++++
 chdir-notify.h        | 73 +++++++++++++++++++++++++++++++++
 environment.c         | 26 ++++++++++--
 refs/files-backend.c  |  6 +++
 refs/packed-backend.c |  3 ++
 setup.c               |  9 ++---
 t/t1501-work-tree.sh  | 12 ++++++
 trace.c               | 14 +++----
 trace.h               |  1 +
 11 files changed, 223 insertions(+), 17 deletions(-)
 create mode 100644 chdir-notify.c
 create mode 100644 chdir-notify.h

-Peff
