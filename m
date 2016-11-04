Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936D22022D
	for <e@80x24.org>; Fri,  4 Nov 2016 20:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757315AbcKDUtN (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 16:49:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:38835 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754066AbcKDUtM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 16:49:12 -0400
Received: (qmail 9050 invoked by uid 109); 4 Nov 2016 19:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 19:49:10 +0000
Received: (qmail 25891 invoked by uid 111); 4 Nov 2016 19:49:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 15:49:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2016 15:49:07 -0400
Date:   Fri, 4 Nov 2016 15:49:07 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 12:19:55PM -0700, Jacob Keller wrote:

> I agree with your assessment here. The main difficulty in implementing
> gitrefs is to ensure that they actually do get picked up by
> reachability checks to prevent dropping commits. I'm not sure how easy
> this is, but I would much rather we go this route rather than
> continuing along with the hack. This seems like the ideal solution,
> since it solves the entire problem and doesn't need more hacks bolted
> on.

I think the main complication is that the reachability rules are used
during object transfer. So you'd probably want to introduce some
protocol extension to say "I understand gitrefs", so that when one side
says "I have sha1 X and its reachable objects", we know whether they are
including gitrefs there. And likewise receivers with
transfer.fsckObjects may complain about the new gitref tree mode
(fortunately a new object type shouldn't be needed).

You might also want fallback rules for storing gitrefs on "old" servers
(e.g., backfilling gitrefs you need if the server didn't them in the
initial fetch). But I guess storing any gitrefs on such a server is
inherently dangerous, because the server might prune them at any time.

So perhaps a related question is: how can gitrefs be designed such that
existing servers reject them (rather than accepting the push and then
later throwing away half the data). It would be easy to notice in the
client during a push that we are sending gitrefs to a server which does
not claim that capability. But it seems more robust if it is the server
who decides "I will not accept these bogus objects".

I haven't thought all that hard about this. That's just my initial
thoughts on what sound hard. Tweaking the reachability code doesn't seem
all that bad; we already know all of the spots that care about
S_ISGITLINK(). It may even be that some of those spots work out of the
box (because gitlinks are usually about telling the graph-walking code
that we _don't_ care about reachability; we do by default for trees and
blobs).

I'd be surprised if all such sites work out of the box, though. Even if
they see "ah, sha1 X is referenced by tree Y and isn't a gitlink, and
therefore should be reachable", they need to also note that "X" is a
commit and recursively walk its objects.

-Peff
