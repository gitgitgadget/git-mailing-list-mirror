Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116EDC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE8A60232
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhIDM67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 08:58:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:39340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhIDM66 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 08:58:58 -0400
Received: (qmail 32521 invoked by uid 109); 4 Sep 2021 12:57:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 12:57:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11499 invoked by uid 111); 4 Sep 2021 12:57:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 08:57:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 08:57:56 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Kevin Phillips <thefriendlycoder@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: Weird interaction between Git protocol versions and git:// and
 https:// URLs (was: Re: Bug with Git shallow clones and submodules)
Message-ID: <YTNtVJy6sCfQ7T3L@coredump.intra.peff.net>
References: <CANNNLMC_XEqjYPOig+pbqrS30dPCTmcDSev6yg+5EEBkJCaaig@mail.gmail.com>
 <1a98c659-e7db-50a6-faf3-b3b4c15df679@gmail.com>
 <542a68a5-d439-921e-2691-bb8890584f27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <542a68a5-d439-921e-2691-bb8890584f27@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 02, 2021 at 09:49:38AM -0400, Philippe Blain wrote:

> > OK, it's running Git 2.20.1. And the list of capabilities above implies that it's responding
> > with protocol v0, even if my local Git version if 2.29, which defaults to protocol v2. If
> > it were responding with protocol v2, we would see:
> > 
> > $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://github.com/git/git 2>&1 | grep agent
> > packet:          git< agent=git/github-g78b452413e8b  # server version
> > packet:          git< agent=git/github-g78b452413e8b
> > packet:          git> agent=git/2.29.2  # client version
> > packet:          git< agent=git/2.29.2
> > 
> > And grepping for "version" would confirm it:
> > 
> > $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://github.com/git/git 2>&1 | grep version
> > packet:          git< version 2
> > packet:          git< version 2
> > 
> > I can't explain why the server refuses to talk with protocol v2. Maybe Jonathan (CC-ed),
> > who worked on the implementation of protocol v2, would be able to explain that.
> 
> I'm sorry to bump this, but I would really like to understand what is going on here.
> I'm not familiar at all with the protocol code, but my understanding was that after
> Git 2.18, if a client requested protocol v2, the server would answer with v2 (at least
> for git:// and http[s]://, and also for ssh:// if AcceptEnv is correctly configured).
> Here, Git 2.20.1 at https://dpdk.org/git/dpdk-stable answers with v0 for https://,
> but with v2 for git:// !

The server has to be configured correctly at the HTTP level, too. The v2
probe for HTTP is a "Git-Protocol: version=2" header in the HTTP
request. The webserver has to be configured to communicate that to the
rest of Git somehow. In our test setup for Apache, we do:

  SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0

If that doesn't happen, then the server doesn't see the header at all,
and just speaks v0 as usual.

I suspect this could be better documented. I have to admit that I have
not actually run a regular HTTP server with Git in a long time (at
GitHub, we have our own custom layer that terminates the HTTP
connections).

-Peff
