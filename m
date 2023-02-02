Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF315C63797
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 00:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBBAQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 19:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAQN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 19:16:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76C2B2B8
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 16:16:12 -0800 (PST)
Received: (qmail 7210 invoked by uid 109); 2 Feb 2023 00:16:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Feb 2023 00:16:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26062 invoked by uid 111); 2 Feb 2023 00:16:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 19:16:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 19:16:10 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     M Hickford <mirth.hickford@gmail.com>, gitgitgadget@gmail.com,
        avarab@gmail.com, chooglen@google.com, derrickstolee@github.com,
        git@jeffhostetler.com, git@vger.kernel.org,
        lessleydennington@gmail.com, vdye@github.com
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
Message-ID: <Y9sAysjR8jCbETxy@coredump.intra.peff.net>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <20230128142827.17397-1-mirth.hickford@gmail.com>
 <AS2PR03MB9815DEDEA3CF40F3D54624E0C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS2PR03MB9815DEDEA3CF40F3D54624E0C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 12:15:17PM -0800, Matthew John Cheetham wrote:

> > Challenge responses are typically short lived [1]. What happens if a storage helper is configured before a challenge-response helper? We want to maintain composability of helpers.
> > 
> > [credential]
> >     helper = storage  # eg. cache or osxkeychain
> >     helper = challenge-response  # eg. oauth-dpop
> 
> I think really this sort of thing is where the credential helper protocol
> isn't designed for credential-generating helpers in mind, but only simple
> storage-only helpers. There is no affinity between get/erase/store commands
> meaning one helper may return a credential for another helper to store it.
> Not sure if this was ever the intention, over just the need to consult a
> list of helpers for a stored credential.

I actually had envisioned helpers generating credentials. In fact, in
the first iteration of the series, Git did not prompt for passwords at
all! It would depend on git-credential-prompt to do so. But I ended up
folding that in for simplicity.

I could well believe that there is not enough context passed around for
helpers to make good decisions, though. It's both a feature and a bug
that credentials from one helper get passed to another. It's good if you
want to cache a generated credential. It's bad if you don't want
credentials from one helper to leak to another, less-secure one.

So I'm open to improvements that help define and communicate that
context.

-Peff
