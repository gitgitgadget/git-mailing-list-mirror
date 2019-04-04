Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9A920248
	for <e@80x24.org>; Thu,  4 Apr 2019 02:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDDCC2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 22:02:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:46282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726167AbfDDCC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 22:02:28 -0400
Received: (qmail 19261 invoked by uid 109); 4 Apr 2019 02:02:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 02:02:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13290 invoked by uid 111); 4 Apr 2019 02:02:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 22:02:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 22:02:26 -0400
Date:   Wed, 3 Apr 2019 22:02:26 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
Message-ID: <20190404020226.GG4409@sigill.intra.peff.net>
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l>
 <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
 <20190403213318.GA14137@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403213318.GA14137@dev-l>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 02:33:18PM -0700, Denton Liu wrote:

> > I am not sure if this is so bad, actually.  Why do we need to treat
> > it as a mistake?  When a command that wants a commit is fed a tag
> > (either a tag that directly refers to a commit, or a tag that tags
> > another tag that refers to a commit), the command knows how to peel
> > so it's not like the user is forced to say "git log T^{commit}".
> 
> This patch came about because Robert Dailey expressed confusion after
> accidentally creating a tag-to-a-tag a while back by mistake when he
> actually meant to amend a tag.
> 
> In the discussion upthread, Peff noted that he has never seen a
> tag-to-a-tag in the wild before. I think the conclusion was that for
> the majority of users, doing this is an error. That is what this patch
> is guarding against.

I do still think it is likely to be a mistake. I think Junio's point,
though is: who cares if the mistake was made? For the most part you can
continue to use the tag as if the mistake had never been made, because
Git peels through multiple layers as necessary.

The only thing that caused the discussion in the first place is that
when "git show" displays each layer, there was a little head-scratching.

So if we were starting from scratch and designing the behavior, I think
putting a safety valve around this mistake would probably be a
no-brainer.

But given that we're changing long-standing behavior (that somebody
_could_ be using intentionally), is it worth it to fix what is a mostly
harmless outcome?

I'm on the fence personally. I think I do still lean slightly towards
"yes, detect this in the porcelain", but I can see an argument both
ways.

-Peff
