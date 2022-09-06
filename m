Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6DECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 22:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIFW6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 18:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiIFW6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 18:58:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7F4D267
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 15:58:21 -0700 (PDT)
Received: (qmail 19784 invoked by uid 109); 6 Sep 2022 22:58:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 22:58:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6612 invoked by uid 111); 6 Sep 2022 22:58:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 18:58:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 18:58:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: [PATCH 0/3] speeding up on-demand fetch for blobs in partial clone
Message-ID: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
 <b0101e7e0e61496a92c2299454c2696a@xiaomi.com>
 <YxDbfXyWzgokb1Bq@coredump.intra.peff.net>
 <d5305274b7c24adbaf6ad9ab92ac3b6a@xiaomi.com>
 <YxeTsWrjpKo+JGfq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxeTsWrjpKo+JGfq@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2022 at 02:38:41PM -0400, Jeff King wrote:

> On Mon, Sep 05, 2022 at 11:17:21AM +0000, 程洋 wrote:
> 
> > Sorry, I told you the wrong branch. It should be "android-t-preview-1"
> > git clone --filter=blob:none --no-local -b android-t-preview-1 grade-plugin
> > 
> > Can you try this one?
> 
> Yes, I see more slow-down there. There are many more blobs there, but I
> don't think it's really the number of them, but their sizes.
> 
> The problem is that both upload-pack and pack-objects are keen to call
> parse_object() on their inputs. For commits, etc, that is usually
> sensible; we have to parse the object to see what it points to. But for
> blobs, the only thing we do is inflate a ton of bytes in order to check
> the sha1. That's not really productive here; if there is a bit
> corruption, the client will notice it on the receiving side.

So here's a cleaned-up series which makes this a lot faster.

The special sauce is in patch 2, along with timings. The first one is
just preparing, and the final one is a small cleanup it enables.

I based these directly on the current tip of master. There will be a
small conflict in the test script when merging with the "rev-list
--verify-objects" series I just sent in:

  https://lore.kernel.org/git/Yxe0k++LA%2FUfFLF%2F@coredump.intra.peff.net/

The resolution is to just keep the tests added by both sides.

  [1/3]: parse_object(): allow skipping hash check
  [2/3]: upload-pack: skip parse-object re-hashing of "want" objects
  [3/3]: parse_object(): check commit-graph when skip_hash set

 object.c        | 21 ++++++++++++++++++---
 object.h        |  6 ++++++
 revision.c      | 14 +++-----------
 t/t1450-fsck.sh | 20 ++++++++++++++++++++
 upload-pack.c   |  8 ++------
 5 files changed, 49 insertions(+), 20 deletions(-)

-Peff
