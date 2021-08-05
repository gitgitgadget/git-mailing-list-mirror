Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749E9C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514DF61108
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbhHEUm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:42:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:40776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237913AbhHEUm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:42:56 -0400
Received: (qmail 12777 invoked by uid 109); 5 Aug 2021 20:42:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Aug 2021 20:42:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7376 invoked by uid 111); 5 Aug 2021 20:42:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Aug 2021 16:42:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Aug 2021 16:42:40 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
Message-ID: <YQxNQJNGOZW6CR6L@coredump.intra.peff.net>
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
 <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
 <YQt/g0iZxAVgw66o@ncase>
 <YQvRTpJ0NGakTy9W@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQvRTpJ0NGakTy9W@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 05, 2021 at 01:53:50PM +0200, Patrick Steinhardt wrote:

> I've put some more time into this. If rebased on top of v4 of [1], then
> we can also use `parse_commit_in_graph_gently()` to further speed this
> up from 15.8 seconds to 11.6 seconds with below patch. It's the same
> memory/speed tradeoff as I'm doing in [1].
> 
> I guess I'd still like to treat both series separately for now given
> that [1] is more involved compared to this patch series here. I'll then
> do a follow-up when (if?) both series have landed.

Heh, I should have read this before writing my other response. Your
strategy here is what I imagined. If you split the find/fill steps from
parse_commit_in_graph(), then you should be able to speculatively ask
"if this is a commit in the graph, fill it in, otherwise do nothing".
Which would solve the memory tradeoff.

-Peff
