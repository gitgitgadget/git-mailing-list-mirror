Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AEFC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 02:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E34207BB
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 02:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHUCdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:33:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:36680 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgHUCdh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 22:33:37 -0400
Received: (qmail 12504 invoked by uid 109); 21 Aug 2020 02:33:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 02:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22668 invoked by uid 111); 21 Aug 2020 02:33:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2020 22:33:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Aug 2020 22:33:35 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
Message-ID: <20200821023335.GA3124022@coredump.intra.peff.net>
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com>
 <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
 <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
 <20200818174116.GA2473110@coredump.intra.peff.net>
 <CA+P7+xqfAqnoKBeOiO6f7tdyi_7M=wKpmnFoWBt6UHbOqbYCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqfAqnoKBeOiO6f7tdyi_7M=wKpmnFoWBt6UHbOqbYCzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 20, 2020 at 04:59:53PM -0700, Jacob Keller wrote:

> > The relevant commit is 2467a4fa03 (Remove duplicate ref matches in
> > fetch, 2007-10-08), I think. We may end up with multiple refspecs
> > requesting a particular ref. E.g.:
> >
> >   git fetch origin refs/heads/master refs/heads/*
> >
> > I don't think the order should matter. If we apply negative refspecs
> > first, then we'd either remove both copies or leave both untouched (and
> > if the latter, then de-dup to a single). If we apply negative refspecs
> > after de-duping, then we'd either remove the single or leave it in
> > place. But the result is the same either way.
> 
> I'm not sure this is quite true in the case where destinations are
> supplied. Suppose this case:

Oh, you're right. I was too focused on the de-duping of identical refs,
but this is also handling colliding destinations.

> git fetch refs/heads/*:refs/remotes/origin/*
> refs/other/mybranch:refs/remotes/origin/mybranch
> 
> This would ofcourse error out due to de-duping where we determine that
> both would fetch to the same place.. however if you also added a
> negative refspec:
> 
> git fetch refs/heads/*:refs/remotes/origin/*
> refs/other/mybranch:refs/remotes/origin/mybranch ^refs/heads/mybranch
> 
> then shouldn't this work? meaning we should de-dupe only after we
> apply negative refspecs in this case?

Yes, I'd agree we should be applying the negative refspecs first, and
then de-duping / looking for collisions. Which I think is what the patch
is doing currently.

-Peff
