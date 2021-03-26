Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD83CC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 03:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D60619D5
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 03:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCZD2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:28:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCZD14 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 23:27:56 -0400
Received: (qmail 28394 invoked by uid 109); 26 Mar 2021 03:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 03:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7014 invoked by uid 111); 26 Mar 2021 03:27:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Mar 2021 23:27:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Mar 2021 23:27:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
Message-ID: <YF1UuNBrAWvHSCp1@coredump.intra.peff.net>
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
 <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
 <87im5gp2ze.fsf@evledraar.gmail.com>
 <YFvaYokQJpvwSzJ6@coredump.intra.peff.net>
 <87czvoowg2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czvoowg2.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 02:26:21AM +0100, Ævar Arnfjörð Bjarmason wrote:

> >>     We could add a ifuncname and xifuncname or whatever for it I guess,
> >>     but currently the ICASE behavior in the C code is magic.
> >
> > Good point. IMHO that is something we should consider fixing
> > independently. It was a mistake to add builtins that couldn't be
> > replicated via the config (though I notice it happened quite a while
> > ago, and nobody seems to have cared, so perhaps it isn't that
> > important).
> 
> I'm conspiring to eventually optimistically replace these ERE patterns
> with PCRE if we build with that at some point.
> 
> Then you could just prefix your pattern with (?i) here in this and other
> things that want icase...

I really like PCRE myself, but is it portable/common enough for us to
start using it for baked-in funcname patterns? I sort of assumed there
were exotic platforms where libpcre wouldn't build (or at least it would
be inconvenient or uncommon to have it). And it would be nice to degrade
those gracefully (or at least better than "I guess you don't get any
builtin funcnames. Tough luck").

> > I have also wondered if we should just ship a file which could be
> > installed as /etc/gitconfig.filetypes and include it the stock
> > /etc/gitconfig. That is effectively the same as "baked in", but
> > hopefully makes it more clear to users how they can modify things.  But
> > all of that is somewhat orthogonal to what you're doing here.
> 
> In theory I'm with you on that, in practice this is just the sort of
> thing that requires opt-in effort from every person packaging git
> (installing system-wide-config).

I assumed that we'd install it with "make install", and packaging would
pick it up from there. But you're right that it is likely to create extra
headaches.

> But yeah, there's no reason your earlier suggestion of injecting global
> defaults into "git config -l" wouldn't work, and for our own C APIs such
> as this one to rely on that happening.
> 
> It would even make git more discoverable, as all the "this is set to xyz
> by default" docs in git-config(1) could become reflective, you could
> just run "git config -l --show-origin | grep ^default:" or something to
> see all default values.

Yeah, exactly. The discoverability is the real value IMHO. I just worry
about overwhelming the user who runs "git config" with --show-origin. I
guess it could avoid showing baked-in config unless an extra option is
given, but then that makes discoverability slightly harder (though still
better than it is today).

I dunno. This is mostly orthogonal to your patch series, so I don't mind
at all punting on it for now. Though if we _did_ do the baked-in config
then, then a lot of this userdiff code would want to be converted to it.

-Peff
