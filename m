Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA78A1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757848AbcK3Xk7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:40:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:49366 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755979AbcK3Xk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:40:59 -0500
Received: (qmail 25651 invoked by uid 109); 30 Nov 2016 23:40:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:40:58 +0000
Received: (qmail 26885 invoked by uid 111); 30 Nov 2016 23:41:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 18:41:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 18:40:56 -0500
Date:   Wed, 30 Nov 2016 18:40:56 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 06:32:04PM -0500, Jeff King wrote:

> On Wed, Nov 30, 2016 at 03:28:23PM -0800, Brandon Williams wrote:
> 
> > So I couldn't find a race condition in the code.  I tracked the problem
> > to grep_source_load_file which attempts to run lstat on the file so that
> > it can read it into a buffer.  The lstat call fails with ENOENT (which
> > conveniently is skipped by the if statement which calls error_errno).  So
> > for some reason the file cannot be found and read into memory resulting
> > in nothing being grep'ed for that particular file (since the buffer is
> > NULL).
> 
> That's definitely weird. Is it possible that any of the underlying calls
> from another thread are using chdir()? I think realpath() make do that
> behind the scenes, and there may be others.
> 
> A full strace from a failing case would be interesting reading. In
> theory we should be able to get that by running the stress script for
> long enough. :)

Actually, it failed pretty much immediately. I guess the extra stracing
changes the timing to make the problem _more_ likely.

And indeed, I see:

20867 lstat("fi:le",  <unfinished ...>
20813 <... read resumed> "", 232)       = 0
20871 futex(0x558cdec8b164, FUTEX_WAIT_PRIVATE, 7, NULL <unfinished ...>
20813 close(7 <unfinished ...>
20870 <... futex resumed> )             = 0
20869 lstat(".gitmodules",  <unfinished ...>
20813 <... close resumed> )             = 0
20865 set_robust_list(0x7f1df92579e0, 24 <unfinished ...>
20813 lstat("su:b/../.git/modules/su:b/commondir", 0x7ffecc8b3ac0) = -1 ENOENT (No such file or directory)
20865 <... set_robust_list resumed> )   = 0
20868 set_robust_list(0x7f1df7a549e0, 24 <unfinished ...>
20813 access("su:b/../.git/modules/su:b/objects", X_OK) = 0
20813 access("su:b/../.git/modules/su:b/refs", X_OK) = 0
20813 stat("su:b/../.git/modules/su:b", {st_mode=S_IFDIR|0755, st_size=280, ...}) = 0
20813 getcwd("/var/ram/git-stress/root-4/trash directory.t7814-grep-recurse-submodules/parent", 129) = 80
20869 <... lstat resumed> {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
20813 chdir("su:b/../.git/modules/su:b") = 0
20869 open(".gitmodules", O_RDONLY <unfinished ...>
20813 getcwd( <unfinished ...>
20867 <... lstat resumed> 0x7f1df8254cf0) = -1 ENOENT (No such file or directory)

where 20813 and 20867 are two threads of the main process. One is doing
the lstat and the other calls chdir at the same moment.

-Peff
