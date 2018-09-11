Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2CD1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeILB6R (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:58:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:46396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726850AbeILB6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:58:16 -0400
Received: (qmail 18114 invoked by uid 109); 11 Sep 2018 20:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Sep 2018 20:57:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21704 invoked by uid 111); 11 Sep 2018 20:57:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Sep 2018 16:57:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Sep 2018 16:57:10 -0400
Date:   Tue, 11 Sep 2018 16:57:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        stas@stason.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: git silently ignores include directive with single quotes
Message-ID: <20180911205709.GA25828@sigill.intra.peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <87bm97rcih.fsf@evledraar.gmail.com>
 <20180908211436.GA31560@sigill.intra.peff.net>
 <ad56c575-1211-61d2-daed-5b0da61db738@ramsayjones.plus.com>
 <20180909023332.GA14762@sigill.intra.peff.net>
 <xmqqk1nrojpq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk1nrojpq.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 01:36:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think that's syntactically invalid. At any rate, there are clearly
> > three options for setting a bit:
> >
> >   1. In the section header (+include, or Ævar's includeIf suggestion).
> >
> >   2. In another key (which looks pretty clean, but does introduce
> >      ordering constraints).
> >
> >   3. In the key name (maybePath or similar).
> >
> > I don't have a huge preference between them.
> 
> What's the longer term goal for the endgame?  Is it acceptable that
> include.path will stay to be "optional include" for compatibility
> with users' existing configuration files, and include.requiredpath
> or similar gets introduced to allow people who want to get warned?
> Or do we want the usual multi-step deprecation dance where the first
> phase introduces include.maybepath and include.path starts warning
> against missing one, encouraging it to be rewritten to maybepath?

I don't see much point in introducing include.requiredPath. It might be
useful for people who want to be extra-careful with their includes, but
it would not really help users who simply made a spelling error and
didn't know how to debug it.

So switching the default for include.path and providing an escape hatch
seems like the more useful path (if we indeed want to do one of these;
adding better debugging like GIT_TRACE_CONFIG is yet another option).

As far as deprecation, it depends on what the new behavior is. If it is
simply that include.path will generate a warning on a missing file, I
don't think there is any point in a multi-step dance. The endgame is a
warning, which is no different than the deprecated-stage behavior. :)

If the endgame is to die(), then I'd agree that there should be a
warning in the middle.

Between all those things I mentioned (or simply leaving it as-is), I
really don't have a strong feeling. I hoped people who did would
generate a patch to give something concrete to review.

> I have mild preference against #2, as I suspect that the ordering
> constraints makes it harder to understand to end users.  Between #1
> and #3, there wouldn't be much difference, whether the endgame is
> "add a stricter variant that is opt in" or "migrate to a stricter
> default".

The thing that #2 buys you is that multiple such bits could be combined.
If we imagine that later there is another choice to make in interpreting
include.path with two options, "foo" and "bar", then we would be stuck
with:

  include.maybeFooPath
  include.maybeBarPath
  include.fooPath
  include.barPath

and of course it only gets worse with a third one.  Whereas with
independent options, you can do:

  [include]
  warnOnMissing = false
  otherPreference = bar
  path = ...

I dunno. The combinatorics might not be too bad if we document the
required order, and actually code the parsing side like:

  if (!skip_prefix(key, "maybe", &key))
	warn_on_missing = 0;
  if (!skip_prefix(key, "foo", &key))
        other_pref = "foo";
  ...and so on

It's kind of hacky, but it does encode the bits into the name. As long
as they remain bits, and not, say, arbitrary strings.

-Peff
