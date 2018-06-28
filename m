Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C7E1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 13:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753792AbeF1NXQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 09:23:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753775AbeF1NXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 09:23:16 -0400
Received: (qmail 11190 invoked by uid 109); 28 Jun 2018 13:23:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 13:23:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19453 invoked by uid 111); 28 Jun 2018 13:23:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 09:23:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 09:23:14 -0400
Date:   Thu, 28 Jun 2018 09:23:14 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Makefile: fix the "built from commit" code
Message-ID: <20180628132314.GA14026@sigill.intra.peff.net>
References: <pull.7.git.gitgitgadget@gmail.com>
 <e0e41d0b88b4104737b9ee80710c1bec91c9d759.1530190395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0e41d0b88b4104737b9ee80710c1bec91c9d759.1530190395.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 09:35:23PM +0200, Johannes Schindelin via GitGitGadget wrote:

> To prevent erroneous commits from being reported (e.g. when unpacking
> Git's source code from a .tar.gz file into a subdirectory of a different
> Git project, as e.g. git_osx_installer does), we painstakingly set
> GIT_CEILING_DIRECTORIES when trying to determine the current commit.
> 
> Except that we got the quoting wrong, and that variable therefore does
> not have the desired effect.
> 
> Let's fix that quoting, and while at it, also suppress the unhelpful
> message

I had to stare at the code for a bit to figure out what was wrong:

> -	'-DGIT_BUILT_FROM_COMMIT="$(shell GIT_CEILING_DIRECTORIES=\"$(CURDIR)/..\" \
> -		git rev-parse -q --verify HEAD || :)"'
> +	'-DGIT_BUILT_FROM_COMMIT="$(shell \
> +		GIT_CEILING_DIRECTORIES="$(CURDIR)/.." \
> +		git rev-parse -q --verify HEAD 2>/dev/null)"'

The issue is that the $(shell) is resolved before the output is stuffed
into the command-line with -DGIT_BUILT_FROM_COMMIT, and therefore is
_not_ inside quotes. And thus backslashing the quotes is wrong, as the
quote gets literally inserted into the CEILING_DIRECTORIES variable.

I thought at first we could not need the quotes in the post-image
either, because shell variable assignments do not do word-splitting.
I.e.:

  FOO='with spaces'
  BAR=$FOO sh -c 'echo $BAR'

works just fine. But $(CURDIR) here is not a shell variable, but rather
a Makefile variable, so it's expanded before we hit the shell. So we
need the quotes. And unfortunately it also breaks if $(CURDIR) contains
exotic metacharacters. If we cared we could use single quotes and
$(CURDIR_SQ), but I suspect it would be far from the first thing to
break in such a case.

Which is a long-winded way of saying the patch looks correct to me.

-Peff
