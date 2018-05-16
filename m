Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03C01F406
	for <e@80x24.org>; Wed, 16 May 2018 19:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750935AbeEPTXs (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:23:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:43292 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750778AbeEPTXr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:23:47 -0400
Received: (qmail 14301 invoked by uid 109); 16 May 2018 19:23:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 May 2018 19:23:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25917 invoked by uid 111); 16 May 2018 19:23:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 16 May 2018 15:23:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2018 12:23:43 -0700
Date:   Wed, 16 May 2018 12:23:43 -0700
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Martin Fick <mfick@codeaurora.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180516192343.GB3417@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 03:01:13PM -0400, Konstantin Ryabitsev wrote:

> On 05/16/18 14:26, Martin Fick wrote:
> > If you are going to keep the unreferenced objects around 
> > forever, it might be better to keep them around in packed 
> > form?
> 
> I'm undecided about that. On the one hand this does create lots of small
> files and inevitably causes (some) performance degradation. On the other
> hand, I don't want to keep useless objects in the pack, because that
> would also cause performance degradation for people cloning the "mother
> repo." If my assumptions on any of that are incorrect, I'm happy to
> learn more.

I implemented "repack -k", which keeps all objects and just rolls them
into the new pack (along with any currently-loose unreachable objects).
Aside from corner cases (e.g., where somebody accidentally added a 20GB
file to an otherwise 100MB-repo and then rolled it back), it usually
doesn't significantly affect the repository size.

And it generally should not cause performance problems for people
cloning, since Git will create a custom pack for each client with only
the reachable objects.

There _is_ an interesting corner case where a reachable object might be
a delta against an unreachable one, which can cause a clone to have to
break that relationship and find a new delta. At GitHub we have some
custom code that tries to avoid these kind of delta dependencies (not
just to unreachable objects, but to other forks that share object
storage). You can see the patch at:

  https://github.com/peff/git jk/delta-islands

-Peff
