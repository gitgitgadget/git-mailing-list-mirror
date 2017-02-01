Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B628D1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 21:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdBAV2c (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 16:28:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:47954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbdBAV2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 16:28:31 -0500
Received: (qmail 16689 invoked by uid 109); 1 Feb 2017 21:28:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 21:28:31 +0000
Received: (qmail 13466 invoked by uid 111); 1 Feb 2017 21:28:32 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 16:28:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2017 22:28:26 +0100
Date:   Wed, 1 Feb 2017 22:28:26 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik van Zijst <erik.van.zijst@gmail.com>, git@vger.kernel.org,
        ssaasen@atlassian.com, mheemskerk@atlassian.com
Subject: Re: [ANNOUNCE] Git Merge Contributor Summit topic planning
Message-ID: <20170201212825.advj7f3ucnfbspbj@sigill.intra.peff.net>
References: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net>
 <1485941532-47993-1-git-send-email-erik.van.zijst@gmail.com>
 <20170201145300.4pn3faodhdb72jly@sigill.intra.peff.net>
 <xmqqh94dpyzs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh94dpyzs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2017 at 10:06:15AM -0800, Junio C Hamano wrote:

> > If you _can_ do that latter part, and you take "I only care about
> > resumability" to the simplest extreme, you'd probably end up with a
> > protocol more like:
> >
> >   Client: I need a packfile with this want/have
> >   Server: OK, here it is; its opaque id is XYZ.
> >   ... connection interrupted ...
> >   Client: It's me again. I have up to byte N of pack XYZ
> >   Server: OK, resuming
> >           [or: I don't have XYZ anymore; start from scratch]
> >
> > Then generating XYZ and generating that bundle are basically the same
> > task.
> 
> The above allows a simple and naive implementation of generating a
> packstream and "tee"ing it to a spool file to be kept while sending
> to the first client that asks XYZ.
> 
> The story I heard from folks who run git servers at work for Android
> and other projects, however, is that they rarely see two requests
> with want/have that result in an identical XYZ, unless "have" is an
> empty set (aka "clone").  In a busy repository, between two clone
> requests relatively close together, somebody would be pushing, so
> you'd need many XYZs in your spool even if you want to support only
> the "clone" case.

Yeah, I agree a tag "XYZ" does not cover all cases, especially for
fetches.

We do caching at GitHub based on the sha1(want+have+options) tag, and it
does catch quite a lot of parallelism, but not all. It catches most
clones, and many fetches that are done by "thundering herds" of similar
clients.

One thing you could do with such a pure "resume XYZ" tag is to represent
the generated pack _without_ replicating the actual object bytes, but
take shortcuts by basing particular bits on the on-disk packfile. Just
enough to serve a deterministic packfile for the same want/have bits.

For instance, if the server knew that XYZ meant

  - send bytes m through n of packfile p, then...
  
  - send the object at position i of packfile p, as a delta against the
    object at position j of packfile q

  - ...and so on

Then you could store very small "instruction sheets" for each XYZ that
rely on the data in the packfiles. If those packfiles go away (e.g., due
to a repack) that invalidates all of your current XYZ tags. That's OK as
long as this is an optimization, not a correctness requirement.

I haven't actually built anything like this, though, so I don't have a
complete language for the instruction sheets, nor numbers on how big
they would be for average cases.

> So in the real life, I think that the exchange needs to be more
> like this:
> 
>     C: I need a packfile with this want/have
>     ... C/S negotiate what "have"s are common ...
>     S: Sorry, but our negitiation indicates that you are way too
>        behind.  I'll send you a packfile that brings you up to a
>        slightly older set of "want", so pretend that you asked for
>        these slightly older "want"s instead.  The opaque id of that
>        packfile is XYZ.  After getting XYZ, come back to me with
>        your original set of "want"s.  You would give me more recent
>        "have" in that request.  
>     ... connection interrupted ...
>     C: It's me again.  I have up to byte N of pack XYZ
>     S: OK, resuming (or: I do not have it anymore, start from scratch)
>     ... after 0 or more iterations C fully receives and digests XYZ ...
> 
> and then the above will iterate until the server does not have to
> say "Sorry but you are way too behind" and returns a packfile
> without having to tweak the "want".

Yes, I think that is a reasonable variant. The client knows about
seeding, but the XYZ conversation continues to happen inside the git
protocol. So it loses flexibility versus a true CDN redirection, but it
would "just work" when the server/client both understand the feature,
without the server admin having to set up a separate bundle-over-http
infrastructure.

-Peff
