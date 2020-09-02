Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571B1C433E6
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 00:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C03320707
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 00:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIBAkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:40:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:47032 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIBAke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 20:40:34 -0400
Received: (qmail 30985 invoked by uid 109); 2 Sep 2020 00:40:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2020 00:40:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 927 invoked by uid 111); 2 Sep 2020 00:40:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2020 20:40:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Sep 2020 20:40:30 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] ci: avoid ugly "failure" in the `ci-config` job
Message-ID: <20200902004030.GC3294015@coredump.intra.peff.net>
References: <pull.719.git.1598991568.gitgitgadget@gmail.com>
 <b92374e69192d57bcb11fb2573beb4e9aee339a9.1598991568.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b92374e69192d57bcb11fb2573beb4e9aee339a9.1598991568.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 01, 2020 at 08:19:27PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the common case where users have _not_ pushed a `ci-config` branch to
> configure which branches should be included in the GitHub workflow runs,
> there is a big fat ugly annotation about a failure in the run's log:
> 
> 	X Check failure on line 1 in .github
> 
> 	  @github-actions github-actions / ci-config
> 
> 	  .github#L1
> 
> 	  Process completed with exit code 128.
> 
> The reason is that the `ci-config` job tries to clone that `ci-config`
> branch, and even if it is configured to continue on error, the
> annotation is displayed, and it is distracting.

Hmm. I thought we handled this with the "continue-on-error" flag.
Unsurprisingly I have a ci-config branch in my repo, but git/git
doesn't, and here's a sample run there:

  https://github.com/git/git/runs/1053619435?check_suite_focus=true

Both the "ci-config" task, as well as the individual "try to clone
ci-config branch" step are marked with a green check.

...Oh, I think I see what you mean. In the "Annotations" summary we
still see an ugly "X" box.

> Let's just handle this on the shell script level, so that the job's step
> is not marked as a failure.

OK, that makes sense. We could do differentiate clone failing versus cd
versus checkout (or for that matter, clone failing because the branch
doesn't exist versus a network error). But it's probably not worth
getting too fancy.

My next question was going to be: should we also drop the
continue-on-error flag? But I see you did that already.

So the patch looks good to me. Sorry for introducing CI noise in the
first place. :)

-Peff
