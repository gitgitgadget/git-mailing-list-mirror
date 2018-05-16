Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48D21F406
	for <e@80x24.org>; Wed, 16 May 2018 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeEPTOP (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:14:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:43254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751038AbeEPTOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:14:15 -0400
Received: (qmail 13654 invoked by uid 109); 16 May 2018 19:14:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 May 2018 19:14:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25725 invoked by uid 111); 16 May 2018 19:14:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 16 May 2018 15:14:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2018 12:14:11 -0700
Date:   Wed, 16 May 2018 12:14:11 -0700
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180516191410.GA3417@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87po1waqyc.fsf@evledraar.gmail.com>
 <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
 <87muwzc2kv.fsf@evledraar.gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
 <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 10:58:19AM -0400, Konstantin Ryabitsev wrote:

> The parent repo is not keeping track of any other repositories that may
> be using it for alternates, which is why you basically:
> 
> 1. never run auto-gc in the parent repo
> 2. repack it manually using -Ad to keep loose objects that other repos
> may be borrowing (but we don't know if they are)
> 3. never prune the parent repo, because this may delete objects other
> repos are borrowing
> 
> Very infrequently you may consider this extra set of maintenance steps:
> 
> 1. Find every repo mentioning the parent repository in their alternates
> 2. Repack them without the -l switch (which copies all the borrowed
> objects into those repos)
> 3. Once all child repos have been repacked this way, prune the parent
> repo (it's safe now)
> 4. Repack child repos again, this time with the -l flag, to get your
> savings back.

You can also do periodic maintenance like:

  1. Copy each ref in the forked repositories into the parent repository
     (e.g., giving each child that borrows from the parent its own
     hierarchy in refs/remotes/<child>/*).

  2. Repack the parent as normal. It will retain any objects referenced
     by the children (because they are now referenced by it).

But note that:

  1. It's not atomic with respect to updates in the child repos (but
     then, neither is the single-repo case!).

  2. It doesn't know about reflogs or the index in the child
     repositories.

This is more or less how we use alternates at GitHub.

> I would heartily love a way to teach git-repack to recognize when an
> object it's borrowing from the parent repo is in danger of being pruned.
> The cheapest way of doing this would probably be to hardlink loose
> objects into its own objects directory and only consider "safe" objects
> those that are part of the parent repository's pack. This should make
> alternates a lot safer, just in case git-prune happens to run by accident.

If you set:

  git config core.repositoryformatversion 1
  git config extensions.preciousObjects true

in the parent, git-prune (repack -d) will refuse to run. That doesn't
solve the problem of how to repack, but it can help prevent accidental
misuse.

-Peff
