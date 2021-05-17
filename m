Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0CCC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E16611BD
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhEQIyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 04:54:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:56086 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhEQIyd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 04:54:33 -0400
Received: (qmail 4590 invoked by uid 109); 17 May 2021 08:53:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 May 2021 08:53:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26610 invoked by uid 111); 17 May 2021 08:53:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 04:53:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 04:53:16 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/5] doc: remove unnecessary rm instances
Message-ID: <YKIu/DUfmU8JbDY2@coredump.intra.peff.net>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
 <20210514115631.503276-4-felipe.contreras@gmail.com>
 <YJ+TQiYVgocUBQRV@coredump.intra.peff.net>
 <609fb8b5bf799_e173a20897@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <609fb8b5bf799_e173a20897@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 15, 2021 at 07:04:05AM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > On Fri, May 14, 2021 at 06:56:29AM -0500, Felipe Contreras wrote:
> > 
> > > Commits 50cff52f1a (When generating manpages, delete outdated targets
> > > first., 2007-08-02) and f9286765b2 (Documentation/Makefile: remove
> > > cmd-list.made before redirecting to it., 2007-08-06) created these rm
> > > instances for a very rare corner-case: building as root by mistake.
> > > 
> > > It's odd to have workarounds here, but nowhere else in the Makefile--
> > > which already fails in this stuation, starting from
> > > Documentation/technical/.
> > 
> > Aren't there tons more that you end up removing in the next patch? E.g.:
> > 
> >    doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
> >   -       $(QUIET_GEN)$(RM) $@+ $@ && \
> >   -       $(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
> >   -       mv $@+ $@
> >   +       $(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@ $(QUIET_STDERR)
> > 
> > That does differ in that it removes $@+, too, but the premise is the
> > same (we know that $@+ could not be a problem, as we're about to
> > clobber it anyway).
> > 
> > I'm OK with getting rid of all of them, but it seems like it ought to be
> > happening all in this patch.
> 
> Yeah, but the rationale is different.
> 
>   1. $(RM) $@: these remove the target file because of permissions
>      (i.e. root owned)
>   2. $(RM) $@+ $@ && $(CODE) && mv $@+ $@: these are for interrupted builds
> 
> To get rid of #2 we need an alternative solution, like .DELETE_ON_ERROR,
> to get rid of #1 we don't, we can just do it.

To get rid of the "mv", you need something like .DELETE_ON_ERROR. But
the "rm" in the second case has nothing to do with interrupted builds.
It is is doing the same nothing that the ones you are getting rid of
here are.

I.e., I was suggesting to get rid of the "rm" call in the hunk I showed
above, but leave the "mv" for the follow-on patch.

-Peff
