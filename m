Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4221AC4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C452076E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgJ3PBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:01:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:42574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgJ3PBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 11:01:37 -0400
Received: (qmail 7470 invoked by uid 109); 30 Oct 2020 15:01:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 15:01:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21902 invoked by uid 111); 30 Oct 2020 15:01:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 11:01:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 11:01:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
Cc:     git@vger.kernel.org
Subject: Re: Credential Store: Don't acquire lock when only reading the file
Message-ID: <20201030150136.GA3282152@coredump.intra.peff.net>
References: <20201029192020.mcri76ylbdure2o7@safonso-t430>
 <20201030055541.GA3264588@coredump.intra.peff.net>
 <20201030120540.dna7k3bmnrrw4cck@safonso-t430>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201030120540.dna7k3bmnrrw4cck@safonso-t430>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 12:05:40PM +0000, Simão Afonso wrote:

> On 2020-10-30 01:55:41, Jeff King wrote:
> >       - teach it to try the lock until hitting a timeout. I think just
> > 	swapping out hold_lock_file_for_update() for
> > 	hold_lock_file_for_update_timeout() would do it (I probably
> > 	would have used it back then, but it didn't exist yet).
> 
> So I tried to patch the credential store with that timeout function and
> it seems to solve it! Thanks.
> 
> https://github.com/git/git/blob/v2.29.2/builtin/credential-store.c#L61
> 
> This is easily reproduced if you do a `fetch --all` in parallel on the
> same repository (seen on the attached image):

Great!

> > $ for n in $(seq 100); do git fetch --all; sleep 0.5; done
> 
> About the timeout, I put it at infinite retries, but should this be
> configurable? Or should it be a different default?
> 
> There aren't many timeout configurations. I found
> "core.filesRefLockTimeout" and "core.packedRefsTimeout", doesn't sound
> like something that should be re-used.
> Should it be something like this with a different name?

Yeah, I don't think it makes sense to reuse those. I kind of doubt that
it is worth making it configurable, as credential-store does not
otherwise read any config at all.

The defaults for those other two values are 100ms and 1s respectively.
So probably just setting a 1s timeout would be plenty, and saves us from
looping forever if we see a stale lockfile.

-Peff
