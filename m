Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E9CC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8E122AAF
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 16:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgLDQk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:40:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:51560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgLDQk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 11:40:27 -0500
Received: (qmail 30442 invoked by uid 109); 4 Dec 2020 16:39:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 16:39:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12500 invoked by uid 111); 4 Dec 2020 16:39:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 11:39:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 11:39:45 -0500
From:   Jeff King <peff@peff.net>
To:     Sofia Syria <sofiasyria@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: diff-filter can't identify renaming if not done directly
Message-ID: <X8pmURHeWcNLwmvs@coredump.intra.peff.net>
References: <CAOsoBv7ors39UzVgq5VcqEwoaEbkXb5ApEf5NqW4bo_fymdruQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOsoBv7ors39UzVgq5VcqEwoaEbkXb5ApEf5NqW4bo_fymdruQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 03:59:03PM +0100, Sofia Syria wrote:

> quick question about using diff-filter in linux. In the scenario
> that in my repository, I first copy file1 to file2, then move file2 to
> file3 and delete file1, "git diff" returns:
> 
> diff --git a/file1 b/file3
> similarity index 100%
> rename from file1
> rename to file3
> 
>  but running "git diff --diff-filter=r" doesn't return anything. Only
> flag "t" will return the change. Can this be considered as a bug?

Lowercase filters exclude particular types. From "git help diff":

    --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
	   Select only files that are Added (A), Copied (C), Deleted
	   (D), Modified (M), Renamed (R), have their type (i.e. regular
	   file, symlink, submodule, ...) changed (T), are Unmerged (U),
	   are Unknown (X), or have had their pairing Broken (B). Any
	   combination of the filter characters (including none) can be
	   used. When * (All-or-none) is added to the combination, all
	   paths are selected if there is any file that matches other
	   criteria in the comparison; if there is no file that matches
	   other criteria, nothing is selected.

	   Also, these upper-case letters can be downcased to exclude.
	   E.g. --diff-filter=ad excludes added and deleted paths.

So "--diff-filter=R" asks to see only renames. But "--diff-filter=r"
asks to exclude them. And "--diff-filter=t" excludes typechanges, which
means that renames are still OK. Doing "--diff-filter=a", etc, would
still show it as well.

-Peff
