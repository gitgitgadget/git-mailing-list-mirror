Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD00C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 21:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIGVKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGVKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 17:10:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD5844E0
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 14:10:52 -0700 (PDT)
Received: (qmail 23493 invoked by uid 109); 7 Sep 2022 21:10:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Sep 2022 21:10:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14802 invoked by uid 111); 7 Sep 2022 21:10:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Sep 2022 17:10:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Sep 2022 17:10:51 -0400
From:   Jeff King <peff@peff.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
Message-ID: <YxkI2zqCheqTv/wc@coredump.intra.peff.net>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
 <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev>
 <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
 <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net>
 <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 02:53:37PM -0400, Lana Deere wrote:

> OK, I tried the bisect again.  I used the bin-wrappers/git from my git
> source each time I did a pull and each time I did a bisect.  This time
> the final result was indeed different:
> 
> $ ~/tmp/git/git/bin-wrappers/git bisect bad
> eb049759fb6b739310af52ee0e13ce6cd0c86be7 is the first bad commit
> commit eb049759fb6b739310af52ee0e13ce6cd0c86be7
> Author: Jeff King <peff@peff.net>

Drat, I shouldn't have helped you figure out I was the culprit. ;)

>     protocol: re-enable v2 protocol by default

OK, so this is definitely a plausible bisection result. Things shouldn't
behave any different between the two protocols, but there could be a
bug.

The first thing I'd try is whether:

  .../git/2.37.2/bin/git -c protocol.version=0 pull

works like 2.18.0 does. If so, then that confirms that protocol v2 is
the problem. At that point I might try capturing packet dumps with:

  GIT_TRACE_PACKET=/tmp/v0.trace \
  .../git/2.37.2/bin/git -c protocol.version=0 pull

  GIT_TRACE_PACKET=/tmp/v2.trace \
  .../git/2.37.2/bin/git -c protocol.version=2 pull

They'll be sufficiently different that you can't just diff them, but if
you're able to share them, one of us familiar with the protocol might be
able to notice something.

I don't _think_ there should be a problem with the server side of your
connection speaking the v2 protocol. After all, you found that the
ls-remote output was the same for both versions.

-Peff
