Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEAEB2082D
	for <e@80x24.org>; Thu,  7 Sep 2017 09:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755208AbdIGJrW (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 05:47:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:59500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755006AbdIGJrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 05:47:21 -0400
Received: (qmail 13727 invoked by uid 109); 7 Sep 2017 09:47:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 09:47:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30032 invoked by uid 111); 7 Sep 2017 09:47:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 05:47:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 05:47:18 -0400
Date:   Thu, 7 Sep 2017 05:47:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UGF3ZcWC?= Marczewski <pwmarcz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Strange behavior of git rev-list
Message-ID: <20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net>
References: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 11:20:15AM +0200, Paweł Marczewski wrote:

> I have an interesting case. In my repository, there are two commits,
> 'one' and 'two'. 'one' is reachable from 'two' (as evidenced by 'git
> rev-list two | grep $(giv rev-parse one)'). However, the output of
> 'git rev-list two..one' is not empty, as is 'git rev-list ^two one'.
> 
> Here is the repository: https://github.com/pwmarcz/git-wtf/
> 
> It seems that the commit dates influence this behavior, because when I
> edit all the dates to be the same, the output of 'git rev-list
> two..one' is empty. Pruning seemingly irrelevant parents also makes it
> empty.
> 
> I verified the behavior on git versions 2.14.1, 2.11.0, and on the
> 'next' branch (2.14.1.586.g1a2e63c10).

Yes, this is known. The commit dates are used as a proxy for graph
height (or generation numbers, if you prefer) so that we avoid having to
walk all the way down to a merge base before producing any output. But
it can give the wrong answer in the face of clock skew.

We walk back five extra commits more than we need to in order to avoid
small runs of skewed commits, but obviously you can have arbitrary-sized
runs.

-Peff
