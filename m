Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C995DC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D1A610A1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhIVUNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:13:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:52896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237507AbhIVUNH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:13:07 -0400
Received: (qmail 10999 invoked by uid 109); 22 Sep 2021 20:11:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 20:11:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17869 invoked by uid 111); 22 Sep 2021 20:11:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 16:11:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 16:11:36 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUuN+KguN0WetC49@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <afd7bd6b-52bf-7fd8-d13e-6dcd660c4100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afd7bd6b-52bf-7fd8-d13e-6dcd660c4100@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 09:32:41AM +0700, Bagas Sanjaya wrote:

> > but this has a few issues:
> > 
> >    - it's not necessarily portable. The http2 apache module might not be
> >      available on all systems. Further, the http2 module isn't compatible
> >      with the prefork mpm, so we have to switch to something else. But we
> >      don't necessarily know what's available. It would be nice if we
> >      could have conditional config, but IfModule only tells us if a
> >      module is already loaded, not whether it is available at all.
> > 
> >      This might be a non-issue. The http tests are already optional, and
> >      modern-enough systems may just have both of these. But...
> > 
> >    - if we do this, then we'd no longer be testing HTTP/1.1 at all. I'm
> >      not sure how much that matters since it's all handled by curl under
> >      the hood, but I'd worry that some detail leaks through. We'd
> >      probably want two scripts running similar tests, one with HTTP/2 and
> >      one with HTTP/1.1.
> 
> Maybe for httpd config we can say that if mpm_prefork isn't loaded, load
> mpm_event and mod_http2.

That doesn't work. We can say "is mpm_prefork" loaded, and indeed we
already do, in order to load mpm_prefork! That's because the module may
or may not be built-in, and if not, we have to load it (or some mpm
module). See 296f0b3ea9 (t/lib-httpd/apache.conf: configure an MPM
module for apache 2.4, 2013-06-09).

But we have no way of knowing _which_ modules are available. It may just
be that "event" or "worker" (both of which support mod_http2) are
available close enough to everywhere that we can just guess.

> And for testing both HTTP/2 and HTTP/1.1 did you mean sharing the same test
> code (with adjustments for each protocol)?

Yes. I'd literally run the same battery of tests against both protocols
(see my other response to Taylor with a sketched-out example). I'm still
not sure it's entirely worth the effort, though. The underlying
transport should be pretty transparent to Git, with the exception of
things like debugging output.

-Peff
