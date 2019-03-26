Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8440020248
	for <e@80x24.org>; Tue, 26 Mar 2019 13:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbfCZNZP (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 09:25:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:36394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731613AbfCZNZP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 09:25:15 -0400
Received: (qmail 13228 invoked by uid 109); 26 Mar 2019 13:25:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 13:25:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18045 invoked by uid 111); 26 Mar 2019 13:25:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 09:25:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 09:25:13 -0400
Date:   Tue, 26 Mar 2019 09:25:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: Auto-gc in the background can take a long time to be put in the
 background
Message-ID: <20190326132512.GA22580@sigill.intra.peff.net>
References: <20190325232223.r72qtffyzn5qzoxc@glandium.org>
 <20190325233007.GA23728@sigill.intra.peff.net>
 <87k1gmb03v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1gmb03v.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 07:50:28AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Unfortunately making it faster is hard. To handle expiring unreachable
> > items, it has to know what's reachable. Which implies walking the commit
> > graph. I don't recall offhand whether setting unreachable-expiration to
> > "never" would skip that part. But if not, that should be low-hanging
> > fruit.
> 
> I have a recently patch that does this that I need to re-roll:
> https://public-inbox.org/git/20190315155959.12390-8-avarab@gmail.com/

I think your patch skips calling git-reflog when both are set to
"never". What I mean is that if regular expiration is set to 90 days,
and unreachable expiration is set to 90 days (or greater), the there is
no need for us to bother walking any history. An entry is either expired
based on time or it is not, regardless of reachability.

> > (I also wonder whether there is really much valuable in keeping
> > unreachable things for a shorter period of time, and the default should
> > simply be to just prune everything after 90 days, unreachable or not).
> 
> Do you mean unify gc.reflogExpire & gc.pruneExpire (and other
> variables). Would that be cheaper somehow?

Yes, this. If we're just expiring based on the timestamp in the reflog,
we should be able to accomplish this with just a single pass over the
reflog data, and never opening any objects at all.

> Or just blindly remove loose objects that are older than some mtime,
> assuming that if anyone cared they'd be in a pack already?

No, definitely not. We're expiring reflogs here, not objects.

-Peff
