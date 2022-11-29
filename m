Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5269EC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiK2BbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiK2BbG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:31:06 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264742F4E
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:31:05 -0800 (PST)
Received: (qmail 11431 invoked by uid 109); 29 Nov 2022 01:31:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Nov 2022 01:31:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13532 invoked by uid 111); 29 Nov 2022 01:31:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Nov 2022 20:31:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Nov 2022 20:31:04 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [Design RFC] Being more defensive about fetching commits in
 partial clone
Message-ID: <Y4Vg2FkoX/Z8G2Cd@coredump.intra.peff.net>
References: <Y37DF7THHv3wEbUc@coredump.intra.peff.net>
 <20221128185320.2735382-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128185320.2735382-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 10:53:19AM -0800, Jonathan Tan wrote:

> > In general, I think partial clones tend to know which filters were used
> > to create them, because we save that filter in the config. Would it be
> > reasonable before lazy-fetching to say "I am looking for an object of
> > type X; would my configured filters have skipped such an object?".
> > 
> > Then not only would you get the behavior you want for commits (which are
> > never skipped), but a blob:none clone would not try to lazy-fetch trees
> > (but a tree:depth one would lazy-fetch both trees and blobs).
> > 
> > The gotcha I'd worry about is that the config doesn't necessarily match
> > how the repository was originally created. There is nothing right now
> > saying you cannot partial-clone with one filter, then change the config
> > going forward.
> 
> Thanks for weighing in. In the general case, we indeed do know what kind of
> object we're fetching, so it does make sense to generalize my idea to trees and
> blobs as well. On the other hand, though, besides the issue that the user may
> subsequently change the config, the benefits of distinguishing between a blob
> and tree are not that great, I think - we would fail fast when, say, a tree
> is missing due to object store corruption when trying to check out something
> in a blob:none clone, but the same object store corruption probably would
> mean that commits are missing too, so even if we just did this for commits, we
> would already fail equally as fast. Because of this (and the user being able
> to change the config), it makes sense to me to handle only the commit case, at
> least for now.
> 
> Having said that, this is not forwards incompatible with restricting lazy fetch
> for trees and blobs, so if we see fit later to do that, we can still do it.

Yeah, I think your reasoning is sound. Certainly it seems reasonable to
start with commit objects, since we know they can never be filtered, and
see how that fares in practice. And then think about handling other
object types later (or never; this is really just a "we might catch
corruption sooner" nice-to-have, and not a correctness problem in normal
use).

-Peff
