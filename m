Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D3C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9283A2070E
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgGIXQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:16:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:53760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgGIXQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 19:16:25 -0400
Received: (qmail 6450 invoked by uid 109); 9 Jul 2020 23:16:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 23:16:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26689 invoked by uid 111); 9 Jul 2020 23:16:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 19:16:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 19:16:24 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
Message-ID: <20200709231624.GE664420@coredump.intra.peff.net>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <20200708235719.GA3189386@google.com>
 <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
 <d0d30dab-7883-199a-3beb-48c87cde3550@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0d30dab-7883-199a-3beb-48c87cde3550@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 09, 2020 at 08:43:48AM -0400, Derrick Stolee wrote:

> >> Is it infeasible to ask for 'git maintenance' to learn something like
> >> '--on /<path-to-repo> --on /<path-to-second-repo>'? Or better yet, some
> >> config like "maintenance.targetRepo = /<path-to-repo>"?
> 
> Sorry that I missed this comment on my first reply.
> 
> The intention is that this cron entry will be simpler after I follow up
> with the "background" part of maintenance. The idea is to use global
> or system config to register a list of repositories that want background
> maintenance and have cron execute something like "git maintenance run --all-repos"
> to span "git -C <repo> maintenance run --scheduled" for all repos in
> the config.
> 
> For now, this manual setup does end up a bit cluttered if you have a
> lot of repos to maintain.

I think it might be useful to have a general command to run a subcommand
in a bunch of repositories. Something like:

  git for-each-repo --recurse /path/to/repos git maintenance ...

which would root around in /path/to/repos for any git-dirs and run "git
--git-dir=$GIT_DIR maintenance ..." on each of them.

And/or:

  git for-each-repo --config maintenance.repos git maintenance ...

which would pull the set of repos from the named config variable instead
of looking around the filesystem.

You could use either as a one-liner in the crontab (depending on which
is easier with your repo layout).

-Peff
