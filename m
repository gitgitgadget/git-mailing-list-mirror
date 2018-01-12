Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E041F406
	for <e@80x24.org>; Fri, 12 Jan 2018 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965193AbeALTXS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 14:23:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:42532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965121AbeALTXR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 14:23:17 -0500
Received: (qmail 20521 invoked by uid 109); 12 Jan 2018 19:23:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 19:23:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1618 invoked by uid 111); 12 Jan 2018 19:23:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 14:23:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 14:23:15 -0500
Date:   Fri, 12 Jan 2018 14:23:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in
 trace_run_command()
Message-ID: <20180112192314.GA19004@sigill.intra.peff.net>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-5-pclouds@gmail.com>
 <20180112133355.GE27499@sigill.intra.peff.net>
 <xmqqpo6fvstf.fsf@gitster.mtv.corp.google.com>
 <20180112184546.GA15514@sigill.intra.peff.net>
 <xmqqlgh2x4tr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgh2x4tr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 11:19:44AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The actual prep_childenv() code looks like it would always do
> > last-one-wins, so we should treat FOO as unset in that final case. But
> > that only kicks in on non-Windows.
> >
> > On Windows we feed cmd->env straight to mingw_spawnvpe().  That ends up
> > in make_environment_block(), which looks like it does something similar.
> >
> > It's too bad the prep code is not shared, since then we could probably
> > just ask _it_ which deltas it applied.
> 
> Yeah, but that function does a lot more than computing delta.  
> 
> It's primary point, which comes from ae25394b ("run-command: prepare
> child environment before forking", 2017-04-19), is to create a full
> copy of the environment, not just a series of putenv/unsetenv that
> describes what gets changed, and that is done to avoid any
> allocation after fork before exec in the child process.
> 
> I guess prep_childenv() could take an extra and optional string-list
> to report what "deltas" it applied to the tracing machinery.  I am
> not sure if that is worth it, though.

Yes, that's exactly what I meant. I think if it covered all platforms it
might be worth it (not so much for code de-duping, but because then we
would know our display logic always matched what we exec'd). But unless
somebody wants to refactor all of the Windows spawn code, it's
definitely not a good idea.

-Peff
