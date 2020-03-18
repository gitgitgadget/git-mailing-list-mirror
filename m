Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD8C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 10:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E0420768
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 10:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCRKD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:03:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:42530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727041AbgCRKD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 06:03:29 -0400
Received: (qmail 13757 invoked by uid 109); 18 Mar 2020 10:03:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Mar 2020 10:03:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14634 invoked by uid 111); 18 Mar 2020 10:13:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Mar 2020 06:13:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Mar 2020 06:03:27 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        james@jramsay.com.au
Subject: Re: [RFC PATCH 1/2] list_objects_filter_options: introduce
 'list_object_filter_config_name'
Message-ID: <20200318100327.GA1227946@coredump.intra.peff.net>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <c75806d011b04f2ad7efbbec01613a2d0b1f570b.1584477196.git.me@ttaylorr.com>
 <CAPig+cTVtv+uzzpoZ-BT=F=srdt1ewvgeBAAr9R+OUCYSov65A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTVtv+uzzpoZ-BT=F=srdt1ewvgeBAAr9R+OUCYSov65A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 04:53:44PM -0400, Eric Sunshine wrote:

> > +       case LOFC_DISABLED:
> > +       case LOFC__COUNT:
> > +               /*
> > +                * Include these to catch all enumerated values, but
> > +                * break to treat them as a bug. Any new values of this
> > +                * enum will cause a compiler error, as desired.
> > +                */
> 
> In general, people will see a warning, not an error, unless they
> specifically use -Werror (or such) to turn the warning into an error,
> so this statement is misleading. Also, while some compilers may
> complain, others may not. So, although the comment claims that we will
> notice an unhandled enum constant at compile-time, that isn't
> necessarily the case.

Yes, but that's the best we can do, isn't it?

There's sort of a meta-issue here which Taylor and I discussed off-list
and which led to this comment. We quite often write switch statements
over enums like this:

  switch (foo)
  case FOO_ONE:
	...do something...
  case FOO_TWO:
        ...something else...
  default:
	BUG("I don't know what to do with %d", foo);
  }

That's reasonable and does the right thing at runtime if we ever hit
this case. But it has the unfortunate side effect that we lose any
-Wswitch warning that could tell us at compile time that we're missing a
case. Not everybody would see such a warning, as you note, but
developers on gcc and clang generally would (it's part of -Wall).

But we can't just remove the default case. Even though enums don't
generally take on other values, it's legal for them to do so. So we do
want to make sure we BUG() in that instance.

This is awkward to solve in the general case[1]. But because we're
returning in each case arm here, it's easy to just put the BUG() after
the switch. Anything that didn't return is unhandled, and we get the
best of both: -Wswitch warnings when we need to add a new filter type,
and a BUG() in the off chance that we see an unexpected value.

But the cost is that we have to enumerate the set of values that are
defined but not handled here (LOFC__COUNT, for instance, isn't a real
enum value but rather a placeholder to let other code know how many
filter types there are).

So...I dunno. Worth it as a general technique?

-Peff

[1] In the general case where you don't return, you have to somehow know
    whether the value was actually handled or not (and BUG() if it
    wasn't). Presumably by keeping a separate flag variable, which is
    pretty ugly. -Wswitch-enum is supposed to deal with this by
    requiring that you list all of the values even if you have a default
    case. But it triggers in a lot of other places in the code that I
    think would be made much harder to read by having to list out the
    enumerated possibilities.
