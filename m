Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F233C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168CC20791
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMOzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:55:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:57706 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgHMOzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:55:16 -0400
Received: (qmail 19851 invoked by uid 109); 13 Aug 2020 14:55:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 14:55:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14114 invoked by uid 111); 13 Aug 2020 14:55:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 10:55:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 10:55:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/5] slimming down installed size
Message-ID: <20200813145515.GA891139@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while ago I was looking at the size of an installed (and stripped)
build of Git, and noticed we could make a few more things into builtins.

Patches 2-4 do that.  I don't think there's any real downside here.
We're not bringing in any new link dependencies to the main binary. And
even if these programs don't use all of the code that's in the main
binary, operating systems are good at just loading the pages that we do
need (and you're probably running other Git programs anyway, which means
the main binary is in RAM anyway and we're actually reducing the overall
memory footprint).

The final patch is not strictly related, but it's something I've had
sitting around for a long time. I actually posted it almost exactly two
years ago:

  https://lore.kernel.org/git/20180817190310.GA5360@sigill.intra.peff.net/

which ended with Jonathan saying:

>  - keeping this in-tree for the benefit of just one user is excessive,
>    so removing it is probably the right thing
> 
>  - it would be nice if the commit removing this code from Git includes
>    a note to help people find its new home
> 
> Would you mind holding off until I'm able to arrange that last bit?

So...I held off for a bit, but I'd really like to be done with this (and
I prefer dropping the code, because I have a few other tree-wide
cleanups for which I'd just as soon not have to deal with vcs-svn).

  [1/5]: Makefile: drop builtins from MSVC pdb list
  [2/5]: make credential helpers builtins
  [3/5]: make git-bugreport a builtin
  [4/5]: make git-fast-import a builtin
  [5/5]: drop vcs-svn experiment

 .gitignore                                    |    1 -
 Makefile                                      |   45 +-
 builtin.h                                     |    5 +
 bugreport.c => builtin/bugreport.c            |   10 +-
 .../credential-cache--daemon.c                |   29 +-
 .../credential-cache.c                        |   29 +-
 .../credential-store.c                        |    6 +-
 fast-import.c => builtin/fast-import.c        |    3 +-
 contrib/buildsystems/CMakeLists.txt           |   52 +-
 contrib/svn-fe/.gitignore                     |    4 -
 contrib/svn-fe/Makefile                       |  105 --
 contrib/svn-fe/svn-fe.c                       |   18 -
 contrib/svn-fe/svn-fe.txt                     |   71 --
 contrib/svn-fe/svnrdump_sim.py                |   68 -
 git.c                                         |    5 +
 remote-testsvn.c                              |  341 -----
 t/helper/.gitignore                           |    2 -
 t/helper/test-line-buffer.c                   |   81 --
 t/helper/test-svn-fe.c                        |   52 -
 t/t0081-line-buffer.sh                        |   90 --
 t/t9010-svn-fe.sh                             | 1105 -----------------
 t/t9011-svn-da.sh                             |  248 ----
 t/t9020-remote-svn.sh                         |   95 --
 t/test-lib-functions.sh                       |    2 +-
 vcs-svn/LICENSE                               |   32 -
 vcs-svn/fast_export.c                         |  365 ------
 vcs-svn/line_buffer.c                         |  126 --
 vcs-svn/line_buffer.txt                       |   77 --
 vcs-svn/sliding_window.c                      |   79 --
 vcs-svn/svndiff.c                             |  309 -----
 vcs-svn/svndump.c                             |  540 --------
 31 files changed, 80 insertions(+), 3915 deletions(-)
 rename bugreport.c => builtin/bugreport.c (96%)
 rename credential-cache--daemon.c => builtin/credential-cache--daemon.c (91%)
 rename credential-cache.c => builtin/credential-cache.c (83%)
 rename credential-store.c => builtin/credential-store.c (96%)
 rename fast-import.c => builtin/fast-import.c (99%)
 delete mode 100644 contrib/svn-fe/.gitignore
 delete mode 100644 contrib/svn-fe/Makefile
 delete mode 100644 contrib/svn-fe/svn-fe.c
 delete mode 100644 contrib/svn-fe/svn-fe.txt
 delete mode 100755 contrib/svn-fe/svnrdump_sim.py
 delete mode 100644 remote-testsvn.c
 delete mode 100644 t/helper/test-line-buffer.c
 delete mode 100644 t/helper/test-svn-fe.c
 delete mode 100755 t/t0081-line-buffer.sh
 delete mode 100755 t/t9010-svn-fe.sh
 delete mode 100755 t/t9011-svn-da.sh
 delete mode 100755 t/t9020-remote-svn.sh
 delete mode 100644 vcs-svn/LICENSE
 delete mode 100644 vcs-svn/fast_export.c
 delete mode 100644 vcs-svn/line_buffer.c
 delete mode 100644 vcs-svn/line_buffer.txt
 delete mode 100644 vcs-svn/sliding_window.c
 delete mode 100644 vcs-svn/svndiff.c
 delete mode 100644 vcs-svn/svndump.c

