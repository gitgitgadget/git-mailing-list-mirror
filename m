Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FAC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8E1604AC
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2U3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:29:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:49748 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhJ2U3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:29:31 -0400
Received: (qmail 23717 invoked by uid 109); 29 Oct 2021 20:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Oct 2021 20:27:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22572 invoked by uid 111); 29 Oct 2021 20:27:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Oct 2021 16:27:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Oct 2021 16:27:01 -0400
From:   Jeff King <peff@peff.net>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Libc-alpha <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, git@vger.kernel.org,
        "tech@openbsd.org" <tech@openbsd.org>
Subject: Re: Is getpass(3) really obsolete?
Message-ID: <YXxZFaqHq9/aEQCO@coredump.intra.peff.net>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 01:28:56PM +0200, Alejandro Colomar (man-pages) wrote:

> > As a real example, git(1) uses getpass(3).
> > <https://github.com/git/git/blob/master/compat/terminal.c>

Sort of. It is the compile-time fallback of last resort. Most builds
would use either termios with /dev/tty or a Windows-native equivalent.

You can see all the reasons we stopped using getpass() in the commit
below.

-- >8 --
commit 21aeafceda2382d26bfa73a98ba45a937d65d77a
Author: Jeff King <peff@peff.net>
Date:   Sat Dec 10 05:41:01 2011 -0500

    add generic terminal prompt function
    
    When we need to prompt the user for input interactively, we
    want to access their terminal directly. We can't rely on
    stdio because it may be connected to pipes or files, rather
    than the terminal. Instead, we use "getpass()", because it
    abstracts the idea of prompting and reading from the
    terminal.  However, it has some problems:
    
      1. It never echoes the typed characters, which makes it OK
         for passwords but annoying for other input (like usernames).
    
      2. Some implementations of getpass() have an extremely
         small input buffer (e.g., Solaris 8 is reported to
         support only 8 characters).
    
      3. Some implementations of getpass() will fall back to
         reading from stdin (e.g., glibc). We explicitly don't
         want this, because our stdin may be connected to a pipe
         speaking a particular protocol, and reading will
         disrupt the protocol flow (e.g., the remote-curl
         helper).
    
      4. Some implementations of getpass() turn off signals, so
         that hitting "^C" on the terminal does not break out of
         the password prompt. This can be a mild annoyance.
    
    Instead, let's provide an abstract "git_terminal_prompt"
    function that addresses these concerns. This patch includes
    an implementation based on /dev/tty, enabled by setting
    HAVE_DEV_TTY. The fallback is to use getpass() as before.
    
    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
