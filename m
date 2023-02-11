Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D859CC05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 03:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBKDAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 22:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKDAT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 22:00:19 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C9084BAA
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 19:00:17 -0800 (PST)
Received: (qmail 22151 invoked by uid 109); 11 Feb 2023 03:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 03:00:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30815 invoked by uid 111); 11 Feb 2023 03:00:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 22:00:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 22:00:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: t5559 breaks with apache 2.4.55
Message-ID: <Y+cEwLjdgThXdkrw@coredump.intra.peff.net>
References: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
 <Y81lQwG85+Skujja@pobox.com>
 <Y9Jmfg/jlSszVep4@coredump.intra.peff.net>
 <Y9YTsF4a8lL7uHm+@coredump.intra.peff.net>
 <xmqq357ems2h.fsf@gitster.g>
 <Y+b7bTs2vdXAe/ky@coredump.intra.peff.net>
 <xmqqilg9exq4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilg9exq4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 06:34:43PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure this is really sufficient. As I was running t5559 over and
> > over to test various versions, I noticed a few other cases that seemed
> > to fail, some of them racily. So I'm a bit worried that the problem may
> > be more extensive, and it is only that this particular test happened to
> > trigger it reliably.
> 
> Yeah, I've seen not just t5559.30 (which is what the patch was
> about) reliably fail, but t5559.25 fail only from time to time.
> There may be others.

Ah, then if it's not just me, maybe it is time to take action. :)

I'm not sure if we have a complete list of good/bad versions, though. I
know 2.0.10 was bad, and 2.0.9 seemed to be OK for me. 2.0.12 passes for
me in regular use, but --stress seems to quickly barf. But it does for
v2.0.9, too.

> > In which case the right solution may be ditching t5559, or at the very
> > least adding a knob or version check to disable it.
> 
> Yup.  Do we have an example of checking versions of mod_frob being
> used from within our test suite?  I didn't locate one.

No, I don't think we do. The answers on stack overflow suggest using
"strings" on the .so file. Not only is that gross, it doesn't seem to
work in this case (I find "mod_http2 (v%s)", which is useless).

We could check the outer apache version with "apachectl -v", which is
enough for Debian, but I think Todd had cases where the system was using
a separate version of the mod, not the one that ships with apache
itself.

I didn't see anything with IfVersion or IfModule that would let us
depend on the module version. It does look like we can probably crank
the LogLevel up and then grep for "mod_http2 (v[0-9.]+" in the log after
starting the server. That would let us bail before actually running any
tests.

We can be a bit cavalier here with technique, I think, because the worst
case is that we say "this is not a known-good version" and just skip the
http/2 tests.

> > So I'm tempted to just punt for now and see how often this bites people
> > in the real world. And if it does become a problem, we'll have more data
> > on what exactly should be changed.
> 
> OK, works for me.

Well, I was all set to try a version check, but after seeing the
race problems above, it doesn't seem like a good direction, at least not
yet. So I'm content to sit on my hands for a while longer.

-Peff
