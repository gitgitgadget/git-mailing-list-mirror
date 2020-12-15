Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9473C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99ADC20782
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgLOCcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:32:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:60750 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgLOCcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:32:15 -0500
Received: (qmail 11402 invoked by uid 109); 15 Dec 2020 02:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 02:31:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6950 invoked by uid 111); 15 Dec 2020 02:31:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Dec 2020 21:31:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Dec 2020 21:31:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
Message-ID: <X9ggAxk/z0D9Qom+@coredump.intra.peff.net>
References: <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
 <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com>
 <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
 <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
 <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
 <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
 <xmqqtussirsl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtussirsl.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 11:17:01PM -0800, Junio C Hamano wrote:

> You want to let the user express: "I do not want to choose either
> rebase or merge.  I want 'pull' to fail when it needs to deal with
> non-ff history.  But I do not need to be told about command line
> option and configuration every time."
> 
> I said I don't (I view that disabling half the "git pull" just a
> safe fallback behaviour until the user chooses between merge and
> rebase), but if we wanted to offer it as a valid choice to users, we
> can do so.  We just make it possible to squelch the latter two parts
> of the three-part message---you leave pull.rebase unconfigured and
> squelch the latter two parts of the message, and you got the "stop
> me, I do not merge or rebase, but don't even tell me how to further
> configure" already.

FWIW, I would be such a user who would want to squelch the error but
keep the ff-only behavior (and have been doing so for years via
pull.ff=only).

I primarily use "git pull" only with branches where I am tracking
upstream work, but don't have any of my own (e.g., if I do all of my
work on topic branches, I may still keep a "master" branch that mirrors
"origin/master", and use "git checkout master && git pull" to
fast-forward it).

So I think this is a valuable thing to have. And it does work just fine
already, without pull.mode. The reasons to care about pull.mode (IMHO)
are mostly about explaining it:

  - it isn't respected with rebase. So if you set pull.rebase=true, now
    pull.ff=only does nothing. This is arguably confusing, though I
    doubt it comes up much in practice.

  - having a single tri-state of merge/rebase/error for "what do I do
    when pulling a non-fast-forward merge" is conceptually simple and
    easy to explain.

So I like pull.mode in that sense. But it is also weighed against the
fact that we'd still have to support pull.rebase, and we'd still have to
support pull.ff, and explain how those interact with pull.mode (and I
think any new error in this area must be squelched by those existing
variables, or it would be a regression for people who already picked
their default long ago).

> But there is an established way used in this project when we allow
> squelching overly-helpful help messages, and we can apply it here as
> well.  That way:
> 
>  - unconfigured folks would get all the three parts of the messages,
>    just like the current system.
> 
>  - if you tell rebase or merge, you do not see any.
> 
>  - if you do not choose between rebase or merge, you can still
>    squelch the latter two by setting advice.pullNonFF to false.
> 
> The last one is "keep the more dangerous half of 'git pull' disabled,
> without getting told how to enable it over and over", which is what
> you want to be able to specify.

Using advice.* to squelch the advice would be fine with me, provided it
was _also_ squelched by the existing config options.

Which I think is where your thinking is ending up.

-Peff
