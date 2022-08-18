Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D09C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 05:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243393AbiHRFtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 01:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiHRFtv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 01:49:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C261723
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 22:49:49 -0700 (PDT)
Received: (qmail 11947 invoked by uid 109); 18 Aug 2022 05:49:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Aug 2022 05:49:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23299 invoked by uid 111); 18 Aug 2022 05:49:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Aug 2022 01:49:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Aug 2022 01:49:48 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [External Mail]Re: Partial-clone cause big performance impact on
 server
Message-ID: <Yv3S/J/ecYi0slQA@coredump.intra.peff.net>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
 <85e6fd08-c741-26d4-1393-4b115133e687@github.com>
 <11d7fc5721c541d6bc44bf635517497b@xiaomi.com>
 <fc71e91b-7a66-5653-d723-e4df17bf2a9c@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc71e91b-7a66-5653-d723-e4df17bf2a9c@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 09:41:10AM -0400, Derrick Stolee wrote:

> On 8/17/2022 6:22 AM, 程洋 wrote:
> > But I still think the protocol still should tell the server which ref
> > the blob is reachable.
> > Because it would be really hard to implement any kind of ACL
> 
> I think this idea has merit on its face, but it wouldn't really solve the
> problem since the reachability query would still need to be done, just
> from a smaller set of references at first. If we were able to say "this
> blob can be found at path X at commit Y" then the server could do a
> commit-reachability query and a path traversal, which should be a lot
> faster.
> 
> However, it would be extremely difficult to plumb into the partial clone
> machinery. At the point where Git realizes it is missing a promisor
> object, that code is very generic and removed from any kind of walk from a
> reference. That is further complicated by the fact that the walk is
> probably from a local reference, which can be entirely different from the
> remote reference.

Agreed. The client often doesn't know the context of what it's asking
for in the first place. Sometimes it's not carried through the code, but
we also have commands that might not be invoked with a commit in the
first place! It's valid to run "git read-tree <tree>", and we should be
able to fault in blobs from that tree as needed.

I also think that this kind of "is the blob reachable" query is
mostly expensive if you don't have reachability bitmaps at all. If you
do, then the cost to ask "is this object reachable" is the same for a
commit or a blob. If the server has a bitmap of all objects reachable
for each branch ACL (even if it has to do some small bit of fill-in
walking to bring it up to date), then querying for any object type the
client asks for is still just a bit lookup.

Not knowing a lot about gerrit or jgit, it's not clear to me if there
are configuration knobs that could be tweaked on the server side to make
these requests more efficient.

> One possible hurdle is the fact that this branch-level security is a
> feature of Gerrit, not a feature of Git itself. Optimizing Git to that
> special case that Git does not itself support is less valuable to the Git
> project itself.

We don't have branch-level security per se, but I do think that
everything is there in Git to do fast "is this object reachable from
these branches" queries. If you're making a lot of those queries it
might influence your decision of which bitmaps to generate, but the
bitmap concept itself should be sufficient.

-Peff
