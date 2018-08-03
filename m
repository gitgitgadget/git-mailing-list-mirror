Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88B41F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeHCP0X (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:26:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:41744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729796AbeHCP0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:26:22 -0400
Received: (qmail 3116 invoked by uid 109); 3 Aug 2018 13:30:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 13:30:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1589 invoked by uid 111); 3 Aug 2018 13:30:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 09:30:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 09:29:59 -0400
Date:   Fri, 3 Aug 2018 09:29:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Liam Decker <ldecker@indeed.com>, git@vger.kernel.org
Subject: Re: Question regarding quarantine environments
Message-ID: <20180803132959.GB28939@sigill.intra.peff.net>
References: <CALcD6sYfcaftciYU+2AHpzabyOS9ohRcZoE6LDuMyht+dxktHw@mail.gmail.com>
 <20180802183924.GB23690@sigill.intra.peff.net>
 <878t5ntxqs.fsf@evledraar.gmail.com>
 <20180803130058.GA4671@sigill.intra.peff.net>
 <877el7twej.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877el7twej.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 03, 2018 at 03:25:08PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I'd be a bit careful with that, though, as the definition of "new" is
> > vague there.
> >
> > For example, completing a thin pack may mean that the receiver creates a
> > copy of a base object found in the main repo. That object isn't new as
> > part of the push, nor was it even sent on the wire, but it will appear
> > in the quarantine directory. But only sometimes, depending on whether we
> > kept the sender's pack or exploded it to loose objects.
> 
> Right, I mean:
> 
>     is_new = !in_quarantine() && in_main()
> 
> Or:
> 
>     is_new = !in_main()
> 
> Should work, in the latter case if the object really is missing from the
> quarnatine too, other fsck bits will stop the push.

Ah, OK. Yes, I agree that should work to cover new objects (including
ones that the other side but aren't actually needed to update the refs,
though hopefully that is rare).

There may also be other object stores, if the main repository used
alternates (or if somebody set GIT_ALTERNATE_OBJECT_DIRECTORIES). You
can probably disregard that, though, as:

  1. If you ignore the main repo, presumably you ignore its
     recursive info/alternates, too.

  2. The easy mechanism for ignoring the main repo is to ignore
     GIT_ALTERNATE_OBJECT_DIRECTORIES, so you'd already be handling
     that.

> But as you point out:
> 
>     is_new = in_quarantine()
> 
> Cannot be relied upon, although it'll be true most of the time.
> 
> Perhaps I'm missing some edge case above, but I wanted to reword it to
> make sure I understood it correctly (and perhaps you have a correction).

Nope, I just didn't think through what you were saying carefully enough. ;)

-Peff
