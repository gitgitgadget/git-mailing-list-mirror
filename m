Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E951F208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbdHIVJu (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:09:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:33790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751904AbdHIVJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:09:49 -0400
Received: (qmail 27927 invoked by uid 109); 9 Aug 2017 21:09:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 21:09:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31194 invoked by uid 111); 9 Aug 2017 21:10:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 17:10:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 17:09:47 -0400
Date:   Wed, 9 Aug 2017 17:09:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/2] sha1_file: drop experimental GIT_USE_LOOKUP search
Message-ID: <20170809210946.2pzz5rze4u57c4lr@sigill.intra.peff.net>
References: <20170809101106.p45y34uk6wcruqxv@sigill.intra.peff.net>
 <20170809101432.6jquwmev423o56pb@sigill.intra.peff.net>
 <xmqqshh06264.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshh06264.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 11:12:19AM -0700, Junio C Hamano wrote:

> Thanks for reducing the count of binary search functions by one.
> 
> I think the "just one round of newton-raphson" in sha1_pos() comes
> from [*1*]; I agree that it needs benchmarking before tweaking it.

Actually, it's weirder than that. You mentioned it in that thread, but
the code dates back much further. It was moved to the file in 96beef8,
but that was just a copy from patch-ids.c. The original seems to be from
5d23e133d2 (Refactor patch-id filtering out of git-cherry and
git-format-patch., 2007-04-09), which predates the sha1_entry_pos()
experiment.

I always thought those two sha1-lookup functions came in the opposite
order, but I guess was wrong. Or possibly you are a time traveler.

> We may want to tell libgit2 folks about this change, though [*2*].
> I think they too are carrying dead code that is only used under CPP
> macro GIT_USE_LOOKUP, which they do not seem to define.

Good thinking. It looks like they could use all three of the patches
under discussion. I opened some PRs:

  https://github.com/libgit2/libgit2/pull/4326
  https://github.com/libgit2/libgit2/pull/4327
  https://github.com/libgit2/libgit2/pull/4328

-Peff
