Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463A02022D
	for <e@80x24.org>; Fri,  4 Nov 2016 21:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761912AbcKDVzq (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 17:55:46 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37269 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757171AbcKDVzp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 17:55:45 -0400
X-Greylist: delayed 2139 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Nov 2016 17:55:45 EDT
Received: from mfilter41-d.gandi.net (mfilter41-d.gandi.net [217.70.178.173])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 7EA1FC5A4E;
        Fri,  4 Nov 2016 22:55:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter41-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter41-d.gandi.net (mfilter41-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id DfBrZeHOs5Wi; Fri,  4 Nov 2016 22:55:42 +0100 (CET)
X-Originating-IP: 198.233.217.214
Received: from x (unknown [198.233.217.214])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C234AC5A50;
        Fri,  4 Nov 2016 22:55:40 +0100 (CET)
Date:   Fri, 4 Nov 2016 15:55:39 -0600
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161104215538.xmpth6qfuou6nde6@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
 <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 03:49:07PM -0400, Jeff King wrote:
> On Fri, Nov 04, 2016 at 12:19:55PM -0700, Jacob Keller wrote:
> 
> > I agree with your assessment here. The main difficulty in implementing
> > gitrefs is to ensure that they actually do get picked up by
> > reachability checks to prevent dropping commits. I'm not sure how easy
> > this is, but I would much rather we go this route rather than
> > continuing along with the hack. This seems like the ideal solution,
> > since it solves the entire problem and doesn't need more hacks bolted
> > on.
> 
> I think the main complication is that the reachability rules are used
> during object transfer. So you'd probably want to introduce some
> protocol extension to say "I understand gitrefs", so that when one side
> says "I have sha1 X and its reachable objects", we know whether they are
> including gitrefs there. And likewise receivers with
> transfer.fsckObjects may complain about the new gitref tree mode
> (fortunately a new object type shouldn't be needed).
> 
> You might also want fallback rules for storing gitrefs on "old" servers
> (e.g., backfilling gitrefs you need if the server didn't them in the
> initial fetch). But I guess storing any gitrefs on such a server is
> inherently dangerous, because the server might prune them at any time.
> 
> So perhaps a related question is: how can gitrefs be designed such that
> existing servers reject them (rather than accepting the push and then
> later throwing away half the data). It would be easy to notice in the
> client during a push that we are sending gitrefs to a server which does
> not claim that capability. But it seems more robust if it is the server
> who decides "I will not accept these bogus objects".

This seems like the critical problem, here.  The parent hack I used in
git-series might be a hack, but it transparently works with old servers
and clients.  So, for instance, I can push a git-series ref to github,
with no changes required on github's part.  If git added gitrefs, and I
started using them in git-series, then that'd eliminate parent hack and
allow many standard git tools to work naturally on git-series commits
and history, but it'd also mean that people couldn't push git-series
commits to any server until that server updates git.

That said, I'd *love* to have gitrefs available, for a wide variety of
applications, and I can see an argument for introducing them and waiting
a few years for them to become universally available, similar to the
process gitlinks went through.

But I'd also love to have a backward-compatible solution.

- Josh Triplett
