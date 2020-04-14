Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE31C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169AD2076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633089AbgDNU1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:27:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:53722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2633085AbgDNU1j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 16:27:39 -0400
Received: (qmail 7572 invoked by uid 109); 14 Apr 2020 20:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Apr 2020 20:27:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1755 invoked by uid 111); 14 Apr 2020 20:38:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2020 16:38:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Apr 2020 16:27:38 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
Message-ID: <20200414202738.GD1879688@coredump.intra.peff.net>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
 <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
 <20200414192418.GB5478@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200414192418.GB5478@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 12:24:18PM -0700, Emily Shaffer wrote:

> > Without the redirection one could have
> >   hook.pre-commit.linter.command = my-command
> >   hook.pre-commit.check-whitespace.command = 'git diff --check --cached'
> [...]
> We'd need to fudge one of these fields to include the extra section, I
> think. Unfortunate, because I find your example very tidy, but in
> practice maybe not very neat. The closest thing I can find to a nice way
> of writing it might be:
> 
>   [hook.pre-commit "linter"]
>     command = my-command
>     before = check-whitespace
>   [hook.pre-commit "check-whitespace"]
>     command = 'git diff --check --cached'

Syntactically the whole section between the outer dots is the
subsection. So it's:

  [hook "pre-commit.check-whitespace"]
  command = ...

And I don't think we want to change the config syntax at this point.
Even in the neater dotted notation, we must keep that whole thing as a
subsection, because existing subsections may contain dots, too.

> But this is kind of a lie; the sections aren't "hook", "pre-commit", and
> "linter" as you'd expect. Whether it's OK to lie like this, though, I
> don't know - I suspect it might make it awkward for others trying to
> parse the config. (my Vim syntax highlighter had kind of a hard time.)

I think we should avoid it if possible. There are some subtleties there,
like the fact that subsections are case-sensitive, but sections and keys
are not.

-Peff
