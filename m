Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8527B1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 12:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfHFM0D (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 08:26:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:35120 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726092AbfHFM0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 08:26:03 -0400
Received: (qmail 16499 invoked by uid 109); 6 Aug 2019 12:26:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 12:26:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1214 invoked by uid 111); 6 Aug 2019 12:28:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 08:28:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 08:26:02 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] the_repository initialization cleanup
Message-ID: <20190806122601.GA21475@sigill.intra.peff.net>
References: <pull.300.git.gitgitgadget@gmail.com>
 <pull.300.v2.git.gitgitgadget@gmail.com>
 <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com>
 <20190731220204.GA1933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1908010004130.21907@tvgsbejvaqbjf.bet>
 <20190731231257.GB1933@sigill.intra.peff.net>
 <20190801004928.GA6351@sigill.intra.peff.net>
 <7f4257d3-5ae0-3a83-84f1-bee83682fa36@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f4257d3-5ae0-3a83-84f1-bee83682fa36@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 01:24:17PM -0400, Jeff Hostetler wrote:

> > By the way, I wondered why trace2's existing config reading did not
> > cause us to segfault because of this. It is because it invented the
> > "very early config" function which always ignores some config sources
> > (working around this problem, but also making it weirdly unlike most
> > other config).
> 
> Yes, I added the "very early config" to try to work around some of
> the chicken-n-egg problems.  I can't say that I was completely happy
> with having to do that.  I haven't had time to play with your patch
> suggestion here, but I think it would be fine to do if it will help
> with the original problem.
> 
> In [1] I added code to just start the clock in isolation (rather than
> being part of the trace2_initialize() -- which does all the config
> loading and subsystem initialization).  So it is OK to let the
> trace2_initialize() run a little later.  (Part of the reason for that
> split was to allow git_resolve_executable_dir() to run first, since
> that data was needed to find the location of the system config relative
> to the exe path (sigh).)
> 
> [1] a089724958a trace2: refactor setting process starting time
> 
> So, as you suggested in your previous response, something like
> this would/should be fine.

Thanks, that pointer helped me write the commit message. So here are a
few cleanups that can go on top (of master now, since Dscho's patch
graduated). There's no rush to get these into v2.23.

Note that there _is_ still a funny corner case with the way the original
patch checks the_repository->git_dir, but I don't think it's worth
fixing at this point. I'll send a followup email with more details.

  [1/3]: t1309: use short branch name in includeIf.onbranch test
  [2/3]: common-main: delay trace2 initialization
  [3/3]: config: stop checking whether the_repository is NULL

 common-main.c           | 8 ++++----
 config.c                | 2 +-
 t/t1309-early-config.sh | 7 ++++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

-Peff
