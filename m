Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC39DECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiIAQTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiIAQTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:19:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DFE91D3A
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:19:10 -0700 (PDT)
Received: (qmail 24840 invoked by uid 109); 1 Sep 2022 16:19:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Sep 2022 16:19:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11347 invoked by uid 111); 1 Sep 2022 16:19:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Sep 2022 12:19:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Sep 2022 12:19:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [External Mail]Re: Partial-clone cause big performance impact on
 server
Message-ID: <YxDbfXyWzgokb1Bq@coredump.intra.peff.net>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
 <b0101e7e0e61496a92c2299454c2696a@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0101e7e0e61496a92c2299454c2696a@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01, 2022 at 06:53:01AM +0000, 程洋 wrote:

> At first I also think it's some implementation bugs by jgit. However I
> can also reproduce it on cgit. Here is the steps, I'm not sure if you
> can reproduce too.
> 
> 1. Clone a repository from AOSP to local machine:  `git clone
>    "https://android.googlesource.com/platform/prebuilts/gradle-plugin"`
> 2. try to clone from localhost using cgit server.
>    `GIT_TRACE_PACKET=1 git clone --filter=blob:none -b master
>    user@localhost:/home/user/repositories/gradle-plugin `
> 3. During checkout phase, it also takes 15 seconds before actual downloading.

I don't see that at all. A few things on your reproduction:

  - you have to tell the local server repo that filters are OK:

      git -C gradle-plugin config uploadpack.allowfilter true

  - your example goes over localhost ssh. Is your server configured to
    allow passing the GIT_PROTOCOL environment variable? If not, you're
    using the v0 protocol. In which case you'll have to set a config
    option to allow clients to fetch objects that the server didn't
    advertise.

    If you do it with allowReachableSHA1InWant, like this:

      git -C gradle-plugin config uploadpack.allowReachableSHA1InWant true

    then there will be a short delay while it checks their
    reachability. That check happens via an external rev-list. I think
    it's not clever enough to use bitmaps, though it could. However, in
    this example, the delay only seems to be around 800ms for me (and of
    course we didn't generate bitmaps anyway, so that wouldn't matter).

    If you instead do:

      git -C gradle-plugin config uploadpack.allowAnySHA1InWant true

    then that reachability check goes away.

    But on modern servers, most of this should be moot anyway. A
    well-configured server should support protocol v2, which defaults to
    allowAnySHA1InWant.

    If you use --no-local to disable local-clone optimizations, then you
    can use --filter without having to go through ssh. That should use
    protocol version 2, as a "real" server would.

So all told, I think a more realistic reproduction is:

  $ git clone https://android.googlesource.com/platform/prebuilts/gradle-plugin
  $ git -C gradle-plugin config uploadpack.allowfilter true
  $ git clone --filter=blob:none --no-local -b master grade-plugin foo

which takes ~3s for me.

I do think upload-pack spends more time than it needs in this case, as
it's keen to call parse_object() on oids that the client asks for. Which
means we'll open up those blobs and check their sha1s before sending
them out, which isn't strictly necessary.

All of this seems orthogonal to the original claim that "Counting
objects" was taking a while, though. The delays here are all inside
upload-pack, before it spawns pack-objects. And it's pack-objects that
says "Counting objects".

-Peff
