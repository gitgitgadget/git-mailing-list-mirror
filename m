Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D14BC4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 17:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D27221E8
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 17:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIVRHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 13:07:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:37066 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgIVRHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 13:07:46 -0400
Received: (qmail 18126 invoked by uid 109); 22 Sep 2020 17:07:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Sep 2020 17:07:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1431 invoked by uid 111); 22 Sep 2020 17:07:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Sep 2020 13:07:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Sep 2020 13:07:45 -0400
From:   Jeff King <peff@peff.net>
To:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
Message-ID: <20200922170745.GA541915@coredump.intra.peff.net>
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 22, 2020 at 07:28:04AM +0000, Chris. Webster via GitGitGadget wrote:

> From: "Chris. Webster" <chris@webstech.net>
> 
> Not all developers are aware of `git diff --check` to warn
> about whitespace issues.  Running a check when a pull request is
> opened or updated can save time for reviewers and the submitter.

Sounds like a useful thing to have.

> A GitHub workflow will run when a pull request is created or the
> contents are updated to check the patch series.  A pull request
> provides the necessary information (number of commits) to only
> check the patch series.

I think this will work OK in practice, but a few thoughts:

 - for a linear branch on top of master, using the commit count will
   work reliably. But I suspect it would run into problems if there were
   ever a merge on a PR (e.g., back-merging from master), where we'd be
   subject to how `git log` linearizes the commits. That's not really a
   workflow I'd expect people to use with git.git, but it would probably
   be easy to make it more robust. Does the PR object provide the "base"
   oid, so we could do "git log $base..$head"?

 - this will run only on PRs. That's helpful for people using
   GitGitGadget, but it might also be useful for people just running the
   CI by pushing branches, or looking at CI builds of Junio's next or
   seen branches. Could we make it work there? Obviously we wouldn't be
   able to rely on having PR data, but I wonder if "git log
   HEAD..$branch" would be sufficient.

-Peff
