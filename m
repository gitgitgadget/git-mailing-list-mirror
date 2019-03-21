Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531FF20248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfCUTzj (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:55:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:59778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727997AbfCUTzj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:55:39 -0400
Received: (qmail 25683 invoked by uid 109); 21 Mar 2019 19:55:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 19:55:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12719 invoked by uid 111); 21 Mar 2019 19:56:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 15:56:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 15:55:37 -0400
Date:   Thu, 21 Mar 2019 15:55:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] t5551: delete auth-for-pack-but-not-refs test
Message-ID: <20190321195536.GC19427@sigill.intra.peff.net>
References: <20190321174719.151877-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321174719.151877-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 10:47:19AM -0700, Jonathan Tan wrote:

> When using protocol v0, upload-pack over HTTP permits a "half-auth"
> configuration in which, at the web server layer, the info/refs path is
> not protected by authentication but the git-upload-pack path is, so that
> a user can perform fetches that do not download any objects without
> authentication, but still needs authentication to download objects.
> 
> 2e736fd5e9 ("remote-curl: retry failed requests for auth even with
> gzip", 2012-10-31) added a test for this, stating that this leaks
> information about the repository but makes it occasionally more
> convenient for users that use manual credential entry.
> 
> Protocol v2 does not support this, because both ref and pack are
> obtained from the git-upload-pack path.

I have mixed feelings. I agree that this this is not a setup we really
want to recommend. But it did come out of somebody's real-world case[1].
It would be nice to know if it got broken, even if v2 doesn't support
it.

I am a little confused about v2 here, though. It should hit the initial
info/refs endpoint the same as usual. If it's a noop fetch, then it's
done. Otherwise, we'd hit the git-upload-pack and expect to require
authentication. That should work after your switch to using post_rpc,
shouldn't it?

And I guess it does, because you did not delete the test before "clone
from auth-only-for-objects repository", which would actually do the
second half of that conversation, and require authentication. You're
only deleting the part that does the noop fetch.

Puzzled...

-Peff

[1] https://public-inbox.org/git/CAHtLG6Q+XO=LhnKw4hhwtOe2ROeDN1Kg=JN5GTQqdvYjk-Sv4g@mail.gmail.com/
