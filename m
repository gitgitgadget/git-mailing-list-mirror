Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF92FC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 00:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBBAL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 19:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 19:11:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A13A69B3D
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 16:11:25 -0800 (PST)
Received: (qmail 7128 invoked by uid 109); 2 Feb 2023 00:11:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Feb 2023 00:11:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26018 invoked by uid 111); 2 Feb 2023 00:11:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 19:11:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 19:11:24 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: pack-objects memory use observations [was: [PATCH]
 delta-islands: free island-related data after use]
Message-ID: <Y9r/rLhB1L9EnTKR@coredump.intra.peff.net>
References: <20221116105013.1777440-1-e@80x24.org>
 <Y3UvhsRC9uCXJJ8P@coredump.intra.peff.net>
 <20230201092027.M96461@dcvr>
 <20230201220929.M549554@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201220929.M549554@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 10:09:29PM +0000, Eric Wong wrote:

> Eric Wong <e@80x24.org> wrote:
> > [1] WIP oidtree map, but I feel like I forgot C, again :<
> 
> Well, it hasn't crashed.  It's just much slower compared to khash.

I experimented a bit with critbit trees several years ago, mostly for
the main obj_hash. I could never make them faster than hashing. I think
part of it is that "hashing" an oid is basically free, since we just
pull off the first 4 bytes. And we keep our table factors quite low.
Whereas for trie structures, even though the big-O behavior is good,
there's a lot of branching that ends up being slow.

> I'm thinking `struct object_id' should be pooled+deduplicated
> like hash keys in the Perl/Ruby interpreters and we'd pass
> 4/8-byte pointers instead of 36-byte structs.

I think that could work, but it feels like it would be pretty major
surgery, given how often object_ids appear in the code.

-Peff
