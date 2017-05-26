Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3781FA14
	for <e@80x24.org>; Fri, 26 May 2017 13:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764663AbdEZNa2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 09:30:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:58499 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763266AbdEZNa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 09:30:27 -0400
Received: (qmail 32293 invoked by uid 109); 26 May 2017 13:30:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 13:30:26 +0000
Received: (qmail 30112 invoked by uid 111); 26 May 2017 13:31:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 09:31:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 09:30:24 -0400
Date:   Fri, 26 May 2017 09:30:24 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv3 1/4] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170526133024.g5rztiv3lea37n72@sigill.intra.peff.net>
References: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
 <20170526100403.19270-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170526100403.19270-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 12:04:03PM +0200, SZEDER Gábor wrote:

> > but given that it lazy-parses in
> > some cases, it feels a little dangerous.
> 
> I'm not sure about lazy parsing.
> remote_get() returns a fully-parsed, cached struct remote instance
> without re-reading the configuration, so all fields directly
> corresponding to configuration variables stay the same.  However, it
> does parse fetch and push refspecs on every invocation.  So if it were
> to be called to return the origin remote more than once during
> cloning, then the default refspec would get lost on subsequent
> invocations.  Is this what you meant with dangerous?

More or less. I actually didn't look far enough to see under what
circumstances we might re-parse (or might not have parsed when we add
our extra refspec), but that's definitely the sort of thing I was
worried about.

> (Sidenote: and it would leak some memory, too, because it re-parses
> the refspecs without free()ing the results of the previous
> invocation.)

Yes, I'd argue that the current code is buggy, since:

  x = remote_get("foo");
  y = remote_get("foo");

is a guaranteed leak. It seems like remote_get_1() should protect the
call to parse_fetch_refspec() by checking whether ret->fetch is NULL
(and ditto for ret->push).

> Your proposed function to add a refspec as a string would eliminate
> this danger.

Yeah, I think it's not that hard to support. I'd just rather have the
logic inside remote.c, rather than infecting the caller with the
complexity.

> It certainly looks better, see the patch below the scissors for
> reference, and I thought it works because until last night I only run
> the corresponding test script (t5611-clone-config), though I know very
> well that "Thou shalt always run the full test suite!" :)
> 
> Unfortunately, putting the default refspec into this temporary
> configuration environment breaks a few submodule tests
> (t5614-clone-submodules or t5614-clone-submodules-shallow (it's got
> renamed between this topic and master), t7407-submodule-foreach,
> t7410-submodule-checkout-to), because it "leaks" to the submodule
> environment.

Doh, of course. I didn't think of that. That's probably a bad direction,
then, as there's no "just for this process" global config.

-Peff
