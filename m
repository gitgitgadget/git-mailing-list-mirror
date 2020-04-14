Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D48C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679DB2076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633197AbgDNUcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:32:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:53756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2633195AbgDNUct (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 16:32:49 -0400
Received: (qmail 7620 invoked by uid 109); 14 Apr 2020 20:32:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Apr 2020 20:32:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1866 invoked by uid 111); 14 Apr 2020 20:43:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2020 16:43:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Apr 2020 16:32:47 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
Message-ID: <20200414203247.GE1879688@coredump.intra.peff.net>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
 <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 04:15:11PM +0100, Phillip Wood wrote:

> On 14/04/2020 01:54, Emily Shaffer wrote:
> > Not much to look at compared to the original RFC I sent some months ago.
> > This implements Peff's suggestion of using the "hookcmd" section as a
> > layer of indirection.
> 
> I'm not really clear what the advantage of this indirection is. It seems
> unlikely to me that different hooks will share exactly the same command line
> or other options. In the 'git secrets' example earlier in this thread each
> hook needs to use a different command line. In general a command cannot tell
> which hook it is being invoked as without a flag of some kind. (In some
> cases it can use the number of arguments if that is different for each hook
> that it handles but that is not true in general)
> 
> Without the redirection one could have
>   hook.pre-commit.linter.command = my-command
>   hook.pre-commit.check-whitespace.command = 'git diff --check --cached'
> 
> and other keys can be added for ordering etc. e.g.
>   hook.pre-commit.linter.before = check-whitespace
> 
> With the indirection one needs to set
>   hook.pre-commit.command = linter
>   hook.pre-commit.check-whitespace = 'git diff --check --cached'
>   hookcmd.linter.command = my-command
>   hookcmd.linter.pre-commit-before = check-whitespace

In the proposal I gave, you could do:

  hook.pre-commit.command = my-command
  hook.pre-commit.command = git diff --check --cached

If you want to refer to commands in ordering options (like your
"before"), then you'd have to refer to their names. For "my-command"
that's not too bad. For the longer one, it's a bit awkward. You _could_
do:

  hookcmd.my-command.before = git diff --check --cached

which is the same number of lines as yours. But I'd probably give it a
name, like:

  hookcmd.check-whitespace.command = git diff --check --cached
  hookcmd.my-command.before = check-whitespace

That's one more line than yours, but I think it separates the concerns
more clearly. And it extends naturally to more options specific to
check-whitespace.

-Peff
