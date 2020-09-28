Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3F1C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 03:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA83239A1
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 03:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI1DZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 23:25:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:42886 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1DZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 23:25:16 -0400
Received: (qmail 2669 invoked by uid 109); 28 Sep 2020 03:25:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Sep 2020 03:25:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3653 invoked by uid 111); 28 Sep 2020 03:25:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 23:25:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 23:25:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 8/8] shortlog: allow multiple groups to be specified
Message-ID: <20200928032515.GC3059492@coredump.intra.peff.net>
References: <20200927083933.GA2222823@coredump.intra.peff.net>
 <20200927084015.GH2465761@coredump.intra.peff.net>
 <xmqq8scuor59.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8scuor59.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 27, 2020 at 02:18:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > -		if (strcasecmp(iter.key.buf, log->trailer))
> > +		if (!string_list_has_string(&log->trailers, iter.key.buf))
> >  			continue;
> ...
> > +	if (!log.groups)
> > +		log.groups = SHORTLOG_GROUP_AUTHOR;
> > +	string_list_sort(&log.trailers);
> 
> I initially reacted with "oh, why sort?" to this line, before
> realizing that the list is used as a look-up table, which, if I
> recall correctly, you said you want to see us move off of in the
> longer term.
> 
> As we already have the string-set in this series, I am wondering
> why we are not using it.  It's not like the code at some point
> needs to iterate over log.trailers in some stable order, right?

Right, it's purely a lookup, and the new strset or any hashmap would
work.  However, the trailers list is part of the public shortlog.h[1]
interface, so we'd have to move strset to be a public thing, too. I
think that may be where we want to go eventually, but I thought I'd
trial it as something strictly internal to shortlog.c for now.

I'm also not _too_ bothered by this particular use of string-list as a
lookup table. It's one of the "easy" cases: we build up the list in one
phase, and then do lookups in the other, so sorting in between is no big
deal (though I do think a strset is even easier, as you do not have to
remember to sort between the phases).

-Peff
