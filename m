Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650462023D
	for <e@80x24.org>; Mon, 22 May 2017 19:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761673AbdEVTfu (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:35:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:56178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758717AbdEVTft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:35:49 -0400
Received: (qmail 19675 invoked by uid 109); 22 May 2017 19:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 May 2017 19:35:38 +0000
Received: (qmail 23849 invoked by uid 111); 22 May 2017 19:36:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 May 2017 15:36:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 May 2017 15:35:35 -0400
Date:   Mon, 22 May 2017 15:35:35 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [WIP/RFC 00/23] repository object
Message-ID: <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
References: <20170518232134.163059-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 04:21:11PM -0700, Brandon Williams wrote:

> When I first started working on the git project I found it very difficult to
> understand parts of the code base because of the inherently global nature of
> our code.  It also made working on submodules very difficult.  Since we can
> only open up a single repository per process, you need to launch a child
> process in order to process a submodule.  But you also need to be able to
> communicate other stateful information to the children processes so that the
> submodules know how best to format their output or match against a
> pathspec...it ends up feeling like layering on hack after hack.  What I would
> really like to do, is to have the ability to have a repository object so that I
> can open a submodule in-process.

We could always buy in fully to the multi-process model and just
implement a generic RPC protocol between the parent and submodule gits.
Does CORBA still exist?

(No, I am not serious about any of that).

> This is still very much in a WIP state, though it does pass all tests.  What
> I'm hoping for here is to get a discussion started about the feasibility of a
> change like this and hopefully to get the ball rolling.  Is this a direction we
> want to move in?  Is it worth the pain?

I think the really painful part is going to be all of the system calls
that rely on global state provided by the OS. Like, say, every
filesystem call that expects to find working tree files without
prepending the working tree path.

That said, even if we never reached the point where we could handle all
submodule requests in-process, I think sticking the repo-related global
state in a struct certainly could not hurt general readability. So it's
a good direction regardless of whether we take it all the way.

-Peff
