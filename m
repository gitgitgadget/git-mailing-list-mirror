Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A761F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 19:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbcHOTPm (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 15:15:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:55699 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753030AbcHOTPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 15:15:41 -0400
Received: (qmail 4823 invoked by uid 109); 15 Aug 2016 19:09:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 19:09:00 +0000
Received: (qmail 18203 invoked by uid 111); 15 Aug 2016 19:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 15:09:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 15:08:57 -0400
Date:	Mon, 15 Aug 2016 15:08:57 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] checkout: do not mention detach advice for explicit
 --detach option
Message-ID: <20160815190856.27obqcpym4mhxgmo@sigill.intra.peff.net>
References: <20160815184021.12396-1-sbeller@google.com>
 <20160815184021.12396-2-sbeller@google.com>
 <20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net>
 <CAGZ79kZq=dPsngaqAVOj6UhaJE0=eR==XSTSSQCmcUTKugeM0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZq=dPsngaqAVOj6UhaJE0=eR==XSTSSQCmcUTKugeM0Q@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 11:54:53AM -0700, Stefan Beller wrote:

> > So....I guess. But has anybody in the history of git ever explicitly
> > configured advice.* to true?
> 
> An admin/teacher of a university that wants to teach Git to students
> in a class? Better be safe than sorry and explicitly ask for advice because...
> we cannot trust the default?
> 
> >
> > It has never produced any change of behavior, and the whole point of
> > "advice.*" was that git would advise by default, and you would use
> > advice.* to shut it up once you were sufficiently educated.
> 
> And now I am arguing that "by default" we should not give advice 100%
> of the time, but only when we think it is appropriate. You may disagree
> (as a teacher see above), so you can slightly change the setting to give
> out advice more often again?

I don't think it's quite the same thing. It is fine not to bother
advising because the advice is not really applicable, and that is what
is happening here. We do not need to lecture the user on something they
explicitly asked for.

But that is different than "by default, in situations where we have
useful advice to give, give it".

I guess you are indicating that somebody may disagree on "applicable"
here. Which I suppose is possible, but it seems like a bit of a made-up
hypothetical.


I had also thought at first you were arguing from the position of "let's
handle advice.detachedHEAD=true in case somebody has set it". That seems
even more silly, because almost certainly nobody _has_ set it. But if
your position is "let's make it do something useful in case somebody
wants to set it", then...I still think it's silly, but at least there is
room for debate. :)

> > I don't think doing it this way is _wrong_. It just feels sort of
> > pointlessly over-engineered. It's also a little weird that all of the:
> >
> >   if (advice_foo)
> >
> > will trigger because "advice_foo" is set to -1. I think it does the
> > right thing, but it feels like a bug (the value is now a tri-state, and
> > we silently collapse two states into one).
> 
> I think this is what I did in some of the submodule code as well, which
> is why I assumed it's ok (or rather the projects groupthink on how to do
> "default on but still different than explicit on")
> 
> If you think this is wrong, what is the idiomatic way to solve this problem?

I don't think it's wrong (didn't I say so :) ).

It's just that idiomatic use of a tri-state like this is generally
something like:

  1. Set the option to -1 for "not specified"

  2. Fill in the values as 0/1 if the user asks for it.

  3. Canonicalize any remaining unspecified value to 0/1, depending on
     the default. Usually this happens after we know all setup is done,
     but sometimes is done lazily by an accessor function.

  3. Check the canonical value with "if (option)", or "if (option())" if
     using a lazy accessor.

And we have fixed many bugs in the past where some non-canonical value
slipped past step 3, and did the wrong thing in step 4.

Here it's OK because "if (option)" means that "unspecified" collapses to
"true", and that is the default for each of these options. It's just
that it's hard to distinguish from the buggy case.

I suppose the more idiomatic way would be:

  static int advice_wanted(int x)
  {
	if (advice_values[x] < 0)
		advice_values[x] = 1; /* all advice defaults to on */
	return advice_values[x];
  }

  ...
  if (advice_wanted(ADVICE_DETACHED_HEAD))
	...

but perhaps it is not worth that amount of boilerplate (but maybe at
least a comment explaining the situation). You'd also need to check with
your patch that each user of the advice variables is checking just for a
non-zero value, and not explicitly for "1" (which is almost certainly
the case, but it needs to be considered).

-Peff
