Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A0C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 00:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C277C2074F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 00:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgI3Aqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 20:46:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:45000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgI3Aqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 20:46:31 -0400
Received: (qmail 20137 invoked by uid 109); 30 Sep 2020 00:46:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 00:46:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23287 invoked by uid 111); 30 Sep 2020 00:46:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2020 20:46:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Sep 2020 20:46:30 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Wu, Zhichen" <zhwu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question About Git V2 Protocol & SHA256
Message-ID: <20200930004630.GA623061@coredump.intra.peff.net>
References: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
 <20200929221311.GA15129@coredump.intra.peff.net>
 <20200929224356.GH1392312@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200929224356.GH1392312@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 29, 2020 at 10:43:56PM +0000, brian m. carlson wrote:

> On 2020-09-29 at 22:13:11, Jeff King wrote:
> > On Tue, Sep 29, 2020 at 01:17:59AM +0000, Wu, Zhichen wrote:
> > > 2. I see v2 has a capability called “object-format” that provides SHA1
> > >    option. I’m wondering if that capability will be the only way for
> > >    client and server to start using SHA256? Or put it as another word,
> > >    will v2 protocol be the prerequisite of SHA256?
> > 
> > I think it would be impossible to handle object-format via v1, because
> > the v1 protocol writes the ref advertisement before any capabilities are
> > negotiated. So I think v1 must implicitly remain sha1-only (and a sha256
> > repository on the server side would need to either reject a v1 client,
> > or back-translate as it would for a v2 client which asks for sha1).
> 
> I don't think that's the case.  You can indeed use v1 with SHA-256, but
> if you have a SHA-1-only Git, it will choke because the object ID is
> longer than it expects.  If you want to negotiate the algorithm when we
> support both and the client can't deal with translating the initial ref
> advertisement, then yes, you'll need v2.

I agree that we _could_ just dump sha256 within a v1 protocol and wait
for the client to choke. But that seems like an awfully lousy user
experience. By contrast, assuming that the client wants sha1 means that
either:

  - we can reject it with a sensible ERR message that tells the user
    what is going on

  - we can serve them by talking in terms of sha1 if we're willing to
    do the extra conversion work server-side (and/or have a cache of
    sha1-format objects)

The only thing we lose is that a recent client who understands sha256
wouldn't be able to contact us and do a sha256-over-v1 transaction. But
why would they want to do so?

This is all hypothetical at this point, though, right? I tried finding
details in the hash transition document, but protocol changes are listed
as out of scope there. It does say that sha256 servers may just reject
sha1 clients; but even so I'd prefer if we could do it with a nice
message (i.e., my bullet one above).

My suggestion does also require that we have a v2 receive-pack protocol,
which does not yet exist (but following the blueprint for fetch, I don't
expect it to be a big deal).

-Peff
