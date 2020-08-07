Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9CC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 04:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7D221744
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 04:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgHGEej (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:34:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgHGEej (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 00:34:39 -0400
Received: (qmail 28449 invoked by uid 109); 7 Aug 2020 04:34:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 04:34:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10517 invoked by uid 111); 7 Aug 2020 04:34:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 00:34:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 00:34:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
Message-ID: <20200807043436.GA21829@coredump.intra.peff.net>
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
 <20200807000126.GC8085@camp.crustytoothpaste.net>
 <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
 <20200807032723.GA15119@coredump.intra.peff.net>
 <xmqqh7tfhzb1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7tfhzb1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 06, 2020 at 09:09:38PM -0700, Junio C Hamano wrote:

> > But there may be
> > systems where we choose not to (either the system version is deficient,
> > or we're testing the fallback code on a more-capable system, or our
> > #ifndef check isn't sufficient on that system for some reason).
> 
> Hmph, perhaps.  We'll cross that bridge when we need to port to such
> a system, and until then, doing this will more easily catch the need
> to cross that bridge, I would imagine.

I agree my concern is theoretical. It might not bite us. If you're
willing to deal with it when it does (and inevitably as maintainer you
will ;) ), then I'm OK with trying it out.

> >   - this is really the tip of the portability iceberg anyway. In the
> >     example that motivated this thread, you were catching failures to
> >     adjust to strvec. But in code like this:
> >
> >       #ifdef FOO
> >       void some_func(int x, const char *y)
> >       {
> >               struct argv_array whatever = ARGV_ARRAY_INIT;
> > 	      ...
> >       }
> >       #else
> >       void some_func(int x, const char *y)
> >       {
> >               /* do nothing */
> >       }
> >       #endif
> 
> Yes, of course, but as I wrote in my response to Brian, the whole
> point of using these replacement implementation macros is so that we
> do not have to sprinkle the main code with such #ifdef/#endif, so
> I think the code like that is what needs to be corrected ;-)

I'm not sure if I made my point clearly. At some point you have to
define the functions, and they'll have code in them which gets compiled
on some systems but not on others. E.g., precompose_argv() uses
reencode_string_iconv(). What if we change the signature of that
function? You will not ever catch it by compiling on your Linux box, and
would only see it in macOS CI, etc.

-Peff
