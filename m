Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6051AC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE6B61214
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbhIWV6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:58:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:54002 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235503AbhIWV6P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:58:15 -0400
Received: (qmail 16105 invoked by uid 109); 23 Sep 2021 21:56:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 21:56:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 361 invoked by uid 111); 23 Sep 2021 21:56:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 17:56:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 17:56:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUz4Gr3o/Kobj10r@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <afd7bd6b-52bf-7fd8-d13e-6dcd660c4100@gmail.com>
 <YUuN+KguN0WetC49@coredump.intra.peff.net>
 <87lf3o5bdz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf3o5bdz.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 03:22:04AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> Maybe for httpd config we can say that if mpm_prefork isn't loaded, load
> >> mpm_event and mod_http2.
> >
> > That doesn't work. We can say "is mpm_prefork" loaded, and indeed we
> > already do, in order to load mpm_prefork! That's because the module may
> > or may not be built-in, and if not, we have to load it (or some mpm
> > module). See 296f0b3ea9 (t/lib-httpd/apache.conf: configure an MPM
> > module for apache 2.4, 2013-06-09).
> >
> > But we have no way of knowing _which_ modules are available. It may just
> > be that "event" or "worker" (both of which support mod_http2) are
> > available close enough to everywhere that we can just guess.
> >
> >> And for testing both HTTP/2 and HTTP/1.1 did you mean sharing the same test
> >> code (with adjustments for each protocol)?
> >
> > Yes. I'd literally run the same battery of tests against both protocols
> > (see my other response to Taylor with a sketched-out example). I'm still
> > not sure it's entirely worth the effort, though. The underlying
> > transport should be pretty transparent to Git, with the exception of
> > things like debugging output.
> 
> Maybe I'm missing something, but it seems to me that trying to figure
> out if we support http v2 or not beforehand is the wrong thing to do in
> this case. Why don't we simply try to start the server, and fail and
> skip_all="sorry, no httpv2" if it fails?
> 
> Then have 2 test files:
> 
> t1234-http-v1.sh
> t1235-http-v2.sh

Sure. I was assuming we'd just have one server config (which _does_
work), but if we are spinning up two servers anyway for the separate
scripts, it would be easy enough to customize them. And I do think it
would make sense to do it in separate scripts.

And this dual-script thing might need to be repeated for others besides
t5551. I didn't look at which other ones might potentially benefit (or
if it's diminishing returns as we just add more basically-identical
tests that spend a bunch of CPU). This is why I say "it might not be
worth the effort".

> Where the latter includes the former (or is a symlink with a $0 check),
> or both include a library. Doing it this way also means you'll get a
> message you notice via "prove", since you won't run all v1 tests in one
> file, then skip some v2.

This does work oddly with GIT_TEST_HTTPD=Yes, which complains about
skipping (intentionally; it's how we notice when http setup code
breaks).  That might be acceptable, though, if the folks setting that
option (like me, or the linux CI jobs) are likely to have http2 support.

-Peff
