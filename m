Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6D7C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB8E64E7C
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBPViz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 16:38:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:34994 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhBPViv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 16:38:51 -0500
Received: (qmail 15029 invoked by uid 109); 16 Feb 2021 21:38:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 21:38:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29689 invoked by uid 111); 16 Feb 2021 21:38:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 16:38:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 16:38:05 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t/perf: handle worktrees as test repos
Message-ID: <YCw7PcqLUFmLJj7K@coredump.intra.peff.net>
References: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2102162211050.52@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2102162211050.52@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 10:13:49PM +0100, Johannes Schindelin wrote:

> I think you'll also need the equivalent of:
> 
> -- snip --
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 22d727cef83..0949c360ec4 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -84,7 +84,7 @@ test_perf_create_repo_from () {
>  			cp -R "$objects_dir" "$repo/.git/"; } &&
>  		for stuff in "$source_git"/*; do
>  			case "$stuff" in
> -				*/objects|*/hooks|*/config|*/commondir)
> +				*/objects|*/hooks|*/config|*/commondir|*/gitdir)
>  					;;
>  				*)
>  					cp -R "$stuff" "$repo/.git/" || exit 1
> -- snap --

I think that's reasonable to do, but isn't it orthogonal?

My patch is fixing the case that we do not copy enough files from a
workdir.

Both before and after my patch, we'd be copying the gitdir file. I don't
think it would actually cause a problem in practice, since a "gitdir"
file in the main repo dir doesn't have any meaning. But I do think it's
prudent to avoid copying it (just as we avoid commondir) to avoid any
confusion, or commands accidentally touching the original repository.

Likewise...

> > Having written that, it occurs to me that an even simpler solution is to
> > just always use the commondir as the source of the scratch repo. It does
> > not produce the same outcome, but the point is generally just to find a
> > suitable starting point for a repository. Grabbing the main repo instead
> > of one of its worktrees is probably OK for most tests.
> 
> Good point: we probably also need to exclude `*/worktrees/*`, but that is
> a bit trickier as we would not want to exclude, say,
> `refs/heads/worktrees/cleanup`.

Yes, for the same reason, I think we should exclude the whole worktrees
directory. I don't think we have to worry about that case (and if we
did, we'd already have trouble with "refs/heads/config" or similar). The
reason is that the case statement is only looking at the glob made from
the top-level. The actual recursive expansion of "refs/", etc, is done
by "cp -R".

Anyway, what I'm suggesting is that it would be a separate patch to
avoid looking at gitdir and worktrees, in order to increase overall
safety. Do you want to do that on top, or should I?

-Peff
