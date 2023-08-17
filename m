Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEAFC531DF
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 19:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354787AbjHQT5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354820AbjHQT4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 15:56:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968B359B
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:56:42 -0700 (PDT)
Received: (qmail 29535 invoked by uid 109); 17 Aug 2023 19:56:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 19:56:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 652 invoked by uid 111); 17 Aug 2023 19:56:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 15:56:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 15:56:41 -0400
From:   Jeff King <peff@peff.net>
To:     Patrik =?utf-8?B?SMOkZ2dsdW5k?= <patrik.h.hagglund@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: clone (single) commit id?
Message-ID: <20230817195641.GD3032779@coredump.intra.peff.net>
References: <CABtpZSGcL8hkk3HA3ECtt7KeLPOhuB0n7EKN1Tg5ZHpFBE0V0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABtpZSGcL8hkk3HA3ECtt7KeLPOhuB0n7EKN1Tg5ZHpFBE0V0A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2023 at 09:45:19PM +0200, Patrik Hägglund wrote:

> In our CI setup, for reproducibility and performance reasons, I want
> to be able to clone a repository with only a single given commit id
> (commit hash). (Using 'git init' + 'git fetch' + 'git checkout' is
> possible, but more elaborate/low-level.)
> 
> At https://lore.kernel.org/git/MN2PR12MB3616C1F2E97A18547740651DF9E29@MN2PR12MB3616.namprd12.prod.outlook.com/
> it is stated that:
> 
> > Never mind, I see, feature exists but server needs to allow it. Sigh.
> 
> However, I'm not able to find this in the Git documentation. Can
> someone point out how to configure this? Can this be better
> documented?

I'd use a shallow clone with depth 1, like:

  git clone -b $your_branch --depth 1 $remote_url

Note that "--depth" implies --single-branch, so it will really just grab
that one branch (and if it's the remote's default branch that you want,
you can omit the "-b $your_branch" part).

If you find the shape of history useful (e.g., your CI wants to look at
just new commits), you might also find partial clones useful. Something
like:

  git clone --filter=blob:none $remote_url

will fetch all commits and trees, but only load blobs on-demand (so
basically whatever is needed to check out that tip commit). You can
pare it down further by switching to "--filter=tree:0", which will avoid
trees (but note that filling in trees when you need them is a bit more
expensive, since inherently you have to make a round-trip to the server
for each level of tree).

-Peff
