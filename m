Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8088FC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596CF20775
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 22:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGIWws (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:52:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:53686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgGIWws (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 18:52:48 -0400
Received: (qmail 6295 invoked by uid 109); 9 Jul 2020 22:52:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 22:52:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26546 invoked by uid 111); 9 Jul 2020 22:52:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 18:52:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 18:52:46 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com
Subject: Re: [PATCH 09/21] maintenance: add commit-graph task
Message-ID: <20200709225246.GA664420@coredump.intra.peff.net>
References: <c8fbd14d41093e12905027ff628b98652cd931d0.1594131695.git.gitgitgadget@gmail.com>
 <20200709022942.39848-1-jonathantanmy@google.com>
 <8dacf017-c445-578c-c82c-f6d6f93469c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dacf017-c445-578c-c82c-f6d6f93469c9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 09, 2020 at 07:14:41AM -0400, Derrick Stolee wrote:

> On 7/8/2020 10:29 PM, Jonathan Tan wrote:
> >> +static int run_write_commit_graph(struct repository *r)
> >> +{
> >> +	int result;
> >> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> >> +
> >> +	argv_array_pushl(&cmd, "-C", r->worktree,
> >> +			 "commit-graph", "write",
> >> +			 "--split", "--reachable",
> >> +			 NULL);
> > 
> > As mentioned in my reply to an earlier patch (sent a few minutes ago),
> > this won't work if there are environment variables like GIT_DIR present.
> 
> Do we not pass GIT_DIR to the subcommand? Or does using "-C" override
> the GIT_DIR?

We do pass GIT_DIR to the subcommand, and "-C" does not override it. I
think this code would work as long as "r" is the_repository, which it
would be in the current code. But then the "-C" would be doing nothing
useful (it might change to the top of the worktree if we weren't there
for some reason, but I don't think "commit-graph write" would care
either way).

But if "r" is some other repository, "commit-graph" would continue to
operate in the parent process repository because of the inherited
GIT_DIR. Using "--git-dir" would solve that, but as a general practice,
if you're spawning a sub-process that might be in another repository,
you should clear any repo-specific environment variables. The list is in
local_repo_env, which you can feed to the "env" or "env_array" parameter
of a child_process (see the use in connect.c for an example).

Even in the current scheme where "r" is always the_repository, I suspect
this might still be buggy. If we're in a bare repository, presumably
r->worktree would be NULL.

-Peff
