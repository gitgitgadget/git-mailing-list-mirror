Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831FEC6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 10:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIVKJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 06:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiIVKJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 06:09:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F9FD74D8
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 03:09:02 -0700 (PDT)
Received: (qmail 5645 invoked by uid 109); 22 Sep 2022 10:09:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 10:09:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 943 invoked by uid 111); 22 Sep 2022 10:09:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 06:09:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 06:09:01 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai <johncai86@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] reducing fsck memory usage
Message-ID: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
References: <9304B938-4A59-456B-B091-DBBCAA1823B2@gmail.com>
 <YyoljwDIn7PxRlC9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyoljwDIn7PxRlC9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 04:41:51PM -0400, Jeff King wrote:

> And this is data we've allocated for trees. It kind of looks like
> fsck_walk_tree() never bothers to clean up the trees it parses, leaving
> the buffers attached to the tree structs. But that can't be the case,
> because linux.git has something like 16GB of trees. These may be entries
> we keep in the internal delta cache, though it should be a bit smaller
> than what you have here (the default is 96MB; you can drop it with
> core.deltaBaseCacheLimit, but runtime may suffer).
> 
> There's a call to free_tree_buffer() in builtin/fsck.c:traverse_one();
> that may be what ends up freeing things. It's been a while since I've
> traced through the call paths for fsck.

I dug into this a bit more. We do indeed free the trees correctly in
most of the code paths, but there's one where we don't, and you can
convince it to hold all of the trees in memory at once (though in
practice few people are likely to hit this case).

So here's a fix for that, plus a cleaned up version of the patch I sent
earlier which should drop your memory usage, plus a bonus small memory
reduction and cleanup in the third patch.

  [1/3]: fsck: free tree buffers after walking unreachable objects
  [2/3]: fsck: turn off save_commit_buffer
  [3/3]: parse_object_buffer(): respect save_commit_buffer

 builtin/fsck.c | 6 +++---
 object.c       | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

-Peff
