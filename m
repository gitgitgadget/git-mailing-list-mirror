Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2503920970
	for <e@80x24.org>; Tue, 11 Apr 2017 12:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbdDKM5p (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 08:57:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:59932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbdDKM5o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 08:57:44 -0400
Received: (qmail 3144 invoked by uid 109); 11 Apr 2017 12:57:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 12:57:43 +0000
Received: (qmail 1763 invoked by uid 111); 11 Apr 2017 12:58:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 08:58:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 08:57:41 -0400
Date:   Tue, 11 Apr 2017 08:57:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 11/12] grep: change the internal PCRE code & header names
 to be PCRE1
Message-ID: <20170411125741.7b7hlmuucid37b3r@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-12-avarab@gmail.com>
 <20170411103746.bth3rof753gbjtjf@sigill.intra.peff.net>
 <CACBZZX5V96Vv5NAYpkQSBWpn-4rgHOatAnL51o4-4DADAF+pEg@mail.gmail.com>
 <20170411104828.skkujde3qrvn4jrt@sigill.intra.peff.net>
 <CACBZZX6A8tcXy-hCcQqqDsGNDtXWmZMdTY=RxeAOn8QFYDypyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6A8tcXy-hCcQqqDsGNDtXWmZMdTY=RxeAOn8QFYDypyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 01:02:56PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> Yes, this is a bug. I'll need to add a git_options along with
> >> submodule_options and pass -c grep.patternType=....
> >
> > Maybe that's an indication we should have --pcre1-regexp and
> > --pcre2-regexp, so we don't have to resort to config tweaking.
> 
> I'd rather not. To reply to both your
> <20170411103018.dkq5gangx3vcxhp4@sigill.intra.peff.net> & this, one
> thing I was trying to do in this series (and I don't think I went far
> enough in "grep & rev-list doc: stop promising libpcre for
> --perl-regexp") was to stop promising some specific version of PCRE.

We don't necessarily have to document them. This is just in the general
rule of "if there's config, there should be command-line to override
it". Because without that, you get this exact situation where you have
to bolt on "-c" options to another part of the command line, which gets
awkward.

I'm also not sure it would be strictly correct, if the sub-program runs
other sub-programs. Providing "-c" affects all child processes, whereas
command-line options are propagated manually. So imagine you have a
process tree like:

  grep
   \-grep
      \-textconv

I.e., grep recurses to a submodule which then has to kick off a textconv
filter for one of the files. If you use "-c" to pass options to the
second grep, then those options will continue to have an effect inside
the textconv filter. Which _probably_ doesn't run git commands that
would care, but technically it could do anything.

> I.e. as far as the user is concerned they just want perl-y regexes,
> but they most likely don't care about the 1% featureset of those
> regexes where the various implementations of "perl-y regex" actually
> differ, because those cases tend to be really obscure syntax.

Yeah, that's what led me to the "why are we even worrying about run-time
switching" direction. I'd think a build-time switch would be enough for
people to test, and it makes all of this type of complexity go away.

-Peff
