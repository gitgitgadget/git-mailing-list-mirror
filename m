Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57FBC25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 06:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbiHNGsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 02:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHNGsH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 02:48:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216D1834B
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 23:48:02 -0700 (PDT)
Received: (qmail 18569 invoked by uid 109); 14 Aug 2022 06:48:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Aug 2022 06:48:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31566 invoked by uid 111); 14 Aug 2022 06:48:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Aug 2022 02:48:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 14 Aug 2022 02:48:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: Partial-clone cause big performance impact on server
Message-ID: <YviaoXRctE9fg/mB@coredump.intra.peff.net>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2022 at 08:09:56AM +0000, 程洋 wrote:

>     4. And we then track our server(which is gerrit with jgit). We
>        found the server is couting objects. Then we check those 40k
>        objects, most of them are blobs rather than commit. (which
>        means they're not in bitmap)
>     5. We believe that's the root cause of our problem. Git sends too
>        many "want SHA1" which are not in bitmap, cause the server to
>        count objects  frequently, which then slow down the server.

I'd be surprised if bitmaps make a big difference either way here, since
blobs are very quick in the "counting" phase of pack-objects. They can't
link to anything else, so we should not be opening the object contents
at all! We just need to find them on disk, and then in many cases we can
send them over the wire without even decompressing (the exception is if
they are stored as deltas against an object the client doesn't have).

I didn't generate a test case, but I'm pretty sure that is how git.git's
pack-objects should behave. But you mentioned that the server is jgit;
it's possible that it isn't as optimized in that area.

-Peff
