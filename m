Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6269FC83F14
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 23:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbjH3XEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344422AbjH3XEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 19:04:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1985B8F
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 16:03:48 -0700 (PDT)
Received: (qmail 19372 invoked by uid 109); 30 Aug 2023 19:03:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Aug 2023 19:03:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28906 invoked by uid 111); 30 Aug 2023 19:03:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Aug 2023 15:03:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Aug 2023 15:03:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .github/workflows: add coverity action
Message-ID: <20230830190309.GA1707474@coredump.intra.peff.net>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
 <6534ba5d-f4a6-71e6-5b0f-9cba2be8426e@gmx.de>
 <20230830001844.GA227310@coredump.intra.peff.net>
 <36143de8-8343-b75d-4ba6-d7241535ba91@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36143de8-8343-b75d-4ba6-d7241535ba91@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2023 at 10:07:35AM +0200, Johannes Schindelin wrote:

> > My gut feeling is that we should be able to do something with env
> > variables [...]
> 
> Environment variables need an environment, i.e. a running build agent.
> That's why they aren't available in our use case, but only inside a step
> (which is too late for our purposes).

Yeah, sorry I was a bit loose with my language. I meant "variables set
from the GitHub UI that are often used as env variables". :)

> > [...] it seems that the "vars" context (but not "secrets") is available
> > to "jobs.*.if". I'm not sure if I missed before, or if that's a new
> > feature since the last time I checked.
> 
> I had missed that, too. It was announced here:
> https://github.blog/2023-01-10-introducing-required-workflows-and-configuration-variables-to-github-actions/#configuration-variables
> (I must have glanced over that post when I saw it because it talked about
> required workflows, which are currently irrelevant to my interests).

Yeah, I found that, too (after sending my email). So it looks like this
is a good, supported path for going forward.

I have a working patch that can replace the ci/config/allow-ref script.
We can't totally ditch the "config" job with it, as there are other
things it does, but it's possible those can be migrated, too. IMHO the
allow-ref one is the _most_ important, though, because it addresses the
case of "everything should be skipped".  Taking that from spinning up
one VM per ref to zero is very good.

I'll post that patch later today.

> FWIW I was unable to deduce any authoritative information as to where the
> `secrets` context can be accessed from
> https://docs.github.com/en/actions/learn-github-actions/contexts#secrets-context,
> but I must assume that access to that context is highly restricted and
> probably cannot be used outside the `steps:` attribute, explaining why a
> job-level (and in my previous tests, even step-level) `if:` condition
> cannot access them.

I found the "vars" context through this table:

  https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability

which does show where "secrets" is available.

-Peff
