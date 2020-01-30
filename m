Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5667C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 10:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C618C206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 10:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgA3KXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:23:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:48354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726893AbgA3KXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 05:23:05 -0500
Received: (qmail 30048 invoked by uid 109); 30 Jan 2020 10:23:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 10:23:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22772 invoked by uid 111); 30 Jan 2020 10:30:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 05:30:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 05:23:03 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] clone: pass --single-branch during
 --recurse-submodules
Message-ID: <20200130102303.GD840531@coredump.intra.peff.net>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200128221736.9217-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200128221736.9217-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 02:17:36PM -0800, Emily Shaffer wrote:

> Previously, performing "git clone --recurse-submodules --single-branch"
> resulted in submodules cloning all branches even though the superproject
> cloned only one branch. Pipe --single-branch through the submodule
> helper framework to make it to 'clone' later on.

This makes sense to me, bearing in mind that I'm not at all a good
person to point out subtleties with submodules that could bite us.

> As discussed in the thread for v1 of this patch, in cases when the
> submodule commit referenced by the specified superproject branch isn't
> the same as the HEAD of the submodule repo known by the server side,
> this still works in kind of a non-obvious way. In these cases, first we
> fetch the single branch that is the ancestor of the server's HEAD; then
> we fetch the commit needed by the superproject (and its ancestry). So
> while this change prevents us from fetching *all* branches on clone, it
> doesn't necessarily limit us to a single branch as described.

Is it worth adding a test that we do the right thing here? Not so much
to prove that it works now, but to protect us against future changes. It
seems like the sort of thing that could get subtly broken.

The patch looks mostly good to me (my, that was a lot of plumbing
through that option); here are a few minor comments:

> -update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
> +update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--single-branch] [--] [<path>...]::

This line is horrendously long. Not new in your patch, but I wonder if
the time might have come to break it up.

> +--single-branch::
> +	This option is only valid for the update command.
> +	Clone only one branch during update, HEAD or --branch.

For some reason my brain insists on parsing this second sentence as a
3-item list without an Oxford comma. I wonder if it would be more clear
as:

  Clone only one branch during update: HEAD or one specified by
  --branch.

or similar.

>  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
>  	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, 0, \
> -	NULL, NULL, NULL, \
> +	NULL, NULL, NULL, 0,\
>  	NULL, 0, 0, 0, NULL, 0, 0, 1}

Wow. Also not new in your patch, but I think we're moving towards the
use of C99 named initializers, which would make this a bit less
daunting (all of the NULL/0 items could be omitted!).

> +test_expect_success 'clone with --single-branch' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --single-branch "file://$pwd/." super_clone &&
> +	(
> +		cd super_clone/sub &&
> +		git branch -a >branches &&
> +		test_must_fail grep other branches
> +	)
> +'

Don't use test_must_fail with non-Git commands; you can just say "!  grep".

We usually try to avoid scripting around git-branch output (although I
find it pretty unlikely that future changes would break this particular
case). git-for-each-ref would be a better pick, but I wonder if:

  git rev-parse --verify origin/master &&
  test_must_fail git rev-parse --verify origin/other

might express the expectation more clearly.

-Peff
