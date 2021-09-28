Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8138C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA9C60F4A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbhI1AnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:43:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:56012 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238236AbhI1AnX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:43:23 -0400
Received: (qmail 8075 invoked by uid 109); 28 Sep 2021 00:41:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 00:41:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22968 invoked by uid 111); 28 Sep 2021 00:41:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 20:41:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 20:41:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Message-ID: <YVJkx2HMf9WlPx6G@coredump.intra.peff.net>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
 <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
 <xmqqa6k1slxe.fsf@gitster.g>
 <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net>
 <xmqqo88eq8um.fsf@gitster.g>
 <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
 <87lf3hzhkr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf3hzhkr.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 01:52:26AM +0200, Ævar Arnfjörð Bjarmason wrote:

> An implicit assumption of mine in the simpler positive-match-only
> version (which I should have made clear) is that anyone who needs this
> sort of complexity can just arrange to wrap their "git" in a function,
> or do this sort of thing in their ~/.bashrc, i.e. just:
> 
>     if code_of_arbitrary_complexity
>     then
>         export GIT_DO_XYZ_INCLUDES=1
>     fi
> 
> Then in your config:
> 
>     includeIf.envBool:GIT_DO_XYZ_INCLUDES.path=~/.gitconfig.d/xyz.cfg
> 
> And having written that out I think the best thing to do is probably to
> have a version that only does the envExists and envBool version (or just
> envBool), and skip envIs and envMatch entirely.

I'm not sure I agree. If you are willing to wrap git, then you can just
add:

  git -c include.path=~/.gitconfig.d/xyz.cfg

to the command-line in the first place. Or if you're willing to use our
undocumented interface, you can even do it in your .bashrc:

  if code_of_arbitrary_complexity
  then
          GIT_CONFIG_PARAMETERS="'include.path'='~/.gitconfig.d/xyz.cfg'"
  fi

The value of this env matching is that it is done at run-time without
wrapping, and can meaningfully inspect the state of the world. E.g., the
$TERM thing that started this thread.

> In the case of env:PATH we're just setting users up for some buggy or
> unexpected interaction with something that would be better done either
> via a gitdir include, or if they really need $PATH they can just wrap
> "git" in a function that sets a boolean inclusion variable.

Yes, I have trouble imagining why any matching on env:PATH would be
useful (or $PWD, since we have the much less confusing gitdir
conditional). Which isn't to say I want to forbid it, but just because
people can shoot themselves in the foot with complexity doesn't mean
that "envIs" is a bad thing when it's not misused.

> > I think it's just the mashed-up colons that I find ugly in the first
> > one. But I agree the latter isn't that nice either, and introduces the
> > ambiguity you describe.
> 
> FWIW I hacked up a --config-key --config-value pairing so you could set
> keys with "=" in them on the command-line, I'm not sure I like the
> interface, but it gets rid of that ":" v.s. "=" edge case:
> https://github.com/avar/git/commit/a86053df48b

Yeah, we talked about that a while ago, but nobody liked the interface
enough to actually code it (and as far as I know, it's really
theoretical; nobody has actually wanted to set such an option from the
command-line yet, and we have the --config-env stuff for people who want
to robustly pass along arbitrary keys).

A perhaps more subtle but less awkward to type version is to just
require two arguments, like:

  git --config <key> <value> ...

but I'd just as soon continue to leave it un-implemented if nobody has
actually needed it in practice.

-Peff
