Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CDC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiIVTMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiIVTMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:12:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A3106A10
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:12:20 -0700 (PDT)
Received: (qmail 6941 invoked by uid 109); 22 Sep 2022 19:12:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 19:12:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4829 invoked by uid 111); 22 Sep 2022 19:12:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 15:12:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 15:12:19 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: t9210-scalar.sh fails with SANITIZE=undefined
Message-ID: <Yyyzk3FVjmms7dkO@coredump.intra.peff.net>
References: <YywzNTzd72tox8Z+@coredump.intra.peff.net>
 <ff921c34-139a-9e2b-ca1f-d6f9f7213d1b@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff921c34-139a-9e2b-ca1f-d6f9f7213d1b@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 08:35:22AM -0400, Derrick Stolee wrote:

> > I didn't dig further. It's obviously new in v2.38.0-rc1, but I'm not
> > sure it's a show-stopper. It _might_ have been there all along, and is
> > just now surfacing. Or it might be in an existing experimental feature
> > that just wasn't exercised enough in the tests. Or if it really is new
> > in scalar, then it will only hurt people using scalar, which didn't
> > exist before. So I don't think it's a regression in the strictest sense,
> > but it might be nice to get a more accurate understanding of the problem
> > before the release.
> 
> Interesting find!
> 
> Here are the index-related settings that Scalar sets as of -rc1:
> 
> * core.preloadIndex=true
> * index.threads=true
> * index.version=4
> 
> My gut feeling is that index.version=4 might be the culprit. I thought
> we tested GIT_TEST_INDEX_VERSION=4 in some CI modes, but apparently we
> do not. Do you get the same error in other tests with that environment
> variable?

Yeah, that seems by far the most likely of those three. And indeed,
running with GIT_TEST_INDEX_VERSION=4 causes even t0000 to fail with the
same problem. A minimal reproduction in git.git is just:

  make SANITIZE=undefined
  git clone . tmp
  cd tmp
  rm .git/index
  export GIT_INDEX_VERSION=4
  ../git reset --hard ;# ok, writes v4 index
  ../git reset --hard ;# fails reading unaligned v4 index

So it seems like a problem with the v4 format in general. Which...yikes.

-Peff
