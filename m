Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0E01F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 07:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfACHHq (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 02:07:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:53576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728613AbfACHHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 02:07:46 -0500
Received: (qmail 24492 invoked by uid 109); 3 Jan 2019 07:07:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 07:07:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8465 invoked by uid 111); 3 Jan 2019 07:07:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 02:07:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 02:07:44 -0500
Date:   Thu, 3 Jan 2019 02:07:44 -0500
From:   Jeff King <peff@peff.net>
To:     William Chargin <wchargin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Parsing trailers
Message-ID: <20190103070744.GA24149@sigill.intra.peff.net>
References: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 23, 2018 at 02:41:20PM -0800, William Chargin wrote:

> I'm interested in parsing the output of `git-interpret-trailers` in a
> script. I had hoped that the `--parse` option would make this easy, but
> it seems that the `trailer.separators` configuration option is used to
> specify both the input format (which separators may indicate a trailer)
> and the output format of `git interpret-trailers --parse`. Given that
> `trailer.separators` may contain any (non-NUL) characters, including
> whitespace, parsing the output is not straightforward.

IMHO this is a bug in --parse. It was always meant to give sane,
normalized output, that you could parse with something like:

  [^:]+: .*

That's what "%(trailers:only)" does (even if the original separator was
something else). It also trims any extra whitespace.

So I think it would be reasonable to:

  1. Add an --output-separator option. This should be uncontroversial.

  2. Make --parse imply "--output-separator=:". This might be more
     controversial, because it does change the output. But as I said
     above, I consider the current behavior to simply be a bug.

  3. (Optional) Add a "-z" option which uses "\0" both
     within and between trailer records. This obviously solves your
     problem without steps 1 and 2, but I think we should have a way to
     do it without relying on NULs, since they're harder to work with in
     some tools.

-Peff
