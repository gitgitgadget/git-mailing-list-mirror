Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E69C433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 23:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD922083E
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 23:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgG0XmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:42:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:39312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgG0XmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 19:42:18 -0400
Received: (qmail 20675 invoked by uid 109); 27 Jul 2020 23:42:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Jul 2020 23:42:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19630 invoked by uid 111); 27 Jul 2020 23:42:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jul 2020 19:42:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jul 2020 19:42:17 -0400
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
Message-ID: <20200727234217.GA802697@coredump.intra.peff.net>
References: <87blk0rjob.fsf@0x63.nu>
 <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
 <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
 <20200727194036.GA795313@coredump.intra.peff.net>
 <875za8r2fu.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875za8r2fu.fsf@0x63.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 12:57:51AM +0200, Anders Waldenborg wrote:

> >> > > When configuring a value in trailer.<token>.key it causes the trailer to
> >> > > be normalized to that in "git interpret-trailers --parse".
> >> > > E.g:
> >> > >  $ printf '\naCKed: Zz\n' | \
> >> > >    git -c 'trailer.Acked.key=Acked' interpret-trailers --parse
> >> > >  will emit: "Acked: Zz"
> >>
> >> Yeah, I think that's nice, as it can make sure that the key appears in
> >> the same way. It's true that it would be better if it would be
> >> documented.
> >
> > I'd note that this also happens without --parse.
> 
> Right, and it also happens with "--only-input" (part of "--parse")
> 
> "--only-input" is documented as follows:
> 
>    Output only trailers that exist in the input; do not add any from the
>    command-line or by following configured trailer.* rules.

I think I meant there only that we wouldn't add new trailers (e.g., from
"trailers.*.ifMissing"). But I do agree that it might be simpler if we
can just say "we don't look at trailer.<token>.* config at all in
--only-input mode. I _think_ that's true (we probably do look at
trailer.separators, but the rest of the token-specific ones look like
they're all about writing or modifying, not reading).

> > I don't recall being aware of this prefix matching until this thread, so
> > I doubt that the current behavior of --parse was something I tried for
> > intentionally. It's mostly just using the existing code, plus a few
> > extra options (listed in the docs). I'm not opposed to adding an option
> > to do strict matching and/or avoid rewriting, and then possibly adding
> > that into --parse by default.
> 
> Would that option also be set for the parsing done by "%(trailers)"
> pretty format specifier?

I thnk %(trailers) isn't quite the same as "--parse", because you have
to say "only" or "unfold" yourself. But yeah, that option should
certainly be available there, if not the default.

> > I don't have much of an opinion on which behavior would be preferred.
> > I've never actually had a use case for configuring trailer.*.key, as I
> > usually am only looking at reading existing trailers to collect stats,
> > etc.
> 
> I'm also mainly using in reading trailers (mostly with pretty format
> "%(trailers:key=x)") and then these convenience shortcuts doesn't really
> seem helpful, they rather add a small risk of mangling my data. Not that
> this has caused any problems for me in practice.

Yeah, pondering it a bit more, I think trailer.<token>.* doesn't really
make any sense for any reading operation (including %(trailers) or
--parse). I guess it _could_ be useful to normalize names in some
instances, but it's as likely to confuse or break somebody as to help.

-Peff
