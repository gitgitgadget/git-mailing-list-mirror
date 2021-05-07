Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F59C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C81613E8
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhEGEzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:55:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:47170 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhEGEzS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:55:18 -0400
Received: (qmail 32163 invoked by uid 109); 7 May 2021 04:54:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 May 2021 04:54:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30168 invoked by uid 111); 7 May 2021 04:54:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 May 2021 00:54:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 May 2021 00:54:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 1/8] compat/terminal: let prompt accept input from pipe
Message-ID: <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <20210506165102.123739-2-firminmartin24@gmail.com>
 <xmqqr1ijwi0i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1ijwi0i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 07, 2021 at 08:37:49AM +0900, Junio C Hamano wrote:

> Firmin Martin <firminmartin24@gmail.com> writes:
> 
> > Currently, git_prompt ignores input coming from anywhere other than
> > terminal (pipe, redirection etc.) meaning that standard prompt
> > auto-answering methods would have no effect:
> >
> >         echo 'Y' | git ...
> >         yes 'Y' | git ...
> >         git ... <input.txt
> >
> > It also prevents git subcommands using git_prompt to be tested using
> > such methods.
> 
> For testing, wouldn't lib-terminal.sh be usable for your purpose?
> If not, what is the reason why it is insufficient?  Can we fix that
> instead?

That doesn't work, because it insists on reading from /dev/tty and not
the pty that lib-terminal will set up as stdin. But...

> Allowing prompter to read from pipe has a big downside in the
> production code: you cannot pipe data into our command, and let it
> ask interactive questions from the end user by opening /dev/tty.

Right. The main purpose of the function was to let git-remote-https,
whose stdin is connected to git-fetch, get a password from the user.
Reading from stdin would break things badly there[1].

Looking at the second patch, the motivation here seems to be to use
git_prompt() for another run-of-the-mill prompt. But the right answer
is: don't do that. In fact, we recently-ish removed a similar case in
97387c8bdd (am: read interactive input from stdin, 2019-05-20) that was
likewise causing problems with the test suite.

I think we might consider renaming git_prompt(), or adding an
explanatory comment above it.

-Peff

[1] Sadly I don't think our test suite could notice the breakage
    introduced by this function. It uses the askpass feature to avoid
    triggering this code at all, because of course we can not reliably
    read from /dev/tty in the script. But with just this patch applied,
    and no credential helpers defined, trying "git ls-remote
    https://github.com/you/some-private-repo" shows the problem: you get
    prompted, but it never reads your input.
