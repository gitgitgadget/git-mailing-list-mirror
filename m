Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B601F405
	for <e@80x24.org>; Wed, 19 Dec 2018 15:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeLSP1i (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 10:27:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:45782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728941AbeLSP1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 10:27:37 -0500
Received: (qmail 22820 invoked by uid 109); 19 Dec 2018 15:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 15:27:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22049 invoked by uid 111); 19 Dec 2018 15:27:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 10:27:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 10:27:35 -0500
Date:   Wed, 19 Dec 2018 10:27:35 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/3] setup: drop return value from
 `read_repository_format()`
Message-ID: <20181219152735.GA14802@sigill.intra.peff.net>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-2-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218072528.3870492-2-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 08:25:26AM +0100, Martin Ågren wrote:

> No-one looks at the return value, so we might as well drop it. It's
> still available as `format->version`.
> 
> In v1 of what became commit 2cc7c2c737 ("setup: refactor repo format
> reading and verification", 2016-03-11), this function actually had
> return type "void", but that was changed in v2. Almost three years
> later, no-one has used this return value.

Hmm. If we have to pick one, I'd say that just returning a sane exit
value would be the more conventional thing to do. But looking at the
callers, many of them want to just pass the struct on to the verify
function.

That said, there is a long-standing curiosity here that we may want to
consider: read_repository_format() does not distinguish between these
three cases:

  1. the config file is missing

  2. the config file is present, but does not have a version field

  3. the config file is malformed, or we experience an I/O error
     (although I think there are still some cases that cause the config
     parser to die(), which may be sufficient)

The comment in check_repository_format_gently() implies that git-init
needs (1) to be a non-error for historical reasons. We could probably
tighten this up for other callers.

I think (2) probably should be an error, but note that it makes t1300
very unhappy, since it stomps all over .git/config. I'm not sure if any
real-world cases would be affected.

Case (3) I think we probably ought to do a better job of diagnosing. So
I wonder if the rule should be:

  - if we encounter a real error reading the config,
    read_repository_format() should return -1. Most callers should
    detect this and complain.

  - otherwise, a missing config returns 0 but puts "-1" into the version
    field

  - possibly verify_repository_format() should issue a warning when it
    sees "version == -1" and then rewrite the result into "0"

I dunno. This is one of those dark corners of the code where we appear
to do the wrong thing, but nobody seems to have noticed or cared much,
and changing it runs the risk of breaking some obscure cases. I'm not
sure if we should bite the bullet and try to address that, or just back
away slowly and pretend we never looked at it. ;)

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  I only discovered the full history after writing the patch. Had I known
>  it from the beginning, maybe I'd have just skipped this step, but I was
>  sufficiently disturbed by the redundant and unused return value that I
>  dropped it before working on the actual meat of this series.
> 
>  cache.h | 7 +++----
>  setup.c | 3 +--
>  2 files changed, 4 insertions(+), 6 deletions(-)

FWIW, the patch itself seems fine, and obviously doesn't make anything
worse on its own. The question is just whether we want to do more
cleanup here.

-Peff
