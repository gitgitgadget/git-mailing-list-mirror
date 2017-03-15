Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0CA202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 16:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbdCOQNu (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 12:13:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:44631 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbdCOQNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 12:13:12 -0400
Received: (qmail 14003 invoked by uid 109); 15 Mar 2017 16:13:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 16:13:11 +0000
Received: (qmail 14313 invoked by uid 111); 15 Mar 2017 16:13:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 12:13:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 12:13:08 -0400
Date:   Wed, 15 Mar 2017 12:13:08 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Florian Adamus <florian-adamus@gmx.de>, git@vger.kernel.org
Subject: Re: Commiting files larger than 4 GB on Windows
Message-ID: <20170315161308.sbyoxzst7ffcu6qs@sigill.intra.peff.net>
References: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66>
 <179b5d92-ee96-c2df-dbd8-eb96f7bbdb24@virtuell-zuhause.de>
 <20170315155952.x2tpiudi6rbqidvi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315155952.x2tpiudi6rbqidvi@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 11:59:52AM -0400, Jeff King wrote:

> I agree that detecting the situation in the meantime is a good idea.
> The patch above probably handles the bulk-checkin code path, I'd guess.
> It might be nice to have similar checks in other places, too:
> 
>   - when reading from an existing packfile
> 
>     Looks like we may already have such a check in
>     unpack_object_header_buffer().
> 
>   - when taking in new objects via index-pack or unpack-objects (to
>     catch a fetch of a too-big object)
> 
>     I think index-pack.c:unpack_raw_entry() would want a similar check
>     to what is in unpack_object_header_buffer().

Here are the results of a few quick experiments using two versions of
git, one built for 32-bit and one for 64-bit:

  $ git init
  $ dd if=/dev/zero of=foo.zero bs=1M count=4097
  $ git32 add foo.zero
  fatal: Cannot handle files this big

That comes from the xsize_t() wrapper. I guess it wouldn't trigger on
Windows, though, because it is measuring size_t, not "unsigned long" (on
my 32-bit build they are the same, of course).

  $ git64 add foo.zero
  $ git32 cat-file blob :foo.zero
  error: bad object header
  fatal: packed object df6f032f301d1ce40477eefa505f2fac1de5e243 (stored in .git/objects/pack/pack-57d422f19904e9651bec43d10b7a9cd882de48ac.pack) is corrupt

So we notice, which is good. This is the message from
unpack_object_header_buffer(). It might be worth improving the error
message to mention the integer overflow.

And here's what index-pack looks like:

  $ git32 index-pack --stdin <.git/objects/pack/*.pack
  fatal: pack has bad object at offset 12: inflate returned -5

It's good that we notice, but the error message isn't great. What
happens is that we overflow the size integer, allocate a too-small
buffer, and then zlib complains when we run out of buffer but there's
still content to inflate. We probably ought to notice the integer
overflow in the first place and complain there.

-Peff
