Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8415F20966
	for <e@80x24.org>; Thu, 30 Mar 2017 21:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933814AbdC3VeE (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 17:34:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:54444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933470AbdC3VeC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 17:34:02 -0400
Received: (qmail 32117 invoked by uid 109); 30 Mar 2017 21:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 21:34:00 +0000
Received: (qmail 3354 invoked by uid 111); 30 Mar 2017 21:34:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 17:34:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 17:33:58 -0400
Date:   Thu, 30 Mar 2017 17:33:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] log: if --decorate is not given, default to
 --decorate=auto
Message-ID: <20170330213358.qjsobjcbons66skf@sigill.intra.peff.net>
References: <20170324054631.21622-1-alexhenrie24@gmail.com>
 <20170324183825.GD31294@aiede.mtv.corp.google.com>
 <xmqqa88263qw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa88263qw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 11:03:51AM -0700, Junio C Hamano wrote:

> With the "--decorate=auto" option becoming the default for "git
> log", "git tbdiff" will be broken.
> 
> The configuration variable has been already there, so in that sense
> this is not a new breakage (tbdiff wouldn't have worked well for
> those with configured default).  A fix is trivial (attached).
> 
> I suspect that Alex's change may uncover similar breakages in
> people's scripts.  Perhaps the topic should be cooked a bit longer
> than other topics on 'next'?

I'm confused. I thought "auto" would kick in only when we are outputting
to a terminal. Or is the problem that the "is it a terminal" check is
fooled by $GIT_PAGER_IN_USE, because you are running "git -p tbdiff"?

If so, this is the symptom of a more general problem, which is that
a script outputting to a pager will have confused sub-processes, who do
not know if their pipe is the pager one or not. Perhaps it is time to
resurrect my patch from:

  http://public-inbox.org/git/20150810052353.GB15441@sigill.intra.peff.net/

I think it would need a Windows-specific variant, but the general idea
is sound.

-Peff

PS I've been running git-tbdiff occasionally for years with log.decorate
   set to "true". I wonder why I haven't noticed any problems.
