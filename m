Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF1CC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394EC2070A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgEOVlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 17:41:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:48282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726183AbgEOVlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 17:41:03 -0400
Received: (qmail 28276 invoked by uid 109); 15 May 2020 21:41:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 21:41:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16340 invoked by uid 111); 15 May 2020 21:41:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 17:41:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 17:41:02 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH 6/6] remote-curl: ensure last packet is a flush
Message-ID: <20200515214102.GE115445@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <7a689da2bb820f70d9e668d656b088af2297d456.1589393036.git.liu.denton@gmail.com>
 <20200515210245.GA3278654@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515210245.GA3278654@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 05:02:45PM -0400, Denton Liu wrote:

> On Wed, May 13, 2020 at 02:04:58PM -0400, Denton Liu wrote:
> > This is not a complete solution to the problem, however. It is possible
> > that a flush packet could be sent in the middle of a message and the
> > connection could die immediately after. Then, remote-curl would not
> > error out and fetch-pack would still be in the middle of a transaction
> > and they would enter deadlock. A complete solution would involve
> > reframing the stateless-connect protocol, possibly by introducing
> > another control packet ("0002"?) as a stateless request separator
> > packet which is always sent at the end of post_rpc().
> > 
> > Although this is not a complete solution, it is better than nothing and
> > it resolves the reported issue for now.
> 
> I managed to get the implementation of the control packet working. As a
> result, I will be dropping this patch in the next reroll and replacing
> it with the more complete solution. For anyone reviewing, feel free to
> skip this patch.

OK. I'm less concerned about a flush packet in the middle of the
response fooling us into thinking things are done, and more that there
may be responses which _don't_ end in a flush. But maybe they all do.

This (and the previous patch) are definitely adding an extra layer of
assumptions about what the protocol going over the rpc channel looks
like. That seems like it will introduce more fragility.

I do kind of like the idea of a stateless separator packet, if I
understand your meaning correctly. I'll wait to see what the patches
look like. :)

-Peff
