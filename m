Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD985C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926AB20732
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbgDOWmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:42:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:55284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726089AbgDOWmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 18:42:47 -0400
Received: (qmail 14735 invoked by uid 109); 15 Apr 2020 22:42:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 22:42:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12417 invoked by uid 111); 15 Apr 2020 22:53:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 18:53:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 18:42:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200415224244.GB3595509@coredump.intra.peff.net>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
 <20200410213146.GA2075494@coredump.intra.peff.net>
 <20200413191515.GA5478@google.com>
 <20200413215256.GA18990@coredump.intra.peff.net>
 <20200415034550.GB36683@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415034550.GB36683@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 08:45:50PM -0700, Jonathan Nieder wrote:

> > Yeah, I do see how that use case makes sense. I wonder how common it is
> > versus having separate one-off hooks.
> 
> I think separately from the frequency question, we should look at the
> "what model do we want to present to the user" question.

I sort of agree. The mental model is important, but we should avoid
presenting a model that is overly complex to a user who only wants to do
simple things. So how common that simple thing is impacts the answer to
your question.

> [...]
> What I mean to get at is that I think thinking of them in terms of
> individual hooks, the user model assumed by these programs is to think
> of them as plugins hooking into Git.  The individual hooks are events
> that the plugin listens on.  If I am trying to disable a plugin, I
> don't want to have to learn which events it cared about.

Sure, I agree that's a perfectly reasonable mental model. But for
somebody who just wants to do a one-off hook, they're now saddled with a
thing they don't care about: defining a plugin group for their hook.

The examples you gave are all reasonable, but personally I've never used
anything other than one-off hooks.

On the other hand, I've very rarely used hooks at all myself.

To be clear, I don't _really_ care all that much, and this isn't a hill
I particularly care to die on. I was mostly just clarifying my earlier
suggestion. (I _am_ somewhat amazed that the simple concept of "I would
like to run this shell command instead of $GIT_DIR/hooks/foo" has
generated so much discussion. So really I am in favor of whatever lets
me stop thinking about this as soon as possible).

> >                                       And whether setting the order
> > priority for all hooks at once is that useful (e.g., I can easily
> > imagine a case where the pre-commit hook for program A must go before B,
> > but it's the other way around for another hook).
> 
> This I agree about.  Actually I'm skeptical about ordering
> dependencies being something that is meaningful for users to work with
> in general, except in the case of closely cooperating hook authors.
>
> That doesn't mean we shouldn't try to futureproof for that, but I
> don't think we need to overfit on it.

I share that skepticism (and also agree that avoiding painting ourselves
into a corner is the main thing).

> >>> And it doesn't leave a lot of room for defining
> >>> per-hook-type options; you have to make new keys like pre-push-order
> >>> (though that does work because the hook names are a finite set that
> >>> conforms to our config key names).
> 
> Exactly: field names like prePushOrder should work okay, even if
> they're a bit noisy.

A side note:

Here you've done a custom munging of pre-push into prePush. I'm fine
with that, but would we ever want to allow third-party scripts to define
their own hooks using this mechanism? E.g., if there's a git-hooks
command could I run "git hooks run foo" to run the foo hook? If so, then
it might be simpler to just use the name as-is rather than defining the
exact munging rules.

-Peff
