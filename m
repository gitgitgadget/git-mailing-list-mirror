Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE30C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 07:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084EE241A5
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 07:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKQHBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 02:01:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:60084 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgKQHBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 02:01:10 -0500
Received: (qmail 14414 invoked by uid 109); 17 Nov 2020 07:01:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 07:01:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23415 invoked by uid 111); 17 Nov 2020 07:01:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Nov 2020 02:01:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Nov 2020 02:01:08 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <20201117070108.GB41136@coredump.intra.peff.net>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
 <X7NvrmisOs4g036W@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7NvrmisOs4g036W@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 07:37:34AM +0100, Patrick Steinhardt wrote:

> > then I'd feel comfortable making it a public-facing feature. And for
> > most cases it would be pretty pleasant to use (and for the unpleasant
> > ones, I'm not sure that a little quoting is any worse than the paired
> > environment variables found here).
> 
> I tend to disagree there. As long as you control keys and values
> yourself it's not too hard, that's true. But as soon as you start
> processing untrusted keys or values, then it's getting a lot harder.
> 
> E.g. suppose you create a fetch mirror for a user, where the source is
> protected by a password. We don't want to write the password into the
> gitconfig of the mirror repository. Passing it via `-C` will show up in
> ps(1). Using GIT_CONFIG_PARAMETERS requires you to quote the value,
> which contains arbitrary data, and if you fail to do that correctly you
> now have an avenue for arbitrary config injection.
> 
> That scenario is roughly why I came up with the _KEY/_VALUE schema. It
> requires no quoting, is trivial to set up (at least for its target
> audience, which is mostly scripts or programs) and wouldn't show up in
> ps(1).

True. Shell-quoting is pretty easy, but it's still a thing that the
caller has to do (and get right). Within Git we have nice routines for
that, but if you're calling from another program, you probably don't.

> > Yeah, scripts can currently assume that:
> > 
> >   unset $(git rev-parse --local-env-vars)
> > 
> > will drop any config from the environment. In some cases, having
> > rev-parse enumerate the GIT_CONFIG_KEY_* variables that are set would be
> > sufficient. But that implies that rev-parse is seeing the same
> > environment we're planning to clear. As it is now, a script is free to
> > use rev-parse to generate that list, hold on to it, and then use it
> > later.
> 
> Good point. Adjusting it would be trivial, though: unset all consecutive
> GIT_CONFIG_KEY_$n keys and potentially also GIT_CONFIG_VALUE_$n until we
> hit a gap. The parser would stop on the first gap anyway.

That doesn't help this case, which currently works:

  # remember the list so we don't have to invoke rev-parse in
  # each iteration of the loop
  vars=$(git rev-parse --local-env-vars)

  for repo in $repos; do
	# start with a clean slate
	unset $vars

	export GIT_DIR=$repo
	git do-some-thing

	# oops, these won't get cleared in the next go-round because
	# they weren't set when we called rev-parse
	export GIT_CONFIG_KEY_1=foo.bar
	export GIT_CONFIG_VALUE_1=whatever
	git do-another-thing
  done

Now I have no idea if anybody is doing something along those lines, and
it's a bit convoluted (I'd probably use a subshell). And obviously
nobody is doing this _exact_ thing yet, because the key/value variables
don't exist yet. So maybe it would all work out (the caller of this
script could have set git vars, but in that case we'd pick them up in
the rev-parse call).

So I dunno. It's probably unlikely to bite somebody, but it is a
departure from the current design.

-Peff
