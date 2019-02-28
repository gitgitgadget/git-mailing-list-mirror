Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8AA20248
	for <e@80x24.org>; Thu, 28 Feb 2019 20:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfB1U4f (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 15:56:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:33392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732996AbfB1U4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 15:56:35 -0500
Received: (qmail 30741 invoked by uid 109); 28 Feb 2019 20:56:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 20:56:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23604 invoked by uid 111); 28 Feb 2019 20:56:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 15:56:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 15:56:33 -0500
Date:   Thu, 28 Feb 2019 15:56:33 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
Message-ID: <20190228205633.GA12199@sigill.intra.peff.net>
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
 <20190227163522.GA25188@sigill.intra.peff.net>
 <CAETBDP42djjmSXeLig6mcRJVR0YMPnDUfCJT4z8SU==Ei62N4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAETBDP42djjmSXeLig6mcRJVR0YMPnDUfCJT4z8SU==Ei62N4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 10:46:49PM -0400, Brandon Richardson wrote:

> > If we are going to go this route, I think you might actually want macros
> > that take both "unset" and "args" and make sure that we're not in a
> > situation the callback doesn't expect (e.g., "!unset && !arg"). That
> > lets us continue to declare those at the top of the callback.
> 
> In doing a quick search, I found a fair number instances of this:
> ...
> BUG_ON_OPT_NEG(unset);
> 
> if (!arg)
>      return -1;
> ...

Those are probably my fault. The originals guarded against an unexpected
"unset" by checking "!arg" and returning an error. But it made the
compiler's -Wunused-parameter complain, so I added the BUG_ON_OPT_NEG()
calls as an assertion. At that point the "if (!arg)" could never
trigger, and could have been removed.

> So a macro like this could be useful. I've also found a few instances of this:
> 
> BUG_ON_OPT_NEG(unset);
> BUG_ON_OPT_ARG(arg);

These ones are different. The second one is checking that "arg" _is_
NULL (i.e., we expect that the options struct provided the right flag to
disallow an argument). And that's orthogonal to the unset flag, so it
would not be right to conflate the two in a single macro.

-Peff
