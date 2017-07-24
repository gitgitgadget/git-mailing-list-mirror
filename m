Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFBCD203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 17:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755997AbdGXRKu (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 13:10:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:47172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754171AbdGXRKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 13:10:49 -0400
Received: (qmail 6275 invoked by uid 109); 24 Jul 2017 17:10:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 17:10:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10759 invoked by uid 111); 24 Jul 2017 17:11:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 13:11:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 13:10:47 -0400
Date:   Mon, 24 Jul 2017 13:10:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate
 from the lockfile
Message-ID: <20170724171046.rcq2vqqzikto4lbi@sigill.intra.peff.net>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
 <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
 <20170720233051.GB159617@aiede.mtv.corp.google.com>
 <xmqqpocuib06.fsf@gitster.mtv.corp.google.com>
 <20170724165907.53zx657qmizgl4lb@sigill.intra.peff.net>
 <20170724170915.GD13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170724170915.GD13924@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 10:09:15AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > This seems like the correct path to me. If the existing behavior is to
> > lock the referring symref, that seems like a violation of the lock
> > procedure in the first place. Because if "A" points to "B", we take
> > "A.lock" and then modify "B". But "B" may have any number of "A" links
> > pointing to it, eliminating the purpose of the lock.
> >
> > I thought we already did this, though. And that modifying HEAD (which
> > might be a symlink) required LOCK_NO_DEREF.
> 
> Yes, I believe the lockfile API already does so.  Since this patch
> creates a ".new" file, not using the lockfile API, it doesn't benefit
> from that, though.

Ah, I see. This bug makes much more sense, then. And I agree doubly that
matching the lock-code's behavior is the right thing to do.

-Peff
