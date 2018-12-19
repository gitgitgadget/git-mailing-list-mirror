Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B5A211B6
	for <e@80x24.org>; Wed, 19 Dec 2018 23:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeLSXWC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 18:22:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:46288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728195AbeLSXWC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 18:22:02 -0500
Received: (qmail 20768 invoked by uid 109); 19 Dec 2018 23:22:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 23:22:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26144 invoked by uid 111); 19 Dec 2018 23:21:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 18:21:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 18:22:00 -0500
Date:   Wed, 19 Dec 2018 18:22:00 -0500
From:   Jeff King <peff@peff.net>
To:     Sitsofe Wheeler <sitsofe@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Periodic hang during git index-pack
Message-ID: <20181219232200.GB21283@sigill.intra.peff.net>
References: <CALjAwxiB1uDfg4iPFjh2dNibEZa5mJ0RwhCzt0R2b87NTVqWfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALjAwxiB1uDfg4iPFjh2dNibEZa5mJ0RwhCzt0R2b87NTVqWfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 10:59:30PM +0000, Sitsofe Wheeler wrote:

> While using trying to use git to clone a remote repository git
> index-pack occasionally goes on to hang:
> [...]
> Looking at where it is stuck, git is doing read of a pipe:
> 
> #0  0x00007fd1b845034e in __libc_read (fd=fd@entry=0,
> buf=buf@entry=0x55ab81e19d40 <input_buffer>, nbytes=nbytes@entry=4096)
>     at ../sysdeps/unix/sysv/linux/read.c:27
> #1  0x000055ab81b51b23 in read (__nbytes=4096, __buf=0x55ab81e19d40
> <input_buffer>, __fd=0)
>     at /usr/include/x86_64-linux-gnu/bits/unistd.h:44

Index-pack is reading the pack on stdin, so it's expecting more bytes.
Those bytes should be coming from the git-clone process, which is
relaying the bytes from the other side.

Check the backtrace of git-clone to see why it isn't feeding more data
(but note that it will generally have two threads -- one processing the
data from the remote, and one wait()ing for index-pack to finish).

My guess, though, is that you'll find that git-clone is simply waiting
on another pipe: the one from ssh.

-Peff
