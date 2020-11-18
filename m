Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EABC2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 01:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9802463B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 01:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKRB7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 20:59:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:33330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgKRB7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 20:59:09 -0500
Received: (qmail 20088 invoked by uid 109); 18 Nov 2020 01:59:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Nov 2020 01:59:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7309 invoked by uid 111); 18 Nov 2020 01:59:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 20:59:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 20:59:07 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <20201118015907.GD650959@coredump.intra.peff.net>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
 <20201118005014.GC389879@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118005014.GC389879@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 12:50:14AM +0000, brian m. carlson wrote:

> > then I'd feel comfortable making it a public-facing feature. And for
> > most cases it would be pretty pleasant to use (and for the unpleasant
> > ones, I'm not sure that a little quoting is any worse than the paired
> > environment variables found here).
> 
> What if we didn't document it but provided a command that produced a
> suitable value?  Maybe something like this:
> 
>   GIT_CONFIG_PARAMETERS=$(git rev-parse --quote-parameters a.b.c ENV_VAR d.e.f OTHER_ENV_VAR)
> 
> Or whatever we decide.

I think we mostly already have that tooling.

  $ GIT_CONFIG_PARAMETERS=$(
      git rev-parse --sq-quote \
        foo.bar=value \
        'section.key=with spaces' \
        "or.even=embedded 'quotes'" |
      sed 's/^ //'; # yuck
    )
  $ export GIT_CONFIG_PARAMETERS
  $ git config --list --show-scope | grep ^command
  command	foo.bar=value
  command	section.key=with spaces
  command	or.even=embedded 'quotes'

The "yuck" there is because --sq-quote insists on putting a space at the
front. Our parser should probably ignore that, but right now it's quite
picky.

Though I suppose:

  - do you mean ENV_VAR to literally look up an environment variable?
    That solves Patrick's original problem of not wanting to put
    sensitive values onto the command line. But it's much more annoying
    to use if you _don't_ already have the value in an environment
    variable. I'm not sure if that original problem matters here, as a
    program that does a lot of this would probably implement the quoting
    itself.

  - obviously it is doubling down on the shell-quoting as a public
    thing, and part of your point is that we would leave it opaque.
    I'm OK with that aspect (even if it ends up as an alias for
    --sq-quote for now). I'm not entirely sure people aren't using this
    in the wild already, though. Saying "it was undocumented" may give
    us a leg to stand on if we change the format, but it will still be
    annoying to people we break.

  - my example above still has the "a.b=c.d=e" ambiguity that I
    mentioned earlier. Fixing that requires changing the format in the
    environment variable.

> I don't personally love shell quoting as an interchange mechanism; I'd
> prefer something like URI-encoding, which is a bit more standardized and
> easier to reason about from a security perspective.  But if we decide to
> change it, it doesn't matter, since it's still undocumented and this
> would be the only acceptable way to pass config through the environment.

Yes, I think concatenating uri_encode(key) + "=" + uri_encode(value)
would be easier to reason about, and solves the ambiguity problem. If we
are willing to break from the existing format, it's probably a
reasonable direction.

> Alternatively, we could just do this:
> 
>   git with-config --key a.b.c --value ENV_VAR --key d.e.f --value OTHER_ENV_VAR --command git foo
> 
> That would also leave it undocumented, but make it easier to work with.

I wondered at first how this is different from:

  git -c a.b.c=value foo

but I guess it is meant to do the same environment-lookup? We could
probably add:

  git --env-config a.b.c=ENV_VAR foo

to have Git internally stick $ENV_VAR into $GIT_CONFIG_PARAMETERS. That
avoids all of the rev-parse rigamarole, keeps the format of the
environment variable opaque, and solves Patrick's problem of putting the
value onto the command-line.

It doesn't solve the ambiguity with "=" in the subsection, but IMHO that
is not all that important a problem.

-Peff
