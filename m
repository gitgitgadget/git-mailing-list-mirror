Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA0420437
	for <e@80x24.org>; Fri, 13 Oct 2017 15:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757670AbdJMPoE (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 11:44:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:52266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753512AbdJMPoE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 11:44:04 -0400
Received: (qmail 26843 invoked by uid 109); 13 Oct 2017 15:44:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 15:44:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26448 invoked by uid 111); 13 Oct 2017 15:44:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 11:44:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 11:44:01 -0400
Date:   Fri, 13 Oct 2017 11:44:01 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
Subject: Re: [PATCH] revision: quit pruning diff more quickly when possible
Message-ID: <20171013154401.hwwvl2xi5quv2sg3@sigill.intra.peff.net>
References: <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
 <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
 <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
 <20171013135636.o2vhktt7aqx6luuy@sigill.intra.peff.net>
 <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
 <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
 <42cbcb4f-7f9d-df69-f55e-0ba42b931957@gmail.com>
 <20171013142646.evapso5uxzvh2r2p@sigill.intra.peff.net>
 <20171013152745.cgqt3qgvcngyr5ew@sigill.intra.peff.net>
 <e2db8086-29af-a8bc-1e12-8642e430fcb3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2db8086-29af-a8bc-1e12-8642e430fcb3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 11:37:50AM -0400, Derrick Stolee wrote:

> Thanks, Peff. This patch looks good to me.
> 
> I tried a few other things like adding a flag DIFF_OPT_HAS_ANY_CHANGE next
> to DIFF_OPT_HAS_CHANGES that we could check in diff_can_quit_early() but it
> had side-effects that broke existing tests. From this exploration, it does
> seem necessary to be aware of 'remove_empty_trees'.

Keep in mind that the regular diff_change callbacks already handle this
case[1].

The file_change callbacks are specific to the revision machinery's
pruning diff, and intentionally hold back the HAS_CHANGES flag.

-Peff

[1] I tried "git diff-tree --root -r --quiet 45546f17e" on the bomb
    repo, and it went quickly. Dropping --quiet makes it take a really
    long time.
