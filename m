Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB671FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 03:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdBID6q (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 22:58:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:52013 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbdBID6p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 22:58:45 -0500
Received: (qmail 24661 invoked by uid 109); 9 Feb 2017 03:58:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 03:58:42 +0000
Received: (qmail 13884 invoked by uid 111); 9 Feb 2017 03:58:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 22:58:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 22:58:39 -0500
Date:   Wed, 8 Feb 2017 22:58:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
Message-ID: <20170209035839.wqsh6ibgnmxyjusi@sigill.intra.peff.net>
References: <20170120171126.16269-1-stefanha@redhat.com>
 <20170120171126.16269-3-stefanha@redhat.com>
 <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
 <20170120235133.GA146274@google.com>
 <20170207150414.GD8583@stefanha-x1.localdomain>
 <xmqq8tphzr41.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tphzr41.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2017 at 12:24:30PM -0800, Junio C Hamano wrote:

> Having said that, I actually think "make it more convenient" without
> making anything incorrect would be to teach the revision parser to
> understand
> 
>     <any-expression-to-name-a-tree-ish:<path>
> 
> as an extended SHA-1 expression to name the blob or the tree at that
> path in the tree-ish, e.g. if we can make the revision parser to
> take this
> 
>     master:Documentation:git.txt

So here I was wondering what happens when you have a filename with a
colon in it, but then...

> to be able to show the same thing as well.  You'd need to backtrack
> the parsing (e.g. attempt to find "Documentation:git.txt" in
> "master", fail to find any, then fall back to find "git.txt" in
> "master:Documentation", find one, and be happy, or something like
> that), and define how to resolve potential ambiguity (e.g. there may
> indeed be "Documentation:git.txt" and "Documentation/git.txt" in the
> tree-ish "master"), though.

...you obviously did think of that. Backtracking sounds pretty nasty,
though. What's the time complexity of parsing:

  master:a:a:a:a:a:a:a:a:a:a:a

I think there are 2^(n-1) possible paths (each colon can be a real colon
or a slash). Though I guess if you walk the trees as you go, you only
have to examine at most "n" paths to find the first-level tree, and then
at most "n-1" paths at the second level, and so on.

Unless you really do have ambiguous trees, in which case you have to
walk down multiple paths.

It certainly would not be the first combinatoric explosion you can
convince Git to perform. But it does seem like a lot of complication for
something as simple as path lookups.

-Peff
