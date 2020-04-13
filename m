Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B96C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800B220663
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbgDMVZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:25:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:52448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388994AbgDMVZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 17:25:08 -0400
Received: (qmail 32748 invoked by uid 109); 13 Apr 2020 21:25:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Apr 2020 21:25:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21737 invoked by uid 111); 13 Apr 2020 21:35:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Apr 2020 17:35:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Apr 2020 17:25:06 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200413212506.GA28407@coredump.intra.peff.net>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
 <20200403184933.GA57202@syl.local>
 <20200403193842.GA7859@szeder.dev>
 <20200403195103.GA663412@coredump.intra.peff.net>
 <20200403204013.GC7859@szeder.dev>
 <20200403231021.GA672258@coredump.intra.peff.net>
 <20200413193934.GC63249@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413193934.GC63249@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 01:39:34PM -0600, Taylor Blau wrote:

> > > Hm, are you trying to go in the direction where '--stdin-commits'
> > > would keep erroring out on any non-full-hex-oid, but would accept and
> > > silently ignore any hex oids that are not commits (perhaps even when
> > > there is no such object, dunno)?  I think that would support the use
> > > cases you mentioned, while it would still save me when I do the 'echo
> > > <ref>' thing (somehow I regularly do that, remember doing it the day
> > > before yesterday!).
> >
> > Yes, exactly. The case you care about and the case I care about are
> > different ones, so there's no inherent conflict between them.
> 
> I was looking back again at this today, and I think we need something
> more or less like the following on top. I'll send it out later today or
> early tomorrow...

Yes, the behavior there looks fine to me. Though you may want to catch
the parse_oid_hex() separately and return its own error message. Telling
the user "I don't understand non-hex object names" instead of just
"invalid commit object" may be useful. I think it would also make the
flow of the function easier to follow.

If we were writing from scratch, I'd actually suggest that
builtin/commit-graph.c do parse_oid_hex() call as we read lines, and
then commit-graph could just be working with an oid_array or oidset,
which would reduce overall memory usage. I don't know if that would
cause other complications, but it could be worth looking into.

> +               if (ret || (ctx->check_oids && !result)) {
>                         error(_("invalid commit object id: %s"),
>                             commit_hex->items[i].string);
>                         return -1;

We could also take this a step further and just ditch check_oids
entirely (under the assumption that nobody really wants it; they just
wanted to catch bad names in the first place).

-Peff
