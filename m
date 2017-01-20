Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8AEB20756
	for <e@80x24.org>; Fri, 20 Jan 2017 19:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbdATTSa (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 14:18:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:42260 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753035AbdATTSY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 14:18:24 -0500
Received: (qmail 10736 invoked by uid 109); 20 Jan 2017 19:17:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 19:17:31 +0000
Received: (qmail 8855 invoked by uid 111); 20 Jan 2017 19:18:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 14:18:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 14:17:28 -0500
Date:   Fri, 20 Jan 2017 14:17:28 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
Message-ID: <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170119193023.26837-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 11:30:23AM -0800, Stefan Beller wrote:

> Now let's ask the same question for "git -C sub status ." (which is a
> command that is only reading and not writing to the repository)
> 
> 1) If the submodule is populated, the user clearly intended to know
>    more about the submodules status
> 2) It is unclear if the user wanted to learn about the submodules state
>    (So ideally: "The submodule 'sub' is not initialized. To init ...")
>    or the status check should be applied to the superproject instead.
> 
> Avoid the confusion in 2) as well and just error out for now. Later on
> we may want to add another flag to git.c to allow commands to be run
> inside unpopulated submodules and each command reacts appropriately.

I like the general idea of catching commands in unpopulated submodules,
but I'm somewhat uncomfortable with putting an unconditional check into
git.c, for two reasons:

  1. Reading the index can be expensive. You would not want "git
     rev-parse" to incur this cost.

  2. How does this interact with commands which do interact with the
     index? Don't they expect to find the_index unpopulated?

     (I notice that it's effectively tied to RUN_SETUP, which is good.
      But that also means that many commands, like "diff", won't get the
      benefit. Not to mention non-builtins).

I'd rather see it in the commands themselves. Especially given the
"ideal" in your status example, which requires command-specific
knowledge.

-Peff
