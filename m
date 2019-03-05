Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819CC20248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfCET1c (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:27:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:39858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726190AbfCET1c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:27:32 -0500
Received: (qmail 20636 invoked by uid 109); 5 Mar 2019 19:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 19:27:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1991 invoked by uid 111); 5 Mar 2019 19:27:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 14:27:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 14:27:30 -0500
Date:   Tue, 5 Mar 2019 14:27:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com,
        git@vger.kernel.org
Subject: Re: [PATCH] rev-list: allow cached objects in existence check
Message-ID: <20190305192729.GA13409@sigill.intra.peff.net>
References: <20190304174053.GA27497@sigill.intra.peff.net>
 <20190304191932.105204-1-jonathantanmy@google.com>
 <20190304211749.GA3020@sigill.intra.peff.net>
 <xmqqzhq9tpie.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhq9tpie.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 05, 2019 at 10:33:13PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Or teach git-blame to have its own pretend mechanism, and remove the
> >> pretend mechanism from sha1-file.c.
> >
> > I think that would be ideal, but I'm not sure if it's feasible due to
> > the layering of the various modules.
> 
> Sorry, but I do not get why we want command-line specific pretend
> mechanism.  When one part of the system wants to behave as if object
> X exists, doesn't that part want other parts of the system to share
> that same world view to be consistent?
> 
> I am mostly reacting to "would be _ideal_"; if it were "if we have
> per-system ad-hoc pretend mechanism, things like this and that would
> become easier to implement, even though that is an ugly hack", I may
> agree when I see examples of things that get easier, though.

The problem is that it's not clear how each of those other parts of the
system should react to these pretend objects. E.g., they probably should
_not_ be used in any operation that might write, since we would not want
to create a permanent object that points to an ephemeral one.

By sticking this in sha1-file.c, it becomes hard to know who will access
them, or with what expectations. Things work right now because we use
the feature sparingly (and only from a process that's purely read-only).
But we're at risk of somebody later misusing it, especially if we spread
its use to more functions like has_object_file().  If this were local to
git-blame, then that risk goes away.

So that's what I meant by "ideal".

I don't think it makes anything easier (in fact, after looking, I think
it makes things in git-blame much harder, to the point that I am not
planning to work on it anytime soon).

-Peff
