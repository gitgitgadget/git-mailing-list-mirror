Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591A51FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 05:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdC1FRe (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 01:17:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:52730 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbdC1FRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 01:17:34 -0400
Received: (qmail 16255 invoked by uid 109); 28 Mar 2017 05:17:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 05:17:27 +0000
Received: (qmail 20513 invoked by uid 111); 28 Mar 2017 05:17:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 01:17:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 01:17:23 -0400
Date:   Tue, 28 Mar 2017 01:17:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH/RFC] parse-options: add facility to make options
 configurable
Message-ID: <20170328051723.h2xi2do6iclm64pi@sigill.intra.peff.net>
References: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <20170324231013.23346-1-avarab@gmail.com>
 <CACBZZX6iz5QpfpOO6s9c-GY7+ZZ2uXBxqgKfSRhU+__P0VLC5g@mail.gmail.com>
 <20170325213107.u2l5eunqgqbxpcbb@sigill.intra.peff.net>
 <CACBZZX6=_Jh-emAr=g1-VQwgA4MnDpu=zSOqPK5QHAa7uef_LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6=_Jh-emAr=g1-VQwgA4MnDpu=zSOqPK5QHAa7uef_LQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 11:32:02PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > So hopefully it's clear that the two are functionally equivalent, and
> > differ only in syntax (in this case we manually decided which options
> > are safe to pull from the config, but we'd have to parse the options.log
> > string, too, and we could make the same decision there).
> 
> I like the simplicity of this approach a lot. I.e. (to paraphrase it
> just to make sure we're on the same page): Skip all the complexity of
> reaching into the getopt guts, and just munge argc/argv given a config
> we can stick ahead of the getopt (struct options) spec, inject some
> options at the beginning if they're in the config, and off we go
> without any further changes to the getopt guts.

Yep, I think that's an accurate description.

> There's two practical issues with this that are easy to solve with my
> current approach, but I can't find an easy solution to using this
> method.
> 
> The first is that we're replacing the semantics of:
> 
> "If you're specifying it on the command-line, we take it from there,
> otherwise we use your config, if set, regardless of how the option
> works"
> 
> with:
> 
> "We read your config, inject options implicitly at the start of the
> command line, and then append whatever command-line you give us"
> 
> These two are not the same. Consider e.g. the commit.verbose config.
> With my current patch if have commit.verbose=1 in your config and do
> "commit --verbose" you just end up with a result equivalent to not
> having it in your config, but since the --verbose option can be
> supplied multiple times to increase verbosity with the injection
> method you'd end up with the equivalent of commit.verbose=2.

Right, for anything where multiple options are meaningful, they'd have
to give "--no-verbose" to reset the option. In a sense that's less
friendly, because it's more manual. But it's also less magical, because
the semantics are clear: the config option behaves exactly as if you
gave the option on the command line. So for an OPT_STRING_LIST(), you
could append to the list, or reset it to empty, etc, as you see fit.

But I do agree that it's more manual, and probably would cause some
confusion.

> I can't think of a good way around that with your proposed approach
> that doesn't essentially get us back to something very similar to my
> patch, i.e. we'd need to parse the command-line using the options spec
> before applying our implicit config.

Yes, the semantics you gave require parsing the options first. I think
it would be sufficient to just give each "struct option" a "seen" flag
(rather than having it understand the config mechanism), having
parse_options() set the flag, and then feeding the result to a separate
config/cmdline mapping mechanism. That keeps the complexity out of the
options code.

It does tie us back in to requiring parse-options, which not all the
options use.

In a lot of cases that "seen" flag is effectively a sentinel value in
whatever variable the option value is stored in. But some of the options
don't have reasonable sentinel values (as you noticed with the "revert
-m" handling recently).

> The second issue is related, i.e. I was going to add some flag an
> option could supply to say "if I'm provided none of these other
> maybe-from-config options get to read their config". This is needed
> for hybrid plumbing/porcelain like "git status --porcelain".

Yeah, I agree you can't make that decision until you've seen the
command-line options. I think we currently do some hairy stuff where we
speculatively read config into a variable, and then apply the
config-based defaults only when we know we're in non-porcelain mode (see
status_deferred_config in builtin/commit.c).

That came about because we didn't want to parse the config a second
time. These days the deferred config should probably just be read from
the cached configset, after we've read the other options.

But I think this can be done after the full option-parsing is finished
by applying the mapping then.  I.e., something like:

    parse_options(argc, argv, options, ...);
    if (status_format != STATUS_FORMAT_PORCELAIN)
	apply_config_mapping(status_mapping, options);

-Peff
