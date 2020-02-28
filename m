Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545DCC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 19:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E12246A2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 19:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgB1TCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:02:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:57416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726720AbgB1TCT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 14:02:19 -0500
Received: (qmail 4734 invoked by uid 109); 28 Feb 2020 19:02:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Feb 2020 19:02:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18686 invoked by uid 111); 28 Feb 2020 19:11:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Feb 2020 14:11:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Feb 2020 14:02:18 -0500
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: GIT_DIR in aliases [Re: Spurious GIT_DIR set when in a worktree
 [was Re: Nested submodule status bug]
Message-ID: <20200228190218.GC1408759@coredump.intra.peff.net>
References: <20200214224242.knmzkwx7ls4sote7@doriath>
 <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
 <20200226172338.unembhjhog36sqj7@mithrim>
 <20200227100557.ydouc4n3jphzbits@feanor>
 <20200227104330.hp7zf2suquxsf6zw@feanor>
 <20200227155057.7idpa447ixo6sf6j@feanor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200227155057.7idpa447ixo6sf6j@feanor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 27, 2020 at 04:50:57PM +0100, Damien Robert wrote:

> So one might argue that the behaviour I observed is not a bug, but it is
> still surprising for me (as a user), and maybe this could be stated more
> clearly in the docs?
> 
> Furthermore there is a question of consistency. GIT_DIR will not always be set
> before running a shell alias. Looking at `setup_discovered_git_dir`, it will
> be set if we are in a bare dir, or core.worktree / WORK_TREE is set, or if
> we have a gitfile.

We were discussing the same issue recently with regards to hooks. See:

  https://lore.kernel.org/git/20200130102933.GE840531@coredump.intra.peff.net/

and the responses. I think we could do better, but at the cost of
breaking a relatively obscure git-clone feature.

> The annoying side effect is that I cannot use as an alias a command that
> iterate over submodules and run git commands inside them, because in this
> alias GIT_DIR will be set sometimes, and sometimes not (a quick fix would be to
> unset GIT_DIR in my alias).

Yes, the recommended thing is to make sure GIT_DIR is unset if you're
going to chdir around and expect auto-discovery of the repository to
work.

Note there are other variables you might want to unset, too, if you're
switching repositories. Doing:

  unset $(git rev-parse --local-env-vars)

would cover the full list.

-Peff
