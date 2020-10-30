Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1F2C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A6C2075E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgJ3PJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:09:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:42598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgJ3PJn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 11:09:43 -0400
Received: (qmail 7533 invoked by uid 109); 30 Oct 2020 15:09:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 15:09:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22058 invoked by uid 111); 30 Oct 2020 15:09:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 11:09:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 11:09:42 -0400
From:   Jeff King <peff@peff.net>
To:     Sohom Datta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sohom Datta <sohom.datta@learner.manipal.edu>
Subject: Re: [PATCH] Fix potential segfault on cloning invalid tag
Message-ID: <20201030150942.GB3282152@coredump.intra.peff.net>
References: <pull.906.git.git.1604058401991.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.906.git.git.1604058401991.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 11:46:41AM +0000, Sohom Datta via GitGitGadget wrote:

> From: Sohom Datta <sohom.datta@learner.manipal.edu>
> 
> Git allows users to create tags pointing to object hashes
> that may or may not be commits. When a tag that doesn't
> point to a commit is used with the -b (--branch) parameter
> of git clone, git segfaults as it assumes that the tag will
> always reference a commit.
> 
> Add a check to make sure that lookup_commit_reference returns a commit
> before detaching HEAD.

This seemed eerily familiar, so I dug up these threads:

  - https://lore.kernel.org/git/20191029092735.GA84120@carpenter.lan/

  - https://lore.kernel.org/git/20191101002432.GA49846@carpenter.lan/

The interesting things are:

  - there are some other cases where we might see a non-commit, which
    are also worth covering

  - it would be friendlier to the user to put in a fallback value for
    HEAD. We already transferred the whole history, so deleting it is a
    bit less friendly than leaving it in a state the user can recover
    from locally

I think the patches there were moving in a good direction, but it looks
like they just got stalled.

-Peff
