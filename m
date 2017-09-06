Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637CC1F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 13:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbdIFNfW (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 09:35:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:58578 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753494AbdIFNfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 09:35:21 -0400
Received: (qmail 18262 invoked by uid 109); 6 Sep 2017 13:35:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 13:35:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21795 invoked by uid 111); 6 Sep 2017 13:35:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 09:35:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 09:35:19 -0400
Date:   Wed, 6 Sep 2017 09:35:19 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <michael@grubix.eu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: change ULONG_MAX to TIME_MAX
Message-ID: <20170906133519.amlc5yunx4yfl5u3@sigill.intra.peff.net>
References: <ef9aebb63227c36b8b72a65240a416a0271cc618.1504086318.git.git@grubix.eu>
 <xmqqbmmo8pp6.fsf@gitster.mtv.corp.google.com>
 <6a4cbbee-ffc6-739b-d649-079ba01439ca@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a4cbbee-ffc6-739b-d649-079ba01439ca@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2017 at 01:59:31PM +0200, Michael J Gruber wrote:

> BTW, there's more fallout from those name-rev changes: In connection
> with that other thread about surprising describe results for emacs.git I
> noticed that I can easily get "git name-rev --stdin" to segfault there.
> As easy as
> 
> echo bc5d96a0b2a1dccf7eeeec459e40d21b54c977f4 | git name-rev --stdin
> 
> for example.
> 
> That's unfortunate for the use-case of name-rev to amend git log output.
> 
> The reason seems to be that with "--stdin" or "--all", "name-rev" walks
> and names all commits before beginning to use that those names for even
> a single commit as above.
> 
> That segfault bisects to the logic changing commit in
> jc/name-rev-lw-tag, but I think the changed logic simply leads to more
> xmallocs() the segfault sooner now. Or something that I dind't spot even
> after a few hours.

The segfault seems to be due to running out of stack space. The problem
is that name_rev() is recursive over the history graph.  That topic
added a parameter to the function, which increased the memory used for
each level of the recursion. But the fundamental problem has always been
there. The right solution is to switch to iteration (with our own stack
structure if necessary).

We had similar problems with the recursive --contains traversal in tag,
and ended up with cbc60b6720 (git tag --contains: avoid stack overflow,
2014-04-24).

-Peff
