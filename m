Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E3C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 00:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57332074B
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 00:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgGaAmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:42:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:43172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbgGaAmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 20:42:03 -0400
Received: (qmail 17685 invoked by uid 109); 31 Jul 2020 00:42:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 00:42:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22653 invoked by uid 111); 31 Jul 2020 00:42:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jul 2020 20:42:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jul 2020 20:42:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fmt-merge-msg: selectively suppress "into
 <branch>"
Message-ID: <20200731004202.GA240563@coredump.intra.peff.net>
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
 <20200730180237.1392480-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730180237.1392480-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 11:02:35AM -0700, Junio C Hamano wrote:

> So, this is the third iteration, which separates the reversion that
> involves too many uninteresting test changes, and the implementation
> of the new feature proper.

Thanks, that did make it much easier to read.

> Two things that changed in the implementation since the previous
> iterations are
> 
>  - An assignment-less 'truth', i.e.
> 
> 	[merge] suppressDest
> 
>    is now an error ("missing value for 'merge.suppressDest'"), not
>    "clear the list", which should be spelled as an empty string, i.e.
> 
>         [merge] suppressDest = ""

OK. I don't have a preference either way on the "truth" behavior, but
certainly considering it an error is the conservative thing.

>  - Scanning of dest_patterns to see if "into <branch>" is suppressed
>    for the current_branch is done in a helper function to make the
>    main codeflow easier to read, as suggested by Peff.

Thanks.

This version looks OK to me. The remaining issues that came up in
earlier discussion but I didn't see you weigh in on are:

  - what should happen with a detached HEAD? We'd match HEAD in the
    suppressDest config, which I think is quite reasonable. Not sure if
    it's worth documenting or testing that specifically.

  - should "master" be in the list even if you configure a value? That
    would do the wrong thing if you have a non-integration master, but
    that seems unlikely. And it would do the right thing if somebody
    later puts "main" in merge.suppressDest, but still occasionally
    works with "master" repos (where "right" is defined as "what they
    probably wanted", but it is perhaps a bit magical).

  - what's the plan if we do switch init.defaultBranch to "main"? Would
    we add default_branch() to the list of defaults alongside "master",
    or just add "main", or just leave it and let people configure
    independently? It doesn't need to be decided now, but maybe worth
    thinking about.

-Peff
