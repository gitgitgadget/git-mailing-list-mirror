Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB9C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E1C206BE
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHXUVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:21:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:39130 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXUVN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 16:21:13 -0400
Received: (qmail 23676 invoked by uid 109); 24 Aug 2020 20:21:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2020 20:21:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17144 invoked by uid 111); 24 Aug 2020 20:21:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2020 16:21:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Aug 2020 16:21:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout, restore: make pathspec recursive
Message-ID: <20200824202111.GA709709@coredump.intra.peff.net>
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
 <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
 <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
 <20200820134013.GA2526241@coredump.intra.peff.net>
 <c3f0d51a-d0e3-ed0a-c9ed-da092704da5c@web.de>
 <20200820182720.GA2537643@coredump.intra.peff.net>
 <7c5144d8-24cd-0d50-a7c6-ff77160d503d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c5144d8-24cd-0d50-a7c6-ff77160d503d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 22, 2020 at 10:57:59AM +0200, René Scharfe wrote:

> The pathspec given to git checkout and git restore is used with both
> tree_entry_interesting (via read_tree_recursive) and match_pathspec
> (via ce_path_match).  The latter effectively only supports recursive
> matching regardless of the value of the pathspec flag "recursive",
> which is unset here.
> 
> That causes different match results for pathspecs with wildcards, and
> can lead checkout and restore in no-overlay mode to remove entries
> instead of modifying them.  Enable recursive matching for both checkout
> and restore to make matching consistent.
> 
> Setting the flag in checkout_main() technically also affects git switch,
> but since that command doesn't accept pathspecs at all this has no
> actual consequence.

Thanks, I think this is the thing to do (and the code change looks
obviously correct ;) ).

This may cause a user-visible behavior change even in overlay mode
(because we'll now match some tree entries that we wouldn't before). But
I think it's an improvement, because it makes:

  git checkout <tree> -- <paths>

consistent with:

  git checkout -- <paths>

I don't know if you want to call that out more directly in the commit
message.

-Peff
