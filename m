Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388151F453
	for <e@80x24.org>; Sat, 29 Sep 2018 08:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeI2Ooi (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:44:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:36202 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727535AbeI2Ooi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:44:38 -0400
Received: (qmail 11425 invoked by uid 109); 29 Sep 2018 08:17:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 08:17:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4756 invoked by uid 111); 29 Sep 2018 08:16:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 04:16:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 04:17:05 -0400
Date:   Sat, 29 Sep 2018 04:17:05 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Hubert <khubert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Improvement to only call Git Credential Helper once
Message-ID: <20180929081705.GI2174@sigill.intra.peff.net>
References: <20180928163716.29947-1-khubert@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180928163716.29947-1-khubert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 12:37:16PM -0400, Kyle Hubert wrote:

> When calling the Git Credential Helper that is set in the git config,
> the get command can return a credential. Git immediately turns around
> and calls the store command, even though that credential was just
> retrieved by the Helper. This creates two side effects. First of all,
> if the Helper requires a passphrase, the user has to type it in
> twice. Secondly, if the user has a number of helpers, this retrieves
> the credential from one service and writes it to all services.
> 
> This commit introduces a new field in the credential struct that
> detects when the credential was retrieved using the Helper, and early
> exits when called to store the credential.

Wow, what's old is new again. Here's more or less the same patch from
2012:

  https://public-inbox.org/git/20120407033417.GA13914@sigill.intra.peff.net/

Unfortunately, some people seem to rely on this multi-helper behavior. I
recommend reading the whole thread, as there are some interesting bits
in it (that I had always meant to return to, but somehow 6 years went
by).

I'm not entirely opposed to breaking the current behavior in the name of
better security (namely not unexpectedly propagating credentials), but
it would be nice if we provided better tools for people to let their
helpers interact (like the credential-wrap thing I showed in that
thread).

> ---
>  credential.c | 8 +++++++-
>  credential.h | 3 ++-
>  2 files changed, 9 insertions(+), 2 deletions(-)

I know your patch is right, because it's almost identical to mine. :)
(Mine didn't use the "retrieved" flag in the middle, but just set
"approved" directly).

If we do go this route, though, we might want to steal the test from
that earlier round.

-Peff
