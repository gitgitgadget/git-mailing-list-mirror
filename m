Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64D31FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 06:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754013AbdABGxy (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 01:53:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:33956 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752242AbdABGxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 01:53:54 -0500
Received: (qmail 16856 invoked by uid 109); 2 Jan 2017 06:53:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 06:53:53 +0000
Received: (qmail 12241 invoked by uid 111); 2 Jan 2017 06:54:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 01:54:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jan 2017 01:53:51 -0500
Date:   Mon, 2 Jan 2017 01:53:51 -0500
From:   Jeff King <peff@peff.net>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     git@vger.kernel.org
Subject: Re: Test failures when Git is built with libpcre and grep is built
 without it
Message-ID: <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
References: <58688C9F.4000605@adelielinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58688C9F.4000605@adelielinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 10:59:11PM -0600, A. Wilcox wrote:

> I'm attempting to package Git for our new Linux distribution and I
> have run in to a failure on our PowerPC builder while running the test
> suite.
> 
> The PowerPC builder runs a tiny version of grep(1) that was not built
> with PCRE.  As such, grep -P returns 2 and prints:
> 
> grep: support for the -P option is not compiled into this
> - --disable-perl-regexp binary
> 
> However, our Git build *does* link against libpcre.  This causes a
> tests numbered 142 and 143 to fail in t7810-grep.sh.

If we are using "grep -P" in our test suite, it should definitely be
marked with a prerequisite that is independent of the LIBPCRE one.

But I can't find any such place in our test suite. Grepping for
"grep.*-P" doesn't turn up any hits, and dropping this into my PATH as
"grep":

    #!/bin/sh

    case "$*" in
    *-P*|*perl-regex*)
      echo >&2 "Pretending not to understand -P"
      exit 1
    esac

    exec /bin/grep "$@"

doesn't break anything. We do call "git grep -P", of course, but that
should be using the internal libpcre (once upon a time we would invoke
an external grep, but that feature has been gone for years).

Can you show us the output of "./t7810-grep.sh -v -i"?

-Peff
