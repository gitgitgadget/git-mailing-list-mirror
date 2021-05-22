Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0742FC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 12:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69ED610A2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 12:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhEVMM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 08:12:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:34396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhEVMM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 08:12:56 -0400
Received: (qmail 10217 invoked by uid 109); 22 May 2021 12:11:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 May 2021 12:11:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18990 invoked by uid 111); 22 May 2021 12:11:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 May 2021 08:11:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 May 2021 08:11:31 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git repack on shallow clone of large repo (linux kernel) hangs
 at "Enumerating objects"
Message-ID: <YKj085Nn/uQYomZG@coredump.intra.peff.net>
References: <c98e51b0-d89b-9170-e3bc-69ac9ec5e114@gmail.com>
 <YKIulliGp8hyf5Y6@coredump.intra.peff.net>
 <158a2f8c-95c0-075a-4cda-6328324c2261@gmail.com>
 <YKOuHLWmJ3jktpyA@coredump.intra.peff.net>
 <168567f7-cec1-a4f1-5b2e-b51637ab7668@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <168567f7-cec1-a4f1-5b2e-b51637ab7668@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 22, 2021 at 06:16:15PM +0700, Bagas Sanjaya wrote:

> Here is excerpt from strace -f just before I triggered SIGINT due to hang:
> 
> > 22903 openat(AT_FDCWD, ".git/objects/3b/tmp_obj_24pz93", O_RDWR|O_CREAT|O_EXCL, 0444) = 3
> > 22903 write(3, "x\1+)JMU0421d040031Q\320K\316I\314K\327M\313/\312M,"..., 1113) = 1113
> > 22903 close(3)                          = 0
> > 22903 utime(".git/objects/3b/tmp_obj_24pz93", {actime=1621599665 /* 2021-05-21T19:21:05+0700 */, modtime=1621599665 /* 2021-05-21T19:21:05+0700 */}) = 0
> > 22903 link(".git/objects/3b/tmp_obj_24pz93", ".git/objects/3b/816f00a02062692e95a9a756247fca34abb911") = 0
> > 22903 unlink(".git/objects/3b/tmp_obj_24pz93") = 0

OK, so this is writing out loose objects. It's exactly the case I
suspected.

> The last write() sequence seems running repeatedly, what it means? Infinite loop?

If it's a lot of just write(), it's probably just a large object. If
it's a lot of writes interspersed with opens and links, as above, then
it's just a lot of objects. It probably would finish eventually, but
it's just slow.

-Peff
