Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D12C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 19:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E8720728
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 19:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgAQTUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:20:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:39082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727115AbgAQTUS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 14:20:18 -0500
Received: (qmail 12959 invoked by uid 109); 17 Jan 2020 19:20:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Jan 2020 19:20:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18954 invoked by uid 111); 17 Jan 2020 19:26:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2020 14:26:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jan 2020 14:20:16 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] fetch: add --no-update-remote-refs
Message-ID: <20200117192016.GB11358@coredump.intra.peff.net>
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 03:28:59PM +0000, Derrick Stolee via GitGitGadget wrote:

> To prevent long blocking time during a 'git fetch' call, a user
> may want to set up a schedule for background 'git fetch' processes.
> However, these runs will update the refs/remotes branches, and
> hence the user will not notice when remote refs are updated during
> their foreground fetches. In fact, they may _want_ those refs to
> stay put so they can work with the refs from their last foreground
> fetch call.
> 
> Add a --[no-]update-remote-refs option to 'git fetch' which defaults
> to the existing behavior of updating the remote refs. This allows
> a user to run
> 
>   git fetch <remote> --no-update-remote-refs +refs/heads/*:refs/hidden/*
> 
> to populate a custom ref space and download a pack of the new
> reachable objects. This kind of call allows a few things to happen:
> 
> 1. We download a new pack if refs have updated.
> 2. Since the refs/hidden branches exist, GC will not remove the
>    newly-downloaded data.
> 3. With fetch.writeCommitGraph enabled, the refs/hidden refs are
>    used to update the commit-graph file.
> 
> To avoid the refs/hidden directory from filling without bound, the
> --prune option can be included. When providing a refspec like this,
> the --prune option does not delete remote refs and instead only
> deletes refs in the target refspace.

So refs/hidden is basically a parallel namespace that is exactly
identical to refs/remotes/origin? It seems like a very roundabout way of
solving the problem. Which, AFAICT, is just that you want "git fetch" to
print out the set of updates since the last manual fetch.  I suppose
this also doesn't update what people see when they refer to
"origin/master" until they run such a fetch.

I don't know. Part of me wants to say this is overly complicated. If you
want to see the difference in refs between two states, then we should
have some tool for showing that (even if it's git-fetch) without having
to have this weird parallel ref structure. OTOH, I guess any such tool
would need to save the ref state, which is equivalent to having all
these parallel refs.

> +--no-update-remote-refs::
> +	By default, git updates the `refs/remotes/` refspace with the refs
> +	advertised by the remotes during a `git fetch` command. With this
> +	option, those refs will be ignored. If the `--prune` option is
> +	specified and the default refpsec is used, then a ref that does not
> +	appear in the remote will still be deleted from refs/remotes.

That "by default" isn't exactly how it works. It's not updating the
advertised refs, but rather applying the configured refspec
opportunistically when we are actually fetching one of those refs. The
idea being that the remote tracking refs should always reflect our
latest notion of what's on the remote. This is due to f269048754 (fetch:
opportunistically update tracking refs, 2013-05-11).

So I think a cleaner implementation would be to prevent that ref mapping
from kicking in in the first place, rather than hacking it into
update_local_ref() as you have here. And it would avoid making
assumptions that "refs/remotes" is the only thing we'd see in such a
configured refspec. E.g., I have a configured refspec for gitster.git
with refs/notes/amlog:refs/notes/amlog, and that _would_ still update
even with your new option.

But I think there's already a way to do that: the --refmap option added
by c5558f80c3 (fetch: allow explicit --refmap to override configuration,
2014-05-29). Using an empty refmap like:

  git fetch --refmap= <remote> refs/heads/*:refs/hidden/*

should do what you want. It suppresses the use of the configured
refspecs, so we don't find any opportunistic mappings to make.

-Peff
