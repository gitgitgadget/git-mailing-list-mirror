Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43195C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2D061155
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhINS4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:56:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:47308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhINS4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 14:56:23 -0400
Received: (qmail 25089 invoked by uid 109); 14 Sep 2021 18:55:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 18:55:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26770 invoked by uid 111); 14 Sep 2021 18:55:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 14:55:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 14:55:03 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Message-ID: <YUDwB0W6IpWWcU81@coredump.intra.peff.net>
References: <cover.1631331139.git.me@ttaylorr.com>
 <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
 <871r5v9z3i.fsf@evledraar.gmail.com>
 <87sfyb8ihg.fsf@evledraar.gmail.com>
 <YTzejKyYvqZu4v16@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTzejKyYvqZu4v16@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:51:24PM -0400, Taylor Blau wrote:

> > >> +	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
> > >> +		oid_to_hex(oid));
> > >
> > > Just an idea: Maybe the file could be lines of "+\tOID\n" instead of
> > > "+OID\n"? Lends itself more naturally to extension, use with the likes
> > > of string_list_split() etc.
> >
> > Actually, even better a format like:
> >
> >     "OID[\t+]\n"
> >
> > Or
> >
> >     "OID[\tpreferred=1]\n"
> 
> Sure, but I admit that I'm a little torn on this suggestion. I don't
> want to be naive and say that we're never going to change this format
> and paint ourselves into a corner.
> 
> On the other hand, changing it does seem extremely unlikely to me, and
> this tab-delimited thing feels like overkill compared to how simple the
> '+' format is.
> 
> So, I don't know. It's certainly easy enough to change now before we
> lock it in, so I guess we should.

I'm not sure I really see the point of making this infinitely
extensible. This is mostly an internal interface between two Git
programs. Sure, it's exposed to the user in the sense that they can use
--refs-snapshot themselves. But if some writer wants to add a "foo"
flag, do they really want to be able to do it in a way that they're
_syntactically_ compatible with the older versions of Git, yet have no
clue if their option was actually recognized and accepted?

I.e., if we later add such a flag, then:

  +OID\tfoo
  +\tOID\tfoo
  OID\t+\tfoo

does not seem to make a big difference. We will likely add a new
command-line option to say "by the way, I am passing you some extra
information" at which point the format can be whatever we like.

And unless it is really complicated, I'd just as soon use a
single-character marker again, because it's dead-simple to generate and
parse (and again, this is an internal interface and not something we
expect users to have to understand).

Unless we think the "+" is too ugly or confusing, but I don't. The "-"
prefix for pack-objects read_object_list_from_stdin() is similar and
works just fine. For that matter, the --stdin-packs feature there works
similarly. Everything more feels a bit like over-engineering at this
point.

-Peff
