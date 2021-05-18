Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FF9C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6F66124C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbhERMJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 08:09:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:57746 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244000AbhERMJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 08:09:15 -0400
Received: (qmail 14582 invoked by uid 109); 18 May 2021 12:07:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 12:07:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7421 invoked by uid 111); 18 May 2021 12:07:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 08:07:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 08:07:56 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git repack on shallow clone of large repo (linux kernel) hangs
 at "Enumerating objects"
Message-ID: <YKOuHLWmJ3jktpyA@coredump.intra.peff.net>
References: <c98e51b0-d89b-9170-e3bc-69ac9ec5e114@gmail.com>
 <YKIulliGp8hyf5Y6@coredump.intra.peff.net>
 <158a2f8c-95c0-075a-4cda-6328324c2261@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158a2f8c-95c0-075a-4cda-6328324c2261@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 06:23:40PM +0700, Bagas Sanjaya wrote:

> > You could try using strace or gdb to see what it's doing.
> > 
> > But as a guess, one thing that sometimes causes a stall near the end of
> > "enumerating objects" is loosening unreachable objects that are
> > currently packed. You told repack to use "-A", which asks to loosen
> > those objects so they aren't lost when the old packs are deleted (as
> > opposed to "-a").
> > 
> 
> I attached two strace logs, one for "git repack -A -d" and one for "git
> repack -a -d".
> 
> For the former, I got following excerpt before I had to SIGINT the process:
> 
> > stat("/opt/git/libexec/git-core/git", {st_mode=S_IFREG|0755, st_size=22096480, ...}) = 0
> > pipe([5, 7])                            = 0
> > openat(AT_FDCWD, "/dev/null", O_RDWR|O_CLOEXEC) = 8
> > fcntl(8, F_GETFD)                       = 0x1 (flags FD_CLOEXEC)
> > fcntl(8, F_SETFD, FD_CLOEXEC)           = 0
> > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> > clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7feb5ecbfa10) = 13691
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > close(7)                                = 0
> > read(5, "", 8)                          = 0
> > close(5)                                = 0
> > close(8)                                = 0
> > close(4)                                = 0
> > fcntl(3, F_GETFL)                       = 0 (flags O_RDONLY)
> > fstat(3, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
> > read(3, 0x55a540de5250, 4096)           = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
> 
> I thought that in the case of "git repack -A -d", it is stucked at the
> last read() before I ctrl-c'ed to trigger SIGINT.

You need "strace -f". The parent repack process spawns pack-objects (via
the clone() call above), and then waits for it to print the name of the
generated pack at the end. So it will stall on that read() for quite a
while, even under normal circumstances.

-Peff
