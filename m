Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F06C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 20:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiHWUf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiHWUfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 16:35:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040E76338
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 13:16:59 -0700 (PDT)
Received: (qmail 6592 invoked by uid 109); 23 Aug 2022 20:16:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Aug 2022 20:16:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12846 invoked by uid 111); 23 Aug 2022 20:16:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Aug 2022 16:16:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Aug 2022 16:16:58 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Daniel Stenberg <daniel@haxx.se>,
        =?utf-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>,
        git@vger.kernel.org
Subject: Re: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
Message-ID: <YwU1uuaeV2s7a2+C@coredump.intra.peff.net>
References: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
 <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
 <o4sp3o6-75sp-o12o-2p29-r94s2s769r47@unkk.fr>
 <YwNGoqcx3c27XpQL@coredump.intra.peff.net>
 <YwP/EYTwHbA14AZV@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwP/EYTwHbA14AZV@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 10:11:29PM +0000, brian m. carlson wrote:

> > I'm not 100% on it either. When it comes to security restrictions,
> > sometimes simple-and-stupid is the best way. I was literally thinking of
> > something as basic and restricted as:
> > 
> >   if (from_port == 80 && to_port == 443 &&
> >       from_protocol == HTTP && to_protocol == HTTPS)
> >         /* ok, allow it */
> > 
> > just because https upgrade is such a common (and presumably harmless)
> > redirect.  But possibly even that leaves wiggle room for bad things to
> > happen. I'm happy to defer to you and other curl folks there.
> 
> I think it's actually better to fail in this case, and here's why.  If
> someone is using HTTP and getting redirected to HTTPS, there's no
> security if an attacker intercepts the HTTP connection.  Anyone who
> knows how a captive portal works will recognize this immediately, and
> it's why we have Strict Transport Security in browsers.
> 
> If we fail when a user redirects, then they'll fix their URL to use
> HTTPS, at which point their connection is prevented from tampering
> effectively forever.  If we redirect, then when they make a connection,
> they'll be vulnerable to tampering every time, possibly sending
> credentials over the wire in plaintext or being redirected to a rogue
> site.

I agree redirecting is less secure, but in this case the credentials are
cleared unless it's an http->https upgrade on the same hostname (not
shown in my example above is the implication that curl would still be
doing the hostname check).

We also follow redirects in general, so this is just about clearing
in-url credentials. We'll still prompt for credentials in the more usual
case, though we do properly say "password for $REDIRECTED_URL" when
doing so.

All that said, I agree that failing and asking the user to adjust their
URL is a fine outcome, as long as we do that. The problem now is just
that Git's output is misleading at best. The diff I showed earlier would
help with that. I think it could use a little polish, but I'll see if I
can do that in the next few days.

-Peff
