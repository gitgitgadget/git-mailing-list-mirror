Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA07C433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 09:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859762064C
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 09:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgGOJic (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:38:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:57958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgGOJic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 05:38:32 -0400
Received: (qmail 10700 invoked by uid 109); 15 Jul 2020 09:38:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jul 2020 09:38:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7905 invoked by uid 111); 15 Jul 2020 09:38:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jul 2020 05:38:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jul 2020 05:38:31 -0400
From:   Jeff King <peff@peff.net>
To:     "R. Diez" <rdiez@neanderfunk.de>
Cc:     git@vger.kernel.org, santiago@nyu.edu
Subject: Re: Interrupted system call
Message-ID: <20200715093831.GA3259535@coredump.intra.peff.net>
References: <14b3d372-f3fe-c06c-dd56-1d9799a12632@yahoo.de>
 <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de>
 <20200701162111.GA934052@coredump.intra.peff.net>
 <11754dcc-3c88-04dd-d009-89da01881e5d@neanderfunk.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11754dcc-3c88-04dd-d009-89da01881e5d@neanderfunk.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 02, 2020 at 09:07:46AM +0200, R. Diez wrote:

> I managed to make it fail once with:
> 
>   strace -f -- git fsck --progress
> 
> The signal involved is SIGALRM. I am guessing that Git is setting it up in
> order to display its progress messages. This is one of the few calls to
> rt_sigaction(SIGALRM):
> 
> rt_sigaction(SIGALRM, {sa_handler=0x556c8ac0fe80, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fbdca7da890}, NULL, 8) = 0

That makes sense (and likewise your "--quiet" workaround seems
reasonable).

> I am not an expert in Unix signals, but I'll do my best here.
> 
> I do not understand why Git is getting these interruptions due to SIGALRM, because SA_RESTART is in place.
> 
> Interestingly, the man page signal(7) does list open() under that flag, but not openat().

Yes, though since open(2) says:

 The openat() system call operates in exactly the same way as open(),
 except for the differences described here.

I'd expect that would include any SA_RESTART handling. Peeking at the
Linux implementation in fs/open.c, it looks like both syscalls quickly
end up in the same do_sys_open().

> The description for open() under SA_RESTART is also interesting:
> 
> * open(2), if it can block (e.g., when opening a FIFO; see fifo(7)).
> 
> I am not sure that opening a normal disk file may qualify as "can block" with that definition though.

Delivering EINTR on a non-blocking call seems even more confusing,
though. I think the "if it can block" is just "you won't even get a
signal if it's not blocking".

This really _seems_ like a kernel bug, either:

  - openat() does not get the same SA_RESTART treatment as open(); or

  - open() on a network file can get EINTR even with SA_RESTART

But it's quite possible that I'm missing some corner case or historical
reason that it would need to behave the way you're seeing. It might be
worth reporting to kernel folks.

-Peff
