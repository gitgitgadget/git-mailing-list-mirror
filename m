Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452851F461
	for <e@80x24.org>; Tue,  9 Jul 2019 21:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfGIVvH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 17:51:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:33312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729093AbfGIVvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 17:51:07 -0400
Received: (qmail 8185 invoked by uid 109); 9 Jul 2019 21:51:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Jul 2019 21:51:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3673 invoked by uid 111); 9 Jul 2019 21:52:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Jul 2019 17:52:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2019 16:51:04 -0500
Date:   Tue, 9 Jul 2019 16:51:04 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Question] Diff text filters and git add
Message-ID: <20190709215104.GA20936@sigill.intra.peff.net>
References: <009201d5369f$4da5d030$e8f17090$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <009201d5369f$4da5d030$e8f17090$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 09, 2019 at 05:43:05PM -0400, Randall S. Becker wrote:

> I am trying to do something a bit strange and wonder about the best way to
> go. I have a text filter that presents content of very special binary file
> formats using textconv. What I am wondering is whether using the textconv
> mechanism is sufficient to have git calculate the file signature or whether
> I need to use an external diff engine, so that git add behaves in a stable
> manner (i.e., does git internally use the textconv mechanism for evaluating
> whether a file changed or whether the external diff engine is required, or
> whether this is even possible at all).

No, textconv only applies when generating a diff to output, and will
never impact what's stored in Git.

It sounds like you might want a clean filter instead, to sanitize
the file contents as they come into Git (and perhaps a matching smudge
filter to convert back to the working-tree version if necessary).

You're talking about "the diff engine" here, but note that git-add would
never do a diff at all. It cares only about full sha1s (and optimizes
out re-computing the sha1 on each invocation by using stat data). So
outside of clean/smudge, there's nothing else going on.

-Peff
