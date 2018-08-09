Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB14C1F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 19:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeHIVvK (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 17:51:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:48896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726927AbeHIVvK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 17:51:10 -0400
Received: (qmail 635 invoked by uid 109); 9 Aug 2018 19:24:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 19:24:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12567 invoked by uid 111); 9 Aug 2018 19:24:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 15:24:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 15:24:54 -0400
Date:   Thu, 9 Aug 2018 15:24:54 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 03/10] sha1-array: provide oid_array_remove_if
Message-ID: <20180809192454.GB32376@sigill.intra.peff.net>
References: <20180808221752.195419-1-sbeller@google.com>
 <20180808221752.195419-4-sbeller@google.com>
 <CAN0heSqwGoFwn34nRp3i09ExnjDPSY8WD=81M9jN5OW-ccpiTg@mail.gmail.com>
 <CAGZ79kYtKZJ0Dm0ejxrotnoaNERtR0J6=DMCgweCObdJr0K6-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kYtKZJ0Dm0ejxrotnoaNERtR0J6=DMCgweCObdJr0K6-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 10:25:52AM -0700, Stefan Beller wrote:

> On Thu, Aug 9, 2018 at 12:39 AM Martin Ågren <martin.agren@gmail.com> wrote:
> >
> > On 9 August 2018 at 00:17, Stefan Beller <sbeller@google.com> wrote:
> > > +int oid_array_remove_if(struct oid_array *array,
> > > +                       for_each_oid_fn fn,
> > > +                       void *data)
> > > +{
> > > +       int i, j;
> > > +       char *to_remove = xcalloc(array->nr, sizeof(char));
> >
> > Do you really need this scratch space?
> 
> I don't think so, when we reorder the items while iterating over them.

Even with keeping the order this can be done in a single linear pass.
See filter_string_list() for an example.

The one twist here is that you cannot:

  oidcpy(array->oid[i], array->oid[j]);

when i==j, because of memcpy restrictions. With the current
implementation it would suffice to use struct assignment (and really,
every oidcpy() could just be struct assignment these days). But you
could also just do:

  if (i != j)
    oidcpy(array->oid[i], array->oid[j]);

> > I can't entirely follow this index-fiddling, but then I haven't had my
> > morning coffee yet, so please forgive me if this is nonsense. Would it
> > suffice to let i point out where to place items (starting at the first
> > item not to keep) and j where to take them from (i.e., the items to
> > keep, after the initial run)?
> 
> I thought this is what happens, just after the actual loop of calls.

I think the point is that we can just maintain those meanings during the
single walk through the array. The result is simpler to read and more
efficient.

-Peff
