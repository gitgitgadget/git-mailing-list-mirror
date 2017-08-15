Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88A420899
	for <e@80x24.org>; Tue, 15 Aug 2017 03:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbdHODif (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 23:38:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:39002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752946AbdHODie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 23:38:34 -0400
Received: (qmail 11680 invoked by uid 109); 15 Aug 2017 03:38:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 03:38:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8224 invoked by uid 111); 15 Aug 2017 03:38:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 23:38:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 23:38:32 -0400
Date:   Mon, 14 Aug 2017 23:38:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] clang-format
Message-ID: <20170815033832.m6fdfvnyf5kvwzkw@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814230657.bmn7exoqmqw3tlyh@sigill.intra.peff.net>
 <CAGZ79kZgRTzWiufZUE02YYOJpH66x_hShBfcv=4RWDn-qR2LUg@mail.gmail.com>
 <20170815014704.thmpoz5xteuhqh3d@sigill.intra.peff.net>
 <xmqqmv71sfbc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmv71sfbc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 08:03:19PM -0700, Junio C Hamano wrote:

> > I'm tempted to say that "config --list" should normalize this case into:
> >
> >   mysection.mykey=true
> >
> > Normally we avoid coercing values without knowing the context in which
> > they'll be used. But the syntax in the original file means the user is
> > telling us it's a boolean and they expect it to be treated that way.
> >
> > The only downside is if the user is wrong, it might be coerced into
> > the string "true" instead of throwing an error. That seems like a minor
> > drawback for eliminating a potentially confusing corner case from the
> > plumbing output.
> 
> Because we cannot sensibly always normalize a variable set to 'yes',
> 'on', etc. to all "true", the degree it can help the reading scripts
> is quite limited, as they need to be prepared to see other
> representation of the truth values anyway.  Even though I too found
> the approach somewhat tempting, because there is no ambiguity in
> "[section] var" that it means a boolean "true", I doubt it would
> help very much.

Good point. This is the only case that is _syntactically_ a problem at
the key/value level, which is why we noticed it (the reader barfed on
the unknown input). But that same reader could be interpreting values
incorrectly and we'd have no idea. And that applies to types beyond
booleans (you showed numbers like "2k" below, but there are others, like
--path or --get-color).

The one nice thing about fixing this syntactic issue is that the current
behavior affected this reader even though it didn't care about
particular config key in question. I.e., in this output:

  my.boolVal
  my.intVal=2k
  my.valueWeCareAbout=some string

if we don't care about the meaning of boolVal or intVal, we could still
parse this output fine if not for the syntactic irregularity of
my.boolVal.

That's what might tempt me to fix this independent of the deeper
problem. But I really think we should try to address that deeper
problem.

> The way they pass "non_string_options" dict to the loader is quite
> sensible for that purpose, as it allows the reader to say "I care
> about this and that variables, and I know I want them interpreted as
> int (e.g. 1M) and bool (e.g. 'on') and returned in a normalized
> form".
> 
> I do not mind adding "git config --list --autotype" option, though,
> with which the reading script tells us that it accepts the chance of
> false conversion, so that
> [...]

I think an "--autotype" is always going to have false positives.
Integers and booleans we can make guesses at. But "--path" or "--color"
are much tougher.

The right answer is to make it easier for that non_string_options
information to make it to git-config so it can do the interpretation for
the caller. The way that happens now is:

  git config --int my.intVal
  git config --bool my.boolVal
  git config --path my.pathVal

and so on. But I think one reason people turn to --list is that it
requires only a single process invocation, rather than repeatedly
calling git-config for each variable which might be of interest.  I know
that diff-highlight's startup is measurably slower due to the six "git
config --get-color" calls it must make, and I've been looking for a way
to do it with a single invocation.

I suspect we need a "--get-stdin" which can accept (key,type) tuples and
return the result over stdout. And in some cases it's more than just a
pair; for example, colors need an extra "parse this default" argument).

-Peff
