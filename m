Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CBCC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32B12087E
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgH0RT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:19:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:42816 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0RT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:19:56 -0400
Received: (qmail 18230 invoked by uid 109); 27 Aug 2020 17:19:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2020 17:19:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29518 invoked by uid 111); 27 Aug 2020 17:19:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2020 13:19:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Aug 2020 13:19:54 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Cleaning up files reported by size-garbage
Message-ID: <20200827171954.GA3970312@coredump.intra.peff.net>
References: <20200827155529.3vtmrec7nn3mqgpl@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827155529.3vtmrec7nn3mqgpl@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 11:55:29AM -0400, Konstantin Ryabitsev wrote:

> Running git count-objects -v reports garbage files:
> 
> $ git count-objects -v
> warning: garbage found: ./objects/pack/tmp_pack_XSv8MO
> warning: garbage found: ./objects/pack/tmp_pack_2uOuMg
> warning: garbage found: ./objects/pack/tmp_pack_KzP1ja
> count: 19
> size: 84
> in-pack: 172456
> packs: 6
> size-pack: 63907
> prune-packable: 0
> garbage: 3
> size-garbage: 1911
> 
> Is there a way to tell git to clean those up? I'm not finding anything 
> and would rather avoid having to parse stderr in these cases.

I think that git-gc will clean them up (via git-prune). It will also
check that their mtimes are older than the expiration time, which avoids
accidentally cleaning up the pack for an incoming fetch or push.

The default gc expiration time is 2 weeks, though, so you might want
something like:

  git gc --prune=5.minutes.ago

if you're trying to get rid of them immediately. Likewise use git-prune
directly if you don't want to incur the cost of a full gc/repack.

-Peff
