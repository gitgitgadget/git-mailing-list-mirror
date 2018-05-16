Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C4D1F406
	for <e@80x24.org>; Wed, 16 May 2018 19:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeEPTht (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:37:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:43362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750937AbeEPTht (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:37:49 -0400
Received: (qmail 15240 invoked by uid 109); 16 May 2018 19:37:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 May 2018 19:37:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26266 invoked by uid 111); 16 May 2018 19:37:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 16 May 2018 15:37:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2018 12:37:45 -0700
Date:   Wed, 16 May 2018 12:37:45 -0700
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Martin Fick <mfick@codeaurora.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180516193744.GA4036@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <20180516192343.GB3417@sigill.intra.peff.net>
 <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 03:29:42PM -0400, Konstantin Ryabitsev wrote:

> On 05/16/18 15:23, Jeff King wrote:
> > I implemented "repack -k", which keeps all objects and just rolls them
> > into the new pack (along with any currently-loose unreachable objects).
> > Aside from corner cases (e.g., where somebody accidentally added a 20GB
> > file to an otherwise 100MB-repo and then rolled it back), it usually
> > doesn't significantly affect the repository size.
> 
> Hmm... I should read manpages more often! :)
> 
> So, do you suggest that this is a better approach:
> 
> - mother repos: "git repack -adk"
> - child repos: "git repack -Adl" (followed by prune)

Yes, that's pretty close to what we do at GitHub. Before doing any
repacking in the mother repo, we actually do the equivalent of:

  git fetch --prune ../$id.git +refs/*:refs/remotes/$id/*
  git repack -Adl

from each child to pick up any new objects to de-duplicate (our "mother"
repos are not real repos at all, but just big shared-object stores).

I say "equivalent" because those commands can actually be a bit slow. So
we do some hacky tricks like directly moving objects in the filesystem.

In theory the fetch means that it's safe to actually prune in the mother
repo, but in practice there are still races. They don't come up often,
but if you have enough repositories, they do eventually. :)

-Peff
