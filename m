Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93088202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 19:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbdJSTeQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:34:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752614AbdJSTeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:34:16 -0400
Received: (qmail 689 invoked by uid 109); 19 Oct 2017 19:34:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 19:34:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11521 invoked by uid 111); 19 Oct 2017 19:34:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 15:34:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 15:34:14 -0400
Date:   Thu, 19 Oct 2017 15:34:13 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH/RFC] grep: turn off threading when recursing submodules
Message-ID: <20171019193413.prx5pkmwaxk6mpdt@sigill.intra.peff.net>
References: <20171019190703.1534-1-martin.agren@gmail.com>
 <20171019192618.GB84767@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019192618.GB84767@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 12:26:18PM -0700, Brandon Williams wrote:

> One alternative to turning off threading would be to employ proper
> locking (like I failed to do) by wrapping the call the
> 'add_to_alternates_memory()' in calls to grep_read_lock/unlock:
> 
>   +       grep_read_lock();
>           add_to_alternates_memory(submodule.objectdir);
>   +       grep_read_unlock();
> 
> That way adding the submodule to the object database won't happen at the
> same time another thread is trying to read from the object store.

Yeah, I think that is the right approach. Many of Git's APIs aren't
thread-safe, so we need a big mutex around "I am doing anything except
actually looking at the already-read blob contents". We just missed this
spot.

-Peff
