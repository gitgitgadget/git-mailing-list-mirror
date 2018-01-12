Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909EB1F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933783AbeALNqM (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:46:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:42156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933478AbeALNqM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:46:12 -0500
Received: (qmail 4913 invoked by uid 109); 12 Jan 2018 13:46:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 13:46:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30889 invoked by uid 111); 12 Jan 2018 13:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 08:46:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 08:46:09 -0500
Date:   Fri, 12 Jan 2018 08:46:09 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: git gc --auto yelling at users where a repo legitimately has
 >6700 loose objects
Message-ID: <20180112134609.GB7880@sigill.intra.peff.net>
References: <87inc89j38.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87inc89j38.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 10:33:15PM +0100, Ævar Arnfjörð Bjarmason wrote:

>  4. At the end of all this, we check *again* if we have >6700 objects,
>     if we do we print "run 'git prune'" to .git/gc.log, and will just
>     emit that error for the next day before trying again, at which point
>     we unlink the gc.log and retry, see gc.logExpiry.
> 
> Right now I've just worked around this by setting gc.pruneExpire to a
> lower value (4.days.ago). But there's a larger issue to be addressed
> here, and I'm not sure how.

IMHO the right solution is to stop exploding loose objects, and instead
write them all into a "cruft" pack. That's more efficient, to boot
(since it doesn't waste inodes, and may even retain deltas between cruft
objects).

But there are some tricks around timestamps. I wrote up some thoughts
in:

  https://public-inbox.org/git/20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net/

and downthread from there.

-Peff
