Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8261620372
	for <e@80x24.org>; Thu, 12 Oct 2017 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbdJLUK0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:10:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753010AbdJLUKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:10:25 -0400
Received: (qmail 466 invoked by uid 109); 12 Oct 2017 20:10:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 20:10:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19494 invoked by uid 111); 12 Oct 2017 20:10:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 16:10:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 16:10:23 -0400
Date:   Thu, 12 Oct 2017 16:10:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: undefined reference to `pcre_jit_exec'
Message-ID: <20171012201023.wrfbs7p7lups5glz@sigill.intra.peff.net>
References: <CAH8yC8mvG3bSpgshHay7B0SSyAafWLrPTtVZRuq2cShn9xQ9JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8mvG3bSpgshHay7B0SSyAafWLrPTtVZRuq2cShn9xQ9JA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 04:06:11PM -0400, Jeffrey Walton wrote:

> I have a script to build Git on some old platforms to ease testing.
> Old platforms include CentOS 5. The script is available at
> https://github.com/noloader/Build-Scripts/blob/master/build-ssh.sh.
> 
> It looks like something got knocked loose recently. I'm seeing several
> of these when building with PCRE 8.41 with Git 2.14.2. Old and new
> platforms are witnessing it. I observe it on CentOS 5 with GCC 4.1;
> and Fedora 26 with GCC 7.2.
> 
>     ...
>     LINK git-credential-store
> libgit.a(grep.o): In function `pcre1match':
> grep.c:(.text+0x1219): undefined reference to `pcre_jit_exec'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:2145: git-credential-store] Error 1

Maybe:

  $ git grep -h -B5 -A1 pcre_jit Makefile
  # When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if the PCRE v1
  # library is compiled without --enable-jit. We will auto-detect
  # whether the version of the PCRE v1 library in use has JIT support at
  # all, but we unfortunately can't auto-detect whether JIT support
  # hasn't been compiled in in an otherwise JIT-supporting version. If
  # you have link-time errors about a missing `pcre_jit_exec` define
  # this, or recompile PCRE v1 with --enable-jit.

It looks like autoconf turns on USE_LIBPCRE1, but isn't smart enough to
test NO_LIBPCRE1_JIT.

-Peff
