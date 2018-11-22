Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7BD1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 17:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404405AbeKWEW6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 23:22:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:48768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2404400AbeKWEW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 23:22:58 -0500
Received: (qmail 26945 invoked by uid 109); 22 Nov 2018 17:42:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 17:42:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23786 invoked by uid 111); 22 Nov 2018 17:41:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 12:41:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 12:42:33 -0500
Date:   Thu, 22 Nov 2018 12:42:33 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, gerardu@amazon.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        tikuta@chromium.org
Subject: Re: [PATCH 6/9] sha1-file: use an object_directory for the main
 object dir
Message-ID: <20181122174233.GB22123@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145039.GF7400@sigill.intra.peff.net>
 <421d3b43-3425-72c9-218e-facd86e28267@gmail.com>
 <20181112160910.GA7612@sigill.intra.peff.net>
 <CAGZ79kaH6WiSYeW2DCyZxYfg+qYuwTnF=2ZBO8rERJS_-8GeGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaH6WiSYeW2DCyZxYfg+qYuwTnF=2ZBO8rERJS_-8GeGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 11:04:52AM -0800, Stefan Beller wrote:

> >   for (odb = the_repository->objects->odb; odb; odb = odb->next) {
> >         if (odb->local)
> >                 return odb->path;
> >   }
> >   return NULL; /* yikes? */
> >
> > ? That feels like it's making things more complicated, not less.
> 
> It depends if the caller cares about the local flag.
> 
> I'd think we can have more than one local, eventually?
> Just think of the partial clone stuff that may have a local
> set of promised stuff and another set of actual objects,
> which may be stored in different local odbs.

Yeah, but I think the definition of "local" gets very tricky there, and
we'll have to think about what it means. So I'd actually prefer to punt
on doing anything too clever at this point.

> If the caller cares about the distinction, they would need
> to write out this loop as above themselves.
> If they don't care, we could migrate them to not
> use this function, so we can get rid of it?

Yes, I do think in the long run we'd want to get rid of most calls to
get_object_directory(). Not only because it uses the_repository, but
because most callers should be asking for a specific action: I want to
write an object, or I want to read an object.

-Peff
