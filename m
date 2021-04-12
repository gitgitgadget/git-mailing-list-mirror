Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED72DC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD0161244
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhDLXvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 19:51:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:50540 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237250AbhDLXvf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 19:51:35 -0400
Received: (qmail 26284 invoked by uid 109); 12 Apr 2021 23:51:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Apr 2021 23:51:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19810 invoked by uid 111); 12 Apr 2021 23:51:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Apr 2021 19:51:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Apr 2021 19:51:14 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <YHTc8mqqDePlrOB8@coredump.intra.peff.net>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
 <20210412213653.GH2947267@szeder.dev>
 <CAGyf7-HTCDm_SB5CfQWJWjvuCVYuJ4=h65=zG-N1XTgNRs+j0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-HTCDm_SB5CfQWJWjvuCVYuJ4=h65=zG-N1XTgNRs+j0w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 02:49:00PM -0700, Bryan Turner wrote:

> I ran into this same surprising behavior recently, too. I was adding
> some automated testing to Bitbucket for partial clones and initially
> tried to use whether the repository was configured with a partial
> clone filter as one of my checks, only to find that even when filters
> weren't supported it was still set. The only way I could find to
> detect that a partial clone that was requested didn't actually happen
> was to parse the git clone output and look for the warning.

I think the state of "we have all the objects, but things are marked as
partial" is some place you could actually get into naturally: you start
with a partial clone, and then later fetch the objects you need, and you
just happen to have all the objects). Or you could even start there if
the filter happens not to exclude any objects. So I don't think that
state is invalid in any way.

But I do agree that if the client _knows_ that the filter was not used
(because the other side did not advertise filters and so we did not even
send it), then it is silly to create the client-side config marking us
as partial. It is misleading at best, and makes things slower at worst.

-Peff
