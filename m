Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4D71F4B6
	for <e@80x24.org>; Tue, 14 May 2019 12:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfENM1c (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:27:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:56884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726221AbfENM1c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:27:32 -0400
Received: (qmail 4405 invoked by uid 109); 14 May 2019 12:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 12:27:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12553 invoked by uid 111); 14 May 2019 12:28:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 08:28:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 08:27:30 -0400
Date:   Tue, 14 May 2019 08:27:30 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: dumb HTTP things I want to do
Message-ID: <20190514122730.GB27276@sigill.intra.peff.net>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <20190514121350.jugxtegpvcxr4vjs@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514121350.jugxtegpvcxr4vjs@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 12:13:50PM +0000, Eric Wong wrote:

> I'm not sure when/if I'll have time for this; but this ought to
> be possible:
> 
> 	GIT_DIR=$HTTP_URL git <any read-only command>
> 
> And possible without existing admins to setup or change
> anything on their server.
> [...]
> git doesn't need mmap; and curl + Range requests ought to be
> able to get us what we need to emulate pread.  It'd be great for
> low-latency LANs, maybe not so great with high latency; but
> probably better in many cases than cloning a giant repo to cat
> one blob.

My first thought here is that we could probably just use the filesystem
boundary as the appropriate layer, and have an httpfs fuse driver. Your
mention of fusedav makes me think you've already gone this route.

I guess non-dav http doesn't necessarily let us enumerate directories.
But it might be enough if we could insert ourselves in a few key spots.
E.g., when we try to opendir("objects/packs") and it fails with ENOSYS
or similar, then we fallback to opening "objects/info/packs" to get the
same information (and ditto for loose ref traversal).

There'd still be _some_ work in Git, but it wouldn't require replacing
every single read with HTTP magic.

> Also, cloning on a static bundle ought to be doable with:
> 
> 	git clone $REMOTE_OR_LOCAL_PATH/foo.bundle

Some nearby discussion:

  https://public-inbox.org/git/20190514092900.GA11679@sigill.intra.peff.net/

> And yeah, it also sucks that bundles double storage overhead
> for admins; it would be nice if I could use bundles as alternates
> or packs...

Yes. It's nice that they're a single file for some uses, but in terms of
implementation it would be easier if the bundle files just said "here
are some refs, and you can find my packfile in the relative filename
XYZ.pack". And then you'd just store the two of them together (and a
matching .idx if you wanted to use it as a real pack, but the bundle
readers wouldn't care).

It probably wouldn't be that hard to wedge that into the bundle format
by bumping the version field.

-Peff
