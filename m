Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52139C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273C260E8B
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhJ1WMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:12:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:49234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhJ1WMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:12:34 -0400
Received: (qmail 17691 invoked by uid 109); 28 Oct 2021 22:10:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Oct 2021 22:10:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10181 invoked by uid 111); 28 Oct 2021 22:10:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Oct 2021 18:10:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Oct 2021 18:10:05 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Is t7006-pager.sh racy?
Message-ID: <YXsfvU+faPH6m/m/@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YXbsPrU6nRSboQ7r@coredump.intra.peff.net>
 <20211028195527.GA2574@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028195527.GA2574@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 09:55:27PM +0200, SZEDER Gábor wrote:

> > 
> > My usual test for an intentional SIGPIPE is "yes". So something like:
> > 
> >   git -p \
> >     -c core.pager='exit 0' \
> >     -c alias.yes='!yes' \
> >     yes
> > 
> > will reliably trigger SIGPIPE from yes, which git.c will then translate
> > into an exit code of 141.
> 
> Oh, that's clever.  Alas it's not applicable to our tests, because
> 'yes' is not portable; 8648732e29 (t/test-lib.sh: provide a shell
> implementation of the 'yes' utility, 2009-08-28).

True, though it would be easy enough to do:

  git -c alias.yes='!while true; do echo y; done' yes

> > So something like "git log --stdin" works, but you have to contort
> > yourself a bit to make it race-free:
> [...]
> Ugh.  I think this would work reliably, but...  ugh :)

Yes. :)

> I wonder whether we could do this as a new pair of 'test-tool'
> helpers, one to run the pager through the usual pager-invoking
> machinery and to generate a lot of output, the other to be used as the
> early-exiting pager, with a pipe between the two to ensure that the
> SIGPIPE does happen.  Well, essentially the same that you outlined
> above but in C instead of shell, which I somehow find less "ugh".

Maybe, though now we may be diverging from how git.c uses the pager. As
gross as what I wrote is, it is testing the code we want to test, I
think. I am not sure that the alias vs builtin thing is worth caring
about anyway, though, in which case the alias.yes thing above would be
fine.

-Peff
