Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A72C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIGSWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiIGSWA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:22:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BAFBD4F4
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:21:58 -0700 (PDT)
Received: (qmail 22890 invoked by uid 109); 7 Sep 2022 18:21:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Sep 2022 18:21:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13345 invoked by uid 111); 7 Sep 2022 18:21:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Sep 2022 14:21:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Sep 2022 14:21:55 -0400
From:   Jeff King <peff@peff.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
Message-ID: <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
 <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev>
 <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 11:56:27AM -0400, Lana Deere wrote:

> Sorry, I was confused by the "0 left".  With one more besect it says
> 
> 9f489ac6bbb755fa4c83289e44cad12f3b765d69 is the first bad commit
> 
> That appears to be
>  [9f489ac6bbb755fa4c83289e44cad12f3b765d69] Merge branch 'dl/zero-oid-in-hooks'

That seems unlikely to be the real culprit. I wonder if something went
wrong during the bisect.

A common gotcha when building Git from source is to directly run:

  /path/to/git-clone/git pull

Under the hood git-pull will run git-fetch, which it will look for in
the installed libexec dir. But of course if you didn't run "make
install", then what is there may be some old version installed
previously. Instead, you want to run:

  /path/to/git-clone/bin-wrappers/git pull

which will set up the environment so that we'll find any other git
commands inside the build directory.

That's all a wild guess, of course, but if you think that might be the
problem it's worth trying the bisect again.

-Peff
