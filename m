Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F5C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B9060241
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhJLVe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:34:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:38078 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233650AbhJLVe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 17:34:27 -0400
Received: (qmail 1735 invoked by uid 109); 12 Oct 2021 21:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 21:32:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17982 invoked by uid 111); 12 Oct 2021 21:32:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 17:32:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 17:32:24 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Alex Waite <alex@waite.eu>,
        git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWX+6OgzN4CDzomO@coredump.intra.peff.net>
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
 <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
 <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 09:21:59PM +0000, brian m. carlson wrote:

> > That may be so for hostnames in general, but URLs seem to allow it. RFC
> > 3986 says:
> > 
> >       host        = IP-literal / IPv4address / reg-name
> >       reg-name    = *( unreserved / pct-encoded / sub-delims )
> >       unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
> 
> That's what the schema says.  The text says this:
> 
>   A host identified by a registered name is a sequence of characters
>   usually intended for lookup within a locally defined host or service
>   name registry, though the URI's scheme-specific semantics may require
>   that a specific registry (or fixed name table) be used instead.  The
>   most common name registry mechanism is the Domain Name System (DNS).
>   A registered name intended for lookup in the DNS uses the syntax
>   defined in Section 3.5 of [RFC1034] and Section 2.1 of [RFC1123].
> 
> Those RFCs disallow the underscore.

Thanks, I skimmed looking for some resolution to this mismatch, but
didn't find that paragraph.

> If we plan to allow names that are not registered in the DNS, we should
> clearly specify what those are and document how they work in conjunction
> with libcurl (which presumably does a DNS lookup on them).  It's my
> guess that there are going to be system resolvers which are not going to
> accept this syntax in getaddrinfo and as a result, we're going to have
> various breakage across systems if we try to accept this.

I don't think this makes anything worse. Either the underscore works or
it doesn't for general use on your system. This just means we'll allow
http.<url>.* config for it.

And it does indeed work fine on my system, via DNS. My stub resolver is
glibc, and curl itself is fine with it. The server side answering the
query was djbdns (tinydns, with dnscache as a recursive resolver in
between). I could believe that other implementations may be more strict,
though.

> I'm happy to put in a change to reject these hostnames altogether, but I
> won't get to it before Friday.

IMHO _that_ is the thing that will produce breakage. People who are not
using URL-specific config but are happily using foo_bar.example.com will
now get a failure for something that used to work.

-Peff
