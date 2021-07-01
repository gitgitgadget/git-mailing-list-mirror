Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC71C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90847613EC
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhGAVvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:51:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:39322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGAVvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 17:51:07 -0400
Received: (qmail 29067 invoked by uid 109); 1 Jul 2021 21:48:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 21:48:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19514 invoked by uid 111); 1 Jul 2021 21:48:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 17:48:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 17:48:36 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Structured (ie: json) output for query commands?
Message-ID: <YN44NB3I/nDiTVg8@coredump.intra.peff.net>
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
 <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
 <YNzR5ZZDTfcN2Q+s@camp.crustytoothpaste.net>
 <YN3mk0LnyJyuQ+9T@coredump.intra.peff.net>
 <YN4xCRDi3JwMc+S0@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN4xCRDi3JwMc+S0@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 01, 2021 at 09:18:01PM +0000, brian m. carlson wrote:

> > I don't love the invalid-utf8-in-json thing in general. But I think it
> > may be the least-bad solution. I seem to recall that YAML has its own
> > complexities, and losing human-readability (even to base64) is a pretty
> > big downside. And the tooling for working with json seems more common
> > and mature (certainly over something like CBOR, but I think even YAML
> > doesn't have anything nearly as nice as jq).
> 
> I'm not opposed to JSON as long as we don't write landmines.  We could
> URI-encode anything that contains a bag-of-bytes, which lets people have
> the niceties of JSON without the breakage when people don't write valid
> UTF-8.  Most things will still be human-readable.
> 
> We could even have --json be an alias for --json=encoded (URI-encoding)
> and also have --json=strict for the situation where you assert
> everything is valid UTF-8 and explicitly said you wanted us to die() if
> we saw non-UTF-8.  I don't want us to say that something is JSON and
> then emit junk, since that's a bad user experience.
> 
> Ideally, we'd have some generic serializer support for this case, so if
> people _do_ want to add YAML or CBOR output, it can be stuffed in.

Yep, I'd agree with all of that. I think we're on more-or-less the same
page.

One annoying thing about JSON is that (to my knowledge) it doesn't have
a binary data type. So you have to encode things and shove them into
"string". I guess that is not too bad if you are using backslash or
percent-encoding, as only a minority of characters get encoded. But it
sure would be nice for readers if the values, once extracted from the
json, could be used without further munging. That's most of the benefit
of using json in the first place. But it may be the best we can do.

-Peff
