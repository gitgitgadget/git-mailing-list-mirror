Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8F91F597
	for <e@80x24.org>; Tue, 24 Jul 2018 09:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbeGXLE0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:04:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:57238 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726270AbeGXLEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:04:25 -0400
Received: (qmail 8932 invoked by uid 109); 24 Jul 2018 09:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 09:58:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25896 invoked by uid 111); 24 Jul 2018 09:58:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 05:58:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 05:58:43 -0400
Date:   Tue, 24 Jul 2018 05:58:43 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
Message-ID: <20180724095843.GB3578@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org>
 <CAGZ79kbF7g3E4hBa0VqMqBoovbAb2dHaGFNRL=+f7Lce1AduVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbF7g3E4hBa0VqMqBoovbAb2dHaGFNRL=+f7Lce1AduVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 11:52:49AM -0700, Stefan Beller wrote:

> > +DELTA ISLANDS
> > +-------------
> [...]
> 
> I had to read all of this [background information] to understand the
> concept and I think it is misnamed, as my gut instinct first told me
> to have deltas only "within an island and no island hopping is allowed".
> (This message reads a bit like a commit message, not as documentation
> as it is long winded, too).

I'm not sure if I'm parsing your sentence correctly, but the reason I
called them "islands" is exactly that you'd have deltas within an island
and want to forbid island hopping. So I wasn't sure if you were saying
"that's what I think, but not how the feature works".

There _is_ a tricky thing, which is that a given object is going to
appear in many islands. So the rule is really "you cannot hop to a base
that is not in all of your islands".

> What about renaming this feature to
> 
> [pack]
>     excludePartialReach = refs/virtual/[0-9]]+/tags/
> 
>   "By setting `pack.excludePartialReach`, object deltafication is
>   prohibited for objects that are not reachable from all
>   manifestations of the given regex"
> 
> Cryptic, but it explains it in my mind in a shorter, more concise way. ;-)

So I'm hopelessly biased at this point, having developed and worked with
the feature under the "island" name for several years. But I find your
name and explanation pretty confusing. :)

Worse, though, it does not have any noun to refer to the reachable set.
The regex capture and the island names are an important part of the
feature, because it lets you make a single island out of:

  refs/virtual/([0-9]+)/heads
  refs/virtual/([0-9]+)/tags

but exclude:

  refs/virtual/([0-9]+)/(foo)

which goes into its own island ("123-foo" instead of "123"). So what's
the equivalent nomenclature to "island name"?

> > @@ -3182,6 +3225,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> >                   option_parse_missing_action },
> >                 OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
> >                          N_("do not pack objects in promisor packfiles")),
> > +               OPT_BOOL(0, "delta-islands", &use_delta_islands,
> > +                        N_("enable islands for delta compression")),
> 
> We enable this feature, but we disallow certain patterns to be used in packing,
> so it sounds weird to me as we tell Git to *not* explore the full design space,
> so we're not enabling it, but rather restricting it?

Yeah, perhaps "respect islands during delta compression" makes more sense.

-Peff
