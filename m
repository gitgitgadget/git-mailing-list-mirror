Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F53202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 22:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932667AbdJPW4n (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 18:56:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932649AbdJPW4n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 18:56:43 -0400
Received: (qmail 13691 invoked by uid 109); 16 Oct 2017 22:56:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 22:56:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18038 invoked by uid 111); 16 Oct 2017 22:56:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 18:56:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 18:56:41 -0400
Date:   Mon, 16 Oct 2017 18:56:41 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Minor man page weirdness?
Message-ID: <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net>
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 07:16:49AM -0700, Lars Schneider wrote:

> Hi,
> 
> I just noticed that a space between "-f" and "git" is missing in `man git-branch`.
> The space is present in "Documentation/git-branch.txt", though. I am using `man`
> version 1.6c on macOS.
> 
> -f, --force
>            Reset <branchname> to <startpoint> if <branchname> exists already. Without
>            -fgit branch refuses to change an existing branch. In combination with -d (or
>             ^^
> 
> Can you reproduce the "problem"?

I don't see it on my copy (Debian man-db 2.7.6.1-2) . What does:

  cd Documentation
  make git-branch.1
  grep Without git-branch.xml

show? I see:

  ... <literal>-f</literal> <emphasis>git branch</emphasis> ...

If there's no space there, then the problem is in asciidoc. If not, then
we can further check:

  grep -A3 Without git-branch.1

I get:

  Reset <branchname> to <startpoint> if <branchname> exists already\&. Without
  \fB\-f\fR
  \fIgit branch\fR
  refuses to change an existing branch\&. In combination with

Since there's no space there, I think we're relying on roff to insert
one between lines. I'm not familiar enough with roff to say if that's a
reasonable expectation or not. But if the problem is at this level, it's
actually an issue between docbook and roff, and there's probably not a
lot we can do on the Git side.

We do have some hacks/workarounds for broken versions of the toolchain.
You can try tweaking various knobs you find in Documentation/Makefile).
DOCBOOK_SUPPRESS_SP sounds promising, but I think it actually does the
opposite (removes extra spaces).

-Peff
