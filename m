Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71F881F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 13:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeKUX4Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 18:56:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:47268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730197AbeKUX4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 18:56:16 -0500
Received: (qmail 18762 invoked by uid 109); 21 Nov 2018 13:21:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Nov 2018 13:21:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8827 invoked by uid 111); 21 Nov 2018 13:21:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Nov 2018 08:21:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2018 08:21:52 -0500
Date:   Wed, 21 Nov 2018 08:21:52 -0500
From:   Jeff King <peff@peff.net>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: pathspec: problems with too long command line
Message-ID: <20181121132152.GA8246@sigill.intra.peff.net>
References: <c3be6eff-365b-96b8-16d2-0528612fc1fc@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3be6eff-365b-96b8-16d2-0528612fc1fc@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 10:23:34AM +0100, Marc Strapetz wrote:

> From our GUI client we are invoking git operations on a possibly large set
> of files. This may result in pathspecs which are exceeding the maximum
> command line length, especially on Windows [1] and OSX [2]. To workaround
> this problem we are currently splitting up such operations by invoking
> multiple git commands. This works well for some commands (like add), but
> doesn't work well for others (like commit).
> 
> A possible solution could be to add another patchspec magic word which will
> read paths from a file instead of command line. A similar approach can be
> found in Mercurial with its "listfile:" pattern [3].
> 
> Does that sound reasonable? If so, we should be able to provide a
> corresponding patch.

Quite a few commands take --stdin, which can be used to send pathspecs
(and often other stuff) without size limits. I don't think either
"commit" or "add" does, but that might be another route.

I'm slightly nervous at a pathspec that starts reading arbitrary files,
because I suspect there may be interesting ways to abuse it for services
which expose Git. E.g., if I have a web service which can show the
history of a file, I might take a $file parameter from the client and
run "git rev-list -- $file" (handling shell quoting, of course). That's
OK now, but with the proposed pathspec magic, a malicious user could ask
for ":(from-file=/etc/passwd)" or whatever.

I dunno. Maybe that is overly paranoid, and certainly servers like that
are a subset of users. And perhaps such servers should be specifying
GIT_LITERAL_PATHSPECS=1 anyway.

-Peff
